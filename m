From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Tue, 23 Nov 2010 20:11:13 +0100
Message-ID: <1290539473-2420-1-git-send-email-kusmabite@gmail.com>
References: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
Cc: ziade.tarek@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 20:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyHb-0008Mw-QM
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab0KWTL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:11:58 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0KWTL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:11:57 -0500
Received: by eye27 with SMTP id 27so4881742eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IQVo9TXzd5225m6KQxCRFs+rF7e7xP2LA5kohaT7RKY=;
        b=vHigItey8EjS9wX33RNOsBCAUtYjzqvw9lWw2qhYnBO5mMO4RHkOffKItK9tOcohGU
         bNMX/tsv95catxndbf5PVN/lQDqemqqjCs74GqTImDw191OMHWwa/+48oQVCJs+Ah+9l
         M8a1yClYlobey/g6Arp/L/zhXfKQSnf/AptAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kvbn9p4b32a8GModackaNx1/fKnAoI5mSgbbzhDzwWybL3Z0YInVauWXhj+Mq7UsWA
         36iV5u1nMCbonLjrQdogTHG5vxOybjQB+FJ4Tf+UeYML9WTTGMvi+wn8f2nuckZnQsPP
         YU6cI3qVKMmB+Ubj91Ou8jg7C/xrVPpFa2Mo0=
Received: by 10.213.106.19 with SMTP id v19mr3672876ebo.51.1290539515970;
        Tue, 23 Nov 2010 11:11:55 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id b52sm6103272eei.1.2010.11.23.11.11.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 11:11:55 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162011>

If someone runs "git st", the command "git status" is not suggested
because it's not one of the closest levenshtein-neighbour.

Reserve the distance of 0 for common commands where the entered command
is a prefixe, as these are often more likely to be what the user meant.

This way, "git status" is the first suggestion, while a list of possible
typos are still suggested as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I guess something like this should do the trick. Thoughts?

 Makefile |    2 ++
 help.c   |   23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

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
index 7f4928e..dc76a62 100644
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
@@ -330,9 +338,12 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh. Your system reports no Git commands at all.");
 
-	best_similarity = main_cmds.names[0]->len;
-	n = 1;
-	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
+	n = 0;
+	do {
+		best_similarity = main_cmds.names[n++]->len;
+	} while (!best_similarity);
+	n++;
+	while (n < main_cmds.cnt && best_similarity >= main_cmds.names[n]->len)
 		++n;
 	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
-- 
1.7.3.2
