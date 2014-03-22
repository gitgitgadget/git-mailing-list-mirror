From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH v4] rev-parse --parseopt: option argument name hints
Date: Sat, 22 Mar 2014 02:47:34 -0700
Message-ID: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
References: <xmqqvbv7v5xh.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 10:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRIXA-0000SU-6E
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 10:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbaCVJsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 05:48:00 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49463 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaCVJr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 05:47:59 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so3330327pdj.40
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U4lwlbizWreP8YTaGRObtpqLA1rbq2dzk4xyYplVGnw=;
        b=cjaTRbFQvACrSzTybQ0yztLuP3RWYmsO/7gCl+7YYybokG7YOwvzLw0wSuXsJLwIqV
         AcAgT7IbavZH1M8uqf1qZ9u9nd0UClMRIpDyCTROQLgWabURSbyJV656JN11u5bZXMrH
         CLEKuiMJ9CwY4hV1ZG84uw+G6Haa43AyZ7LnagkVe+i3H+dMPa/pDDv+UDOlIFo+QAFi
         Ba9zIdeahtERxX34lLWQSFPzSVGt5Z02WMdYCM0vsdoHtXHn7gmqraM7WWICMn+veH5x
         jccu8rIAQFJ2hcTcomokv+2L3u0mjrAfN86Cru/ERT4b/lEzl+OFAX9vtpqQkfRbB4YJ
         1JKQ==
X-Received: by 10.68.215.40 with SMTP id of8mr58343139pbc.15.1395481678579;
        Sat, 22 Mar 2014 02:47:58 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id xk1sm39632540pac.21.2014.03.22.02.47.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Mar 2014 02:47:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <xmqqvbv7v5xh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244766>

Built-in commands can specify names for option arguments when usage text
is generated for a command.  sh based commands should be able to do the
same.

Option argument name hint is any text that comes after [*=?!] after the
argument name up to the first whitespace.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 Fixed "arg_hing" typo, decoration for `-h` and `--help` and removed
 underscore replacement for the hint text.

 Documentation/git-rev-parse.txt |   34 ++++++++++++++++++++++++++++++++--
 builtin/rev-parse.c             |   13 ++++++++++++-
 t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0d2cdcd..be85023 100644
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
+	`<arg_hint>`, if specified, is used as a name of the argument in the
+	help output, for options that take arguments. `<arg_hint>` is
+	terminated by the first whitespace. When you need to use space in the
+	argument hint use dash instead.
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
+When "$@" is `-h` or `--help` the above example would produce the following
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
index 45901df..1a6122d 100644
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
@@ -419,6 +420,16 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
+
+		/* Possible argument name hint */
+		end = s;
+		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
+			--s;
+		if (s != sb.buf && s != end)
+			o->argh = xmemdupz(s, end - s);
+		if (s == sb.buf)
+			s = end;
+
 		while (s > sb.buf && strchr("*=?!", s[-1])) {
 			switch (*--s) {
 			case '=':
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 83b1300..e3c6f02 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -18,6 +18,17 @@ An option group Header
     -C[...]               option C with an optional argument
     -d, --data[=...]      short and long option with an optional argument
 
+Argument hints
+    -b <arg>              short option required argument
+    --bar2 <arg>          long option required argument
+    -e, --fuz <with-space>
+                          short and long option required argument
+    -s[<some>]            short option optional argument
+    --long[=<data>]       long option optional argument
+    -g, --fluf[=<path>]   short and long option optional argument
+    --longest <very-long-argument-hint>
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
+e,fuz=with-space  short and long option required argument
+s?some    short option optional argument
+long?data long option optional argument
+g,fluf?path     short and long option optional argument
+longest=very-long-argument-hint  a very long argument hint
+
 Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
-- 
1.7.9
