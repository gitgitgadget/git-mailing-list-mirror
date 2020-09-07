Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2C21481
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgIGIRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:17:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:50278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgIGIRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 04:17:41 -0400
Received: (qmail 13026 invoked by uid 109); 7 Sep 2020 08:17:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Sep 2020 08:17:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14461 invoked by uid 111); 7 Sep 2020 08:17:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Sep 2020 04:17:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Sep 2020 04:17:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tom Hale <tomnott@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] add--interactive.perl: specify --no-color explicitly
Message-ID: <20200907081739.GB1263923@coredump.intra.peff.net>
References: <20200907080632.GA1261825@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907080632.GA1261825@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our color tests of "git add -p" do something a bit different from how a
normal user would behave: we pretend there's a pager in use, so that Git
thinks it's OK to write color to a non-tty stdout.  This comes from
8539b46534 (t3701: avoid depending on the TTY prerequisite, 2019-12-06),
which allows us to avoid a lot of complicated mock-tty code.

However, those environment variables also make their way down to
sub-processes of add--interactive, including the "diff-files" we run to
generate the patches. As a result, it thinks it should output color,
too. So in t3701.50, for example, the machine-readable version of the
diff we get unexpectedly has color in it. We fail to parse it as a diff
and think there are zero hunks.

The test does still pass, though, because even with zero hunks we'll
dump the diff header (and we consider those unparseable bits to be part
of the header!), and so the output still has the expected color codes in
it. We don't notice that the command was totally broken and failed to
apply anything.

And in fact we're not really testing what we think we are about the
color, either. While add--interactive does correctly show the version we
got from running "diff-files --color", we'd also pass the test if we had
accidentally shown the machine-readable version, too, since it
(erroneously) has color codes in it.

One could argue that the test isn't very realistic; it's setting up this
"pretend there's a pager" situation to get around the tty restrictions
of the test environment. So one option would be to move back towards
using a real tty. But the behavior of add--interactive really is
user-visible here. If a user, for whatever reason, did run "git
--paginate add --patch" (perhaps because their pager is really a filter
or something), the command would totally fail to do anything useful.

Since we know that we don't want color in this output, let's just make
add--interactive more defensive, and say "--no-color" explicitly. It
doesn't hurt anything in the common case, but it fixes this odd case and
lets our test function properly again.

Note that the C builtin run_add_p() already passes --no-color, so it
doesn't need a similar fix. That will eventually replace this perl code
anyway, but the test change here will be valuable for ensuring that.

Signed-off-by: Jeff King <peff@peff.net>
---
Curiously, run_add_p() claims that --no-color is important to override
"diff.color = always", but in a quick test that doesn't seem to make any
difference. I didn't dig into whether it's possible to trigger or not
(either way, defensively using --no-color is a reasonable precaution).

 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f36c0078ac..b6cdcfef61 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -714,7 +714,7 @@ sub parse_diff {
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, get_diff_reference($patch_mode_revision);
 	}
-	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
+	my @diff = run_cmd_pipe("git", @diff_cmd, qw(--no-color --), $path);
 	my @colored = ();
 	if ($diff_use_color) {
 		my @display_cmd = ("git", @diff_cmd, qw(--color --), $path);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 67d1c36cef..1590cf6b98 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -582,6 +582,7 @@ test_expect_success 'diffs can be colorized' '
 	echo content >test &&
 	printf y >y &&
 	force_color git add -p >output 2>&1 <y &&
+	git diff-files --exit-code &&
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
-- 
2.28.0.889.g64d3ad7607
