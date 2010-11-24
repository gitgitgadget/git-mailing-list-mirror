From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Thu, 25 Nov 2010 00:53:41 +0100
Message-ID: <1290642821-2984-1-git-send-email-kusmabite@gmail.com>
References: <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com>
Cc: gitster@pobox.com, ziade.tarek@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 00:54:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLPAZ-0000wt-No
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 00:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab0KXXy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 18:54:29 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42053 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab0KXXy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 18:54:28 -0500
Received: by ewy5 with SMTP id 5so181965ewy.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 15:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v8c7U8bd+6douLDBvP0go9wkDGQBcUyOhiDRBKnR3aQ=;
        b=cOyPSuK3GQAtjMbkJ1ASJgF1A9WeWR7DOPp32YYtL7/aI/h/Lo2uBBY2cGpqCpvilr
         o2LUgjt2iyIkLNCx08GykkndNOw/QvfVp7dMfLR9Yk8FIu878PrmJMtJNtu38GROxvac
         IE2kojyEEfe4yA2cSsLw5pq8WGxE/iPbaqYmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J1j6hHpyyg6LBsbBh9Lhhu4INq0TnR27IRp+JWgYiITOJJJ6wjjmfa+5cezwR/w4kf
         BEhlhEbF1U+U8NLjSgkS+JQEJquHHzf0oA091MxIEcp0+k0dxuP5emJvvZDLiFTYoBTn
         LWE/QWn8uBMVK5KcyE6a0zNrqC8oq+l1WLKKU=
Received: by 10.213.8.143 with SMTP id h15mr1734711ebh.17.1290642867222;
        Wed, 24 Nov 2010 15:54:27 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm66666eeh.6.2010.11.24.15.54.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 15:54:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162094>

If someone runs "git st", the command "git status" is not suggested
because it's not one of the closest levenshtein-neighbour.

Reserve the distance of 0 for common commands where the entered command
is a prefixe, as these are often more likely to be what the user meant.

This way, "git status" is the first suggestion, while a list of possible
typos are still suggested as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's an updated version, with the issues Junio fixed.

I hope this is a bit clearer.

 Makefile |    2 ++
 help.c   |   26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..d6ba349 100644
--- a/Makefile
+++ b/Makefile
@@ -1611,6 +1611,8 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
+help.o: common-cmds.h
+
 builtin/help.o: common-cmds.h
 builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
diff --git a/help.c b/help.c
index 7f4928e..dff5d6b 100644
--- a/help.c
+++ b/help.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "levenshtein.h"
 #include "help.h"
+#include "common-cmds.h"
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
@@ -298,7 +299,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 }
 
 /* An empirically derived magic number */
-#define SIMILAR_ENOUGH(x) ((x) < 6)
+#define SIMILAR_ENOUGH(x) ((x) < 7)
 
 const char *help_unknown_cmd(const char *cmd)
 {
@@ -320,9 +321,16 @@ const char *help_unknown_cmd(const char *cmd)
 	uniq(&main_cmds);
 
 	/* This reuses cmdname->len for similarity index */
-	for (i = 0; i < main_cmds.cnt; ++i)
-		main_cmds.names[i]->len =
+	for (i = 0; i < main_cmds.cnt; ++i) {
+		main_cmds.names[i]->len = 1 +
 			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+		for (n = 0; n < ARRAY_SIZE(common_cmds); ++n) {
+			if (!strcmp(main_cmds.names[i]->name,
+			    common_cmds[n].name) &&
+			    !prefixcmp(main_cmds.names[i]->name, cmd))
+				main_cmds.names[i]->len = 0;
+		}
+	}
 
 	qsort(main_cmds.names, main_cmds.cnt,
 	      sizeof(*main_cmds.names), levenshtein_compare);
@@ -330,10 +338,16 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh. Your system reports no Git commands at all.");
 
-	best_similarity = main_cmds.names[0]->len;
-	n = 1;
-	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
+	n = 0;
+	while (n < main_cmds.cnt && !main_cmds.names[n]->len)
 		++n;
+	if (n < main_cmds.cnt) {
+		best_similarity = main_cmds.names[n++]->len;
+		while (n < main_cmds.cnt &&
+		       best_similarity == main_cmds.names[n]->len)
+			++n;
+	} else
+		best_similarity = 0;
 	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
-- 
1.7.3.2
