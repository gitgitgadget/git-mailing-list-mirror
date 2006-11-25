X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-shortlog: make common repository prefix configurable with .mailmap
Date: Sat, 25 Nov 2006 00:11:02 -0800
Message-ID: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 08:11:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32266>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnscz-0007AB-Ln for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757888AbWKYILG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757889AbWKYILG
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:11:06 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:65514 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1757888AbWKYILE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:11:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125081103.JZRW97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 03:11:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qwBB1V00N1kojtg0000000; Sat, 25 Nov 2006
 03:11:11 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The code had "/pub/scm/linux/kernel/git/" hardcoded which was
too specific to the kernel project.

With this, a line in the .mailmap file:

	# repo-abbrev: /pub/scm/linux/kernel/git/

can be used to cause the substring to be abbreviated to /.../
on the title line of the commit message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-shortlog.c    |   24 ++++++++++++++++++++++--
 contrib/mailmap.linux |    2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index bdd952c..b5b13de 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,6 +9,8 @@
 static const char shortlog_usage[] =
 "git-shortlog [-n] [-s] [<commit-id>... ]";
 
+static char *common_repo_prefix;
+
 static int compare_by_number(const void *a1, const void *a2)
 {
 	const struct path_list_item *i1 = a1, *i2 = a2;
@@ -35,8 +37,26 @@ static int read_mailmap(const char *filename)
 		char *end_of_name, *left_bracket, *right_bracket;
 		char *name, *email;
 		int i;
-		if (buffer[0] == '#')
+		if (buffer[0] == '#') {
+			static const char abbrev[] = "# repo-abbrev:";
+			int abblen = sizeof(abbrev) - 1;
+			int len = strlen(buffer);
+
+			if (len && buffer[len - 1] == '\n')
+				buffer[--len] = 0;
+			if (!strncmp(buffer, abbrev, abblen)) {
+				char *cp;
+
+				if (common_repo_prefix)
+					free(common_repo_prefix);
+				common_repo_prefix = xmalloc(len);
+
+				for (cp = buffer + abblen; isspace(*cp); cp++)
+					; /* nothing */
+				strcpy(common_repo_prefix, cp);
+			}
 			continue;
+		}
 		if ((left_bracket = strchr(buffer, '<')) == NULL)
 			continue;
 		if ((right_bracket = strchr(left_bracket + 1, '>')) == NULL)
@@ -87,7 +107,7 @@ static void insert_author_oneline(struct path_list *list,
 		const char *author, int authorlen,
 		const char *oneline, int onelinelen)
 {
-	const char *dot3 = "/pub/scm/linux/kernel/git/";
+	const char *dot3 = common_repo_prefix;
 	char *buffer, *p;
 	struct path_list_item *item;
 	struct path_list *onelines;
diff --git a/contrib/mailmap.linux b/contrib/mailmap.linux
index 83927c9..e4907f8 100644
--- a/contrib/mailmap.linux
+++ b/contrib/mailmap.linux
@@ -3,6 +3,8 @@
 # So have an email->real name table to translate the
 # (hopefully few) missing names
 #
+# repo-abbrev: /pub/scm/linux/kernel/git/
+#
 Adrian Bunk <bunk@stusta.de>
 Andreas Herrmann <aherrman@de.ibm.com>
 Andrew Morton <akpm@osdl.org>
-- 
1.4.4.1.g61fba

