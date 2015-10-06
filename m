From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] Fix gc failure when a remote HEAD goes stale
Date: Tue, 06 Oct 2015 15:57:58 +0200
Organization: gmx
Message-ID: <cover.1444139796.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff Kind <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSkz-00034K-JJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbbJFN6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:58:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:57154 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbJFN6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:58:12 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LkxLZ-1aJLrx3ToD-00ak6A; Tue, 06 Oct 2015 15:58:00
 +0200
In-Reply-To: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:m34F0du5qju4eogpzi/T06/ocHPqYK50zoqLUmuGkRw3r5FXX0j
 BWCVC0de2cBktHT/Zm2D6o3VPRHG7On6SVNdbMI3HDR9QXJdeD+dPxpD58IWDWJNJsE6uVq
 vsztpZ0vvnJ7fZAWdtR9NCqD+QssDlGv55SnCoSI7wCbFJac4qSS7rtfXbdmy35QMWtvmFf
 PikIyKia0gDYXKwjzX3Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0P88gytJqaM=:eVBFxkDyeESkq5IXnjl8cW
 0Y74FfA9d2bV0GBrheWThsMvAI4DA6Tqkie3Z11I0zTZG3z2EVdFq/dZfIpBfVJgqVFmpi+LT
 0L69fw3FUPqlzdi+IT7uPi2W/m20ROGT4cDqqM6/zlxvD6gqpHvSGKUzJVSRpZT8cnXEEcVDE
 CMtZEZc8N3nmMaCMhi60wcpjM21t151/xs1aKGRuqGvmmTVlIMvYA7RH7pG/PBYwh4xKbgg02
 D3vOho9gR/2GYdZfQop5g6suNacI5h6ZJa7KUtDNmKRwI3epFkwYBO8xkE6BRYrGLzIPRUHae
 8kh0yxfl1DD0T+N7xyE1lnfliRvlqPY0NeTj3FzfE1Z25G3yc82ZBorpNG5Lq+rb4bkbFJ0bY
 vqwKHtYyiamaPHmOKe8Ut9uCr+nOQTly2Sbh9UWDTjwggSaKe+2V1tBTCDQtAE0z9DcJppoyv
 WrbMt8EQJRioNTay3WrOrgujg+8D5nKF0G8x4CNkTxUIvJ0K7omsjrNVlCTR1eDdDtTerzH7R
 LqUTpJLw2KD8ev8ZWXrrlAYB4JpTX4zuc6eZtyL+FeJIu1e0gfZFpFYeC166T+CknbdfKz1Yt
 nEHIj9PAAq2nYRDH8W/aQ8Kbo25pw/QDAQpBI7radbdlVAbAyStewS3rG4Z4NxeAdszuGYG0F
 H/BmRQIWDODravt10SSOwLEOIzXUrR3q+uDqKM1wUVciV35nkKb+ilKxzUtaYt2Wpa17lTKqb
 wdfr5TJyh7drsJSVSsaxZNda/ep5NZbUbnekfT5cXzZDbMSN6CEIkru6fRRSyoOE+sg0wxDv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279143>

There has been a report in the Git for Windows project that gc fails
sometimes: https://github.com/git-for-windows/git/issues/423

It turns out that there are cases when a remote HEAD can go stale and
it is not the user's fault at all. It can happen, for example, if the
active branch in the remote repository gets renamed.

Thanks to Junio and Peff for their really valuable sanity check.

Interdiff re: v2 after the diffstat (3/4 and 4/4 were dropped, I am
no longer removing the broken symrefs).


Johannes Schindelin (2):
  gc: demonstrate failure with stale remote HEAD
  pack-objects: do not get distracted by broken symrefs

 reachable.c   |  8 +++++++-
 t/t6500-gc.sh | 13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 337b12a..10b03d3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,7 +6,6 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
-#include "refs.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
@@ -101,7 +100,6 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct string_list broken_symrefs = STRING_LIST_INIT_DUP;
 	struct progress *progress = NULL;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -112,7 +110,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	char *s;
-	int i;
 
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
@@ -139,14 +136,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	revs.ignore_missing = 1;
-	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);
-	for (i = 0; i < broken_symrefs.nr; i++) {
-		char *path = broken_symrefs.items[i].string;
-		printf("Removing stale ref %s\n", path);
-		if (!show_only && delete_ref(path, NULL, REF_NODEREF))
-			die("Could not remove stale ref %s", path);
-	}
+	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index cb8758a..f96ca2a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -583,7 +583,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		init_revisions(&cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL, NULL);
+		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
diff --git a/reachable.c b/reachable.c
index 25c4932..43616d4 100644
--- a/reachable.c
+++ b/reachable.c
@@ -15,11 +15,6 @@ struct connectivity_progress {
 	unsigned long count;
 };
 
-struct add_one_data {
-	struct rev_info *revs;
-	struct string_list *broken_symrefs;
-};
-
 static void update_progress(struct connectivity_progress *cp)
 {
 	cp->count++;
@@ -30,19 +25,16 @@ static void update_progress(struct connectivity_progress *cp)
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct add_one_data *data = (struct add_one_data *)cb_data;
+	struct rev_info *revs = (struct rev_info *)cb_data;
 	struct object *object;
 
 	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
-		if (data->broken_symrefs)
-			string_list_append(data->broken_symrefs, path);
-		else
-			warning("ref is broken: %s", path);
+		warning("symbolic ref is dangling: %s", path);
 		return 0;
 	}
 
 	object = parse_object_or_die(oid->hash, path);
-	add_pending_object(data->revs, object, "");
+	add_pending_object(revs, object, "");
 
 	return 0;
 }
@@ -167,11 +159,9 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    unsigned long mark_recent,
-			    struct progress *progress,
-			    struct string_list *broken_symrefs)
+			    struct progress *progress)
 {
 	struct connectivity_progress cp;
-	struct add_one_data data;
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -184,14 +174,11 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* Add all refs from the index file */
 	add_index_objects_to_pending(revs, 0);
 
-	data.revs = revs;
-	data.broken_symrefs = broken_symrefs;
-
 	/* Add all external refs */
-	for_each_ref(add_one_ref, &data);
+	for_each_ref(add_one_ref, revs);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, &data);
+	head_ref(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/reachable.h b/reachable.h
index 06f1400..d23efc3 100644
--- a/reachable.h
+++ b/reachable.h
@@ -5,7 +5,6 @@ struct progress;
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  unsigned long timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   unsigned long mark_recent, struct progress *,
-				   struct string_list *broken_symrefs);
+				   unsigned long mark_recent, struct progress *);
 
 #endif
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 0ae4271..5d7d414 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_success 'gc removes broken refs/remotes/<name>/HEAD' '
+test_expect_success 'gc is not aborted due to a stale symref' '
 	git init remote &&
 	(
 		cd remote &&
@@ -39,9 +39,7 @@ test_expect_success 'gc removes broken refs/remotes/<name>/HEAD' '
 		git branch -m develop &&
 		cd ../client &&
 		git fetch --prune &&
-		git gc &&
-		git branch --list -r origin/HEAD >actual &&
-		test_line_count = 0 actual
+		git gc
 	)
 '
 
-- 
2.6.1.windows.1
