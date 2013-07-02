From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH v2] merge: handle --ff/--no-ff/--ff-only as a tri-state option
Date: Tue, 2 Jul 2013 16:47:57 +0200
Message-ID: <20130702144757.GG5317@suse.cz>
References: <20130701070143.GB17269@suse.cz>
 <51D197AD.1070502@alum.mit.edu>
 <20130701195407.GK17269@suse.cz>
 <51D2927F.3040207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 02 16:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu1sI-0006zE-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 16:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab3GBOsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 10:48:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50998 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab3GBOsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 10:48:04 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 6404BA4EB7;
	Tue,  2 Jul 2013 16:48:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51D2927F.3040207@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229397>

This has multiple benefits: with more than one of {"--ff", "--no-ff",
"--ff-only"} respects the last option; also the command-line option to
always take precedence over the config file option.

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---
 builtin/merge.c  | 55 +++++++++++++++++++++++++++++++++----------------------
 t/t7600-merge.sh | 12 +++++++++---
 2 files changed, 42 insertions(+), 25 deletions(-)

On Tue, Jul 02, 2013 at 10:42:39AM +0200, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> You allow --no-ff-only but ignore it, which I think is incorrect.  In
> 
>     git merge --ff-only --no-ff-only [...]
> 
> , the --no-ff-only should presumably cancel the effect of the previous
> --ff-only (i.e., be equivalent to "--ff").  But it is a little bit
> subtle because
> 
>     git merge --no-ff --no-ff-only
> 
> should presumably be equivalent to --no-ff.  So I think that
> "--no-ff-only" should do something like
> 
>     if (fast_forward == FF_ONLY)
>         fast_forward = FF_ALLOW;

Do we really want --no-ff-only? I would rather just disable it, see the
updated patch.

> I'm no options guru, but I think it would be possible to implement --ff
> and --no-ff without callbacks if you choose constants such that
> FF_NO==0, something like:

Indeed, done.

> Should these do the same as the versions with the option order reversed?
>  Or should the command line option that appears later take precedence?
> The latter implies that {--ff, --no-ff, --ff-only, --squash} actually
> constitute a single *quad-state* option, representing "how the results
> of the merge should be handled", and, for example,
> 
>     git merge --squash --ff-only
> 
> ignores the --squash option, and
> 
>     git merge --ff-only --squash
> 
> ignores the --ff-only option.
> 
> I'm not sure.

Actually there is also --no-squash, used by e.g. git-pull internally.
You definitely don't want a five-state option. :-) So for now I would
rather let --squash/--no-squash alone.

diff --git a/builtin/merge.c b/builtin/merge.c
index 2ebe732..149f32a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -47,8 +47,8 @@ static const char * const builtin_merge_usage[] = {
 };
 
 static int show_diffstat = 1, shortlog_len = -1, squash;
-static int option_commit = 1, allow_fast_forward = 1;
-static int fast_forward_only, option_edit = -1;
+static int option_commit = 1;
+static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
@@ -76,6 +76,14 @@ static struct strategy all_strategy[] = {
 
 static const char *pull_twohead, *pull_octopus;
 
+enum ff_type {
+	FF_NO,
+	FF_ALLOW,
+	FF_ONLY
+};
+
+static enum ff_type fast_forward = FF_ALLOW;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -178,6 +186,13 @@ static int option_parse_n(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_ff_only(const struct option *opt,
+			  const char *arg, int unset)
+{
+	fast_forward = FF_ONLY;
+	return 0;
+}
+
 static struct option builtin_merge_options[] = {
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		N_("do not show a diffstat at the end of the merge"),
@@ -194,10 +209,10 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
-	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
-		N_("allow fast-forward (default)")),
-	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
-		N_("abort if fast-forward is not possible")),
+	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
+	{ OPTION_CALLBACK, 0, "ff-only", NULL, NULL,
+		N_("abort if fast-forward is not possible"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, option_parse_ff_only },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
@@ -581,10 +596,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_config_maybe_bool(k, v);
 		if (0 <= boolval) {
-			allow_fast_forward = boolval;
+			fast_forward = boolval ? FF_ALLOW : FF_NO;
 		} else if (v && !strcmp(v, "only")) {
-			allow_fast_forward = 1;
-			fast_forward_only = 1;
+			fast_forward = FF_ONLY;
 		} /* do not barf on values from future versions of git */
 		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
@@ -863,7 +877,7 @@ static int finish_automerge(struct commit *head,
 
 	free_commit_list(common);
 	parents = remoteheads;
-	if (!head_subsumed || !allow_fast_forward)
+	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
@@ -1008,7 +1022,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
-	if (!allow_fast_forward)
+	if (fast_forward == FF_NO)
 		strbuf_addf(&buf, "no-ff");
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
 		die_errno(_("Could not write to '%s'"), filename);
@@ -1157,14 +1171,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		show_diffstat = 0;
 
 	if (squash) {
-		if (!allow_fast_forward)
+		if (fast_forward == FF_NO)
 			die(_("You cannot combine --squash with --no-ff."));
 		option_commit = 0;
 	}
 
-	if (!allow_fast_forward && fast_forward_only)
-		die(_("You cannot combine --no-ff with --ff-only."));
-
 	if (!abort_current_merge) {
 		if (!argc) {
 			if (default_to_upstream)
@@ -1206,7 +1217,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				"empty head"));
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
-		if (!allow_fast_forward)
+		if (fast_forward == FF_NO)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
 		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
@@ -1294,11 +1305,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
-		if (!fast_forward_only &&
+		if (fast_forward != FF_ONLY &&
 		    merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
 		    merge_remote_util(commit)->obj->type == OBJ_TAG)
-			allow_fast_forward = 0;
+			fast_forward = FF_NO;
 	}
 
 	if (option_edit < 0)
@@ -1315,7 +1326,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < use_strategies_nr; i++) {
 		if (use_strategies[i]->attr & NO_FAST_FORWARD)
-			allow_fast_forward = 0;
+			fast_forward = FF_NO;
 		if (use_strategies[i]->attr & NO_TRIVIAL)
 			allow_trivial = 0;
 	}
@@ -1345,7 +1356,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		finish_up_to_date("Already up-to-date.");
 		goto done;
-	} else if (allow_fast_forward && !remoteheads->next &&
+	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
 			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
 		/* Again the most common case of merging one remote. */
@@ -1392,7 +1403,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * only one common.
 		 */
 		refresh_cache(REFRESH_QUIET);
-		if (allow_trivial && !fast_forward_only) {
+		if (allow_trivial && fast_forward != FF_ONLY) {
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
@@ -1433,7 +1444,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward_only)
+	if (fast_forward == FF_ONLY)
 		die(_("Not possible to fast-forward, aborting."));
 
 	/* We are going to make a new commit. */
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 460d8eb..3ff5fb8 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -497,9 +497,15 @@ test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --no-ff --squash c1
 '
 
-test_expect_success 'combining --ff-only and --no-ff is refused' '
-	test_must_fail git merge --ff-only --no-ff c1 &&
-	test_must_fail git merge --no-ff --ff-only c1
+test_expect_success 'option --ff-only overwrites --no-ff' '
+	git merge --no-ff --ff-only c1 &&
+	test_must_fail git merge --no-ff --ff-only c2
+'
+
+test_expect_success 'option --ff-only overwrites merge.ff=only config' '
+	git reset --hard c0 &&
+	test_config merge.ff only &&
+	git merge --no-ff c1
 '
 
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
-- 
1.8.1.4
