From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/5] setup_revisions: remember whether a ref was positive or not
Date: Sun, 24 Jul 2011 16:21:20 +0200
Message-ID: <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZo-0006Dd-6K
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab1GXOW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab1GXOWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:24 -0400
Received: by wwe5 with SMTP id 5so3380781wwe.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fUfYhbrz2Ti237jGK/Pn6XiOm4ssMAbY7JqZpr8dEas=;
        b=DEsfGt+xN8590lyseZPmrfiZmKgpGwARc1tspiUIlHVKIawyl+dkcHbXHtsA3RNuPy
         /MEYqwiNWSSOaZ4aHJZlCWwo/duOge4s8w70eqHR+16VwFiL2mnRORSNMPro17HtzBza
         1Ltd+hxDS/EHp3GUkAPLrW2HDcg4Ow7BOyzWs=
Received: by 10.227.177.72 with SMTP id bh8mr2982035wbb.67.1311517342998;
        Sun, 24 Jul 2011 07:22:22 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
In-Reply-To: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177755>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This will be required by fast-export, when no commits were
exported, but the refs should be set, of course.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This is just in preperation of fixing the actual bug.

 object.h   |    2 +-
 revision.c |   12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/object.h b/object.h
index b6618d9..a28cd45 100644
--- a/object.h
+++ b/object.h
@@ -12,7 +12,7 @@ struct object_array {
 	struct object_array_entry {
 		struct object *item;
 		const char *name;
-		unsigned mode;
+		unsigned mode, flags;
 	} *objects;
 };
 
diff --git a/revision.c b/revision.c
index c46cfaa..72c3ee5 100644
--- a/revision.c
+++ b/revision.c
@@ -131,7 +131,7 @@ void mark_parents_uninteresting(struct commit *commit)
 	}
 }
 
-static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
+static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode, unsigned flags)
 {
 	if (!obj)
 		return;
@@ -152,11 +152,12 @@ static void add_pending_object_with_mode(struct rev_info *revs, struct object *o
 			return;
 	}
 	add_object_array_with_mode(obj, name, &revs->pending, mode);
+	revs->pending.objects[revs->pending.nr-1].flags = flags;
 }
 
 void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
 {
-	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
 }
 
 void add_head_to_pending(struct rev_info *revs)
@@ -1073,7 +1074,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			} else
 				a->object.flags |= flags_exclude;
 			b->object.flags |= flags;
-			add_pending_object(revs, &a->object, this);
+			add_pending_object_with_mode(revs, &a->object, this,
+						     S_IFINVALID, flags_exclude);
 			add_pending_object(revs, &b->object, next);
 			return 0;
 		}
@@ -1103,7 +1105,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
-	add_pending_object_with_mode(revs, object, arg, mode);
+	add_pending_object_with_mode(revs, object, arg, mode, local_flags);
 	return 0;
 }
 
@@ -1708,7 +1710,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (get_sha1_with_mode(revs->def, sha1, &mode))
 			die("bad default revision '%s'", revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
-		add_pending_object_with_mode(revs, object, revs->def, mode);
+		add_pending_object_with_mode(revs, object, revs->def, mode, 0);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
-- 
1.7.6.385.g91185.dirty
