From: Michael Grubb <devel@dailyvoid.com>
Subject: [PATCH v3] Add default merge options for all branches
Date: Tue, 03 May 2011 00:38:49 -0500
Message-ID: <4DBF94E9.2010502@dailyvoid.com>
References: <4DBF04C5.1080608@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, vmiklos@frugalware.org,
	deskinm@umich.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 07:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH8K4-0004ob-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 07:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab1ECFiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 01:38:55 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:56613
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1ECFiy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 01:38:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=F/xbGZJ70rlZuu/JH+FVg+Wr0cphyYN54W2ukE1JHLqdABsXurWAX4Qtt8+t5A8q51eN4Lb5+reZcfCEcSkBvVVq9uKc7Tj+fXfrjl/l0Vp+ycZGuJqLgXV7RDrkDPSy;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QH8Jt-0006Rc-Qy; Tue, 03 May 2011 01:38:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DBF04C5.1080608@dailyvoid.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172644>

Add support for branch.*.mergeoptions for setting default options for
all branches.  This new value shares semantics with the existing
branch.<name>.mergeoptions variable. If a branch specific value is
found, that value will be used.

The need for this arises from the fact that there is currently not an
easy way to set merge options for all branches. Instead of having to
specify merge options for each individual branch there should be a way
to set defaults for all branches and then override a specific branch's
options.

The approach taken is to make note of whether a branch specific
mergeoptions key has been seen and only apply the global value if it
hasn't.

Signed-off-by: Michael Grubb <devel@dailyvoid.com>
---
 Documentation/git-merge.txt |    3 +++
 builtin/merge.c             |   40 +++++++++++++++++++++++++++++++++-------
 t/t7600-merge.sh            |   27 +++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e2e6aba..eaab3e4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -307,6 +307,9 @@ branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of 'git merge', but option
 	values containing whitespace characters are currently not supported.
+	The special value '*' for <name> may be used to configure default
+	options for all branches.  Values for specific branch names will
+	override the this default.
 
 SEE ALSO
 --------
diff --git a/builtin/merge.c b/builtin/merge.c
index d171c63..9fe129f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,6 +32,13 @@
 #define NO_FAST_FORWARD (1<<2)
 #define NO_TRIVIAL      (1<<3)
 
+#define MERGEOPTIONS_DEFAULT (1<<0)
+#define MERGEOPTIONS_BRANCH (1<<1)
+
+struct merge_options_cb {
+	int override_default;
+};
+
 struct strategy {
 	const char *name;
 	unsigned attr;
@@ -505,24 +512,42 @@ cleanup:
 
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	int merge_option_mode = 0;
+	struct merge_options_cb *merge_options =
+		(struct merge_options_cb *)cb;
+
+	if (!strcmp(k, "branch.*.mergeoptions"))
+		merge_option_mode = MERGEOPTIONS_DEFAULT;
+	else if (branch && !prefixcmp(k, "branch.") &&
+			 !prefixcmp(k + 7, branch) &&
+			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
+		merge_option_mode = MERGEOPTIONS_BRANCH;
+
+	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
+		!merge_options->override_default) ||
+		merge_option_mode == MERGEOPTIONS_BRANCH) {
 		const char **argv;
 		int argc;
 		char *buf;
 
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
-		if (argc < 0)
-			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-			    split_cmdline_strerror(argc));
+		if (argc < 0) {
+			if (merge_option_mode == 1)
+				die(_("Bad merge.mergeoptions string: %s"), 
+					split_cmdline_strerror(argc));
+			else
+				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
+					split_cmdline_strerror(argc));
+		}
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
+		if (merge_option_mode == MERGEOPTIONS_BRANCH)
+			merge_options->override_default = 1;
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
@@ -987,6 +1012,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *head_arg;
 	int flag, head_invalid = 0, i;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
+	struct merge_options_cb merge_options = {0};
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
@@ -1004,7 +1030,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (is_null_sha1(head))
 		head_invalid = 1;
 
-	git_config(git_merge_config, NULL);
+	git_config(git_merge_config, &merge_options);
 
 	/* for color.ui */
 	if (diff_use_color_default == -1)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e84e822..cea2b31 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -415,6 +415,33 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (global no-ff)' '
+	git reset --hard c0 &&
+	git config --unset branch.master.mergeoptions &&
+	git config "branch.*.mergeoptions" "--no-ff" &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section "branch.*" &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
+test_expect_success 'combine merge.mergeoptions with branch.x.mergeoptions' '
+	git reset --hard c0 &&
+	git config --remove-section branch.master &&
+	git config "branch.*.mergeoptions" "--no-ff" &&
+	git config branch.master.mergeoptions "--ff" &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section "branch.*" &&
+	verify_merge file result.1 &&
+	verify_parents "$c0"
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --squash --no-ff c1 &&
 	test_must_fail git merge --no-ff --squash c1
-- 
1.7.5
