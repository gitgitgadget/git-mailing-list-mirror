From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle
 bool/int variable
Date: Sun, 13 Apr 2008 12:14:55 -0700
Message-ID: <7vy77hbm8g.fsf@gitster.siamese.dyndns.org>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
 <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
 <46dff0320804130030q19dd9f23j66d9b7adc7d305d3@mail.gmail.com>
 <7vprsucej4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 21:15:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl7gB-0007xC-Sn
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 21:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbYDMTPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 15:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYDMTPL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 15:15:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbYDMTPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 15:15:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3109229A;
	Sun, 13 Apr 2008 15:15:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D52922297; Sun, 13 Apr 2008 15:15:02 -0400 (EDT)
In-Reply-To: <7vprsucej4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 13 Apr 2008 02:03:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79417>

Junio C Hamano <gitster@pobox.com> writes:

> "Ping Yin" <pkufranky@gmail.com> writes:
>
>>>         return git_config_int(name, value) != 0;
>>>   }
>>
>> Should return an interger if *is_bool==0
>> s/!=0//
>
> Yeah, you are right.  I do not know where that "!= 0" came from.

Sorry about the breakage.

The real reason the breakage did not get caught was there was nothing that
catches the breakage.  Hence this adds tests for this new feature.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 13 Apr 2008 12:11:11 -0700
Subject: [PATCH] Fix git_config_bool_or_int

The earlier one botched the return value logic between config_bool and
config_bool_and_int.  The former should normalize between 0 and 1 while
the latter should give back full range of integer values.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-config.c       |   22 ++++++++++++++++-
 config.c               |    4 +-
 t/t1300-repo-config.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index c34bc8b..10447a7 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -16,7 +16,7 @@ static int seen;
 static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
-static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
+static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
 {
@@ -53,6 +53,14 @@ static int show_config(const char* key_, const char* value_)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
 	else if (type == T_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
+	else if (type == T_BOOL_OR_INT) {
+		int is_bool, v;
+		v = git_config_bool_or_int(key_, value_, &is_bool);
+		if (is_bool)
+			vptr = v ? "true" : "false";
+		else
+			sprintf(value, "%d", v);
+	}
 	else
 		vptr = value_?value_:"";
 	seen++;
@@ -157,6 +165,14 @@ char *normalize_value(const char *key, const char *value)
 		else if (type == T_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
+		else if (type == T_BOOL_OR_INT) {
+			int is_bool, v;
+			v = git_config_bool_or_int(key, value, &is_bool);
+			if (!is_bool)
+				sprintf(normalized, "%d", v);
+			else
+				sprintf(normalized, "%s", v ? "true" : "false");
+		}
 	}
 
 	return normalized;
@@ -273,6 +289,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
+		else if (!strcmp(argv[1], "--bool-or-int"))
+			type = T_BOOL_OR_INT;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (argc != 2)
 				usage(git_config_set_usage);
diff --git a/config.c b/config.c
index 5ea18ef..b0ada51 100644
--- a/config.c
+++ b/config.c
@@ -315,13 +315,13 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
 		return 0;
 	*is_bool = 0;
-	return git_config_int(name, value) != 0;
+	return git_config_int(name, value);
 }
 
 int git_config_bool(const char *name, const char *value)
 {
 	int discard;
-	return git_config_bool_or_int(name, value, &discard);
+	return !!git_config_bool_or_int(name, value, &discard);
 }
 
 int git_config_string(const char **dest, const char *var, const char *value)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index b36a901..a675cbb 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -595,6 +595,64 @@ test_expect_success 'set --int' '
 
 rm .git/config
 
+cat >expect <<\EOF
+[bool]
+	true1 = true
+	true2 = true
+	false1 = false
+	false2 = false
+[int]
+	int1 = 0
+	int2 = 1
+	int3 = -1
+EOF
+
+test_expect_success 'get --bool-or-int' '
+	(
+		echo "[bool]"
+		echo true1
+		echo true2 = true
+		echo false = false
+		echo "[int]"
+		echo int1 = 0
+		echo int2 = 1
+		echo int3 = -1
+	) >>.git/config &&
+	test $(git config --bool-or-int bool.true1) = true &&
+	test $(git config --bool-or-int bool.true2) = true &&
+	test $(git config --bool-or-int bool.false) = false &&
+	test $(git config --bool-or-int int.int1) = 0 &&
+	test $(git config --bool-or-int int.int2) = 1 &&
+	test $(git config --bool-or-int int.int3) = -1
+
+'
+
+rm .git/config
+cat >expect <<\EOF
+[bool]
+	true1 = true
+	false1 = false
+	true2 = true
+	false2 = false
+[int]
+	int1 = 0
+	int2 = 1
+	int3 = -1
+EOF
+
+test_expect_success 'set --bool-or-int' '
+	git config --bool-or-int bool.true1 true &&
+	git config --bool-or-int bool.false1 false &&
+	git config --bool-or-int bool.true2 yes &&
+	git config --bool-or-int bool.false2 no &&
+	git config --bool-or-int int.int1 0 &&
+	git config --bool-or-int int.int2 1 &&
+	git config --bool-or-int int.int3 -1 &&
+	test_cmp expect .git/config
+'
+
+rm .git/config
+
 git config quote.leading " test"
 git config quote.ending "test "
 git config quote.semicolon "test;test"
-- 
1.5.5.104.ge4331
