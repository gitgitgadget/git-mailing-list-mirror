From: Jeff King <peff@peff.net>
Subject: [PATCH v3 7/8] wt-status: load diff ui config
Date: Sun, 26 Oct 2008 00:49:35 -0400
Message-ID: <20081026044935.GG21047@coredump.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:50:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxaV-00065W-ID
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYJZEtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYJZEtj
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:49:39 -0400
Received: from peff.net ([208.65.91.99]:2261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYJZEti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:49:38 -0400
Received: (qmail 5075 invoked by uid 111); 26 Oct 2008 04:49:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:49:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:49:35 -0400
Content-Disposition: inline
In-Reply-To: <20081026043802.GA14530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99147>

When "git status -v" shows a diff, we did not respect the
user's usual diff preferences at all. Loading just
git_diff_basic_config would give us things like rename
limits and diff drivers. But it makes even more sense to
load git_diff_ui_config, which gives us colorization if the
user has requested it.

Note that we need to take special care to cancel
colorization when writing to the commit template file, as
described in the code comments.

Signed-off-by: Jeff King <peff@peff.net>
---
This is necessary to do textconvs in the "status -v" diff (which will
come in the next patch).

But it makes me a little nervous. On one hand, I think it is definitely
the right thing for "status -v" to respect user options. But we do
several _other_ diffs in addition, and those are more "plumbing" diffs.
I think they should probably at least have diff_basic_config (e.g., for
rename limits). But we are applying the diff_ui_config options to all
diffs. Looking over the available options, I _think_ there are no nasty
surprises. But you never know.

 t/t7502-commit.sh |    8 ++++++++
 wt-status.c       |   10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3eb9fae..ad42c78 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -89,6 +89,14 @@ test_expect_success 'verbose' '
 
 '
 
+test_expect_success 'verbose respects diff config' '
+
+	git config color.diff always &&
+	git status -v >actual &&
+	grep "\[1mdiff --git" actual &&
+	git config --unset color.diff
+'
+
 test_expect_success 'cleanup commit messages (verbatim,-t)' '
 
 	echo >>negative &&
diff --git a/wt-status.c b/wt-status.c
index c3a9cab..54d2f58 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -303,6 +303,14 @@ static void wt_status_print_verbose(struct wt_status *s)
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
+	/*
+	 * If we're not going to stdout, then we definitely don't
+	 * want color, since we are going to the commit message
+	 * file (and even the "auto" setting won't work, since it
+	 * will have checked isatty on stdout).
+	 */
+	if (s->fp != stdout)
+		DIFF_OPT_CLR(&rev.diffopt, COLOR_DIFF);
 	run_diff_index(&rev, 1);
 }
 
@@ -422,5 +430,5 @@ int git_status_config(const char *k, const char *v, void *cb)
 			return error("Invalid untracked files mode '%s'", v);
 		return 0;
 	}
-	return git_color_default_config(k, v, cb);
+	return git_diff_ui_config(k, v, cb);
 }
-- 
1.6.0.3.524.ge8b2e.dirty
