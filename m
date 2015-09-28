From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/4] Fix gc failure when a remote HEAD goes stale
Date: Mon, 28 Sep 2015 16:01:00 +0200
Organization: gmx
Message-ID: <cover.1443448748.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgYzT-000460-HH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 16:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933948AbbI1OBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 10:01:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:61745 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbbI1OBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 10:01:08 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Ldbqw-1aPHjw3qew-00ik8q; Mon, 28 Sep 2015 16:01:02
 +0200
In-Reply-To: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:AxFSOSsByV9MQcBZNLIZfhmQW/j0EGNxlUTzdBfsYLGSVPsCbYM
 jZTby/z1fBMWofZ5BoUmvMdJ+ta++E+GKnFTwVwReHroa8Oe7mmmNNKGY6rjotA6uqTcOaI
 ivfgInt1a0dsVUL+Z2I8tpYRgSdvcH52JYhcKOl7zaz8O5DAm71ka3AmL7sLzy9xU4gqphR
 OvvwsX/kSP5R7l02Lar2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k5KPrPIAy0c=:RraEkoHBa/m0KflJy6u7xS
 yBJIrUcgJSu5pJUrIJ0ywI6a55L9E/UtwysxSRvS/fLdQGYyyrE9jtKqbnwNmfFWP5a/DO7rj
 0ueCbZxtjRYrEL80uXLqb5D8Gg4/Lp1T8u2BNz8OIdnK6ZIKy1S4LsB3URykjYmWN7TqfChBc
 gac2oghOSgwMUr0qim43UW9OjxCtU94JBl3Ia/gPapDnNbRy0hKi/F2/8agFTTtQ3lsFV7dEd
 vruXgn3JT65x9oP2zUTypLLew0rfZkY2st1jltuxeDkBa/W8iPAj0YzzmMYHiJVfBxB323ebT
 wsq9AQg83vGFhy5xzYNu/sV7bEuSdEMmTB4YiwJASRI13RWccbzuMRxK8ABkJc8EB6ZufcEjj
 KNLRsFML3dWu4YZAjx5WuAlJH+QNh19alnNkqH4/8ePJJQPmv+7Ge8CIdgOVrVpEdNQ8BQFN+
 HZSnIUCa8XiEjWgmv46eMPbVolGVxHi0LmncSs5+fSa0xeOqHhB3hsimLQCtQ3ATCPlC4nap+
 NY7y7mZNS2i5jqlkbnRuVSsqhkWJFBBP1A/rJ+tGK8iQjLwPlY97VekHfcSFaJtxP3uGDEyju
 amdtECaPvKTJAhaOu5Y8UVCLZIx2+3X9BGt2KuJgREYqU6lN4+ahIRJ17ifyvhhlWbzA4tmUM
 JBWc6+0wbaeLtDl3OceUVqp8+B8GBqryIVZ0qrzjf7p+hFaAZPAr1oJpOJXWjpe8Do2ajcopg
 pYFHJP2goyn25EKpsztRPkpwAxCuhSSFc6v8mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278724>

There has been a report in the Git for Windows project that gc fails
sometimes: https://github.com/git-for-windows/git/issues/423

It turns out that there are cases when a remote HEAD can go stale and
it is not the user's fault at all. It can happen, for example, if the
active branch in the remote repository gets renamed.

Git's garbage collector should handle this gracefully. The best this
developer could come up with, is to simply warn and delete broken
symrefs.

Thanks to Junio and Peff for their really valuable sanity check.

Interdiff vs v1 below diffstat.

Johannes Schindelin (4):
  gc: demonstrate failure with stale remote HEAD
  pack-objects: do not get distracted by broken symrefs
  mark_reachable_objects(): optionally collect broken symrefs
  gc: remove broken refs

 builtin/prune.c  | 12 +++++++++++-
 builtin/reflog.c |  2 +-
 reachable.c      | 31 +++++++++++++++++++++++++------
 reachable.h      |  3 ++-
 t/t6500-gc.sh    | 15 +++++++++++++++
 5 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ef2f794..1c63f8f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2499,7 +2499,6 @@ static void get_object_list(int ac, const char **av)
 	int flags = 0;
 
 	init_revisions(&revs, NULL);
-	revs.ignore_missing = 1;
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 1a30f65..337b12a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -101,7 +101,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct string_list broken_refs = STRING_LIST_INIT_DUP;
+	struct string_list broken_symrefs = STRING_LIST_INIT_DUP;
 	struct progress *progress = NULL;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -140,9 +140,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
 	revs.ignore_missing = 1;
-	mark_reachable_objects(&revs, 1, expire, progress, &broken_refs);
-	for (i = 0; i < broken_refs.nr; i++) {
-		char *path = broken_refs.items[i].string;
+	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);
+	for (i = 0; i < broken_symrefs.nr; i++) {
+		char *path = broken_symrefs.items[i].string;
 		printf("Removing stale ref %s\n", path);
 		if (!show_only && delete_ref(path, NULL, REF_NODEREF))
 			die("Could not remove stale ref %s", path);
diff --git a/reachable.c b/reachable.c
index 1fc7ada..25c4932 100644
--- a/reachable.c
+++ b/reachable.c
@@ -17,7 +17,7 @@ struct connectivity_progress {
 
 struct add_one_data {
 	struct rev_info *revs;
-	struct string_list *broken_refs;
+	struct string_list *broken_symrefs;
 };
 
 static void update_progress(struct connectivity_progress *cp)
@@ -31,13 +31,18 @@ static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
 	struct add_one_data *data = (struct add_one_data *)cb_data;
-	struct object *object = data->broken_refs ? parse_object(oid->hash) :
-		parse_object_or_die(oid->hash, path);
+	struct object *object;
 
-	if (!object)
-		string_list_append(data->broken_refs, path);
-	else
-		add_pending_object(data->revs, object, "");
+	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+		if (data->broken_symrefs)
+			string_list_append(data->broken_symrefs, path);
+		else
+			warning("ref is broken: %s", path);
+		return 0;
+	}
+
+	object = parse_object_or_die(oid->hash, path);
+	add_pending_object(data->revs, object, "");
 
 	return 0;
 }
@@ -163,7 +168,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    unsigned long mark_recent,
 			    struct progress *progress,
-			    struct string_list *broken_refs)
+			    struct string_list *broken_symrefs)
 {
 	struct connectivity_progress cp;
 	struct add_one_data data;
@@ -180,7 +185,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	add_index_objects_to_pending(revs, 0);
 
 	data.revs = revs;
-	data.broken_refs = broken_refs;
+	data.broken_symrefs = broken_symrefs;
 
 	/* Add all external refs */
 	for_each_ref(add_one_ref, &data);
diff --git a/reachable.h b/reachable.h
index 39de1c7..06f1400 100644
--- a/reachable.h
+++ b/reachable.h
@@ -6,6 +6,6 @@ extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  unsigned long timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 				   unsigned long mark_recent, struct progress *,
-				   struct string_list *broken_refs);
+				   struct string_list *broken_symrefs);
 
 #endif
-- 
2.5.3.windows.1.3.gc322723
