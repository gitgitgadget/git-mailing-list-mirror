From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] prune: show progress while marking reachable objects
Date: Sat,  5 Nov 2011 19:00:08 +0700
Message-ID: <1320494408-6373-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 13:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMf7J-0003np-GV
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 13:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab1KEMBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 08:01:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47477 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1KEMBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 08:01:35 -0400
Received: by iage36 with SMTP id e36so3689875iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=y8sIcHOmQiWEtFwF2/MtbAKqMvq0hmL1q5WvTzNPSOk=;
        b=QtWnmOcALoPbTu+7FKSMoQa/holwSCl7+tQ3pz0h2wVtqXOMNlhZ7tIaS3S1gL5lU3
         yR7nC4dvimdIveI3fUcvl8m6O/Fvt7tC18xVSMQDst+iHBKHnowvGy1qZEnneDDCOCf9
         L6OMBnaYRQpnVcSqycd9ZmuDFTxlGbxXJ8RAY=
Received: by 10.42.244.137 with SMTP id lq9mr24780938icb.28.1320494493337;
        Sat, 05 Nov 2011 05:01:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.245.14])
        by mx.google.com with ESMTPS id km16sm18147892pbb.9.2011.11.05.05.01.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 05:01:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 19:00:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184846>

prune already shows progress meter while pruning. The marking part may
take a few seconds or more, depending on repository size. Show
progress meter during this time too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/prune.c  |    6 +++++-
 builtin/reflog.c |    2 +-
 reachable.c      |   14 ++++++++++----
 reachable.h      |    3 ++-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index e65690b..6b39d3f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
+#include "progress.h"
 #include "dir.h"
=20
 static const char * const prune_usage[] =3D {
@@ -124,6 +125,7 @@ static void remove_temporary_files(const char *path=
)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
+	struct progress *progress;
 	const struct option options[] =3D {
 		OPT__DRY_RUN(&show_only, "do not remove, show only"),
 		OPT__VERBOSE(&verbose, "report pruned objects"),
@@ -152,7 +154,9 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 		else
 			die("unrecognized argument: %s", name);
 	}
-	mark_reachable_objects(&revs, 1);
+	progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+	mark_reachable_objects(&revs, 1, progress);
+	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
=20
 	prune_packed_objects(show_only);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3a9c80f..062d7da 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -647,7 +647,7 @@ static int cmd_reflog_expire(int argc, const char *=
*argv, const char *prefix)
 		init_revisions(&cb.revs, prefix);
 		if (cb.verbose)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.revs, 0);
+		mark_reachable_objects(&cb.revs, 0, NULL);
 		if (cb.verbose)
 			putchar('\n');
 	}
diff --git a/reachable.c b/reachable.c
index 3fc6b1d..293d37d 100644
--- a/reachable.c
+++ b/reachable.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "reachable.h"
 #include "cache-tree.h"
+#include "progress.h"
=20
 static void process_blob(struct blob *blob,
 			 struct object_array *p,
@@ -81,21 +82,25 @@ static void process_tag(struct tag *tag, struct obj=
ect_array *p, const char *nam
 		add_object(tag->tagged, p, NULL, name);
 }
=20
-static void walk_commit_list(struct rev_info *revs)
+static void walk_commit_list(struct rev_info *revs, struct progress *p=
rogress)
 {
 	int i;
 	struct commit *commit;
 	struct object_array objects =3D OBJECT_ARRAY_INIT;
+	uint32_t count =3D 0;
=20
 	/* Walk all commits, process their trees */
-	while ((commit =3D get_revision(revs)) !=3D NULL)
+	while ((commit =3D get_revision(revs)) !=3D NULL) {
 		process_tree(commit->tree, &objects, NULL, "");
+		display_progress(progress, ++count);
+	}
=20
 	/* Then walk all the pending objects, recursively processing them too=
 */
 	for (i =3D 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending =3D revs->pending.objects + i;
 		struct object *obj =3D pending->item;
 		const char *name =3D pending->name;
+		display_progress(progress, ++count);
 		if (obj->type =3D=3D OBJ_TAG) {
 			process_tag((struct tag *) obj, &objects, name);
 			continue;
@@ -191,7 +196,8 @@ static void add_cache_refs(struct rev_info *revs)
 		add_cache_tree(active_cache_tree, revs);
 }
=20
-void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
+void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
+			    struct progress *progress)
 {
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -217,5 +223,5 @@ void mark_reachable_objects(struct rev_info *revs, =
int mark_reflog)
 	 */
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	walk_commit_list(revs);
+	walk_commit_list(revs, progress);
 }
diff --git a/reachable.h b/reachable.h
index 4075181..5d082ad 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,6 +1,7 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
=20
-extern void mark_reachable_objects(struct rev_info *revs, int mark_ref=
log);
+struct progress;
+extern void mark_reachable_objects(struct rev_info *revs, int mark_ref=
log, struct progress *);
=20
 #endif
--=20
1.7.4.74.g639db
