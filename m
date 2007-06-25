From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/3] config: Add --null/-z option for null-delimted output
Date: Mon, 25 Jun 2007 16:03:55 +0200
Message-ID: <11827802382221-git-send-email-frank@lichtenheld.de>
References: <200706220156.01175.jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pBj-0002ZJ-Do
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbXFYOFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXFYOFF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:05:05 -0400
Received: from v32413.1blu.de ([88.84.155.73]:55997 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbXFYOFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:05:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1I2pAj-00044z-7t; Mon, 25 Jun 2007 16:04:06 +0200
Received: from p54b0ff8c.dip.t-dialin.net ([84.176.255.140] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1I2pAi-0000df-Af; Mon, 25 Jun 2007 16:04:04 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1I2pAd-0004kb-6X; Mon, 25 Jun 2007 16:03:59 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <200706220156.01175.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50898>

Use \n as delimiter between key and value and \0 as
delimiter after each key/value pair. This should be
easily parsable output.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt |   18 +++++++++++++-----
 builtin-config.c             |   20 ++++++++++++++------
 t/t1300-repo-config.sh       |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)

 This time with documentation and test cases.

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index bb6dbb0..8c09b88 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,17 +9,17 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global] name [value [value_regex]]
+'git-config' [--system | --global] [-z|--null] name [value [value_regex]]
 'git-config' [--system | --global] --add name value
 'git-config' [--system | --global] --replace-all name [value [value_regex]]
-'git-config' [--system | --global] [type] --get name [value_regex]
-'git-config' [--system | --global] [type] --get-all name [value_regex]
-'git-config' [--system | --global] [type] --get-regexp name_regex [value_regex]
+'git-config' [--system | --global] [type] [-z|--null] --get name [value_regex]
+'git-config' [--system | --global] [type] [-z|--null] --get-all name [value_regex]
+'git-config' [--system | --global] [type] [-z|--null] --get-regexp name_regex [value_regex]
 'git-config' [--system | --global] --unset name [value_regex]
 'git-config' [--system | --global] --unset-all name [value_regex]
 'git-config' [--system | --global] --rename-section old_name new_name
 'git-config' [--system | --global] --remove-section name
-'git-config' [--system | --global] -l | --list
+'git-config' [--system | --global] [-z|--null] -l | --list
 
 DESCRIPTION
 -----------
@@ -118,6 +118,14 @@ See also <<FILES>>.
 	in the config file will cause the value to be multiplied
 	by 1024, 1048576, or 1073741824 prior to output.
 
+-z, --null::
+	For all options that output values and/or keys, always
+	end values with with the null character (instead of a
+	newline). Use newline instead as a delimiter between
+	key and value. This allows for secure parsing of the
+	output without getting confused e.g. by values that
+	contain line breaks. 
+
 
 [[FILES]]
 FILES
diff --git a/builtin-config.c b/builtin-config.c
index dbc2339..9d52ba8 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -12,14 +12,17 @@ static int use_key_regexp;
 static int do_all;
 static int do_not_match;
 static int seen;
+static char delim = '=';
+static char key_delim = ' ';
+static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
 {
 	if (value_)
-		printf("%s=%s\n", key_, value_);
+		printf("%s%c%s%c", key_, delim, value_, term);
 	else
-		printf("%s\n", key_);
+		printf("%s%c", key_, term);
 	return 0;
 }
 
@@ -40,9 +43,9 @@ static int show_config(const char* key_, const char* value_)
 
 	if (show_keys) {
 		if (value_)
-			printf("%s ", key_);
+			printf("%s%c", key_, key_delim);
 		else
-			printf("%s", key_);
+			printf("%s",key_);
 	}
 	if (seen && !do_all)
 		dup_error = 1;
@@ -58,7 +61,7 @@ static int show_config(const char* key_, const char* value_)
 				key_, vptr);
 	}
 	else
-		printf("%s\n", vptr);
+		printf("%s%c", vptr, term);
 
 	return 0;
 }
@@ -159,6 +162,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[1], "--system"))
 			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
+		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
+			term = '\0';
+			delim = '\n';
+			key_delim = '\n';
+		}
 		else if (!strcmp(argv[1], "--rename-section")) {
 			int ret;
 			if (argc != 4)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8b5e9fc..99d84cc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -519,4 +519,36 @@ git config --list > result
 
 test_expect_success 'value continued on next line' 'cmp result expect'
 
+cat > .git/config <<\EOF
+[section "sub=section"]
+	val1 = foo=bar
+	val2 = foo\nbar
+	val3 = \n\n
+	val4 =
+	val5
+EOF
+
+cat > expect <<\EOF
+Key: section.sub=section.val1
+Value: foo=bar
+Key: section.sub=section.val2
+Value: foo
+bar
+Key: section.sub=section.val3
+Value: 
+
+
+Key: section.sub=section.val4
+Value: 
+Key: section.sub=section.val5
+EOF
+
+git config --null --list | perl -0ne 'chop;($key,$value)=split(/\n/,$_,2);print "Key: $key\n";print "Value: $value\n" if defined($value)' > result
+
+test_expect_success '--null --list' 'cmp result expect'
+
+git config --null --get-regexp 'val[0-9]' | perl -0ne 'chop;($key,$value)=split(/\n/,$_,2);print "Key: $key\n";print "Value: $value\n" if defined($value)' > result
+
+test_expect_success '--null --get-regexp' 'cmp result expect'
+
 test_done
-- 
1.5.2.1
