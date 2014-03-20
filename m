From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 01:44:52 -0700
Message-ID: <1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com>
References: <532AA923.6030409@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 09:45:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQYbg-0003cL-CA
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 09:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbaCTIpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 04:45:36 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56759 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbaCTIpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 04:45:31 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so623318pbb.25
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2RHJwIaauhrrv/laxjuo8wOaXtYm7+N7rabGiwqgnhI=;
        b=0dULlgBDIJ+4mgglZYqlWKsi9d77PHPNXder7sGr1i7j4jKz5BQXymgny0T9kkCUqZ
         Y17OdoDoTQbfLwVw3OVQynrkA7PT1M7kaAhW2+JkQIho97ahlbtg8Uw1/51jEGIwNJTx
         pyFjgisv2/JYzrUaIP+2PimP365CqWhDFPDXGe0adOJ81IehmB49y4mNB6sVD14AQEFa
         XZxV7YtccN/10Rl8pAf+PWNxWa5Q4wahRFpRGuQRVO2Gm/GuK6GDWFuQsFbPsbsNUGIg
         hn+97ciFilHdFs2BDe9rAWrV/kUASOCaESLO2H1sD2yKbTUhH9OWOS6wAUZ0JLHDb3xa
         fVXA==
X-Received: by 10.68.171.4 with SMTP id aq4mr22729344pbc.150.1395305130742;
        Thu, 20 Mar 2014 01:45:30 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id yo9sm6651225pab.16.2014.03.20.01.45.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Mar 2014 01:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <532AA923.6030409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244524>

Built-in commands can specify names for option arguments when usage text
is generated for a command.  sh based commands should be able to do the
same.

Option argument name hint is any text that comes after [*=?!] after the
argument name up to the first whitespace.  Underscores are replaced with
whitespace.  It is unlikely that an underscore would be useful in the
hint text.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 Changed according to the last comments.  Added "Usage text" paragraph in the
 documentation and updated variable names.

 Documentation/git-rev-parse.txt |   34 ++++++++++++++++++++++++++++++++--
 builtin/rev-parse.c             |   17 ++++++++++++++++-
 t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0d2cdcd..b8aabc9 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -284,13 +284,13 @@ Input Format
 
 'git rev-parse --parseopt' input format is fully text based. It has two parts,
 separated by a line that contains only `--`. The lines before the separator
-(should be more than one) are used for the usage.
+(should be one or more) are used for the usage.
 The lines after the separator describe the options.
 
 Each line of options has this format:
 
 ------------
-<opt_spec><flags>* SP+ help LF
+<opt_spec><flags>*<arg_hint>? SP+ help LF
 ------------
 
 `<opt_spec>`::
@@ -313,6 +313,12 @@ Each line of options has this format:
 
 	* Use `!` to not make the corresponding negated long option available.
 
+`<arg_hint>`::
+	`<arg_hing>`, if specified, is used as a name of the argument in the
+	help output, for options that take arguments. `<arg_hint>` is
+	terminated by the first whitespace. When output the name is shown in
+	angle braces.  Underscore symbols are replaced with spaces.
+
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
 
@@ -333,6 +339,8 @@ h,help    show the help
 
 foo       some nifty option --foo
 bar=      some cool option --bar with an argument
+baz=arg   another cool option --baz with a named argument
+qux?path  qux may take a path argument but has meaning by itself
 
   An option group Header
 C?        option C with an optional argument"
@@ -340,6 +348,28 @@ C?        option C with an optional argument"
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 ------------
 
+
+Usage text
+~~~~~~~~~~
+
+When "$@" is "-h" or "--help" the above example would produce the following
+usage text:
+
+------------
+usage: some-command [options] <args>...
+
+    some-command does foo and bar!
+
+    -h, --help            show the help
+    --foo                 some nifty option --foo
+    --bar ...             some cool option --bar with an argument
+    --bar <arg>           another cool option --baz with a named argument
+    --qux[=<path>]        qux may take a path argument but has meaning by itself
+
+An option group Header
+    -C[...]               option C with an optional argument
+------------
+
 SQ-QUOTE
 --------
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 45901df..a4c9fdf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -395,9 +395,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		usage[unb++] = strbuf_detach(&sb, NULL);
 	}
 
-	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
+	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
 	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
 		const char *s;
+		const char *end;
 		struct option *o;
 
 		if (!sb.len)
@@ -419,6 +420,20 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
+
+		/* Possible argument name hint */
+		end = s;
+		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
+			--s;
+		if (s != sb.buf && s != end) {
+			char *a;
+			o->argh = a = xmemdupz(s, end - s);
+			while (a = strchr(a, '_'))
+				*a = ' ';
+		}
+		if (s == sb.buf)
+			s = end;
+
 		while (s > sb.buf && strchr("*=?!", s[-1])) {
 			switch (*--s) {
 			case '=':
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 83b1300..bf0db05 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -18,6 +18,17 @@ An option group Header
     -C[...]               option C with an optional argument
     -d, --data[=...]      short and long option with an optional argument
 
+Argument hints
+    -b <arg>              short option required argument
+    --bar2 <arg>          long option required argument
+    -e, --fuz <with spaces>
+                          short and long option required argument
+    -s[<some>]            short option optional argument
+    --long[=<data>]       long option optional argument
+    -g, --fluf[=<path>]   short and long option optional argument
+    --longest <a very long argument hint>
+                          a very long argument hint
+
 Extras
     --extra1              line above used to cause a segfault but no longer does
 
@@ -39,6 +50,15 @@ b,baz     a short and long option
 C?        option C with an optional argument
 d,data?   short and long option with an optional argument
 
+ Argument hints
+b=arg     short option required argument
+bar2=arg  long option required argument
+e,fuz=with_spaces  short and long option required argument
+s?some    short option optional argument
+long?data long option optional argument
+g,fluf?path     short and long option optional argument
+longest=a_very_long_argument_hint  a very long argument hint
+
 Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
-- 
1.7.9
