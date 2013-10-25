From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] reset: pass real rev name to add--interactive
Date: Fri, 25 Oct 2013 02:54:06 -0400
Message-ID: <20131025065406.GB15253@sigill.intra.peff.net>
References: <20131025065117.GA15192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 08:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbHk-0004zC-UA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab3JYGyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:54:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:55368 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751512Ab3JYGyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:54:12 -0400
Received: (qmail 5898 invoked by uid 102); 25 Oct 2013 06:54:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:54:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:54:06 -0400
Content-Disposition: inline
In-Reply-To: <20131025065117.GA15192@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236686>

The add--interactive --patch mode adjusts the UI based on
whether we are pulling changes from HEAD or elsewhere (in
the former case it asks to unstage the reverse hunk, rather
than apply the forward hunk).

Commit 166ec2e taught reset to work on an unborn branch, but
in doing so, switched to always providing add--interactive
with the sha1 rather than the symbolic name. This meant we
always used the "apply" interface, even for "git reset -p
HEAD".

We can fix this by passing the symbolic name to
add--interactive.  Since it understands unborn branches
these days, we do not even have to cover this special case
ourselves; we can simply pass HEAD.

The tests in t7105 now check that the right interface is
used in each circumstance (and notice the regression from
166ec2e we are fixing). The test in t7106 checks that we
get this right for the unborn case, too (not a regression,
since it didn't work at all before, but a nice improvement).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reset.c                |  2 +-
 t/t7105-reset-patch.sh         | 10 ++++++----
 t/t7106-reset-unborn-branch.sh |  5 +++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index f2f9d55..6004803 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -304,7 +304,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
+		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 95fab20..98b7d7b 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -25,15 +25,17 @@ test_expect_success PERL 'saying "n" does nothing' '
 '
 
 test_expect_success PERL 'git reset -p' '
-	(echo n; echo y) | git reset -p &&
+	(echo n; echo y) | git reset -p >output &&
 	verify_state dir/foo work head &&
-	verify_saved_state bar
+	verify_saved_state bar &&
+	test_i18ngrep "Unstage" output
 '
 
 test_expect_success PERL 'git reset -p HEAD^' '
-	(echo n; echo y) | git reset -p HEAD^ &&
+	(echo n; echo y) | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
-	verify_saved_state bar
+	verify_saved_state bar &&
+	test_i18ngrep "Apply" output
 '
 
 # The idea in the rest is that bar sorts first, so we always say 'y'
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index af00ab4..0f95f00 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -37,11 +37,12 @@ test_expect_success PERL 'reset -p' '
 	rm .git/index &&
 	git add a &&
 	echo y >yes &&
-	git reset -p <yes &&
+	git reset -p <yes >output &&
 
 	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_i18ngrep "Unstage" output
 '
 
 test_expect_success 'reset --soft is a no-op' '
-- 
1.8.4.1.898.g8bf8a41.dirty
