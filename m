From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow hierarchical section names
Date: Sun, 20 Nov 2005 21:22:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511202109160.23849@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Nov 20 21:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edvhj-00054R-Ln
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKTUWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKTUWW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:22:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8150 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750795AbVKTUWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 15:22:21 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 91A5F13F0A1
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:22:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 72A12B5280
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:22:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 49AD7B3754
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:22:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2A53513F0A1
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:22:20 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12398>

A .git/config like follows becomes valid with this patch:

	[remote.junio]
		url = git://git.kernel.org/pub/scm/git/git.git
		pull = master:junio todo:todo +pu:pu

	[remote.ibook]
		url = ibook:git/
		pull = master:ibook
		push = master:quetzal

(This patch only does the ini file thing, git-fetch and friends still
ignore these values).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Note that -- since don't favor that approach -- this patch
	does *not* allow for "citing hierarchies" like this:

		[Tyrannosaurus.rex]
			jaw = big
		[.minor]
			jaw = unknown

	i.e. the complete key of the second entry would be ".minor.jaw",
	not "Tyrannosaurus.minor.jaw".

 config.c              |   19 ++++++++++---------
 t/t1300-config-set.sh |   19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

applies-to: b86aaa1512dbd810af049ec0611604272ac731e7
ff7acdf861ddcb9ff385476c68d35777469494bc
diff --git a/config.c b/config.c
index 5d237c8..38c0edd 100644
--- a/config.c
+++ b/config.c
@@ -143,7 +143,7 @@ static int get_base_var(char *name)
 			return -1;
 		if (c == ']')
 			return baselen;
-		if (!isalnum(c))
+		if (!isalnum(c) && c != '.')
 			return -1;
 		if (baselen > MAXNAME / 2)
 			return -1;
@@ -405,28 +405,29 @@ int git_config_set_multivar(const char* 
 	int fd;
 	char* config_file = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
-
-	store.multi_replace = multi_replace;
+	const char* last_dot = strrchr(key, '.');
 
 	/*
 	 * Since "key" actually contains the section name and the real
 	 * key name separated by a dot, we have to know where the dot is.
 	 */
-	for (store.baselen = 0;
-			key[store.baselen] != '.' && key[store.baselen];
-			store.baselen++);
-	if (!key[store.baselen] || !key[store.baselen+1]) {
+
+	if (last_dot == NULL) {	
 		fprintf(stderr, "key does not contain a section: %s\n", key);
 		return 2;
 	}
+	store.baselen = last_dot - key;
+
+	store.multi_replace = multi_replace;
 
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
 	store.key = (char*)malloc(strlen(key)+1);
 	for (i = 0; key[i]; i++)
-		if (i != store.baselen && (!isalnum(key[i]) ||
-				(i == store.baselen+1 && !isalpha(key[i])))) {
+		if (i != store.baselen &&
+				((!isalnum(key[i]) && key[i] != '.') ||
+				 (i == store.baselen+1 && !isalpha(key[i])))) {
 			fprintf(stderr, "invalid key: %s\n", key);
 			free(store.key);
 			return 1;
diff --git a/t/t1300-config-set.sh b/t/t1300-config-set.sh
index 59b6c4c..7a5849a 100644
--- a/t/t1300-config-set.sh
+++ b/t/t1300-config-set.sh
@@ -248,5 +248,24 @@ test_expect_failure 'invalid key' 'git-c
 
 test_expect_success 'correct key' 'git-config-set 123456.a123 987'
 
+test_expect_success 'hierarchical section' \
+	'git-config-set 1.2.3.alpha beta'
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection]
+	NoNewLine = wow2 for me
+[123456]
+	a123 = 987
+[1.2.3]
+	alpha = beta
+EOF
+
+test_expect_success 'hierarchical section value' 'cmp .git/config expect'
+
 test_done
 
---
0.99.9.GIT
