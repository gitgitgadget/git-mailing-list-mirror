From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/4] mark_reachable_objects(): optionally collect broken refs
Date: Thu, 24 Sep 2015 11:13:52 +0200
Organization: gmx
Message-ID: <bcceeae4c8f7f690502651dd6cc537b2f4918fac.1443085919.git.johannes.schindelin@gmx.de>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 11:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2bK-0004Ko-20
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbbIXJN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:13:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:61607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbbIXJN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:13:57 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MZkic-1ZzRXD2u6A-00LXQN; Thu, 24 Sep 2015 11:13:53
 +0200
In-Reply-To: <cover.1443085919.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:wMaYg8uKmxKdJ1rDy9f9OsyO0XcM02hdyVt1UVtukaH5EV94wmO
 6TKblqBr4HsrYEooZ7SkO50AHCOCfztac/qF9QS/X4QWCDaRX94iaZeS45o7QVA04c4pvo7
 OJvF+H1+AP4A56TShZWiDQzhWt2+J0GGc98hpaTlSA+AfX8t9x0qHOWew3REMDdm/jReVIr
 wm7WG3ppv8pzRJ+k/Iprw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IjCXOddRIbU=:kTyNnLeMcGcnKBFid7g5hx
 uZ3mxVspUlSidXUxOBbS7g/tTRhftdQMgk1ful1tMt6VJyCff7crJKt4JqYGEt5OawWvMaJAN
 xgilDuHTEZvVBruUha947lPWG9GB1X7JzYyKHmXkU4Auv6Z9A4warPg5t1LX8DepL4UTRDMjK
 Xzlq/aSIk+CMOIv8jR9eZa+q9ce+FH0Yq/mzMq0/q6ediddmWOeeE3dJfs9nUPuA+d5HSnvJJ
 Ytp/tt75+/CNLVBFKPJWfKSmTeh+CxA1lTHUqgioK0Gg/5wdnpcsPzuWv6RzDHlrlqEG8dmil
 F3NAKjV9NdkdSwvn9L7YyrxMvryvEdRb3AilMTRpamPIfd/0WzucPGAgKLkx6EOuCP7sNQZh2
 NAmklxsEmaO+sXRILuxpqGQCEb/q2vr7wwQED1INn5sM6yFkfSvN6NiLIU4c2h/6qaPWB5v3X
 7GrDyV22DoHjesZPP679uV6W8sPgY3+saUO/724ovDszt6p4VBARi0IyklcuAQQXVxRjaNxNi
 1tLho2znoRSmUgFaVm5FxUhBPa28h2Az3Tw+HcstI1us6xRd1NjN9qRzAMFKc6BepR90JCfmI
 uc9I4U5gOy5+j2YU5BK4IUPYGj4kI68Js25HSHPvWwjardkXBdWrP9E6foqdClrTwYPD4BHQA
 KRRrbKSP85VC5YvHICPmJHogOV0Dn9u+zhppXYIo3vSZ1eM0JuVjyClL3dnRTZFvbguibdr58
 jzhMIWLA23uHsqyhzD57rNd6NVX80xkKB4YCTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278541>

The behavior of `mark_reachable_objects()` without this patch is that it
dies if it encounters a broken ref. This is sometimes undesirable, e.g.
when garbage collecting in a repository with a stale remote HEAD.

So let's introduce an optional parameter to collect such broken refs. The
behavior of the function is unchanged if that parameter is `NULL`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c  |  2 +-
 builtin/reflog.c |  2 +-
 reachable.c      | 26 ++++++++++++++++++++------
 reachable.h      |  3 ++-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 10b03d3..d6f664f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -136,7 +136,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	mark_reachable_objects(&revs, 1, expire, progress);
+	mark_reachable_objects(&revs, 1, expire, progress, NULL);
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index f96ca2a..cb8758a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -583,7 +583,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		init_revisions(&cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
+		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
diff --git a/reachable.c b/reachable.c
index 9cff25b..1fc7ada 100644
--- a/reachable.c
+++ b/reachable.c
@@ -15,6 +15,11 @@ struct connectivity_progress {
 	unsigned long count;
 };
 
+struct add_one_data {
+	struct rev_info *revs;
+	struct string_list *broken_refs;
+};
+
 static void update_progress(struct connectivity_progress *cp)
 {
 	cp->count++;
@@ -25,10 +30,14 @@ static void update_progress(struct connectivity_progress *cp)
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *object = parse_object_or_die(oid->hash, path);
-	struct rev_info *revs = (struct rev_info *)cb_data;
+	struct add_one_data *data = (struct add_one_data *)cb_data;
+	struct object *object = data->broken_refs ? parse_object(oid->hash) :
+		parse_object_or_die(oid->hash, path);
 
-	add_pending_object(revs, object, "");
+	if (!object)
+		string_list_append(data->broken_refs, path);
+	else
+		add_pending_object(data->revs, object, "");
 
 	return 0;
 }
@@ -153,9 +162,11 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    unsigned long mark_recent,
-			    struct progress *progress)
+			    struct progress *progress,
+			    struct string_list *broken_refs)
 {
 	struct connectivity_progress cp;
+	struct add_one_data data;
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -168,11 +179,14 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* Add all refs from the index file */
 	add_index_objects_to_pending(revs, 0);
 
+	data.revs = revs;
+	data.broken_refs = broken_refs;
+
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	for_each_ref(add_one_ref, &data);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	head_ref(add_one_ref, &data);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/reachable.h b/reachable.h
index d23efc3..39de1c7 100644
--- a/reachable.h
+++ b/reachable.h
@@ -5,6 +5,7 @@ struct progress;
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  unsigned long timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   unsigned long mark_recent, struct progress *);
+				   unsigned long mark_recent, struct progress *,
+				   struct string_list *broken_refs);
 
 #endif
-- 
2.5.2.windows.2
