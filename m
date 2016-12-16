Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EBF1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759603AbcLPNvq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 08:51:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:57565 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755619AbcLPNvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 08:51:44 -0500
Received: (qmail 17222 invoked by uid 109); 16 Dec 2016 13:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 13:51:44 +0000
Received: (qmail 11701 invoked by uid 111); 16 Dec 2016 13:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 08:52:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 08:51:41 -0500
Date:   Fri, 16 Dec 2016 08:51:41 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 08:39:40AM -0500, Jeff King wrote:

> I'm OK with the approach your patch takes, but I think there were some
> unresolved issues:
> 
>   - are we OK taking the short "-c" for this, or do we want
>     "--group-by=committer" or something like it?
> 
>   - no tests; you can steal the general form from my [1]
> 
>   - no documentation (can also be stolen from [1], though the syntax is
>     quite different)

Being moved by the holiday spirit, I wrote a patch to address the latter
two. ;)

It obviously would need updating if we switch away from "-c", but I
think I am OK with the short "-c" (even if we add a more exotic grouping
option later, this can remain as a short synonym).

-- >8 --
Subject: [PATCH] shortlog: test and document --committer option

This puts the final touches on the feature added by
fbfda15fb8 (shortlog: group by committer information,
2016-10-11).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  4 ++++
 t/t4201-shortlog.sh            | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 31af7f2736..ee6c5476c1 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,6 +47,10 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
+-c::
+--committer::
+	Collect and show committer identities instead of authors.
+
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index ae08b57712..6c7c637481 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -190,4 +190,17 @@ test_expect_success 'shortlog with --output=<file>' '
 	test_line_count = 3 shortlog
 '
 
+test_expect_success 'shortlog --committer (internal)' '
+	cat >expect <<-\EOF &&
+	     3	C O Mitter
+	EOF
+	git shortlog -nsc HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'shortlog --committer (external)' '
+	git log --format=full | git shortlog -nsc >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.348.g960a0b554

