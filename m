From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Fri, 26 Nov 2010 17:00:39 +0100
Message-ID: <1290787239-4508-1-git-send-email-kusmabite@gmail.com>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
Cc: gitster@pobox.com, ziade.tarek@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 17:01:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0jL-0001MK-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0KZQAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 11:00:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39115 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZQAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:00:53 -0500
Received: by eye27 with SMTP id 27so1022212eye.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AO8Ut2SA/4T+GNOyh72AZQlIaRleb2n4wj+tZt8Ca4I=;
        b=Tk4gDmW8ly+KyXBgqGJ6HPnjS/U/ybojrW0cDclnRCh6HrXdvUzRwXk9a0yz2Gxj36
         KVHQZH+EAWrMQdIs8SbxfPKZuo7c2R4MRoLucS3LvHnYSW9uQJV6RpGTp+/mDRQc8wqn
         QQf0KJiT9kwrhk75gh5Je+eoTU7eb9iOmc4LU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y+7F9tTonjaBIYHncGvp9oO57p0decjiiO1KIVDu9W+9ewrfWwsDux5htBPd45V5Lq
         1h1N5K9CvasSawNTmY3LjPjZRF3SwR0ln25NF9frekyuikoFQKLJ+UryxKKXK3JTyL4A
         Q2ZUDnu8xWg1klxvj2eLY8afU+U+7PAQaXUas=
Received: by 10.213.113.210 with SMTP id b18mr6773315ebq.50.1290787252310;
        Fri, 26 Nov 2010 08:00:52 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm1868064eeh.3.2010.11.26.08.00.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 08:00:50 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162256>

If someone runs "git st", the command "git status" is not suggested
because it's not one of the closest levenshtein-neighbour.

Reserve the distance of 0 for common commands where the entered command
is a prefixe, as these are often more likely to be what the user meant.

This way, "git status" is the first suggestion, while a list of possible
typos are still suggested as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 ++
 help.c   |   27 ++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

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
index 7f4928e..0d76a82 100644
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
@@ -330,10 +338,15 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh. Your system reports no Git commands at all.");
 
-	best_similarity = main_cmds.names[0]->len;
-	n = 1;
-	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
-		++n;
+	for (n = 0; n < main_cmds.cnt && !main_cmds.names[n]->len; ++n)
+		; /* nothing */
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
