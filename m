From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 02 Sep 2008 13:02:31 -0700
Message-ID: <7v1w02l3jc.fsf@gitster.siamese.dyndns.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
 <20080819125429.GD17582@genesis.frugalware.org>
 <7vabf83j9u.fsf@gitster.siamese.dyndns.org>
 <20080819205917.GJ23800@genesis.frugalware.org>
 <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
 <20080901010612.GC16514@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kac6M-0004Zs-0W
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYIBUCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYIBUCk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:02:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYIBUCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:02:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C15575B1B8;
	Tue,  2 Sep 2008 16:02:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B54E5B1B6; Tue,  2 Sep 2008 16:02:33 -0400 (EDT)
In-Reply-To: <20080901010612.GC16514@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 1 Sep 2008 03:06:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 174B7550-792A-11DD-B9A8-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94699>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I tried to let cmd_revert() use merge_trees() only and not
> merge_recursive_generic(), but something is fishy with it.

> t3501-revert-cherry-pick passes fine, but t3404-rebase-interactive fail,
> becase once we have a conflict, git diff --name-status says 'M' for the
> given file and not 'U', which is obviously wrong.

I think this is because you are forgotting to write the index file out.
You are calling "git commit -n" at the end if a cherry-pick/revert is
clean, or giving the user back an unmerged state in the index otherwise.
In either case, after merge_trees() gives you a potentially unmerged index
back in-core, you need to write it to the $GIT_INDEX_FILE for later users.

Also notice that your output is awfully silent.  You are forgetting to
flush the buffered output that is kept in "obuf".

Please check what other extra things merge_recursive() function does that
merge_trees() doesn't; the above two are what I've spotted by code
inspection, but there may be others.  It could be an indication of
incorrect interface layering when the builtin was refactored.

I found it a bit disturbing that "index_only" and "call_depth" were not
part of merge_options structure.  The machinery is not yet meant to be
reentrant, so we may rely the previous call to the function (either
merge_recursive() or merge_trees() revert them to a sane initial value,
but it is a bit unnerving, having to depend on that assumption.

I think your code happily dereferences NULL when picking the root commit
is involved, although I do not think the failure in the test suite you saw
is related to this omission.

Here is a partial fix to address the above issues I noticed on
top of your version; untested.

 builtin-revert.c |   46 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 36 insertions(+), 10 deletions(-)

diff --git i/builtin-revert.c w/builtin-revert.c
index 3071518..41f3ca2 100644
--- i/builtin-revert.c
+++ w/builtin-revert.c
@@ -234,16 +234,27 @@ static int index_is_dirty(void)
 	return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
 }
 
+static struct tree *empty_tree(void)
+{
+	struct tree *tree = xcalloc(1, sizeof(struct tree));
+
+	tree->object.parsed = 1;
+	tree->object.type = OBJ_TREE;
+	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
+	return tree;
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
-	int i;
+	int i, index_fd, clean;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 	struct merge_options o;
-	struct tree *result;
+	struct tree *result, *next_tree, *base_tree, *head_tree;
+	static struct lock_file index_lock;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -254,6 +265,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (action == REVERT && !no_replay)
 		die("revert is incompatible with replay");
 
+	index_fd = hold_locked_index(&index_lock, 1);
+
+	if (read_cache() < 0)
+		die("git %s: failed to read the index", me);
 	if (no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
@@ -266,12 +281,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	} else {
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
-		if (read_cache() < 0)
-			die("could not read the index");
 		if (index_is_dirty())
 			die ("Dirty index: cannot %s", me);
-		discard_cache();
 	}
+	discard_cache();
 
 	if (!commit->parents) {
 		if (action == REVERT)
@@ -305,6 +318,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
 
+	if (parent && parse_commit(parent) < 0)
+		die("%s: cannot parse parent commit %s",
+		    me, sha1_to_hex(parent->object.sha1));
+
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -351,11 +368,20 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
 	o.branch2 = oneline;
-	parse_commit(next);
-	parse_commit(base);
-	if (!merge_trees(&o, lookup_commit_reference_gently(head, 0)->tree,
-				next->tree, base->tree, &result) ||
-		write_cache_as_tree(head, 0, NULL)) {
+
+	head_tree = parse_tree_indirect(head);
+	next_tree = next ? next->tree : empty_tree();
+	base_tree = base ? base->tree : empty_tree();
+
+	clean = merge_trees(&o,
+			    head_tree,
+			    next_tree, base_tree, &result);
+
+	if (write_cache(index_fd, active_cache, active_nr) ||
+	    commit_locked_index(&index_lock))
+		die("%s: Unable to write new index file", me);
+
+	if (!clean) {
 		add_to_msg("\nConflicts:\n\n");
 		for (i = 0; i < active_nr;) {
 			struct cache_entry *ce = active_cache[i++];
