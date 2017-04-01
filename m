Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050C720966
	for <e@80x24.org>; Sat,  1 Apr 2017 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdDAIFZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:05:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:55283 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdDAIFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:05:23 -0400
Received: (qmail 29122 invoked by uid 109); 1 Apr 2017 08:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:05:23 +0000
Received: (qmail 16194 invoked by uid 111); 1 Apr 2017 08:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:05:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:05:21 -0400
Date:   Sat, 1 Apr 2017 04:05:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH 1/2] sha1_loose_object_info: return error for corrupted
 objects
Message-ID: <20170401080521.ehjc6jomjd5py3lj@sigill.intra.peff.net>
References: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sha1_loose_object_info() finds that a loose object file
cannot be stat(2)ed or mmap(2)ed, it returns -1 to signal an
error to the caller.  However, if it found that the loose
object file is corrupt and the object data cannot be used
from it, it stuffs OBJ_BAD into "type" field of the
object_info, but returns zero (i.e., success), which can
confuse callers.

This is due to 052fe5eac (sha1_loose_object_info: make type
lookup optional, 2013-07-12), which switched the return to a
strict success/error, rather than returning the type (but
botched the return).

Callers of regular sha1_object_info() don't notice the
difference, as that function returns the type (which is
OBJ_BAD in this case). However, direct callers of
sha1_object_info_extended() see the function return success,
but without setting any meaningful values in the object_info
struct, leading them to access potentially uninitialized
memory.

The easiest way to see the bug is via "cat-file -s", which
will happily ignore the corruption and report whatever
value happened to be in the "size" variable.

Signed-off-by: Jeff King <peff@peff.net>
---
So not only does it not fail, but running with --valgrind complains.

 sha1_file.c                  | 2 +-
 t/t1060-object-corruption.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 71063890f..368c89b5c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (status && oi->typep)
 		*oi->typep = status;
 	strbuf_release(&hdrbuf);
-	return 0;
+	return (status < 0) ? status : 0;
 }
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 3f8705139..3a88d79c5 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -53,6 +53,13 @@ test_expect_success 'streaming a corrupt blob fails' '
 	)
 '
 
+test_expect_success 'getting type of a corrupt blob fails' '
+	(
+		cd bit-error &&
+		test_must_fail git cat-file -s HEAD:content.t
+	)
+'
+
 test_expect_success 'read-tree -u detects bit-errors in blobs' '
 	(
 		cd bit-error &&
-- 
2.12.2.943.g91cb50fd8

