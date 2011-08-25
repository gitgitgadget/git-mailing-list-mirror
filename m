From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] allow multiple calls to submodule merge search for the
	same path
Date: Thu, 25 Aug 2011 23:11:44 +0200
Message-ID: <20110825211144.GA67523@book.hvoigt.net>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <7v39gqo2fn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhDN-0000H4-5D
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1HYVLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:11:47 -0400
Received: from darksea.de ([83.133.111.250]:54200 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754476Ab1HYVLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:11:47 -0400
Received: (qmail 8695 invoked from network); 25 Aug 2011 23:11:45 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Aug 2011 23:11:45 +0200
Content-Disposition: inline
In-Reply-To: <7v39gqo2fn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180119>

When multiple merge-bases are found for two commits to be merged the
merge machinery will ask twice for a merge resolution. Currently its not
possible to use the revision-walking api for walking the same commits
multiple times. Thats why we now run the revision walking in a seperate
git process.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Hi,

On Wed, Aug 24, 2011 at 03:43:56PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> I have been suspecting that most of this should be done in a separate
> >> helper program that is run via run_command() interface, without
> >> contaminating the object pool the main merge process has with data from
> >> the submodule object store to begin with (i.e. add_submodule_odb() and
> >> everything below should go). Wouldn't it be a lot cleaner solution?
> >
> > Hmm, I would like to keep it in process. Since there are platforms where
> > spawning new processes is very slow.
> 
> Adding submodule's odb into the main process _will_ also have performance
> penalties because it will make it more expensive to look up objects that
> belong to the superproject when the superproject wants its own look up.
> 
> In case you haven't realized yet, walking revision graph multiple times
> while making sure that you do not affect other revision traversals in
> effect is hard to arrange right. But more importantly, correctness counts
> more than performing quickly and giving a bogus result with premature
> optimization that makes it harder to implement things correctly (and
> harder to verify the change is correct).

Yes of course correctness has priority one. And so here is a patch
implementing the rev-iteration using a seperate process. Once the
revision walking api is able to walk multiple times we get back to it
again.

I noticed that the suggestion for the merge resolution presented is
wrong which Brad also seems to have found as presented in his patch in
message:

<438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>

But this breakage depends on the wrong output from rev-list with the
--ancestry-path option. This patch should be correct on its own.

 submodule.c                |   31 ++++++++++++++++++++++---------
 t/t7405-submodule-merge.sh |    2 +-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1ba9646..9820df7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -581,29 +581,42 @@ static int find_first_merges(struct object_array *result, const char *path,
 	char merged_revision[42];
 	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
 				   "--all", merged_revision, NULL };
-	struct rev_info revs;
-	struct setup_revision_opt rev_opts;
+	struct child_process cp;
+	struct strbuf one_rev = STRBUF_INIT;
 
 	memset(&merges, 0, sizeof(merges));
 	memset(result, 0, sizeof(struct object_array));
-	memset(&rev_opts, 0, sizeof(rev_opts));
+	memset(&cp, 0, sizeof(cp));
 
 	/* get all revisions that merge commit a */
 	snprintf(merged_revision, sizeof(merged_revision), "^%s",
 			sha1_to_hex(a->object.sha1));
-	init_revisions(&revs, NULL);
-	rev_opts.submodule = path;
-	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
+
+	cp.argv = rev_args;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.dir = path;
+	if (start_command(&cp))
+		die("Could not run 'git rev-list --merges --ancestry-path --all %s' "
+				"command in submodule %s", merged_revision, path);
+	FILE *out = fdopen(cp.out, "r");
+	if (!out)
+		die("Could not open pipe of rev-list command.");
 
 	/* save all revisions from the above list that contain b */
-	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
-	while ((commit = get_revision(&revs)) != NULL) {
+	while (strbuf_getline(&one_rev, out, '\n') != EOF) {
+		commit = lookup_commit_reference_by_name(one_rev.buf);
 		struct object *o = &(commit->object);
 		if (in_merge_bases(b, &commit, 1))
 			add_object_array(o, NULL, &merges);
 	}
 
+	fclose(out);
+	finish_command(&cp);
+	strbuf_release(&one_rev);
+
 	/* Now we've got all merges that contain a and b. Prune all
 	 * merges that contain another found merge and save them in
 	 * result.
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 8f6f2d6..603fb72 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
 '
 
 # merge should leave submodule unmerged in index
-test_expect_failure 'recursive merge with submodule' '
+test_expect_success 'recursive merge with submodule' '
 	(cd merge-recursive &&
 	 test_must_fail git merge top-bc &&
 	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
-- 
1.7.6.551.g0f51b.dirty
