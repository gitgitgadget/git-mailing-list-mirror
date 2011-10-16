From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Sun, 16 Oct 2011 13:37:04 -0700
Message-ID: <7vy5wkptan.fsf@alter.siamese.dyndns.org>
References: <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org>
 <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
 <loom.20111013T171530-970@post.gmane.org>
 <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
 <loom.20111013T193054-868@post.gmane.org>
 <7vzkh44ug1.fsf@alter.siamese.dyndns.org>
 <loom.20111013T203610-130@post.gmane.org>
 <20111014013830.GA7258@sigill.intra.peff.net> <4E980093.6040704@ira.uka.de>
 <20111014095447.GC2856@victor.terreactive.ch>
 <loom.20111016T201930-426@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 22:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFXSg-0008SP-J5
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 22:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab1JPUha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 16:37:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab1JPUhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 16:37:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A349557F;
	Sun, 16 Oct 2011 16:37:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=agqaGQfjaoxy67jxMMa7knXdJO8=; b=YAtNiR
	0ZBMyAPZABwsN7WbD2wI+tMRqqpB4yrkVZ1h+vOoKob9Ftis+EjJhdnGp9bucvMC
	ACkhfWV2AdW2B5NvfAoS1imlmWnj2qxkcjpL6L2jF4pmjeiKRBGnGiIhXKUIfMIq
	gvSvqlWLGo3ey9Cfv8P2+JzFtgR9A7SRYIv4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fHeL7vMHuqgbOkBl/tcbIcQNUbZmgskD
	bfaE334rZvINoCwKWCYNi+wIYSaueNlNhg6HZSy1pTUXPuAHvugL0O1n5e9Z8UlA
	giQY+9PP32pzvEzB/EK+Sj1ORlb+ogXMzyr0qs/THZjiA1bhQ/7Eje3pTBPJSa8w
	qcEYqGYhUB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62277557E;
	Sun, 16 Oct 2011 16:37:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC96D557D; Sun, 16 Oct 2011
 16:37:05 -0400 (EDT)
In-Reply-To: <loom.20111016T201930-426@post.gmane.org> (arqon@gmx.com's
 message of "Sun, 16 Oct 2011 18:25:03 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C694490-F836-11E0-A11C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183734>

arQon <arqon@gmx.com> writes:

> ... better *behavior* is a
> clear win either way.

I doubt the full status output is better behaviour. For one thing, you do
not need full status as by definition branch switching would only have
local changes as a result (i.e. you will not see "Changes to be committed"
section).

But if you really do not want to learn how to read "diff --name-status"
output, here is a patch to allow you say "git checkout -v other_branch".
Hopefully it will help you convince yourself why it is not a better
behaviour.

 builtin/checkout.c |   46 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 49a547a..0c21556 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -28,7 +28,7 @@ static const char * const checkout_usage[] = {
 };
 
 struct checkout_opts {
-	int quiet;
+	int verbosity;
 	int merge;
 	int force;
 	int force_detach;
@@ -291,10 +291,10 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	return errs;
 }
 
-static void show_local_changes(struct object *head, struct diff_options *opts)
+static void show_local_changes_brief(struct object *head, struct diff_options *opts)
 {
 	struct rev_info rev;
-	/* I think we want full paths, even if we're in a subdirectory. */
+
 	init_revisions(&rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
@@ -304,6 +304,26 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
 	run_diff_index(&rev, 0);
 }
 
+static void show_local_changes_status(void)
+{
+	const char *argv[] = { "status", NULL };
+
+	run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static void show_local_changes(struct checkout_opts *opts,
+			       struct object *head,
+			       struct diff_options *diffopts)
+{
+	if (opts->force || opts->verbosity < 0)
+		return;
+
+	if (0 < opts->verbosity)
+		show_local_changes_status();
+	else
+		show_local_changes_brief(head, diffopts);
+}
+
 static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -326,7 +346,7 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet;
+	opts.verbose_update = (0 <= o->verbosity);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -403,7 +423,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet;
+		topts.verbose_update = (0 <= opts->verbosity);
 		topts.fn = twoway_merge;
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
@@ -478,9 +498,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
 
-	if (!opts->force && !opts->quiet)
-		show_local_changes(&new->commit->object, &opts->diff_options);
-
 	return 0;
 }
 
@@ -552,14 +569,14 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
-		if (!opts->quiet) {
+		if (0 <= opts->verbosity) {
 			if (old->path && advice_detached_head)
 				detach_advice(old->path, new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
-		if (!opts->quiet) {
+		if (0 <= opts->verbosity) {
 			if (old->path && !strcmp(new->path, old->path)) {
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
@@ -584,7 +601,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
-	if (!opts->quiet &&
+	if (0 <= opts->verbosity &&
 	    (new->path || (!opts->force_detach && !strcmp(new->name, "HEAD"))))
 		report_tracking(new);
 }
@@ -717,13 +734,16 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	if (ret)
 		return ret;
 
-	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
+	if (0 <= opts->verbosity && !old.path && old.commit && new->commit != old.commit)
 		orphaned_commit_warning(old.commit);
 
 	update_refs_for_switch(opts, &old, new);
 
 	ret = post_checkout_hook(old.commit, new->commit, 1);
 	free((char *)old.path);
+
+	show_local_changes(opts, &new->commit->object, &opts->diff_options);
+
 	return ret || opts->writeout_error;
 }
 
@@ -906,7 +926,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
+		OPT__VERBOSITY(&opts.verbosity),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
