From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 1/3] git remote update: Report error for non-existing groups
Date: Mon,  6 Apr 2009 15:41:00 +0200
Message-ID: <1239025262-16960-2-git-send-email-finnag@pvv.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp70-0002xr-3c
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZDFNlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZDFNli
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:41:38 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56637 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbZDFNlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:41:36 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lqp4m-0004Pq-Q9; Mon, 06 Apr 2009 15:41:27 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115827>

Previosly, git remote update <non-existing-group> would just silently fail
and do nothing. Now it will report an error saying that the group does
not exist.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 builtin-remote.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 3146eb4..51df99b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1188,16 +1188,18 @@ struct remote_group {
 	struct string_list *list;
 } remote_group;
 
-static int get_remote_group(const char *key, const char *value, void *cb)
+static int get_remote_group(const char *key, const char *value, void *num_hits)
 {
 	if (!prefixcmp(key, "remotes.") &&
 			!strcmp(key + 8, remote_group.name)) {
 		/* split list by white space */
 		int space = strcspn(value, " \t\n");
 		while (*value) {
-			if (space > 1)
+			if (space > 1) {
 				string_list_append(xstrndup(value, space),
 						remote_group.list);
+				++*((int *)num_hits);
+			}
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
 		}
@@ -1227,8 +1229,11 @@ static int update(int argc, const char **argv)
 
 	remote_group.list = &list;
 	for (i = 1; i < argc; i++) {
+		int groups_found = 0;
 		remote_group.name = argv[i];
-		result = git_config(get_remote_group, NULL);
+		result = git_config(get_remote_group, &groups_found);
+		if (!groups_found && (i != 1 || strcmp(argv[1], "default")))
+			die("No such remote group: '%s'", argv[i]);
 	}
 
 	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
-- 
1.6.2.1.471.gdfdaa
