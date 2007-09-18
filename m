From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/5] Correct handling of branch.$name.merge in builtin-fetch
Date: Tue, 18 Sep 2007 04:54:53 -0400
Message-ID: <20070918085453.GC5390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYrw-0001jx-98
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbXIRIzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbXIRIzA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:55:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52375 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbXIRIy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYr4-00067x-Ea; Tue, 18 Sep 2007 04:54:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD09620FBAE; Tue, 18 Sep 2007 04:54:53 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58553>

My prior bug fix for git-push titled "Don't configure remote "." to
fetch everything to itself" actually broke t5520 as we were unable
to evaluate a branch configuration of:

  [branch "copy"]
    remote = .
    merge = refs/heads/master

as remote "." did not have a "remote...fetch" configuration entry to
offer up refs/heads/master as a possible candidate available to be
fetched and merged.  In shell script git-fetch and prior to the above
mentioned commit this was hardcoded for a url of "." to be the set of
local branches.

Chasing down this bug led me to the conclusion that our prior behavior
with regards to branch.$name.merge was incorrect.  In the shell script
based git-fetch implementation we only fetched and merged a branch if
it appeared both in branch.$name.merge *and* in remote.$r.fetch, where
$r = branch.$name.remote.  In other words in the following config file:

  [remote "origin"]
    url = git://git.kernel.org/pub/scm/git/git.git
    fetch = refs/heads/master:refs/remotes/origin/master
  [branch "master"]
    remote = origin
    merge = refs/heads/master
  [branch "pu"]
    remote = origin
    merge = refs/heads/pu

Attempting to run `git pull` while on branch "pu" would always give
the user "Already up-to-date" as git-fetch did not fetch pu and thus
did not mark it for merge in .git/FETCH_HEAD.  The configured merge
would always be ignored and the user would be left scratching her
confused head wondering why merge did not work on "pu" but worked
fine on "master".

If we are using the "default fetch" specification for the current
branch and the current branch has a branch.$name.merge configured
we now union it with the list of refs in remote.$r.fetch.  This
way the above configuration does what the user expects it to do,
which is to fetch only "master" by default but when on "pu" to
fetch both "master" and "pu".

This uncovered some breakage in the test suite where old-style Cogito
branches (.git/branches/$r) did not fetch the branches listed in
.git/config for merging and thus did not actually merge them if the
user tried to use `git pull` on that branch.  Junio and I discussed
it on list and felt that the union approach here makes more sense to
DWIM for the end-user than silently ignoring their configured request
so the test vectors for t5515 have been updated to include for-merge
lines in .git/FETCH_HEAD where they have been configured for-merge
in .git/config.

Since we are now performing a union of the fetch specification and
the merge specification and we cannot allow a branch to be listed
twice (otherwise it comes out twice in .git/FETCH_HEAD) we need to
perform a double loop here over all of the branch.$name.merge lines
and try to set their merge flag if we have already schedule that
branch for fetching by remote.$r.fetch.  If no match is found then
we must add new specifications to fetch the branch but not store it
as no local tracking branch has been designated.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c                                    |   48 ++++++++++++++-----
 remote.c                                           |   13 ++---
 remote.h                                           |    3 +-
 t/t5515/fetch.br-branches-default-merge            |    1 +
 ...etch.br-branches-default-merge_branches-default |    1 +
 t/t5515/fetch.br-branches-default-octopus          |    2 +
 ...ch.br-branches-default-octopus_branches-default |    2 +
 t/t5515/fetch.br-branches-one-merge                |    1 +
 t/t5515/fetch.br-branches-one-merge_branches-one   |    1 +
 t/t5515/fetch.br-branches-one-octopus              |    1 +
 t/t5515/fetch.br-branches-one-octopus_branches-one |    1 +
 11 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 20926e0..670af0b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -28,20 +28,37 @@ static void unlock_pack_on_signal(int signo)
 	raise(signo);
 }
 
-static void find_merge_config(struct ref *ref_map, struct remote *remote)
+static void add_merge_config(struct ref **head,
+		           struct ref *remote_refs,
+		           struct branch *branch,
+		           struct ref ***tail)
 {
-	struct ref *rm = ref_map;
-	struct branch *branch = branch_get(NULL);
+	int i;
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (!branch_has_merge_config(branch)) {
-			if (remote && remote->fetch &&
-			    !strcmp(remote->fetch[0].src, rm->name))
-				rm->merge = 1;
-		} else {
-			if (branch_merges(branch, rm->name))
+	for (i = 0; i < branch->merge_nr; i++) {
+		struct ref *rm, **old_tail = *tail;
+		struct refspec refspec;
+
+		for (rm = *head; rm; rm = rm->next) {
+			if (branch_merge_matches(branch, i, rm->name)) {
 				rm->merge = 1;
+				break;
+			}
 		}
+		if (rm)
+			continue;
+
+		/* Not fetched to a tracking branch?  We need to fetch
+		 * it anyway to allow this branch's "branch.$name.merge"
+		 * to be honored by git-pull.
+		 */
+		refspec.src = branch->merge[i]->src;
+		refspec.dst = NULL;
+		refspec.pattern = 0;
+		refspec.force = 0;
+		get_fetch_map(remote_refs, &refspec, tail);
+		for (rm = *old_tail; rm; rm = rm->next)
+			rm->merge = 1;
 	}
 }
 
@@ -76,17 +93,22 @@ static struct ref *get_ref_map(struct transport *transport,
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
-		if (remote->fetch_refspec_nr) {
+		struct branch *branch = branch_get(NULL);
+		int has_merge = branch_has_merge_config(branch);
+		if (remote && (remote->fetch_refspec_nr || has_merge)) {
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch[i], &tail);
 				if (remote->fetch[i].dst &&
 				    remote->fetch[i].dst[0])
 					*autotags = 1;
+				if (!i && !has_merge && ref_map &&
+				    !strcmp(remote->fetch[0].src, ref_map->name))
+					ref_map->merge = 1;
 			}
-			find_merge_config(ref_map, remote);
+			if (has_merge)
+				add_merge_config(&ref_map, remote_refs, branch, &tail);
 		} else {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
-
 			ref_map->merge = 1;
 		}
 	}
diff --git a/remote.c b/remote.c
index af3c46b..31e2b70 100644
--- a/remote.c
+++ b/remote.c
@@ -772,16 +772,13 @@ int branch_has_merge_config(struct branch *branch)
 	return branch && !!branch->merge;
 }
 
-int branch_merges(struct branch *branch, const char *refname)
+int branch_merge_matches(struct branch *branch,
+		                 int i,
+		                 const char *refname)
 {
-	int i;
-	if (!branch)
+	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	for (i = 0; i < branch->merge_nr; i++) {
-		if (ref_matches_abbrev(branch->merge[i]->src, refname))
-			return 1;
-	}
-	return 0;
+	return ref_matches_abbrev(branch->merge[i]->src, refname);
 }
 
 static struct ref *get_expanded_map(struct ref *remote_refs,
diff --git a/remote.h b/remote.h
index 8994052..b5b558f 100644
--- a/remote.h
+++ b/remote.h
@@ -88,7 +88,6 @@ struct branch {
 struct branch *branch_get(const char *name);
 
 int branch_has_merge_config(struct branch *branch);
-
-int branch_merges(struct branch *branch, const char *refname);
+int branch_merge_matches(struct branch *, int n, const char *);
 
 #endif
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index 828bfd8..ca2cc1d 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,5 +1,6 @@
 # br-branches-default-merge
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index f148673..7d947cd 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,5 +1,6 @@
 # br-branches-default-merge branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index bb1a191..ec39c54 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -1,5 +1,7 @@
 # br-branches-default-octopus
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 970fc93..6bf42e2 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -1,5 +1,7 @@
 # br-branches-default-octopus branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index 24099fd..b4b3b35 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,5 +1,6 @@
 # br-branches-one-merge
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index e4b4fde..2ecef38 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,5 +1,6 @@
 # br-branches-one-merge branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
index 53fe808..96e3029 100644
--- a/t/t5515/fetch.br-branches-one-octopus
+++ b/t/t5515/fetch.br-branches-one-octopus
@@ -1,5 +1,6 @@
 # br-branches-one-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t5515/fetch.br-branches-one-octopus_branches-one
index 41b18ff..55e0bad 100644
--- a/t/t5515/fetch.br-branches-one-octopus_branches-one
+++ b/t/t5515/fetch.br-branches-one-octopus_branches-one
@@ -1,5 +1,6 @@
 # br-branches-one-octopus branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-- 
1.5.3.1.1000.g7319b
