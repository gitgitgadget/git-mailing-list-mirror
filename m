From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] rerere: Expose an API corresponding to 'clear' functionality
Date: Wed, 13 Apr 2011 18:48:38 +0530
Message-ID: <1302700718-19093-1-git-send-email-artagnon@gmail.com>
References: <7vmxjwws8a.fsf@alter.siamese.dyndns.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zys-00046U-BX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836Ab1DMNTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 09:19:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60698 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1DMNTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 09:19:32 -0400
Received: by iwn34 with SMTP id 34so578791iwn.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=A+GnSmuklCv+OJ2HWG8kDK3Bz2+yN82F19OX0Gd7StA=;
        b=P2DhjJYmq2QkWxnE3bz0QIiWKzbPODd9oBbloEjPy+Pbe9fb50pyVkflkHS78J0J7U
         FndoS0ACJhiIJVBFMH7YIv/9wKPVMBOjviKrrV5Gekd0SyRx2nCM2zYLR19GfCs4+zKx
         +SXwcuO+PEPBbhVuX72prfnZ5VymKT0J29PkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ve1FfER6mfVYHY/hW94voLAHrlwulOK9qa74ug1pxLAyMbgtfXbEDZmgLTzLrdgdgZ
         MJhQN+c69p5nJIBm3Ik3FzzOeBgCViSNLqL4q28+gJ8XYyw5VBDfNe/ljAxkoiosfe6I
         nw4U+NMXiJPiAE4mYJEHLntUsiYPCTzNO/cVM=
Received: by 10.43.54.9 with SMTP id vs9mr1745542icb.5.1302700771591;
        Wed, 13 Apr 2011 06:19:31 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 19sm444072ibx.1.2011.04.13.06.19.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 06:19:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <7vmxjwws8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171455>

Expose a new function called rerere_clear, and make 'builtin/rerere.c'
use this when the corresponding command-line argument is passed.  As a
side-effect, also expose unlink_rr_item as unlink_rerere_item.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
Junio: Thanks for the review.  Is this version alright?

 builtin/rerere.c |   21 ++++-----------------
 rerere.c         |   27 +++++++++++++++++++++++++++
 rerere.h         |    2 ++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..8f939b3 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -28,14 +28,6 @@ static time_t rerere_last_used_at(const char *name)
 	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static void unlink_rr_item(const char *name)
-{
-	unlink(rerere_path(name, "thisimage"));
-	unlink(rerere_path(name, "preimage"));
-	unlink(rerere_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
-}
-
 static int git_rerere_gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.rerereresolved"))
@@ -76,7 +68,7 @@ static void garbage_collect(struct string_list *rr)
 			string_list_append(&to_remove, e->d_name);
 	}
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].string);
+		unlink_rerere_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
 }
 
@@ -142,19 +134,14 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		pathspec = get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
+	if (!strcmp(argv[0], "clear"))
+		return rerere_clear();
 
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
 
-	if (!strcmp(argv[0], "clear")) {
-		for (i = 0; i < merge_rr.nr; i++) {
-			const char *name = (const char *)merge_rr.items[i].util;
-			if (!has_rerere_resolution(name))
-				unlink_rr_item(name);
-		}
-		unlink_or_warn(git_path("MERGE_RR"));
-	} else if (!strcmp(argv[0], "gc"))
+	if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
diff --git a/rerere.c b/rerere.c
index 22dfc84..6821f33 100644
--- a/rerere.c
+++ b/rerere.c
@@ -25,6 +25,14 @@ const char *rerere_path(const char *hex, const char *file)
 	return git_path("rr-cache/%s/%s", hex, file);
 }
 
+void unlink_rerere_item(const char *name)
+{
+	unlink(rerere_path(name, "thisimage"));
+	unlink(rerere_path(name, "preimage"));
+	unlink(rerere_path(name, "postimage"));
+	rmdir(git_path("rr-cache/%s", name));
+}
+
 int has_rerere_resolution(const char *hex)
 {
 	struct stat st;
@@ -671,3 +679,22 @@ int rerere_forget(const char **pathspec)
 	}
 	return write_rr(&merge_rr, fd);
 }
+
+int rerere_clear(void)
+{
+	int i, fd;
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
+	if (fd < 0)
+		return 0;
+
+	for (i = 0; i < merge_rr.nr; i++) {
+		const char *name = (const char *)merge_rr.items[i].util;
+		if (!has_rerere_resolution(name))
+			unlink_rerere_item(name);
+	}
+	string_list_clear(&merge_rr, 1);
+	unlink_or_warn(git_path("MERGE_RR"));
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 595f49f..cd2cdb2 100644
--- a/rerere.h
+++ b/rerere.h
@@ -16,8 +16,10 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
+extern void unlink_rerere_item(const char *name);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
+extern int rerere_clear(void);
 extern int rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-- 
1.7.4.rc1.7.g2cf08.dirty
