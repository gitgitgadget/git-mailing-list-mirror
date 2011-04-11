From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] rerere: Expose an API corresponding to 'clear' functionality
Date: Mon, 11 Apr 2011 14:21:56 +0530
Message-ID: <1302511916-23320-1-git-send-email-artagnon@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 10:52:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Cre-0007Dd-No
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 10:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab1DKIwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 04:52:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47466 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab1DKIwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 04:52:49 -0400
Received: by iyb14 with SMTP id 14so5403692iyb.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=KYkFU1yVlGQXZP8y/WhBdEvWPJoIyqC9AXpdLPa5izc=;
        b=h8vwu/SfcyqIfGURpAqBtoe+dD7JnrKDay6XGBg0HlpBSdmAB0ZYW3y2BoP/B6CrJ8
         tpBxNrRRHA7XbSyFLvlEnKZMPtAOqZGEiLGbENIG96fX4bXJ88aQRtFzoKhVyBkl87dj
         yr9OxkWIQ8feQzcsSWEV9/KZdgcQo9Y/q3AsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Mt7tTZeyfjLr3YC0wj3khVlm1CfvCURSC3ulrcK/CsZ0yFbuM4jCNsmoSBBpDbzQVa
         dPM4H21wR5KESJuSfO/jdddVz6G5BMLJcQC1bjeaRezPWSmjF9Zs/CoD8KGP5YwYHWsN
         iCzXhQIfEfiahkNsYf/N5TaiIwk0T8KfGqOtI=
Received: by 10.231.25.137 with SMTP id z9mr5217032ibb.53.1302511968593;
        Mon, 11 Apr 2011 01:52:48 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d9sm4086481ibb.19.2011.04.11.01.52.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 01:52:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171314>

Expose a new function called rerere_clear, and rework
'builtin/rerere.c' to use this when the corresponding command-line
argument is passed.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
Ref: http://thread.gmane.org/gmane.comp.version-control.git/171255/focus=171273

 builtin/rerere.c |   19 +++----------------
 rerere.c         |   24 ++++++++++++++++++++++++
 rerere.h         |    2 ++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..f3956bf 100644
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
index 22dfc84..f8da9bd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -25,6 +25,14 @@ const char *rerere_path(const char *hex, const char *file)
 	return git_path("rr-cache/%s/%s", hex, file);
 }
 
+void unlink_rr_item(const char *name)
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
@@ -671,3 +679,19 @@ int rerere_forget(const char **pathspec)
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
+	for (i = 0; i < merge_rr.nr; i++) {
+		const char *name = (const char *)merge_rr.items[i].util;
+		if (!has_rerere_resolution(name))
+			unlink_rr_item(name);
+	}
+	string_list_clear(&merge_rr, 1);
+	unlink_or_warn(git_path("MERGE_RR"));
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 595f49f..b9ab839 100644
--- a/rerere.h
+++ b/rerere.h
@@ -16,8 +16,10 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
+extern void unlink_rr_item(const char *name);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
+extern int rerere_clear(void);
 extern int rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-- 
1.7.4.rc1.7.g2cf08.dirty
