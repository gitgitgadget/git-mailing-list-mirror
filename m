From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 4/5] store mode in rev_list, if <tree>:<filename> syntax is used
Date: Sun, 22 Apr 2007 18:43:59 +0200
Message-ID: <11772602401214-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at> <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at> <1177260240928-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HffBB-0001Ur-5g
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbXDVQoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbXDVQo3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:44:29 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51172 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161475AbXDVQoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:44:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 334247833E04;
	Sun, 22 Apr 2007 18:44:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNO-avhD2dhz; Sun, 22 Apr 2007 18:44:01 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B0DD27833E00; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <1177260240928-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45251>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 revision.c |   17 ++++++++++++-----
 revision.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index ce70f48..49bd292 100644
--- a/revision.c
+++ b/revision.c
@@ -116,9 +116,14 @@ void mark_parents_uninteresting(struct commit *commit)
 
 void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
 {
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
+}
+
+void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
+{
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
-	add_object_array(obj, name, &revs->pending);
+	add_object_array_with_mode(obj, name, &revs->pending, mode);
 	if (revs->reflog_info && obj->type == OBJ_COMMIT)
 		add_reflog_for_walk(revs->reflog_info,
 				(struct commit *)obj, name);
@@ -723,6 +728,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
 {
+	unsigned mode;
 	char *dotdot;
 	struct object *object;
 	unsigned char sha1[20];
@@ -796,12 +802,12 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1(arg, sha1))
+	if (get_sha1_with_mode(arg, sha1, &mode))
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
-	add_pending_object(revs, object, arg);
+	add_pending_object_with_mode(revs, object, arg, mode);
 	return 0;
 }
 
@@ -1177,10 +1183,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
-		if (get_sha1(def, sha1))
+		unsigned mode;
+		if (get_sha1_with_mode(def, sha1, &mode))
 			die("bad default revision '%s'", def);
 		object = get_reference(revs, def, sha1, 0);
-		add_pending_object(revs, object, def);
+		add_pending_object_with_mode(revs, object, def, mode);
 	}
 
 	if (revs->topo_order)
diff --git a/revision.h b/revision.h
index 8a02618..5b41e2d 100644
--- a/revision.h
+++ b/revision.h
@@ -131,5 +131,6 @@ extern void add_object(struct object *obj,
 		       const char *name);
 
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
+extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
 
 #endif
-- 
1.5.1.1.206.g4a12-dirty
