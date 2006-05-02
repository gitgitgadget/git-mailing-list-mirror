From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] repo-config: support --get-regexp and fix crash
Date: Tue, 2 May 2006 14:22:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 02 14:23:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fatu5-0001la-TJ
	for gcvg-git@gmane.org; Tue, 02 May 2006 14:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWEBMWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWEBMWu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 08:22:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11451 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964792AbWEBMWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 08:22:49 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 4218BD95;
	Tue,  2 May 2006 14:22:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3543DCEF;
	Tue,  2 May 2006 14:22:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 14F49B9B;
	Tue,  2 May 2006 14:22:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19415>


With --get-regexp, output all key/value pairs where the key matches a
regexp. Example:

	git-repo-config --get-regexp remote.*.url

will output something like

	remote.junio.url git://git.kernel.org/pub/scm/git/git.git
	remote.gitk.url git://git.kernel.org/pub/scm/gitk/gitk.git

This also fixes a crash when no arguments are given, which was introduced
with the "-l" and "--list" handling.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Junio made me aware of a crash, a fix for which was too easy to
	merit a separate patch.

	Strange thing I realized: A value is white-space-trimmed at the end
	only if the line does not end with a comment. This fact is accounted
	for in the new tests.

 Documentation/git-repo-config.txt |    5 +++-
 repo-config.c                     |   45 +++++++++++++++++++++++++++++--------
 t/t1300-repo-config.sh            |   23 +++++++++++++++++++
 3 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 566cfa1..ddcf523 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -49,7 +49,7 @@ OPTIONS
 
 --replace-all::
 	Default behaviour is to replace at most one line. This replaces
-	all lines matching the key (and optionally the value_regex)
+	all lines matching the key (and optionally the value_regex).
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
@@ -59,6 +59,9 @@ OPTIONS
 	Like get, but does not fail if the number of values for the key
 	is not exactly one.
 
+--get-regexp::
+	Like --get-all, but interprets the name as a regular expression.
+
 --unset::
 	Remove the line matching the key from .git/config.
 
diff --git a/repo-config.c b/repo-config.c
index fa8aba7..722153c 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -6,7 +6,10 @@ static const char git_config_set_usage[]
 
 static char* key = NULL;
 static char* value = NULL;
+static regex_t* key_regexp = NULL;
 static regex_t* regexp = NULL;
+static int show_keys = 0;
+static int use_key_regexp = 0;
 static int do_all = 0;
 static int do_not_match = 0;
 static int seen = 0;
@@ -26,16 +29,18 @@ static int show_config(const char* key_,
 	if (value_ == NULL)
 		value_ = "";
 
-	if (!strcmp(key_, key) &&
+	if ((use_key_regexp || !strcmp(key_, key)) &&
+			(!use_key_regexp ||
+			 !regexec(key_regexp, key_, 0, NULL, 0)) &&
 			(regexp == NULL ||
 			 (do_not_match ^
 			  !regexec(regexp, value_, 0, NULL, 0)))) {
-		if (do_all) {
-			printf("%s\n", value_);
-			return 0;
-		}
+		if (show_keys)
+			printf("%s ", key_);
 		if (seen > 0) {
-			fprintf(stderr, "More than one value: %s\n", value);
+			if (!do_all)
+				fprintf(stderr, "More than one value: %s\n",
+						value);
 			free(value);
 		}
 
@@ -50,6 +55,8 @@ static int show_config(const char* key_,
 			value = strdup(value_);
 		}
 		seen++;
+		if (do_all)
+			printf("%s\n", value);
 	}
 	return 0;
 }
@@ -63,6 +70,14 @@ static int get_value(const char* key_, c
 		key[i] = tolower(key_[i]);
 	key[i] = 0;
 
+	if (use_key_regexp) {
+		key_regexp = (regex_t*)malloc(sizeof(regex_t));
+		if (regcomp(key_regexp, key, REG_EXTENDED)) {
+			fprintf(stderr, "Invalid key pattern: %s\n", regex_);
+			return -1;
+		}
+	}
+
 	if (regex_) {
 		if (regex_[0] == '!') {
 			do_not_match = 1;
@@ -78,7 +93,8 @@ static int get_value(const char* key_, c
 
 	git_config(show_config);
 	if (value) {
-		printf("%s\n", value);
+		if (!do_all)
+			printf("%s\n", value);
 		free(value);
 	}
 	free(key);
@@ -102,15 +118,14 @@ int main(int argc, const char **argv)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
+		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
+			return git_config(show_all_config);
 		else
 			break;
 		argc--;
 		argv++;
 	}
 
-	if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
-		return git_config(show_all_config);
-
 	switch (argc) {
 	case 2:
 		return get_value(argv[1], NULL);
@@ -124,6 +139,11 @@ int main(int argc, const char **argv)
 		else if (!strcmp(argv[1], "--get-all")) {
 			do_all = 1;
 			return get_value(argv[2], NULL);
+		} else if (!strcmp(argv[1], "--get-regexp")) {
+			show_keys = 1;
+			use_key_regexp = 1;
+			do_all = 1;
+			return get_value(argv[2], NULL);
 		} else
 
 			return git_config_set(argv[1], argv[2]);
@@ -137,6 +157,11 @@ int main(int argc, const char **argv)
 		else if (!strcmp(argv[1], "--get-all")) {
 			do_all = 1;
 			return get_value(argv[2], argv[3]);
+		} else if (!strcmp(argv[1], "--get-regexp")) {
+			show_keys = 1;
+			use_key_regexp = 1;
+			do_all = 1;
+			return get_value(argv[2], argv[3]);
 		} else if (!strcmp(argv[1], "--replace-all"))
 
 			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ab4dd5c..52e8e33 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -247,6 +247,24 @@ EOF
 
 test_expect_success 'hierarchical section value' 'cmp .git/config expect'
 
+cat > expect << EOF
+beta.noindent=sillyValue 
+nextsection.nonewline=wow2 for me
+123456.a123=987
+1.2.3.alpha=beta
+EOF
+
+test_expect_success 'working --list' \
+	'git-repo-config --list > output && cmp output expect'
+
+cat > expect << EOF
+beta.noindent sillyValue 
+nextsection.nonewline wow2 for me
+EOF
+
+test_expect_success '--get-regexp' \
+	'git-repo-config --get-regexp in > output && cmp output expect'
+
 cat > .git/config << EOF
 [novalue]
 	variable
@@ -255,5 +273,10 @@ EOF
 test_expect_success 'get variable with no value' \
 	'git-repo-config --get novalue.variable ^$'
 
+git-repo-config > output 2>&1
+
+test_expect_success 'no arguments, but no crash' \
+	"test $? = 129 && grep usage output"
+
 test_done
 
