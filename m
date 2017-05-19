Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E222021E
	for <e@80x24.org>; Fri, 19 May 2017 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbdESMsi (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:48:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:54787 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755162AbdESMsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:48:36 -0400
Received: (qmail 2198 invoked by uid 109); 19 May 2017 12:48:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:48:36 +0000
Received: (qmail 27672 invoked by uid 111); 19 May 2017 12:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:49:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:48:34 -0400
Date:   Fri, 19 May 2017 08:48:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 01/15] handle_revision_arg: reset "dotdot" consistently
Message-ID: <20170519124834.ipk42isngqck2egu@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
"a..b" name in error messages, and these erroneously show
only "a" instead of "a..b". E.g.:

  $ git cherry-pick HEAD:foo..HEAD:foo
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
I also considered just making a copy of the string rather than this
in-place munging (technically we get it as a pointer-to-const; it's only
the use of strstr() that lets us quietly drop the const). But it doesn't
really make the code any cleaner; now instead of restoring the dot you
have to remember to free() the string in each code path.

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
index f57799071..6da1bbe91 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1380,4 +1380,13 @@ test_expect_success 'log --source paints tag names' '
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
2.13.0.219.g63f6bc368

