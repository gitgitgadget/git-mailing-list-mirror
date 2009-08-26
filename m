From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 15:05:08 -0400
Message-ID: <20090826190508.GA2863@coredump.intra.peff.net>
References: <20090826121600.GA29098@atjola.homenet>
 <1251298007-18693-1-git-send-email-catap@catap.ru>
 <20090826155029.GA5750@atjola.homenet>
 <20090826161059.GC32741@coredump.intra.peff.net>
 <20090826165618.GA7477@atjola.homenet>
 <20090826174823.GA1202@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kirill A. Korinskiy" <catap@catap.ru>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgNoA-0003t4-9i
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZHZTFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 15:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZHZTFL
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 15:05:11 -0400
Received: from peff.net ([208.65.91.99]:39140 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbZHZTFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 15:05:10 -0400
Received: (qmail 24164 invoked by uid 107); 26 Aug 2009 19:05:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 26 Aug 2009 15:05:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2009 15:05:08 -0400
Content-Disposition: inline
In-Reply-To: <20090826174823.GA1202@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127113>

On Wed, Aug 26, 2009 at 01:48:23PM -0400, Jeff King wrote:

> Later in the code, we look at head_points_at->peer_ref, which means it
> _must_ come from mapped_refs. And which means the code I posted is
> bogus, as the ref we look up in "refs" will not have that member filled
> in. So I think we do need:
> 
>   head_points_at = find_ref_by_name(mapped_refs, branch_head.buf);

Actually, it is much more complicated than that. We want to do several
things with the remote HEAD:

  1. set up our HEAD; this uses head_points_at now

  2. set up a pointer in refs/remotes/$origin/HEAD; this uses
     head_points_at now

  3. check out the actual contents; this uses remote_head (and it can't
     just blindly use head_points_at, because it may be a detached HEAD).

So you can see by (1) and (2) that we actually need to distinguish
between the remote's HEAD and where we want our HEAD to be. And we need
to checkout _our_ HEAD, if available, falling back to the remote's head.

I really wish clone was implemented simply as "init && remote add &&
fetch && checkout", which would have made this a lot easier. We would
simply be munging the HEAD file in the middle.

Anyway, here is a patch which I think does the right thing, and tests
each of the desired behaviors in the test script. If there are further
"should it do X or Y" questions, please phrase them in the form of a
patch to the test script. ;)

I also tried to roll in comments on the documentation to make it a bit
clearer.

-- >8 --
Subject: [PATCH] clone: add --branch option to select a different HEAD

We currently point the HEAD of a newly cloned repo to the
same ref as the parent repo's HEAD. While a user can then
"git checkout -b foo origin/foo" whichever branch they
choose, it is more convenient and more efficient to tell
clone which branch you want in the first place.

Based on a patch by Kirill A. Korinskiy.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |    7 ++++
 builtin-clone.c             |   75 +++++++++++++++++++++++++++----------------
 t/t5706-clone-branch.sh     |   68 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 28 deletions(-)
 create mode 100755 t/t5706-clone-branch.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2c63a0f..1cd1ecc 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -127,6 +127,13 @@ objects from the source repository into a pack in the cloned repository.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name>.
 
+--branch <name>::
+-b <name>::
+	Instead of pointing the newly created HEAD to the branch pointed
+	to by the cloned repositoroy's HEAD, point to <name> branch
+	instead. In a non-bare repository, this is the branch that will
+	be checked out.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..9d79301 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -41,6 +41,7 @@ static int option_quiet, option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
+static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbose;
 
@@ -65,6 +66,8 @@ static struct option builtin_clone_options[] = {
 		   "reference repository"),
 	OPT_STRING('o', "origin", &option_origin, "branch",
 		   "use <branch> instead of 'origin' to track upstream"),
+	OPT_STRING('b', "branch", &option_branch, "branch",
+		   "checkout <branch> instead of the remote's HEAD"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
@@ -347,7 +350,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	const struct ref *refs, *remote_head, *mapped_refs;
+	const struct ref *remote_head_points_at;
+	const struct ref *our_head_points_at;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
@@ -519,11 +524,31 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		mapped_refs = write_remote_refs(refs, refspec, reflog_msg.buf);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
-		head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
+		remote_head_points_at =
+			guess_remote_head(remote_head, mapped_refs, 0);
+
+		if (option_branch) {
+			struct strbuf head = STRBUF_INIT;
+			strbuf_addstr(&head, src_ref_prefix);
+			strbuf_addstr(&head, option_branch);
+			our_head_points_at =
+				find_ref_by_name(mapped_refs, head.buf);
+			strbuf_release(&head);
+
+			if (!our_head_points_at) {
+				warning("Remote branch %s not found in "
+					"upstream %s, using HEAD instead",
+					option_branch, option_origin);
+				our_head_points_at = remote_head_points_at;
+			}
+		}
+		else
+			our_head_points_at = remote_head_points_at;
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
-		head_points_at = NULL;
+		our_head_points_at = NULL;
+		remote_head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
@@ -531,41 +556,35 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					      "refs/heads/master");
 	}
 
-	if (head_points_at) {
-		/* Local default branch link */
-		create_symref("HEAD", head_points_at->name, NULL);
+	if (remote_head_points_at && !option_bare) {
+		struct strbuf head_ref = STRBUF_INIT;
+		strbuf_addstr(&head_ref, branch_top.buf);
+		strbuf_addstr(&head_ref, "HEAD");
+		create_symref(head_ref.buf,
+			      remote_head_points_at->peer_ref->name,
+			      reflog_msg.buf);
+	}
 
+	if (our_head_points_at) {
+		/* Local default branch link */
+		create_symref("HEAD", our_head_points_at->name, NULL);
 		if (!option_bare) {
-			struct strbuf head_ref = STRBUF_INIT;
-			const char *head = head_points_at->name;
-
-			if (!prefixcmp(head, "refs/heads/"))
-				head += 11;
-
-			/* Set up the initial local branch */
-
-			/* Local branch initial value */
+			const char *head = skip_prefix(our_head_points_at->name,
+						       "refs/heads/");
 			update_ref(reflog_msg.buf, "HEAD",
-				   head_points_at->old_sha1,
+				   our_head_points_at->old_sha1,
 				   NULL, 0, DIE_ON_ERR);
-
-			strbuf_addstr(&head_ref, branch_top.buf);
-			strbuf_addstr(&head_ref, "HEAD");
-
-			/* Remote branch link */
-			create_symref(head_ref.buf,
-				      head_points_at->peer_ref->name,
-				      reflog_msg.buf);
-
 			install_branch_config(0, head, option_origin,
-					      head_points_at->name);
+					      our_head_points_at->name);
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
-		if (!option_bare)
+		if (!option_bare) {
 			update_ref(reflog_msg.buf, "HEAD",
 				   remote_head->old_sha1,
 				   NULL, REF_NODEREF, DIE_ON_ERR);
+			our_head_points_at = remote_head;
+		}
 	} else {
 		/* Nothing to checkout out */
 		if (!option_no_checkout)
@@ -597,7 +616,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		opts.src_index = &the_index;
 		opts.dst_index = &the_index;
 
-		tree = parse_tree_indirect(remote_head->old_sha1);
+		tree = parse_tree_indirect(our_head_points_at->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
 		unpack_trees(1, &t, &opts);
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
new file mode 100755
index 0000000..f3f9a76
--- /dev/null
+++ b/t/t5706-clone-branch.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='clone --branch option'
+. ./test-lib.sh
+
+check_HEAD() {
+	echo refs/heads/"$1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+}
+
+check_file() {
+	echo "$1" >expect &&
+	test_cmp expect file
+}
+
+test_expect_success 'setup' '
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file && git commit -m one &&
+	 git checkout -b two &&
+	 echo two >file && git add file && git commit -m two &&
+	 git checkout master)
+'
+
+test_expect_success 'vanilla clone chooses HEAD' '
+	git clone parent clone &&
+	(cd clone &&
+	 check_HEAD master &&
+	 check_file one
+	)
+'
+
+test_expect_success 'clone -b chooses specified branch' '
+	git clone -b two parent clone-two &&
+	(cd clone-two &&
+	 check_HEAD two &&
+	 check_file two
+	)
+'
+
+test_expect_success 'clone -b sets up tracking' '
+	(cd clone-two &&
+	 echo origin >expect &&
+	 git config branch.two.remote >actual &&
+	 echo refs/heads/two >>expect &&
+	 git config branch.two.merge >>actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'clone -b does not munge remotes/origin/HEAD' '
+	(cd clone-two &&
+	 echo refs/remotes/origin/master >expect &&
+	 git symbolic-ref refs/remotes/origin/HEAD >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'clone -b with bogus branch chooses HEAD' '
+	git clone -b bogus parent clone-bogus &&
+	(cd clone-bogus &&
+	 check_HEAD master &&
+	 check_file one
+	)
+'
+
+test_done
-- 
1.6.4.1.340.ge9f66.dirty
