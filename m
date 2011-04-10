From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/11] revert: Handle conflict resolutions more elegantly
Date: Sun, 10 Apr 2011 20:41:53 +0530
Message-ID: <1302448317-32387-8-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKi-0008P3-Ki
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab1DJPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab1DJPNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:42 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=3jE17J13434odQWpNpm0Gf2YsXzaEqPU7ZBhjCdNnfQ=;
        b=xOoFthZS7xudAvZmRErqCuSmxK9FrgaDXzf3R0IUnmxq+jnnWBSaEJzoMwvvarVcab
         O0tmlW3iMZRkuBomxipIzkP0iISVEECbbDZg+3HCr9OOWQpT/rU7SE5zOd2kL2TW8QhV
         T6+437tIbdqdb+eXTjuTn1NiN243Tkgq8sTA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wq0WzPnP2wU1D0R6GqKQr90SPa6DhEPOMXuHjy0gVqQrgIxKgiBUiJX+NhGnJocE3E
         GSMdlGFWk+GsRhOrkKrT1X8iTExoX0STwvcrZTXQEjTZ3dD0VYO7RyR+14gniMsjfQII
         t9qb50x2zXZ4G66UpWJHrJIEaLwpfXA3BiHjU=
Received: by 10.231.116.139 with SMTP id m11mr4377109ibq.165.1302448421824;
        Sun, 10 Apr 2011 08:13:41 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171261>

Avoid calling die; return error instead.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 advice.c         |   14 ++++++++++++++
 advice.h         |    1 +
 builtin/revert.c |   40 ++++++++++++++++++----------------------
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..3c3c187 100644
--- a/advice.c
+++ b/advice.c
@@ -47,3 +47,17 @@ void NORETURN die_resolve_conflict(const char *me)
 	else
 		die("'%s' is not possible because you have unmerged files.", me);
 }
+
+int error_resolve_conflict(const char *me)
+{
+	if (advice_resolve_conflict)
+		/*
+		 * Message used both when 'git commit' fails and when
+		 * other commands doing a merge do.
+		 */
+		return error("'%s' is not possible because you have unmerged files.\n"
+			"Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
+			"appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
+	else
+		return error("'%s' is not possible because you have unmerged files.", me);
+}
diff --git a/advice.h b/advice.h
index 3244ebb..7b7cea5 100644
--- a/advice.h
+++ b/advice.h
@@ -13,5 +13,6 @@ extern int advice_detached_head;
 int git_default_advice_config(const char *var, const char *value);
 
 extern void NORETURN die_resolve_conflict(const char *me);
+extern int error_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
diff --git a/builtin/revert.c b/builtin/revert.c
index b90f3d0..e0352d4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -344,25 +344,20 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static int error_dirty_index()
+static int verify_resolution(const char *me)
 {
-	if (read_cache_unmerged()) {
-		die_resolve_conflict(cmd_opts.action == REVERT ? "revert" : "cherry-pick");
-	} else {
-		if (advice_commit_before_merge) {
-			if (cmd_opts.action == REVERT)
-				return error(_("Your local changes would be overwritten by revert.\n"
-					  "Please, commit your changes or stash them to proceed."));
-			else
-				return error(_("Your local changes would be overwritten by cherry-pick.\n"
-					  "Please, commit your changes or stash them to proceed."));
-		} else {
-			if (cmd_opts.action == REVERT)
-				return error(_("Your local changes would be overwritten by revert.\n"));
-			else
-				return error(_("Your local changes would be overwritten by cherry-pick.\n"));
-		}
-	}
+	if (!read_cache_unmerged())
+		return 0;
+
+	return error_resolve_conflict(me);
+}
+
+static int error_dirty_worktree(const char *me)
+{
+	if (advice_commit_before_merge)
+		return error(_("Your local changes would be overwritten by %s.\n"
+				"Please, commit your changes or stash them to proceed."), me);
+	return error(_("Your local changes would be overwritten by %s.\n"), me);
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -467,8 +462,10 @@ static int do_pick_commit(struct commit *commit)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
+	const char *me;
 	int res;
 
+	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
 	if (cmd_opts.no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
@@ -481,8 +478,8 @@ static int do_pick_commit(struct commit *commit)
 	} else {
 		if (get_sha1("HEAD", head))
 			return error(_("You do not have a valid HEAD"));
-		if (index_differs_from("HEAD", 0))
-			return error_dirty_index();
+		if (index_differs_from("HEAD", 0) && !verify_resolution(me))
+			return error_dirty_worktree(me);
 	}
 	discard_cache();
 
@@ -521,8 +518,7 @@ static int do_pick_commit(struct commit *commit)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			cmd_opts.action == REVERT ? "revert" : "cherry-pick",
-			sha1_to_hex(parent->object.sha1));
+			me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, commit->buffer, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
-- 
1.7.4.rc1.7.g2cf08.dirty
