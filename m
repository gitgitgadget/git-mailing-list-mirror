From: Michael Grubb <devel@dailyvoid.com>
Subject: [PATCH v4] Add default merge options for all branches
Date: Tue, 03 May 2011 15:07:43 -0500
Message-ID: <4DC0608F.9040208@dailyvoid.com>
References: <20110503090351.GA27862@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, vmiklos@frugalware.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 22:07:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHLsx-0000ja-2k
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 22:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab1ECUHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 16:07:49 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:60597
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab1ECUHs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 16:07:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=MAQK6lFXKg8ps8WDvof1rZSO3chdhRtf9N2eOdNHYy1pT9ybgGT+5ugUHoB6KVxbomlmKRlRFyWEeNCw/B+nbFws6dZThIBQnOgbdJnFyr/Cs89bZ7aFR7RkOeYMoDBw;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHLsl-0002y1-WD; Tue, 03 May 2011 16:07:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110503090351.GA27862@elie>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172687>

Add support for branch.*.mergeoptions for setting default options for
all branches.  This new value shares semantics with the existing
branch.<name>.mergeoptions variable. If a branch specific value is
found, that value will be used.

The need for this arises from the fact that there is currently not an
easy way to set merge options for all branches. Instead of having to
specify merge options for each individual branch there should be a way
to set defaults for all branches and then override a specific branch's
options.

In order to facilitate future features centered around this new
"globlike" syntax a new struct has been created to keep track of the
branch.*.* options.  Currently it only supports branch.*.mergeoptions,
but can be easily modified in the future to support other branch
specific options as well. The mechanism will "vote" on specific-"ness"
of the configuration key and ultimately only use the most specific
options.  This is not cumulative but overriding.

Signed-off-by: Michael Grubb <devel@dailyvoid.com>
---
 Documentation/git-merge.txt |    3 +
 builtin/merge.c             |   90 +++++++++++++++++++++++++++++++++---------
 t/t7600-merge.sh            |   39 ++++++++++++++++++
 3 files changed, 112 insertions(+), 20 deletions(-)

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
index d171c63..d6ce85e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,6 +32,21 @@
 #define NO_FAST_FORWARD (1<<2)
 #define NO_TRIVIAL      (1<<3)
 
+/* This is for branch.<foo>. blocks
+ * the vote member holds a value between
+ * 0.0 and 1.0 which measures how closely
+ * a branch name matches the key member.
+ * where branch.*.mergeoptions would be 0.1 and
+ * branch.<name>.mergeoptions would be 1.0
+ * Also it is called vote because I couldn't come
+ * up with a better name.
+ */
+struct merge_options_cb {
+	char *key;
+	char *value;
+	float vote;
+};
+
 struct strategy {
 	const char *name;
 	unsigned attr;
@@ -503,28 +518,60 @@ cleanup:
 	strbuf_release(&bname);
 }
 
-static int git_merge_config(const char *k, const char *v, void *cb)
+static void parse_git_merge_options(const char *k, const char *v,
+			void *cb)
 {
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
-		const char **argv;
-		int argc;
-		char *buf;
-
-		buf = xstrdup(v);
-		argc = split_cmdline(buf, &argv);
-		if (argc < 0)
-			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-			    split_cmdline_strerror(argc));
-		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
-		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
-		argc++;
-		parse_options(argc, argv, NULL, builtin_merge_options,
-			      builtin_merge_usage, 0);
-		free(buf);
+	struct merge_options_cb *merge_options = cb;
+	int changed = 0;
+
+	/* We only handle mergeoptions for now */
+	if (suffixcmp(k, ".mergeoptions"))
+		return;
+
+	if (!prefixcmp(k, "branch.*") && merge_options->vote <= 0.1 ) {
+		merge_options->vote = 0.1;
+		changed = 1;
+	} else if (branch && !prefixcmp(k, "branch.") &&
+				!prefixcmp(k + 7, branch) &&
+				merge_options->vote < 1.0) {
+		merge_options->vote = 1.0;
+		changed = 1;
 	}
 
+	if (changed) {
+		merge_options->key = (char *)k;
+		merge_options->value = (char *)v;
+	}
+}
+
+static void apply_merge_options(struct merge_options_cb *opts)
+{
+	const char **argv;
+	int argc;
+	char *buf;
+
+	if ( opts == NULL )
+		return;
+
+	buf = xstrdup(opts->value);
+	argc = split_cmdline(buf, &argv);
+	if (argc < 0)
+		die(_("Bad %s string: %s"), 
+			opts->key, split_cmdline_strerror(argc));
+
+	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
+	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+	argc++;
+	parse_options(argc, argv, NULL, builtin_merge_options,
+			  builtin_merge_usage, 0);
+	free(buf);
+}
+
+static int git_merge_config(const char *k, const char *v, void *cb)
+{
+	if (cb != NULL && branch && !prefixcmp(k, "branch."))
+		parse_git_merge_options(k, v, cb);
+
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
@@ -987,6 +1034,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *head_arg;
 	int flag, head_invalid = 0, i;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
+	struct merge_options_cb merge_options = {NULL, NULL, 0.0};
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
@@ -1004,7 +1052,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (is_null_sha1(head))
 		head_invalid = 1;
 
-	git_config(git_merge_config, NULL);
+	git_config(git_merge_config, &merge_options);
+	if (merge_options.key != NULL && merge_options.value != NULL)
+		apply_merge_options(&merge_options);
 
 	/* for color.ui */
 	if (diff_use_color_default == -1)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e84e822..5b1f8e1 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -415,6 +415,45 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (default no-ff)' '
+	git reset --hard c0 &&
+	test_might_fail git config --unset branch.master.mergeoptions &&
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
+test_expect_success 'combine branch.*.mergeoptions with branch.x.mergeoptions' '
+	git reset --hard c0 &&
+	test_might_fail git config --remove-section branch.master &&
+	git config "branch.*.mergeoptions" "--no-ff" &&
+	git config branch.master.mergeoptions "--ff" &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section "branch.*" &&
+	verify_merge file result.1 &&
+	verify_parents "$c0"
+'
+
+test_expect_success 'reverse branch.x.mergeoptions with branch.*.mergeoptions' '
+	git reset --hard c0 &&
+	test_might_fail git config --remove-section branch.master &&
+	git config branch.master.mergeoptions "--ff" &&
+	git config "branch.*.mergeoptions" "--no-ff" &&
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
