From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 11:36:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 11:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpJly-0003Kp-K5
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 11:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbYJMJaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 05:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYJMJaS
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 05:30:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:37013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbYJMJaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 05:30:16 -0400
Received: (qmail invoked by alias); 13 Oct 2008 09:30:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 13 Oct 2008 11:30:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4UVEVvQP4EdlZBo6PtA7q1N9CIPXMT0IsP4Sp5/
	Svg/n4McHJ14EQ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98099>


Some confusing tutorials suggested that it would be a good idea to fetch
into the current branch with something like this:

	git fetch origin master:master

(or even worse: the same command line with "pull" instead of "fetch").
While it might make sense to store what you want to pull, it typically
is plain wrong when the current branch is "master".

As noticed by Junio, this behavior should be triggered by _not_ passing
the --update-head-ok option, but somewhere along the lines we lost that
behavior.

NOTE: this patch does not completely resurrect the original behavior
without --update-head-ok: the check for the current branch is now _only_
performed in non-bare repositories.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 12 Oct 2008, Daniel Barkalow and Shawn Pearce sent some 
	good suggestions to fix the first version of the patch.

	This is the updated version.  In particular, the test is only 
	performed without the option "--update-head-ok", the function 
	branch_get(NULL) is called to get the current branch, a test was 
	added to verify that --update-head-ok works as expected, and the 
	commit message was modified in the hope that it confuses less now.

	Strangely, some more tests refused to pass this time, because they
	did not use --update-head-ok; this was fixed, too.

 builtin-fetch.c             |   15 +++++++++++++++
 t/t5405-send-pack-rewind.sh |    2 +-
 t/t5505-remote.sh           |    2 +-
 t/t5510-fetch.sh            |   12 ++++++++++++
 t/t9300-fast-import.sh      |    2 +-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ee93d3a..57c161d 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -534,6 +534,19 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&new_refs, 0);
 }
 
+static void check_not_current_branch(struct ref *ref_map)
+{
+	struct branch *current_branch = branch_get(NULL);
+
+	if (is_bare_repository() || !current_branch)
+		return;
+
+	for (; ref_map; ref_map = ref_map->next)
+		if (ref_map->peer_ref && !strcmp(current_branch->refname,
+					ref_map->peer_ref->name))
+			die("Refusing to fetch into current branch");
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
@@ -558,6 +571,8 @@ static int do_fetch(struct transport *transport,
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	if (!update_head_ok)
+		check_not_current_branch(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref)
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 86abc62..cb9aacc 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 	mkdir another && (
 		cd another &&
 		git init &&
-		git fetch .. master:master
+		git fetch --update-head-ok .. master:master
 	) &&
 
 	>file2 && git add file2 && test_tick &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c449663..0103e1a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -188,7 +188,7 @@ test_expect_success 'prune --dry-run' '
 test_expect_success 'add --mirror && prune' '
 	(mkdir mirror &&
 	 cd mirror &&
-	 git init &&
+	 git init --bare &&
 	 git remote add --mirror -f origin ../one) &&
 	(cd one &&
 	 git branch -m side2 side) &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9aae496..9e679b4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -323,4 +323,16 @@ test_expect_success 'auto tag following fetches minimum' '
 	)
 '
 
+test_expect_success 'refuse to fetch into the current branch' '
+
+	test_must_fail git fetch . side:master
+
+'
+
+test_expect_success 'fetch into the current branch with --update-head-ok' '
+
+	git fetch --update-head-ok . side:master
+
+'
+
 test_done
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 328444a..91b5ace 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -983,7 +983,7 @@ test_expect_success \
 	 git checkout subuse1 &&
 	 rm -rf sub && mkdir sub && cd sub &&
 	 git init &&
-	 git fetch .. refs/heads/sub:refs/heads/master &&
+	 git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
 	 git checkout master &&
 	 cd .. &&
 	 git submodule init &&
-- 
1.6.0.2.749.g0cc32
