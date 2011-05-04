From: Michael Grubb <devel@dailyvoid.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Wed, 04 May 2011 13:58:04 -0500
Message-ID: <4DC1A1BC.5010601@dailyvoid.com>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com> <20110503204442.GI1019@elie> <7vsjsvgzzf.fsf@alter.siamese.dyndns.org> <7vzkn3f5wo.fsf@alter.siamese.dyndns.org> <4DC0D605.20204@dailyvoid.com> <20110504045802.GF8187@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHhH8-0001yn-Ig
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab1EDS6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:58:12 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:42046
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab1EDS6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:58:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=j2LaSKYbB4HmwOWxG4QUbvo6RJE3z4teiAqgykXc9eSP5vQQfh3aEcnIdqya2AkBvOiFrTFiLmUkP0mX/JLdTLHKGRYmWZW86G8m7K8gtw3I/5hmioXAqfBJcsqEIsMn;
Received: from [99.59.251.170] (helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHhGv-00011i-8q; Wed, 04 May 2011 14:58:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110504045802.GF8187@elie>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172760>

Well, it certainly serves *my* immediate needs and addresses the specific use case that I was originally working on.  Though I think that what we've come up with would benefit the codebase in general if for no other reason than it lays some ground work for future features and is a bit more generic.  I also wouldn't mind going a step further and working on the globbing feature in a separate series.

Here are some corrections to the previous patch:

This patch makes the branch specific options more flexible by laying
the ground work for supporting globs for the branch names.
At this time only the value '*' is supported which will set default
values for all branches.  In the future this may be expanded to support
true globbing.

Signed-off-by: Michael Grubb <devel@dailyvoid.com>
---
 builtin/merge.c  |  120 ++++++++++++++++++++++++++++++++++-------------------
 t/t7600-merge.sh |   27 ++++++++----
 2 files changed, 95 insertions(+), 52 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index fa56205..9e6ec5f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -31,20 +31,12 @@
 #define DEFAULT_OCTOPUS (1<<1)
 #define NO_FAST_FORWARD (1<<2)
 #define NO_TRIVIAL      (1<<3)
+#define MERGE_OPTIONS_INIT {NULL, NULL, NULL}
 
-/* This is for branch.<foo>. blocks
- * the vote member holds a value between
- * 0.0 and 1.0 which measures how closely
- * a branch name matches the key member.
- * where branch.*.mergeoptions would be 0.1 and
- * branch.<name>.mergeoptions would be 1.0
- * Also it is called vote because I couldn't come
- * up with a better name.
- */
 struct merge_options_cb {
-	char *key;
-	char *value;
-	float vote;
+	char *option;
+	char *spec;
+	char *name;
 };
 
 struct strategy {
@@ -518,30 +510,11 @@ cleanup:
 	strbuf_release(&bname);
 }
 
-static void parse_git_merge_options(const char *k, const char *v,
-			void *cb)
+static void free_merge_options_cb(struct merge_options_cb *data)
 {
-	struct merge_options_cb *merge_options = cb;
-	int changed = 0;
-
-	/* We only handle mergeoptions for now */
-	if (suffixcmp(k, ".mergeoptions"))
-		return;
-
-	if (!prefixcmp(k, "branch.*") && merge_options->vote <= 0.1 ) {
-		merge_options->vote = 0.1;
-		changed = 1;
-	} else if (branch && !prefixcmp(k, "branch.") &&
-				!prefixcmp(k + 7, branch) &&
-				merge_options->vote < 1.0) {
-		merge_options->vote = 1.0;
-		changed = 1;
-	}
-
-	if (changed) {
-		merge_options->key = (char *)k;
-		merge_options->value = (char *)v;
-	}
+	free(data->option);
+	free(data->spec);
+	free(data->name);
 }
 
 static void apply_merge_options(struct merge_options_cb *opts)
@@ -550,26 +523,85 @@ static void apply_merge_options(struct merge_options_cb *opts)
 	int argc;
 	char *buf;
 
-	if ( opts == NULL )
+	if (!opts)
 		return;
 
-	buf = xstrdup(opts->value);
+	buf = xstrdup(opts->option);
 	argc = split_cmdline(buf, &argv);
 	if (argc < 0)
-		die(_("Bad %s string: %s"),
-			opts->key, split_cmdline_strerror(argc));
+		die(_("Bad branch.%s.%s string: %s"),
+			opts->spec, opts->name, split_cmdline_strerror(argc));
 
 	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 	argc++;
 	parse_options(argc, argv, NULL, builtin_merge_options,
-			  builtin_merge_usage, 0);
+		builtin_merge_usage, 0);
 	free(buf);
 }
 
+/*
+ * This function returns -1 if the first argument is less specific
+ * than the second, and 1 vice versa. Returns -1 if both arguments
+ * are the same.
+ */
+static int cmp_specificity(const char *a, const char *b)
+{
+	switch((!strcmp(a, "*") ? 2 : 0) |
+		(!strcmp(b, "*") ? 1 : 0)) {
+	case 3:
+	case 0:
+		return -1; /* later one wins if they are the same */
+	case 1:
+		return 1;
+	case 2:
+		return -1;
+	}
+	return 0; /* should never happen */
+}
+
+static void parse_git_merge_options(const char *k, const char *v,
+			void *cb)
+{
+	struct merge_options_cb *merge_options = cb;
+	char *spec, *eon; /* end-of-name */
+
+	k += 7; /* not interested in the leading "branch." */
+	eon = strrchr(k, '.');
+	if (!eon || strcmp(eon, ".mergeoptions"))
+		return;
+
+	/* k through eon is name or glob */
+	spec = xmemdupz(k, eon - k);
+	/*
+	 * NEEDSWORK: for now we say "*" matches; we would need
+	 * to turn the following into something like:
+	 *	if (has_wildcard(spec)
+	 *		? !glob_matches(spec, branch)
+	 *		: strcmp(spec, branch)) {
+	 *		free(spec);
+	 *		return;
+	 *	}
+	 */
+	if (strcmp(spec, "*") && strcmp(spec, branch)) {
+		free(spec);
+		return;
+	}
+
+	if (!merge_options->option ||
+			cmp_specificity(merge_options->spec, spec) < 0) {
+		free_merge_options_cb(merge_options);
+		merge_options->option = xstrdup(v);
+		merge_options->name = xstrdup(eon + 1);
+		merge_options->spec = spec;
+		return;
+	}
+	free(spec);
+}
+
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
-	if (cb != NULL && branch && !prefixcmp(k, "branch."))
+	if (branch && !prefixcmp(k, "branch."))
 		parse_git_merge_options(k, v, cb);
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
@@ -1034,7 +1066,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *head_arg;
 	int flag, head_invalid = 0, i;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
-	struct merge_options_cb merge_options = {NULL, NULL, 0.0};
+	struct merge_options_cb merge_options = MERGE_OPTIONS_INIT;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
@@ -1053,8 +1085,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_invalid = 1;
 
 	git_config(git_merge_config, &merge_options);
-	if (merge_options.key != NULL && merge_options.value != NULL)
+	if (merge_options.option) {
 		apply_merge_options(&merge_options);
+		free_merge_options_cb(&merge_options);
+	}
 
 	/* for color.ui */
 	if (diff_use_color_default == -1)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5b1f8e1..d7a60b2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -417,37 +417,46 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (default no-ff)' '
 	git reset --hard c0 &&
-	test_might_fail git config --unset branch.master.mergeoptions &&
-	git config "branch.*.mergeoptions" "--no-ff" &&
+	cat >.git/config <<-\EOF &&
+	[branch "*"]
+		mergeoptions = --no-ff
+	EOF
 	test_tick &&
 	git merge c1 &&
 	git config --remove-section "branch.*" &&
 	verify_merge file result.1 &&
 	verify_parents $c0 $c1
 '
-
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'combine branch.*.mergeoptions with branch.x.mergeoptions' '
 	git reset --hard c0 &&
-	test_might_fail git config --remove-section branch.master &&
-	git config "branch.*.mergeoptions" "--no-ff" &&
-	git config branch.master.mergeoptions "--ff" &&
+	cat >.git/config <<-\EOF &&
+	[branch "*"]
+		mergeoptions = --no-ff
+	[branch "master"]
+		mergeoptions = --ff
+	EOF
 	test_tick &&
 	git merge c1 &&
 	git config --remove-section "branch.*" &&
+	git config --remove-section "branch.master" &&
 	verify_merge file result.1 &&
 	verify_parents "$c0"
 '
 
 test_expect_success 'reverse branch.x.mergeoptions with branch.*.mergeoptions' '
 	git reset --hard c0 &&
-	test_might_fail git config --remove-section branch.master &&
-	git config branch.master.mergeoptions "--ff" &&
-	git config "branch.*.mergeoptions" "--no-ff" &&
+	cat >.git/config <<-\EOF &&
+	[branch "master"]
+		mergeoptions = --ff
+	[branch "*"]
+		mergeoptions = --no-ff
+	EOF
 	test_tick &&
 	git merge c1 &&
 	git config --remove-section "branch.*" &&
+	git config --remove-section "branch.master" &&
 	verify_merge file result.1 &&
 	verify_parents "$c0"
 '
-- 
1.7.5



On 5/3/11 11:58 PM, Jonathan Nieder wrote:
> Michael Grubb wrote:
> 
>> I take this to mean that my patch is no longer needed/wanted?
> 
> No, as usual it means that Junio was thinking and sent us his
> thoughts.
> 
> Do you like it?  If so, the way to move it forward would be to add
> tests and write a commit log message.  If not, the way to move things
> forward would be to explain what use case it misses and work on a
> better patch that takes care of them.
> 
> Hope that helps,
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
