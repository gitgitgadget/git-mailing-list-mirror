From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Fri, 25 Oct 2013 22:18:11 +0200
Message-ID: <1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
References: <20131016223306.GN9464@google.com>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 22:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZnqB-0006tY-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 22:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab3JYUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 16:18:36 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:40991 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab3JYUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 16:18:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id CABA548CC
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 22:18:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SQoqKszA35-Q; Fri, 25 Oct 2013 22:18:45 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id C7F64422A;
	Fri, 25 Oct 2013 22:18:45 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 539E443934; Fri, 25 Oct 2013 22:18:30 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <20131016223306.GN9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236712>

Add the --sticked-long option to output the options in their long form
if available, and with their arguments sticked.

Contrary to the default form (non sticked arguments and short options),
this can be parsed unambiguously when using options with optional
arguments :

 - in the non sticked form, when an option is taking an optional argument
   you cannot know if the next argument is its optional argument, or the
   next option.

 - the long options form allows to differenciate between an empty argument
   '--option=' and an unset argument '--option', which is not possible
   with short options.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-rev-parse.txt |  8 +++++++-
 builtin/rev-parse.c             | 11 +++++++++--
 t/t1502-rev-parse-parseopt.sh   | 42 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d068a65..d3bad9d 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -50,6 +50,10 @@ Options for --parseopt
 	the first non-option argument.  This can be used to parse sub-commands
 	that take options themselves.
 
+--sticked-long::
+	Only meaningful in `--parseopt` mode. Output the options in their
+	long form if available, and with their arguments sticked.
+
 Options for Filtering
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -285,7 +289,9 @@ Each line of options has this format:
 	`<flags>` are of `*`, `=`, `?` or `!`.
 	* Use `=` if the option takes an argument.
 
-	* Use `?` to mean that the option is optional (though its use is discouraged).
+	* Use `?` to mean that the option takes an optional argument. You
+	  probably want to use the `--sticked-long` mode to be able to
+	  unambiguously parse the optional argument.
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c76b89d..418b7f7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -30,6 +30,8 @@ static int abbrev_ref;
 static int abbrev_ref_strict;
 static int output_sq;
 
+static int sticked_long;
+
 /*
  * Some arguments are relevant "revision" arguments,
  * others are about output format or other details.
@@ -320,12 +322,15 @@ static int parseopt_dump(const struct option *o, const char *arg, int unset)
 	struct strbuf *parsed = o->value;
 	if (unset)
 		strbuf_addf(parsed, " --no-%s", o->long_name);
-	else if (o->short_name)
+	else if (o->short_name && (o->long_name == NULL || !sticked_long))
 		strbuf_addf(parsed, " -%c", o->short_name);
 	else
 		strbuf_addf(parsed, " --%s", o->long_name);
 	if (arg) {
-		strbuf_addch(parsed, ' ');
+		if (!sticked_long)
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
+		OPT_BOOL(0, "sticked-long", &sticked_long,
+					N_("output in sticked long form")),
 		OPT_END(),
 	};
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 13c88c9..7e12d9b 100755
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
+test_expect_success 'test --parseopt --sticked-long' '
+	git rev-parse --parseopt --sticked-long -- --foo --bar=z -b arg -CZ -dA <optionspec >output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --data='' -C --baz -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt --sticked-long and empty optional argument' '
+	git rev-parse --parseopt --sticked-long -- --data= arg -C -b <optionspec >output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --data --baz -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt --sticked-long and long option with unset optional argument' '
+	git rev-parse --parseopt --sticked-long -- --data arg -b <optionspec >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt --sticked-long and short option with unset optional argument' '
+	git rev-parse --parseopt --sticked-long -- -d arg -b <optionspec >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.8.4
