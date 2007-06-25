From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] config: add support for --bool and --int while setting values
Date: Mon, 25 Jun 2007 16:00:24 +0200
Message-ID: <1182780024442-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2p7K-0001QG-O1
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbXFYOAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbXFYOAd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:00:33 -0400
Received: from v32413.1blu.de ([88.84.155.73]:55160 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbXFYOAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:00:32 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1I2p7H-00011T-3k; Mon, 25 Jun 2007 16:00:31 +0200
Received: from p54b0ff8c.dip.t-dialin.net ([84.176.255.140] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1I2p7G-0000PA-4Y; Mon, 25 Jun 2007 16:00:30 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1I2p7B-0004hO-SJ; Mon, 25 Jun 2007 16:00:25 +0200
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50894>


Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt    |    9 +++---
 builtin-config.c                |   54 +++++++++++++++++++++++++++++---------
 t/t1300-repo-config.sh          |   48 +++++++++++++++++++++++++++++++++-
 t/t9400-git-cvsserver-server.sh |    4 +-
 4 files changed, 94 insertions(+), 21 deletions(-)

 There are probably more elegant ways to do this...
 But it seems to work.

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f2c6717..ddb1dea 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,9 +9,9 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global] name [value [value_regex]]
-'git-config' [--system | --global] --add name value
-'git-config' [--system | --global] --replace-all name [value [value_regex]]
+'git-config' [--system | --global] [type] name [value [value_regex]]
+'git-config' [--system | --global] [type] --add name value
+'git-config' [--system | --global] [type] --replace-all name [value [value_regex]]
 'git-config' [--system | --global] [type] --get name [value_regex]
 'git-config' [--system | --global] [type] --get-all name [value_regex]
 'git-config' [--system | --global] --unset name [value_regex]
@@ -36,8 +36,7 @@ prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 The type specifier can be either '--int' or '--bool', which will make
 'git-config' ensure that the variable(s) are of the given type and
 convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool).  Type specifiers currently only
-take effect for reading operations.  If no type specifier is passed,
+a "true" or "false" string for bool).  If no type specifier is passed,
 no checks or transformations are performed on the value.
 
 This command will fail if:
diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..3aa4645 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -131,9 +131,32 @@ free_strings:
 	return ret;
 }
 
+char* normalize_value(const char* key, const char* value)
+{
+	char* normalized;
+
+	if (!value)
+		return NULL;
+
+	if (type == T_RAW)
+		normalized = xstrdup(value);
+	else {
+		normalized = xmalloc(64);
+		if (type == T_INT)
+			sprintf(normalized, "%d",
+				git_config_int(key, value?value:""));
+		else if (type == T_BOOL)
+			sprintf(normalized, "%s",
+				git_config_bool(key, value) ? "true" : "false");
+	}
+
+	return normalized;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
+	char* value;
 	setup_git_directory_gently(&nongit);
 
 	while (1 < argc) {
@@ -205,9 +228,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			use_key_regexp = 1;
 			do_all = 1;
 			return get_value(argv[2], NULL);
-		} else
-
-			return git_config_set(argv[1], argv[2]);
+		} else {
+			value = normalize_value(argv[1], argv[2]);
+			return git_config_set(argv[1], value);
+		}
 	case 4:
 		if (!strcmp(argv[1], "--unset"))
 			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
@@ -223,17 +247,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			use_key_regexp = 1;
 			do_all = 1;
 			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--add"))
-			return git_config_set_multivar(argv[2], argv[3], "^$", 0);
-		else if (!strcmp(argv[1], "--replace-all"))
-
-			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
-		else
-
-			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
+		} else if (!strcmp(argv[1], "--add")) {
+			value = normalize_value(argv[2], argv[3]);
+			return git_config_set_multivar(argv[2], value, "^$", 0);
+		} else if (!strcmp(argv[1], "--replace-all")) {
+			value = normalize_value(argv[2], argv[3]);
+			return git_config_set_multivar(argv[2], value, NULL, 1);
+		} else {
+			value = normalize_value(argv[1], argv[2]);
+			return git_config_set_multivar(argv[1], value, argv[3], 0);
+		}
 	case 5:
-		if (!strcmp(argv[1], "--replace-all"))
-			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
+		if (!strcmp(argv[1], "--replace-all")) {
+			value = normalize_value(argv[2], argv[3]);
+			return git_config_set_multivar(argv[2], value, argv[4], 1);
+		}
 	case 1:
 	default:
 		usage(git_config_set_usage);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7731fa7..4234d83 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -465,11 +465,57 @@ test_expect_success bool '
         done &&
 	cmp expect result'
 
-test_expect_failure 'invalid bool' '
+test_expect_failure 'invalid bool (--get)' '
 
 	git-config bool.nobool foobar &&
 	git-config --bool --get bool.nobool'
 
+test_expect_failure 'invalid bool (set)' '
+
+	git-config --bool bool.nobool foobar'
+
+rm .git/config
+
+cat > expect <<\EOF
+[bool]
+	true1 = true
+	true2 = true
+	true3 = true
+	true4 = true
+	false1 = false
+	false2 = false
+	false3 = false
+	false4 = false
+EOF
+
+test_expect_success 'set --bool' '
+
+	git-config --bool bool.true1 01 &&
+	git-config --bool bool.true2 -1 &&
+	git-config --bool bool.true3 YeS &&
+	git-config --bool bool.true4 true &&
+	git-config --bool bool.false1 000 &&
+	git-config --bool bool.false2 "" &&
+	git-config --bool bool.false3 nO &&
+	git-config --bool bool.false4 FALSE &&
+	cmp expect .git/config'
+
+rm .git/config
+
+cat > expect <<\EOF
+[int]
+	val1 = 1
+	val2 = -1
+	val3 = 5242880
+EOF
+
+test_expect_success 'set --int' '
+
+	git-config --int int.val1 01 &&
+	git-config --int int.val2 -1 &&
+	git-config --int int.val3 5m &&
+	cmp expect .git/config'
+
 rm .git/config
 
 git-config quote.leading " test"
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 0331770..641303e 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -38,7 +38,7 @@ echo >empty &&
   git commit -q -m "First Commit" &&
   git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
-  GIT_DIR="$SERVERDIR" git config --bool gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+  GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
   exit 1
 
 # note that cvs doesn't accept absolute pathnames
@@ -255,7 +255,7 @@ rm -fr "$SERVERDIR"
 cd "$WORKDIR" &&
 git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
-GIT_DIR="$SERVERDIR" git config --bool gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
+GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
 exit 1
 
 test_expect_success 'cvs update (create new file)' \
-- 
1.5.2.1
