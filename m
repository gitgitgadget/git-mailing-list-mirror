From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix 'diff=pgm' attribute to consult config
Date: Sun, 22 Apr 2007 21:41:59 -0700
Message-ID: <11773033192350-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 06:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfqNT-0003Wf-5p
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 06:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbXDWEmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 00:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbXDWEmA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 00:42:00 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56255 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161024AbXDWEl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 00:41:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423044200.UUXA1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Mon, 23 Apr 2007 00:42:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qUhz1W00F1kojtg0000000; Mon, 23 Apr 2007 00:41:59 -0400
X-Mailer: git-send-email 1.5.1.2.936.ge4dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45298>

This builds on top of the previous 'diff=pgm' attribute
support.  Attributes only name a low-level diff driver, which is
defined in the configuration:

	[lldiff "drivername"]
		command = ...

The earlier one lacked this indirection, which was a mistake.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c                   |   60 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t4020-diff-external.sh |    4 ++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index ebc1997..db61a78 100644
--- a/diff.c
+++ b/diff.c
@@ -1747,6 +1747,53 @@ static void run_external_diff(const char *pgm,
 	}
 }
 
+static struct ll_diff_driver {
+	const char *name;
+	struct ll_diff_driver *next;
+	char *cmd;
+} *user_diff, **user_diff_tail;
+
+static int parse_lldiff_config(const char *var, const char *value)
+{
+	const char *ep, *name;
+	int namelen;
+	struct ll_diff_driver *drv;
+
+	if (prefixcmp(var, "lldiff."))
+		return 0;
+
+	/* "lldiff.<drivername>.<variable>" */
+	if ((ep = strrchr(var, '.')) == var + 6)
+		return 0;
+	name = var + 7;
+	namelen = ep - name;
+	for (drv = user_diff; drv; drv = drv->next)
+		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
+			break;
+	if (!drv) {
+		char *namebuf;
+		drv = xcalloc(1, sizeof(struct ll_diff_driver));
+		namebuf = xmalloc(namelen + 1);
+		memcpy(namebuf, name, namelen);
+		namebuf[namelen] = 0;
+		drv->name = namebuf;
+		drv->next = NULL;
+		*user_diff_tail = drv;
+		user_diff_tail = &(drv->next);
+	}
+
+	ep++;
+
+	if (!strcmp("command", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		drv->cmd = strdup(value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static const char *external_diff_attr(const char *name)
 {
 	struct git_attr_check attr_diff_check;
@@ -1756,8 +1803,17 @@ static const char *external_diff_attr(const char *name)
 		const char *value = attr_diff_check.value;
 		if (!ATTR_TRUE(value) &&
 		    !ATTR_FALSE(value) &&
-		    !ATTR_UNSET(value))
-			return value;
+		    !ATTR_UNSET(value)) {
+			struct ll_diff_driver *drv;
+
+			if (!user_diff_tail) {
+				user_diff_tail = &user_diff;
+				git_config(parse_lldiff_config);
+			}
+			for (drv = user_diff; drv; drv = drv->next)
+				if (!strcmp(drv->name, value))
+					return drv->cmd;
+		}
 	}
 	return NULL;
 }
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 60a93a7..bae9c46 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -45,7 +45,9 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
 
 test_expect_success 'diff attribute' '
 
-	echo >.gitattributes "file diff=echo" &&
+	git config lldiff.parrot.command echo &&
+
+	echo >.gitattributes "file diff=parrot" &&
 
 	git diff | {
 		read path oldfile oldhex oldmode newfile newhex newmode &&
-- 
1.5.1.2.936.ge4dd
