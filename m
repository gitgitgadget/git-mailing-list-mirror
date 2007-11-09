From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 07/11] git-fetch: Limit automated tag following to only fetched objects
Date: Fri, 9 Nov 2007 06:06:31 -0500
Message-ID: <20071109110631.GG19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:08:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRiQ-00081j-4k
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761561AbXKILGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761509AbXKILGj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34105 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760419AbXKILGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:35 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRh0-0003Cn-2c; Fri, 09 Nov 2007 06:06:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 766C020FBAE; Fri,  9 Nov 2007 06:06:31 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64161>

When we fetch objects with any transport we want to follow (fetch)
any tag that refers to an object we just transferred, if automated
tag fetching is enabled.

In the past this rule was based on any object that was supposedly
reachable by the local repository.  However this depended heavily
on the transport implementation actually using the object walking
system to lookup all reachable objects.  In the case of both the
native git protocol and the HTTP walker not all objects get looked
up; instead only those that are necessary to determine what to fetch
are processed.  This can cause random behavior for tags where some
are fetched and some aren't.

We now redefine the rule to be: "tags are fetched if they refer
to an object that was just transferred; that is an object that is
new to your repository".  This rule is quite simple to understand,
you only get a tag if you just got the object it refers to.

Some of the test vectors for t5515 were affected by this as they
were listing "not-for-merge" tags in .git/FETCH_HEAD that were
being fetched under the old rule but are now not fetched under the
new rule.  To be perfectly honest I have no idea why they were even
fetching under the old rule, and I think that's part of the problem
with the old rule.  It was very difficult to understand why some
things would auto-follow a tag and others wouldn't.

As a bonus side-effect of this change git-fetch will fail early
without updating any refs if a bogus server gave us a packfile
that doesn't contain all of the objects we need to make a fully
reachable ref.  This could happen due to a bug on the remote side,
where the set of objects to be packed was miscalculated and a valid
packfile was sent but one or more objects are missing from it.
It has probably never happened in practice but its better to be
paranoid in what we accept over the wire then to blindly trust the
other peer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c                                    |   41 +++++++++++++++++++-
 t/t5515/fetch.br-branches-default                  |    2 -
 t/t5515/fetch.br-branches-default-merge            |    2 -
 ...etch.br-branches-default-merge_branches-default |    2 -
 t/t5515/fetch.br-branches-default-octopus          |    2 -
 ...ch.br-branches-default-octopus_branches-default |    2 -
 t/t5515/fetch.br-branches-default_branches-default |    2 -
 t/t5515/fetch.br-branches-one                      |    2 -
 t/t5515/fetch.br-branches-one-merge                |    2 -
 t/t5515/fetch.br-branches-one-merge_branches-one   |    2 -
 t/t5515/fetch.br-branches-one-octopus              |    2 -
 t/t5515/fetch.br-branches-one-octopus_branches-one |    2 -
 t/t5515/fetch.br-branches-one_branches-one         |    2 -
 t/t5515/fetch.br-config-explicit                   |    2 -
 t/t5515/fetch.br-config-explicit-merge             |    2 -
 .../fetch.br-config-explicit-merge_config-explicit |    2 -
 t/t5515/fetch.br-config-explicit-octopus           |    2 -
 ...etch.br-config-explicit-octopus_config-explicit |    2 -
 t/t5515/fetch.br-config-explicit_config-explicit   |    2 -
 t/t5515/fetch.br-config-glob                       |    2 -
 t/t5515/fetch.br-config-glob-merge                 |    2 -
 t/t5515/fetch.br-config-glob-merge_config-glob     |    2 -
 t/t5515/fetch.br-config-glob-octopus               |    2 -
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    2 -
 t/t5515/fetch.br-config-glob_config-glob           |    2 -
 t/t5515/fetch.br-remote-explicit                   |    2 -
 t/t5515/fetch.br-remote-explicit-merge             |    2 -
 .../fetch.br-remote-explicit-merge_remote-explicit |    2 -
 t/t5515/fetch.br-remote-explicit-octopus           |    2 -
 ...etch.br-remote-explicit-octopus_remote-explicit |    2 -
 t/t5515/fetch.br-remote-explicit_remote-explicit   |    2 -
 t/t5515/fetch.br-remote-glob                       |    2 -
 t/t5515/fetch.br-remote-glob-merge                 |    2 -
 t/t5515/fetch.br-remote-glob-merge_remote-glob     |    2 -
 t/t5515/fetch.br-remote-glob-octopus               |    2 -
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    2 -
 t/t5515/fetch.br-remote-glob_remote-glob           |    2 -
 t/t5515/fetch.br-unconfig                          |    2 -
 ...nfig_.._.git_one_tag_tag-one_tag_tag-three-file |    1 -
 ...h.br-unconfig_.._.git_tag_tag-one_tag_tag-three |    2 -
 t/t5515/fetch.br-unconfig_branches-default         |    2 -
 t/t5515/fetch.br-unconfig_branches-one             |    2 -
 t/t5515/fetch.br-unconfig_config-explicit          |    2 -
 t/t5515/fetch.br-unconfig_config-glob              |    2 -
 t/t5515/fetch.br-unconfig_remote-explicit          |    2 -
 t/t5515/fetch.br-unconfig_remote-glob              |    2 -
 t/t5515/fetch.master                               |    2 -
 ...ster_.._.git_one_tag_tag-one_tag_tag-three-file |    1 -
 .../fetch.master_.._.git_tag_tag-one_tag_tag-three |    2 -
 t/t5515/fetch.master_branches-default              |    2 -
 t/t5515/fetch.master_branches-one                  |    2 -
 t/t5515/fetch.master_config-explicit               |    2 -
 t/t5515/fetch.master_config-glob                   |    2 -
 t/t5515/fetch.master_remote-explicit               |    2 -
 t/t5515/fetch.master_remote-glob                   |    2 -
 55 files changed, 39 insertions(+), 108 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 18f123e..6a36c02 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -8,6 +8,9 @@
 #include "path-list.h"
 #include "remote.h"
 #include "transport.h"
+#include "diff.h"
+#include "list-objects.h"
+#include "revision.h"
 
 static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | --keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<repository> <refspec>...]";
 
@@ -335,14 +338,46 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 	fclose(fp);
 }
 
+static void mark_just_fetched_commit(struct commit *commit)
+{
+}
+
+static void mark_just_fetched_object(struct object_array_entry *p)
+{
+	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
+		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+}
+
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret;
 
 	free_all_objects();
 	ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
+	if (!ret) {
+		const char *args[] = { "rev-list", "--objects", "--not", "--all", NULL};
+		struct rev_info revs;
+		struct ref *ref;
+
+		free_all_objects();
+		init_revisions(&revs, NULL);
+		setup_revisions(ARRAY_SIZE(args) - 1, args, &revs, NULL);
+		save_commit_buffer = 0;
+		track_object_refs = 0;
+
+		for (ref = ref_map; ref; ref = ref->next) {
+			struct object *o = parse_object(ref->old_sha1);
+			if (o)
+				add_pending_object(&revs, o, "(just-fetched)");
+		}
+
+		prepare_revision_walk(&revs);
+		mark_edges_uninteresting(revs.commits, &revs, NULL);
+		traverse_commit_list(&revs,
+			mark_just_fetched_commit,
+			mark_just_fetched_object);
 		store_updated_refs(transport->url, ref_map);
+	}
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -368,6 +403,7 @@ static struct ref *find_non_local_tags(struct transport *transport,
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
 	const struct ref *ref;
+	struct object *obj;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
@@ -392,7 +428,8 @@ static struct ref *find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    lookup_object(ref->old_sha1)) {
+		    (obj = lookup_object(ref->old_sha1)) &&
+		    obj->flags & SEEN) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branches-default
index 2e0414f..174ea02 100644
--- a/t/t5515/fetch.br-branches-default
+++ b/t/t5515/fetch.br-branches-default
@@ -2,7 +2,5 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index ca2cc1d..e410d55 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -3,7 +3,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index 7d947cd..f0f8230 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -3,7 +3,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index ec39c54..f497ee3 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -4,7 +4,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 6bf42e2..a1694aa 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -4,7 +4,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default_branches-default b/t/t5515/fetch.br-branches-default_branches-default
index 4a2bf3c..eef9635 100644
--- a/t/t5515/fetch.br-branches-default_branches-default
+++ b/t/t5515/fetch.br-branches-default_branches-default
@@ -2,7 +2,5 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-one
index 12ac8d2..629e0cf 100644
--- a/t/t5515/fetch.br-branches-one
+++ b/t/t5515/fetch.br-branches-one
@@ -2,7 +2,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index b4b3b35..62176a4 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -3,7 +3,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index 2ecef38..13935fd 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -3,7 +3,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
index 96e3029..b42ab60 100644
--- a/t/t5515/fetch.br-branches-one-octopus
+++ b/t/t5515/fetch.br-branches-one-octopus
@@ -3,7 +3,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t5515/fetch.br-branches-one-octopus_branches-one
index 55e0bad..c9868c0 100644
--- a/t/t5515/fetch.br-branches-one-octopus_branches-one
+++ b/t/t5515/fetch.br-branches-one-octopus_branches-one
@@ -3,7 +3,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one_branches-one b/t/t5515/fetch.br-branches-one_branches-one
index 281fa09..2592e3c 100644
--- a/t/t5515/fetch.br-branches-one_branches-one
+++ b/t/t5515/fetch.br-branches-one_branches-one
@@ -2,7 +2,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit b/t/t5515/fetch.br-config-explicit
index e2fa9c8..a9a6573 100644
--- a/t/t5515/fetch.br-config-explicit
+++ b/t/t5515/fetch.br-config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-config-explicit-merge
index ec1a723..5aa1a75 100644
--- a/t/t5515/fetch.br-config-explicit-merge
+++ b/t/t5515/fetch.br-config-explicit-merge
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge_config-explicit b/t/t5515/fetch.br-config-explicit-merge_config-explicit
index 54f6891..a3de0a3 100644
--- a/t/t5515/fetch.br-config-explicit-merge_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-merge_config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.br-config-explicit-octopus
index 7011dfc..612aac9 100644
--- a/t/t5515/fetch.br-config-explicit-octopus
+++ b/t/t5515/fetch.br-config-explicit-octopus
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus_config-explicit b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
index bdad51f..a098d56 100644
--- a/t/t5515/fetch.br-config-explicit-octopus_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit_config-explicit b/t/t5515/fetch.br-config-explicit_config-explicit
index 1b237dd..a744172 100644
--- a/t/t5515/fetch.br-config-explicit_config-explicit
+++ b/t/t5515/fetch.br-config-explicit_config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob b/t/t5515/fetch.br-config-glob
index e75ec2f..d042adc 100644
--- a/t/t5515/fetch.br-config-glob
+++ b/t/t5515/fetch.br-config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-config-glob-merge
index ce8f739..86f7f5f 100644
--- a/t/t5515/fetch.br-config-glob-merge
+++ b/t/t5515/fetch.br-config-glob-merge
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge_config-glob b/t/t5515/fetch.br-config-glob-merge_config-glob
index 5817bed..88c095f 100644
--- a/t/t5515/fetch.br-config-glob-merge_config-glob
+++ b/t/t5515/fetch.br-config-glob-merge_config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
index 938e532..5a63ac9 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515/fetch.br-config-glob-octopus_config-glob
index c9225bf..4de6fc8 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob_config-glob b/t/t5515/fetch.br-config-glob_config-glob
index a6c20f9..c6a1ac7 100644
--- a/t/t5515/fetch.br-config-glob_config-glob
+++ b/t/t5515/fetch.br-config-glob_config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote-explicit
index 83534d2..439c473 100644
--- a/t/t5515/fetch.br-remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
index a9064dd..338431c 100644
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ b/t/t5515/fetch.br-remote-explicit-merge
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
index 732a37e..db75bb1 100644
--- a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
index ecf020d..c265c43 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ b/t/t5515/fetch.br-remote-explicit-octopus
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
index af77531..ff0072b 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit_remote-explicit b/t/t5515/fetch.br-remote-explicit_remote-explicit
index 51fae56..a0a1480 100644
--- a/t/t5515/fetch.br-remote-explicit_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit_remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glob
index 94e6ad3..db59afb 100644
--- a/t/t5515/fetch.br-remote-glob
+++ b/t/t5515/fetch.br-remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
index 09362e2..9a1edd0 100644
--- a/t/t5515/fetch.br-remote-glob-merge
+++ b/t/t5515/fetch.br-remote-glob-merge
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/fetch.br-remote-glob-merge_remote-glob
index e2eabec..569890c 100644
--- a/t/t5515/fetch.br-remote-glob-merge_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-merge_remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
index b08e046..1d1db0e 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
index d4d547c..1649d5f 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob_remote-glob b/t/t5515/fetch.br-remote-glob_remote-glob
index 646dbc8..5769be6 100644
--- a/t/t5515/fetch.br-remote-glob_remote-glob
+++ b/t/t5515/fetch.br-remote-glob_remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig b/t/t5515/fetch.br-unconfig
index 65ce6d9..ce9e098 100644
--- a/t/t5515/fetch.br-unconfig
+++ b/t/t5515/fetch.br-unconfig
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
index f02bab2..409b033 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -3,6 +3,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
index 0da2337..b535401 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -2,6 +2,4 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-default b/t/t5515/fetch.br-unconfig_branches-default
index fc7041e..5787d50 100644
--- a/t/t5515/fetch.br-unconfig_branches-default
+++ b/t/t5515/fetch.br-unconfig_branches-default
@@ -2,7 +2,5 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-one b/t/t5515/fetch.br-unconfig_branches-one
index e94cde7..7a98d64 100644
--- a/t/t5515/fetch.br-unconfig_branches-one
+++ b/t/t5515/fetch.br-unconfig_branches-one
@@ -2,7 +2,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-explicit b/t/t5515/fetch.br-unconfig_config-explicit
index 01a283e..f618d4e 100644
--- a/t/t5515/fetch.br-unconfig_config-explicit
+++ b/t/t5515/fetch.br-unconfig_config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-glob b/t/t5515/fetch.br-unconfig_config-glob
index 3a556c5..e47b27a 100644
--- a/t/t5515/fetch.br-unconfig_config-glob
+++ b/t/t5515/fetch.br-unconfig_config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-explicit b/t/t5515/fetch.br-unconfig_remote-explicit
index db216df..b2fe473 100644
--- a/t/t5515/fetch.br-unconfig_remote-explicit
+++ b/t/t5515/fetch.br-unconfig_remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-glob b/t/t5515/fetch.br-unconfig_remote-glob
index aee65c2..83ef090 100644
--- a/t/t5515/fetch.br-unconfig_remote-glob
+++ b/t/t5515/fetch.br-unconfig_remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master b/t/t5515/fetch.master
index 950fd07..671945c 100644
--- a/t/t5515/fetch.master
+++ b/t/t5515/fetch.master
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
index 8286852..67f9314 100644
--- a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -3,6 +3,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
index 92b18b4..ee914a3 100644
--- a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
@@ -2,6 +2,4 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-default b/t/t5515/fetch.master_branches-default
index 603d6d2..a40bb5a 100644
--- a/t/t5515/fetch.master_branches-default
+++ b/t/t5515/fetch.master_branches-default
@@ -2,7 +2,5 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-one b/t/t5515/fetch.master_branches-one
index fe9bb0b..3f8bdbc 100644
--- a/t/t5515/fetch.master_branches-one
+++ b/t/t5515/fetch.master_branches-one
@@ -2,7 +2,5 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_config-explicit b/t/t5515/fetch.master_config-explicit
index 4be97c7..451750b 100644
--- a/t/t5515/fetch.master_config-explicit
+++ b/t/t5515/fetch.master_config-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_config-glob b/t/t5515/fetch.master_config-glob
index cb0726f..4fde761 100644
--- a/t/t5515/fetch.master_config-glob
+++ b/t/t5515/fetch.master_config-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-explicit b/t/t5515/fetch.master_remote-explicit
index 44a1ca8..e5305b9 100644
--- a/t/t5515/fetch.master_remote-explicit
+++ b/t/t5515/fetch.master_remote-explicit
@@ -5,7 +5,5 @@
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-glob b/t/t5515/fetch.master_remote-glob
index 724e8db..a96ce5f 100644
--- a/t/t5515/fetch.master_remote-glob
+++ b/t/t5515/fetch.master_remote-glob
@@ -5,7 +5,5 @@
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
-- 
1.5.3.5.1622.g41d10
