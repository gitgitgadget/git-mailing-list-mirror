From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-config-set: support selecting values by non-matching
 regex
Date: Sun, 20 Nov 2005 13:24:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511201320340.4838@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511200650130.12832@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr79b3i7e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 13:25:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdoF6-0002oh-K6
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 13:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVKTMYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 07:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKTMYV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 07:24:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20707 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751227AbVKTMYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 07:24:20 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 507CF1402D4; Sun, 20 Nov 2005 13:24:19 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E4D5B5274; Sun, 20 Nov 2005 13:24:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 00472B3754; Sun, 20 Nov 2005 13:24:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C24211402D4; Sun, 20 Nov 2005 13:24:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr79b3i7e.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12382>


Extend the regex syntax of value_regex so that prepending an exclamation
mark means non-match:

	[core]
		quetzal = "Dodo" for Brainf*ck
		quetzal = "T. Rex" for Malbolge
		quetzal = "cat"

You can match the third line with

	git-config-set --get quetzal '! for '

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Sat, 19 Nov 2005, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > 	The only thing I am concerned about now is how to deal with
	> > 	anti value_regex's, i.e.
	> >...
	> > 	Note: we could adjust the pattern syntax so that a prefix "!"
	> > 	means "no match", and "\!" means "match literal !", but this
	> > 	is ugly.
	> 
	> I do not think it is so bad, except that I would not even bother
	> doing the quoting of prefix '!'; the user can always say '[!]'
	> to mean a positive match that begins with an exclamation point.

	The patch is a little bit bigger, because I included also the
	documentation update and test cases proving that it works.

	Also, the matching part got minimally refactored in config.c.


 Documentation/git-config-set.txt |   18 +++++++++++++++++-
 config-set.c                     |    9 ++++++++-
 config.c                         |   23 +++++++++++++++++------
 t/t1300-config-set.sh            |   28 ++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

applies-to: 648bd602281a789b2dbcecedeae32321bb09ccbf
e2e9f798d6aa02ca54193f0c84d916d0e1a1d29b
diff --git a/Documentation/git-config-set.txt b/Documentation/git-config-set.txt
index c707fbc..bfbd421 100644
--- a/Documentation/git-config-set.txt
+++ b/Documentation/git-config-set.txt
@@ -22,7 +22,9 @@ actually the section and the key separat
 escaped.
 
 If you want to set/unset an option which can occor on multiple lines, you
-should provide a POSIX regex for the value.
+should provide a POSIX regex for the value. If you want to handle the lines
+*not* matching the regex, just prepend a single exlamation mark in front
+(see EXAMPLES).
 
 This command will fail if
 
@@ -82,6 +84,7 @@ Given a .git/config like this:
 		command="ssh" for "ssh://kernel.org/"
 		command="proxy-command" for kernel.org
 		command="myprotocol-command" for "my://"
+		command=default-proxy ; for all the rest
 
 you can set the filemode to true with
 
@@ -139,6 +142,19 @@ new one with
 % git config-set --replace-all proxy.command ssh
 ------------
 
+However, if you really only want to replace the line for the default proxy,
+i.e. the one without a "for ..." postfix, do something like this:
+
+------------
+% git config-set proxy.command ssh '! for '
+------------
+
+To actually match only values with an exclamation mark, you have to
+
+------------
+% git config-set section.key value '[!]'
+------------
+
 
 Author
 ------
diff --git a/config-set.c b/config-set.c
index 90a28b3..5f654f7 100644
--- a/config-set.c
+++ b/config-set.c
@@ -8,13 +8,15 @@ static char* key = NULL;
 static char* value = NULL;
 static regex_t* regex = NULL;
 static int do_all = 0;
+static int do_not_match = 0;
 static int seen = 0;
 
 static int show_config(const char* key_, const char* value_)
 {
 	if (!strcmp(key_, key) &&
 			(regex == NULL ||
-			 !regexec(regex, value_, 0, NULL, 0))) {
+			 (do_not_match ^
+			  !regexec(regex, value_, 0, NULL, 0)))) {
 		if (do_all) {
 			printf("%s\n", value_);
 			return 0;
@@ -38,6 +40,11 @@ static int get_value(const char* key_, c
 		key[i] = tolower(key_[i]);
 
 	if (regex_) {
+		if (regex_[0] == '!') {
+			do_not_match = 1;
+			regex_++;
+		}
+
 		regex = (regex_t*)malloc(sizeof(regex_t));
 		if (regcomp(regex, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
diff --git a/config.c b/config.c
index 697d79f..5d237c8 100644
--- a/config.c
+++ b/config.c
@@ -269,6 +269,7 @@ int git_config(config_fn_t fn)
 static struct {
 	int baselen;
 	char* key;
+	int do_not_match;
 	regex_t* value_regex;
 	int multi_replace;
 	off_t offset[MAX_MATCHES];
@@ -276,13 +277,19 @@ static struct {
 	int seen;
 } store;
 
+static int matches(const char* key, const char* value)
+{
+	return !strcmp(key, store.key) &&
+		(store.value_regex == NULL ||
+		 (store.do_not_match ^
+		  !regexec(store.value_regex, value, 0, NULL, 0)));
+}
+
 static int store_aux(const char* key, const char* value)
 {
 	switch (store.state) {
 	case KEY_SEEN:
-		if (!strcmp(key, store.key) &&
-				(store.value_regex == NULL ||
-				!regexec(store.value_regex, value, 0, NULL, 0))) {
+		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
 				fprintf(stderr,
 					"Warning: %s has multiple values\n",
@@ -306,9 +313,7 @@ static int store_aux(const char* key, co
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
-		if (!strcmp(key, store.key) &&
-				(store.value_regex == NULL ||
-				!regexec(store.value_regex, value, 0, NULL, 0))) {
+		if (matches(key, value)) {
 			store.offset[store.seen] = ftell(config_file);
 			store.state = KEY_SEEN;
 			store.seen++;
@@ -471,6 +476,12 @@ int git_config_set_multivar(const char* 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
 		else {
+			if (value_regex[0] == '!') {
+				store.do_not_match = 1;
+				value_regex++;
+			} else
+				store.do_not_match = 0;
+
 			store.value_regex = (regex_t*)malloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
diff --git a/t/t1300-config-set.sh b/t/t1300-config-set.sh
index 717bf4d..59b6c4c 100644
--- a/t/t1300-config-set.sh
+++ b/t/t1300-config-set.sh
@@ -69,6 +69,28 @@ EOF
 
 test_expect_success 'similar section' 'cmp .git/config expect'
 
+test_expect_success 'replace with non-match' \
+	'git-config-set core.penguin kingpin !blue'
+
+test_expect_success 'replace with non-match (actually matching)' \
+	'git-config-set core.penguin "very blue" !kingpin'
+
+cat > expect << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin = very blue
+	Movie = BadPhysics
+	UPPERCASE = true
+	penguin = kingpin
+[Cores]
+	WhatEver = Second
+EOF
+
+test_expect_success 'non-match result' 'cmp .git/config expect'
+
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
 noIndent= sillyValue ; 'nother silly comment
@@ -173,6 +195,12 @@ EOF
 
 test_expect_success 'multivar' 'cmp .git/config expect'
 
+test_expect_success 'non-match' \
+	'git-config-set --get nextsection.nonewline !for'
+
+test_expect_success 'non-match value' \
+	'test wow = $(git-config-set --get nextsection.nonewline !for)'
+
 test_expect_failure 'ambiguous get' \
 	'git-config-set --get nextsection.nonewline'
 
---
0.99.9.GIT
