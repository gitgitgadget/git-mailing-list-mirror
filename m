Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7187D20281
	for <e@80x24.org>; Tue, 23 May 2017 19:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967676AbdEWTvg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:51:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56949 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967061AbdEWTvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:51:35 -0400
Received: (qmail 8829 invoked by uid 109); 23 May 2017 19:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 19:51:34 +0000
Received: (qmail 3520 invoked by uid 111); 23 May 2017 19:52:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 15:52:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 15:51:32 -0400
Date:   Tue, 23 May 2017 15:51:32 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/15] handle_revision_arg: reset "dotdot" consistently
Message-ID: <20170523195132.s57ikef4romy3n3r@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
 <20170519124834.ipk42isngqck2egu@sigill.intra.peff.net>
 <F66E608B6CE34520BD764C404A2AD36C@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F66E608B6CE34520BD764C404A2AD36C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 03:56:32PM +0100, Philip Oakley wrote:

> > That means we do report the correct name for "a" in the
> > pending array. But some code paths try to show the whole
> > "a..b" name in error messages, and these erroneously show
> > only "a" instead of "a..b". E.g.:
> > 
> >  $ git cherry-pick HEAD:foo..HEAD:foo
> 
> shouldn't this be three dots? Also the para above uses two dot examples in
> its description but the paras before that start by describing the three dot
> case.

Yeah, it should be. The problem happens with the two-dot case, too (it's
the same code) but to provoke cherry-pick to actually show the error in
question, you need to use three-dots. There's probably a way to provoke
a broken error message with the two-dot case, but I didn't dig further
after finding this one.

Thanks for being a careful reader. Here's the patch with a modified
commit message. I don't think this series otherwise needs a re-roll so
far.

-- >8 --
Subject: [PATCH] handle_revision_arg: reset "dotdot" consistently

When we are parsing a range like "a..b", we write a
temporary NUL over the first ".", so that we can access the
names "a" and "b" as C strings. But our restoration of the
original "." is done at inconsistent times, which can lead
to confusing results.

For most calls, we restore the "." after we resolve the
names, but before we call verify_non_filename().  This means
that when we later call add_pending_object(), the name for
the left-hand "a" has been re-expanded to "a..b". You can
see this with:

  git log --source a...b

where "b" will be correctly marked with "b", but "a" will be
marked with "a...b". Likewise with "a..b" (though you need
to use --boundary to even see "a" at all in that case).

To top off the confusion, when the REVARG_CANNOT_BE_FILENAME
flag is set, we skip the non-filename check, and leave the
NUL in place.

That means we do report the correct name for "a" in the
pending array. But some code paths try to show the whole
"a...b" name in error messages, and these erroneously show
only "a" instead of "a...b". E.g.:

  $ git cherry-pick HEAD:foo...HEAD:foo
  error: object d95f3ad14dee633a758d2e331151e950dd13e4ed is a blob, not a commit
  error: object d95f3ad14dee633a758d2e331151e950dd13e4ed is a blob, not a commit
  fatal: Invalid symmetric difference expression HEAD:foo

(That last message should be "HEAD:foo...HEAD:foo"; I used
cherry-pick because it passes the CANNOT_BE_FILENAME flag).

As an interesting side note, cherry-pick actually looks at
and re-resolves the arguments from the pending->name fields.
So it would have been visibly broken by the first bug, but
the effect was canceled out by the second one.

This patch makes the whole function consistent by re-writing
the NUL immediately after calling verify_non_filename(), and
then restoring the "." as appropriate in some error-printing
and early-return code paths.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c     | 3 +++
 t/t4202-log.sh | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/revision.c b/revision.c
index 8a8c1789c..014bf52e3 100644
--- a/revision.c
+++ b/revision.c
@@ -1477,12 +1477,14 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 			if (!cant_be_filename) {
 				*dotdot = '.';
 				verify_non_filename(revs->prefix, arg);
+				*dotdot = '\0';
 			}
 
 			a_obj = parse_object(from_sha1);
 			b_obj = parse_object(sha1);
 			if (!a_obj || !b_obj) {
 			missing:
+				*dotdot = '.';
 				if (revs->ignore_missing)
 					return 0;
 				die(symmetric
@@ -1525,6 +1527,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 					REV_CMD_RIGHT, flags);
 			add_pending_object(revs, a_obj, this);
 			add_pending_object(revs, b_obj, next);
+			*dotdot = '.';
 			return 0;
 		}
 		*dotdot = '.';
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1c7d6729c..76c511973 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1392,4 +1392,13 @@ test_expect_success 'log --source paints tag names' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --source paints symmetric ranges' '
+	cat >expect <<-\EOF &&
+	09e12a9	source-b three
+	8e393e1	source-a two
+	EOF
+	git log --oneline --source source-a...source-b >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.13.0.387.gec0afcebb.dirty

