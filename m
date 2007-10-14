From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/6] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 14 Oct 2007 10:54:42 +0200
Message-ID: <11923520853189-git-send-email-prohaska@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de>
 <1192352085653-git-send-email-prohaska@zib.de>
 <11923520852991-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 10:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzFX-0006lW-Nl
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXJNIyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbXJNIyw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:54:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:58229 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbXJNIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:54:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E8ska9025869
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 10:54:46 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E8sjYu021275;
	Sun, 14 Oct 2007 10:54:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11923520852991-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60808>

"git rev-parse --symbolic" used to return the ref name as it was
specified on the command line. This is changed to returning the
full matched ref name, i.e. "git rev-parse --symbolic master"
now typically returns "refs/heads/master".

Note, this changes output of an established command. It might
break existing setups. I checked that it does not break scripts
in git.git.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-rev-parse.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 8d78b69..e64abeb 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -93,7 +93,7 @@ static void show(const char *arg)
 }
 
 /* Output a revision, only if filter allows it */
-static void show_rev(int type, const unsigned char *sha1, const char *name)
+static void show_rev(int type, const unsigned char *sha1, const char *name, const char* real_name)
 {
 	if (!(filter & DO_REVS))
 		return;
@@ -102,7 +102,9 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 
 	if (type != show_type)
 		putchar('^');
-	if (symbolic && name)
+	if (symbolic && real_name)
+		show(real_name);
+	else if (symbolic && name)
 		show(name);
 	else if (abbrev)
 		show(find_unique_abbrev(sha1, abbrev));
@@ -131,7 +133,7 @@ static void show_default(void)
 
 		def = NULL;
 		if (!get_sha1(s, sha1)) {
-			show_rev(NORMAL, sha1, s);
+			show_rev(NORMAL, sha1, s, 0);
 			return;
 		}
 	}
@@ -139,7 +141,7 @@ static void show_default(void)
 
 static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	show_rev(NORMAL, sha1, refname);
+	show_rev(NORMAL, sha1, refname, 0);
 	return 0;
 }
 
@@ -187,8 +189,8 @@ static int try_difference(const char *arg)
 	if (dotdot == arg)
 		this = "HEAD";
 	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
-		show_rev(NORMAL, end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
+		show_rev(NORMAL, end, next, 0);
+		show_rev(symmetric ? NORMAL : REVERSED, sha1, this, 0);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
@@ -198,7 +200,7 @@ static int try_difference(const char *arg)
 			while (exclude) {
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
-					 exclude->item->object.sha1,NULL);
+					 exclude->item->object.sha1, NULL, 0);
 				free(exclude);
 				exclude = n;
 			}
@@ -213,6 +215,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
+	char* real_name = 0;
 
 	git_config(git_default_config);
 
@@ -393,12 +396,16 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
-		if (!get_sha1(arg, sha1)) {
-			show_rev(NORMAL, sha1, arg);
+		if (!get_sha1_with_real_ref(arg, sha1, &real_name)) {
+			show_rev(NORMAL, sha1, arg, real_name);
+			if(real_name) {
+				free(real_name);
+				real_name = 0;
+			}
 			continue;
 		}
 		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
-			show_rev(REVERSED, sha1, arg+1);
+			show_rev(REVERSED, sha1, arg+1, 0);
 			continue;
 		}
 		as_is = 1;
-- 
1.5.3.4.224.gc6b84
