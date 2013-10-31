From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 2/2] rev-parse --parseopt: add the --stuck-long mode
Date: Thu, 31 Oct 2013 12:08:29 +0100
Message-ID: <1383217709-5518-3-git-send-email-boklm@mars-attacks.org>
References: <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
 <1383217709-5518-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 12:09:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbq7a-00044c-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 12:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3JaLIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 07:08:55 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:44769 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab3JaLIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 07:08:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 1EC224E6F;
	Thu, 31 Oct 2013 12:09:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TYRcL6Oj-yxs; Thu, 31 Oct 2013 12:09:08 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 41F2C3EC9;
	Thu, 31 Oct 2013 12:09:08 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 3BF5D43934; Thu, 31 Oct 2013 12:08:52 +0100 (CET)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383217709-5518-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237120>

Add the --stuck-long option to output the options in their long form
if available, and with their arguments stuck.

Contrary to the default form (non stuck arguments and short options),
this can be parsed unambiguously when using options with optional
arguments :

 - in the non stuck form, when an option is taking an optional argument
   you cannot know if the next argument is its optional argument, or the
   next option.

 - the long options form allows to differentiate between an empty argument
   '--option=' and an unset argument '--option', which is not possible
   with short options.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-rev-parse.txt |  8 +++++++-
 builtin/rev-parse.c             | 11 +++++++++--
 t/t1502-rev-parse-parseopt.sh   | 42 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d068a653778d..a436b24cc406 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -50,6 +50,10 @@ Options for --parseopt
 	the first non-option argument.  This can be used to parse sub-commands
 	that take options themselves.
 
+--stuck-long::
+	Only meaningful in `--parseopt` mode. Output the options in their
+	long form if available, and with their arguments stuck.
+
 Options for Filtering
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -285,7 +289,9 @@ Each line of options has this format:
 	`<flags>` are of `*`, `=`, `?` or `!`.
 	* Use `=` if the option takes an argument.
 
-	* Use `?` to mean that the option is optional (though its use is discouraged).
+	* Use `?` to mean that the option takes an optional argument. You
+	  probably want to use the `--stuck-long` mode to be able to
+	  unambiguously parse the optional argument.
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c76b89dc5bcc..3e8c4cce060e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -30,6 +30,8 @@ static int abbrev_ref;
 static int abbrev_ref_strict;
 static int output_sq;
 
+static int stuck_long;
+
 /*
  * Some arguments are relevant "revision" arguments,
  * others are about output format or other details.
@@ -320,12 +322,15 @@ static int parseopt_dump(const struct option *o, const char *arg, int unset)
 	struct strbuf *parsed = o->value;
 	if (unset)
 		strbuf_addf(parsed, " --no-%s", o->long_name);
-	else if (o->short_name)
+	else if (o->short_name && (o->long_name == NULL || !stuck_long))
 		strbuf_addf(parsed, " -%c", o->short_name);
 	else
 		strbuf_addf(parsed, " --%s", o->long_name);
 	if (arg) {
-		strbuf_addch(parsed, ' ');
+		if (!stuck_long)
+			strbuf_addch(parsed, ' ');
+		else if (o->long_name)
+			strbuf_addch(parsed, '=');
 		sq_quote_buf(parsed, arg);
 	}
 	return 0;
@@ -351,6 +356,8 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "stop-at-non-option", &stop_at_non_option,
 					N_("stop parsing after the "
 					   "first non-option argument")),
+		OPT_BOOL(0, "stuck-long", &stuck_long,
+					N_("output in stuck long form")),
 		OPT_END(),
 	};
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 13c88c9aae7f..83b1300cef91 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -12,9 +12,11 @@ usage: some-command [options] <args>...
     -h, --help            show the help
     --foo                 some nifty option --foo
     --bar ...             some cool option --bar with an argument
+    -b, --baz             a short and long option
 
 An option group Header
     -C[...]               option C with an optional argument
+    -d, --data[=...]      short and long option with an optional argument
 
 Extras
     --extra1              line above used to cause a segfault but no longer does
@@ -31,9 +33,11 @@ h,help    show the help
 
 foo       some nifty option --foo
 bar=      some cool option --bar with an argument
+b,baz     a short and long option
 
  An option group Header
 C?        option C with an optional argument
+d,data?   short and long option with an optional argument
 
 Extras
 extra1    line above used to cause a segfault but no longer does
@@ -45,16 +49,16 @@ test_expect_success 'test --parseopt help output' '
 '
 
 cat > expect <<EOF
-set -- --foo --bar 'ham' -- 'arg'
+set -- --foo --bar 'ham' -b -- 'arg'
 EOF
 
 test_expect_success 'test --parseopt' '
-	git rev-parse --parseopt -- --foo --bar=ham arg < optionspec > output &&
+	git rev-parse --parseopt -- --foo --bar=ham --baz arg < optionspec > output &&
 	test_cmp expect output
 '
 
 test_expect_success 'test --parseopt with mixed options and arguments' '
-	git rev-parse --parseopt -- --foo arg --bar=ham < optionspec > output &&
+	git rev-parse --parseopt -- --foo arg --bar=ham --baz < optionspec > output &&
 	test_cmp expect output
 '
 
@@ -99,4 +103,36 @@ test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-option withou
 	test_cmp expect output
 '
 
+cat > expect <<EOF
+set -- --foo --bar='z' --baz -C'Z' --data='A' -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt --stuck-long' '
+	git rev-parse --parseopt --stuck-long -- --foo --bar=z -b arg -CZ -dA <optionspec >output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --data='' -C --baz -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt --stuck-long and empty optional argument' '
+	git rev-parse --parseopt --stuck-long -- --data= arg -C -b <optionspec >output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --data --baz -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt --stuck-long and long option with unset optional argument' '
+	git rev-parse --parseopt --stuck-long -- --data arg -b <optionspec >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt --stuck-long and short option with unset optional argument' '
+	git rev-parse --parseopt --stuck-long -- -d arg -b <optionspec >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.8.4
