From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach repo-config the -l and --get-regexp options
Date: Sat, 11 Feb 2006 13:10:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602111306450.25997@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43ED0368.7020204@gmail.com> <7vhd76vqrg.fsf@assigned-by-dhcp.cox.net>
 <43ED3FD3.7020005@gmail.com> <7vvevmtza4.fsf@assigned-by-dhcp.cox.net>
 <43ED5F60.1010408@gmail.com> <7v1wyasfam.fsf@assigned-by-dhcp.cox.net>
 <7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 13:10:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7taC-00025n-Nk
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 13:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWBKMKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 07:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBKMKY
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 07:10:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10725 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751392AbWBKMKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 07:10:23 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32A0B14629D; Sat, 11 Feb 2006 13:10:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 23DF110E0;
	Sat, 11 Feb 2006 13:10:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F267714629D; Sat, 11 Feb 2006 13:10:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15938>


Now you can say "git-repo-config -l" and it will output the same as
"git-var -l", except that the keys are separated from the values by
a space instead of an equal sign.

If you want to match only "core" lines, just do

	git-repo-config --get-regexp ^core

and if you want to be more specific, you can say

	git-repo-config --get-regexp "^core.*mode"

to match any keys in section [core] which end in "mode".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Fri, 10 Feb 2006, Junio C Hamano wrote:

	> Junio C Hamano <junkio@cox.net> writes:
	> 
	> > git-sh-setup one is easy to fix.  We could say something equally
	> > silly like this instead:
	> 
	> BTW, the reason I initially did this one and git-pull with
	> git-var was there was no way to extract values from the config
	> file easily from the command line back then. git-repo-config was
	> initially called git-config-set and was about setting values.

	Happier?

 Documentation/git-repo-config.txt |   10 ++++-
 repo-config.c                     |   77 ++++++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 19 deletions(-)

aef2834ec6dfbdcca79879b4b749bbe9d3c2b63f
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 3069464..b7e0c23 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -8,10 +8,12 @@ git-repo-config - Get and set options in
 
 SYNOPSIS
 --------
+'git-repo-config' -l
 'git-repo-config' name [value [value_regex]]
 'git-repo-config' --replace-all name [value [value_regex]]
 'git-repo-config' --get name [value_regex]
 'git-repo-config' --get-all name [value_regex]
+'git-repo-config' --get-regexp name
 'git-repo-config' --unset name [value_regex]
 'git-repo-config' --unset-all name [value_regex]
 
@@ -39,9 +41,12 @@ This command will fail if
 OPTIONS
 -------
 
+-l::
+	List all key/value pairs.
+
 --replace-all::
 	Default behaviour is to replace at most one line. This replaces
-	all lines matching the key (and optionally the value_regex)
+	all lines matching the key (and optionally the value_regex).
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
@@ -51,6 +56,9 @@ OPTIONS
 	Like get, but does not fail if the number of values for the key
 	is not exactly one.
 
+--get-regexp::
+	Like --get-all, but interprets the name as a regular expression.
+
 --unset::
 	Remove the line matching the key from .git/config.
 
diff --git a/repo-config.c b/repo-config.c
index c31e441..80f370e 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -2,32 +2,42 @@
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
+"git-repo-config [-l | --get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]]";
 
 static char* key = NULL;
 static char* value = NULL;
+static regex_t* key_regexp = NULL;
 static regex_t* regexp = NULL;
+static int show_keys = 0;
+static int use_key_regexp = 0;
 static int do_all = 0;
 static int do_not_match = 0;
 static int seen = 0;
 
 static int show_config(const char* key_, const char* value_)
 {
-	if (!strcmp(key_, key) &&
-			(regexp == NULL ||
-			 (do_not_match ^
-			  !regexec(regexp, value_, 0, NULL, 0)))) {
-		if (do_all) {
-			printf("%s\n", value_);
+	if (key && strcmp(key_, key))
 			return 0;
-		}
-		if (seen > 0) {
-			fprintf(stderr, "More than one value: %s\n", value);
-			free(value);
-		}
-		value = strdup(value_);
-		seen++;
+	if (key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+		return 0;
+
+	if (regexp && (do_not_match ^
+			  !!regexec(regexp, value_, 0, NULL, 0)))
+		return 0;
+
+	if (show_keys)
+		printf("%s ", key_);
+
+	if (do_all) {
+		printf("%s\n", value_);
+		return 0;
+	}
+	if (seen > 0) {
+		fprintf(stderr, ": More than one value: %s\n", value);
+		free(value);
 	}
+	value = strdup(value_);
+	seen++;
 	return 0;
 }
 
@@ -35,10 +45,22 @@ static int get_value(const char* key_, c
 {
 	int i;
 
-	key = malloc(strlen(key_)+1);
-	for (i = 0; key_[i]; i++)
-		key[i] = tolower(key_[i]);
-	key[i] = 0;
+	if (key_) {
+		if (use_key_regexp) {
+			key_regexp = (regex_t*)malloc(sizeof(regex_t));
+			if (regcomp(key_regexp, key_, REG_EXTENDED)) {
+				fprintf(stderr, "Invalid key pattern: %s\n",
+						regex_);
+				return -1;
+			}
+		} else {
+			key = malloc(strlen(key_)+1);
+			for (i = 0; key_[i]; i++)
+				key[i] = tolower(key_[i]);
+			key[i] = 0;
+		}
+	} else
+		key = NULL;
 
 	if (regex_) {
 		if (regex_[0] == '!') {
@@ -73,6 +95,15 @@ static int get_value(const char* key_, c
 int main(int argc, const char **argv)
 {
 	setup_git_directory();
+
+	if (!strcmp(argv[1], "-l")) {
+		if (argc > 2)
+			usage(git_config_set_usage);
+		show_keys = 1;
+		do_all = 1;
+		return get_value(NULL, NULL);
+	}
+
 	switch (argc) {
 	case 2:
 		return get_value(argv[1], NULL);
@@ -86,6 +117,11 @@ int main(int argc, const char **argv)
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
@@ -99,6 +135,11 @@ int main(int argc, const char **argv)
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
-- 
1.1.4.g3d3a-dirty
