Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14AC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBD620774
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgGIUfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:35:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgGIUfv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 16:35:51 -0400
Received: (qmail 5795 invoked by uid 109); 9 Jul 2020 20:35:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 20:35:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24996 invoked by uid 111); 9 Jul 2020 20:35:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 16:35:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 16:35:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/4] t9700: loosen ident timezone regex
Message-ID: <20200709203550.GB661064@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709203336.GA2748777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few of the perl tests in t9700 ask for the author and committer ident,
and then make sure we get something sensible. For the timestamp portion,
we just match [0-9]+, because the actual value will depend on when the
test is run. However, we do require that the timezone be "+0000". This
works reliably because we set $TZ in test-lib.sh. But in preparation for
changing the default timezone, let's be a bit more flexible. We don't
actually care about the exact value here, just that we were able to get
a sensible output from the perl module's access methods.

Signed-off-by: Jeff King <peff@peff.net>
---
Alternatively, we could use test_tick here and then make sure we got the
expected timestamp. Or revisit it after patch 4 and use the default date
from there. But I think the intent of the tests is fulfilled by
remaining flexible.

 t/t9700/test.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 34cd01366f..c59a015f89 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -59,15 +59,15 @@ sub adjust_dirsep {
 open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
 
 # ident
-like($r->ident("aUthor"), qr/^A U Thor <author\@example.com> [0-9]+ \+0000$/,
+like($r->ident("aUthor"), qr/^A U Thor <author\@example.com> [0-9]+ [+-]\d{4}$/,
      "ident scalar: author (type)");
-like($r->ident("cOmmitter"), qr/^C O Mitter <committer\@example.com> [0-9]+ \+0000$/,
+like($r->ident("cOmmitter"), qr/^C O Mitter <committer\@example.com> [0-9]+ [+-]\d{4}$/,
      "ident scalar: committer (type)");
 is($r->ident("invalid"), "invalid", "ident scalar: invalid ident string (no parsing)");
 my ($name, $email, $time_tz) = $r->ident('author');
 is_deeply([$name, $email], ["A U Thor", "author\@example.com"],
 	 "ident array: author");
-like($time_tz, qr/[0-9]+ \+0000/, "ident array: author");
+like($time_tz, qr/[0-9]+ [+-]\d{4}/, "ident array: author");
 is_deeply([$r->ident("Name <email> 123 +0000")], ["Name", "email", "123 +0000"],
 	  "ident array: ident string");
 is_deeply([$r->ident("invalid")], [], "ident array: invalid ident string");
-- 
2.27.0.730.gcc195a083d

