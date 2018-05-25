Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C161F42D
	for <e@80x24.org>; Fri, 25 May 2018 23:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030666AbeEYXEU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 19:04:20 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:62886 "EHLO
        cdptpa-cmomta03.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030538AbeEYXET (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 May 2018 19:04:19 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 May 2018 19:04:19 EDT
Received: from dell-suse.jhome.net ([70.123.58.237])
        by cmsmtp with ESMTP
        id MLgafsovclWPgMLgdfHB1l; Fri, 25 May 2018 22:59:51 +0000
From:   Jeremy Linton <lintonrjeremy@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com,
        Jeremy Linton <lintonrjeremy@gmail.com>
Subject: [PATCH] packfile: Correct zlib buffer handling
Date:   Fri, 25 May 2018 17:56:01 -0500
Message-Id: <20180525225601.22575-1-lintonrjeremy@gmail.com>
X-Mailer: git-send-email 2.13.6
X-CMAE-Envelope: MS4wfBmm3AXtJxcBvTHTJOV5efURqFiLjtxaqkU4L/m4UA+F9dxTR74uYiNPL/QzhGZA1O74dl3Ljac2gmD4WcPbMpbdST68syczrIY3l0ZI6aly52iY5Yms
 0mN7N4dRN9OZElOCoXnNs1slFTGy3uJkjSJfo9/7n2TcLF3j9fvm0ieI450EAKvLnr2/Fgg6MQ28Y+YeOuF+X36vLD+x9BHExQUWDWSn/hPrTk5qpE2ptZJa
 QEcSnyEfqx5ZoPnU7rtgmg6apJaxhmYqpxOUelKGJZDm8q4ORdvxRWZAKOYQH+9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer being passed to zlib includes a null terminator that
git needs to keep in place. unpack_compressed_entry() attempts to
detect the case that the source buffer hasn't been fully consumed
by checking to see if the destination buffer has been over consumed.

This yields two problems, first a single byte overrun won't be detected
properly because the Z_STREAM_END will then be set, but the null
terminator will have been overwritten. The other problem is that
more recent zlib patches have been poisoning the unconsumed portions
of the buffers which also overwrites the null, while correctly
returning length and status.

Lets rely on the fact that the source buffer will only be fully
consumed when the when the destination buffer is inflated to the
correct size. We can do this by passing zlib the correct buffer size
and properly checking the return status. The latter check actually
already exists if the buffer size is correct.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
---
 packfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7c1a2519f..245eb3204 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		return NULL;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size + 1;
+	stream.avail_out = size;
 
 	git_inflate_init(&stream);
 	do {
@@ -1424,7 +1424,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
 		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
+			break; /* done, st indicates if source fully consumed */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
-- 
2.13.6

