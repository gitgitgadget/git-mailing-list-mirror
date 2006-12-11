X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't use memcpy when source and dest. buffers may overlap
Date: Mon, 11 Dec 2006 19:06:34 +0100
Message-ID: <87slfm489h.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 18:07:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Lines: 34
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34023>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtpYV-0004B6-8e for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936424AbWLKSHH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762958AbWLKSHH
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:07:07 -0500
Received: from mx.meyering.net ([82.230.74.64]:57827 "EHLO mx.meyering.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760656AbWLKSHG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 13:07:06 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 BA7702CD31; Mon, 11 Dec 2006 19:06:34 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-index-pack can call memcpy with overlapping source and destination
buffers.  The patch below makes it use memmove instead.

If you want to demonstrate a failure, add the following two lines

+               if (input_offset < input_len)
+                 abort ();

before the existing memcpy call (shown in the patch below),
and then run this:

  (cd t; sh ./t5500-fetch-pack.sh)


Signed-off-by: Jim Meyering <jim@meyering.net>
---
 index-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 8331d99..6d6c92b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -96,7 +96,7 @@ static void flush(void)
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
 		SHA1_Update(&input_ctx, input_buffer, input_offset);
-		memcpy(input_buffer, input_buffer + input_offset, input_len);
+		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
 }
--
