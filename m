Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B910020756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdAMR45 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:56:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:38929 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdAMR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:56:56 -0500
Received: (qmail 6066 invoked by uid 109); 13 Jan 2017 17:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:55:59 +0000
Received: (qmail 7374 invoked by uid 111); 13 Jan 2017 17:56:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 12:56:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:55:55 -0500
Date:   Fri, 13 Jan 2017 12:55:55 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 3/6] t1450: test fsck of packed objects
Message-ID: <20170113175555.3xlkk27ozniiql3h@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code paths in fsck for packed and loose objects are
quite different, and it is not immediately obvious that the
packed case behaves well. In particular:

  1. The fsck_loose() function always returns "0" to tell the
     iterator to keep checking more objects. Whereas
     fsck_obj_buffer() (which handles packed objects)
     returns -1. This is OK, because the callback machinery
     for verify_pack() does not stop when it sees a non-zero
     return.

  2. The fsck_loose() function sets the ERROR_OBJECT bit
     when fsck_obj() fails, whereas fsck_obj_buffer() sets it
     only when it sees a corrupt object. This turns out not
     to matter. We don't actually do anything with this bit
     except exit the program with a non-zero code, and that
     is handled already by the non-zero return from the
     function.

So there are no bugs here, but it was certainly confusing to
me. And we do not test either of the properties in t1450
(neither that a non-corruption error will caused a non-zero
exit for a packed object, nor that we keep going after
seeing the first error). Let's test both of those
conditions, so that we'll notice if any of those assumptions
becomes invalid.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1450-fsck.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f95174c9d..c39d42120 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -560,4 +560,25 @@ test_expect_success 'alternate objects are correctly blamed' '
 	grep alt.git out
 '
 
+test_expect_success 'fsck errors in packed objects' '
+	git cat-file commit HEAD >basis &&
+	sed "s/</one/" basis >one &&
+	sed "s/</foo/" basis >two &&
+	one=$(git hash-object -t commit -w one) &&
+	two=$(git hash-object -t commit -w two) &&
+	pack=$(
+		{
+			echo $one &&
+			echo $two
+		} | git pack-objects .git/objects/pack/pack
+	) &&
+	test_when_finished "rm -f .git/objects/pack/pack-$pack.*" &&
+	remove_object $one &&
+	remove_object $two &&
+	test_must_fail git fsck 2>out &&
+	grep "error in commit $one.* - bad name" out &&
+	grep "error in commit $two.* - bad name" out &&
+	! grep corrupt out
+'
+
 test_done
-- 
2.11.0.629.g10075098c

