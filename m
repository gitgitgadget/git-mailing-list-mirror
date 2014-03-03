From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH] rev-parse --parseopt: option argument name hints
Date: Mon,  3 Mar 2014 02:32:20 -0800
Message-ID: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 11:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQAl-00076k-TW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbaCCKcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:32:32 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39583 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbaCCKcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:32:31 -0500
Received: by mail-pd0-f178.google.com with SMTP id x10so3544123pdj.23
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9P273EdnKl2QmwvqR1mRFDsO+tvosErZMu2027zsCic=;
        b=vA1izbsNiA5MuvoWhMbf9097AdBx/Uo9WVkQwoMUsVeeeuR1MQIzKzdvybX1Exc1a4
         02KDWCWh/AevVwhWaquJc6dVDTEkwtCv+cA1QBFDdC7TMaLiKjfOqaHMmHQ0g3w6vu27
         a66mzcUZziOJ7RrKdUyt2J8vsclGvxPBLkM+GMH8L/9ph9P5AsfFZgzfLGhVpYYxKh+/
         RgAI2kunoCEUW+hqAdee/XVZfQ7QjtFvM1TaKOm+ZfKc7JKWUUDZmhLSbe0RBR4ywr0/
         VwUKGdkQHlNd699KuJWIXAuB1skT2tpb86ftDCk+VC3bqs58TLJXl1kxUmkYQxJCE3JZ
         OtNw==
X-Received: by 10.67.13.134 with SMTP id ey6mr5033246pad.44.1393842750759;
        Mon, 03 Mar 2014 02:32:30 -0800 (PST)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ac5sm34652043pbc.37.2014.03.03.02.32.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 02:32:30 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243216>

Built-in commands can specify names for option arguments, that are shown
when usage text is generated for the command.  sh based commands should
be able to do the same.

Option argument name hint is any text that comes after [*=?!] after the
argument name up to the first whitespace.  Underscores are replaced with
whitespace.  It is unlikely that an underscore would be useful in the
hint text.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 Documentation/git-rev-parse.txt |   11 +++++++++--
 builtin/rev-parse.c             |   17 ++++++++++++++++-
 t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0d2cdcd..4cb6e02 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -284,13 +284,13 @@ Input Format
 
 'git rev-parse --parseopt' input format is fully text based. It has two parts,
 separated by a line that contains only `--`. The lines before the separator
-(should be more than one) are used for the usage.
+(could be more than one) are used for the usage.
 The lines after the separator describe the options.
 
 Each line of options has this format:
 
 ------------
-<opt_spec><flags>* SP+ help LF
+<opt_spec><flags>*<argh>? SP+ help LF
 ------------
 
 `<opt_spec>`::
@@ -313,6 +313,12 @@ Each line of options has this format:
 
 	* Use `!` to not make the corresponding negated long option available.
 
+`<argh>`::
+	`<argh>`, if specified, is used as a name of the argument, if the
+	option takes an argument. `<argh>` is terminated by the first
+	whitespace. Angle braces are added automatically.  Underscore symbols
+	are replaced with spaces.
+
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
 
@@ -333,6 +339,7 @@ h,help    show the help
 
 foo       some nifty option --foo
 bar=      some cool option --bar with an argument
+baz=arg   another cool option --baz with an argument named <arg>
 
   An option group Header
 C?        option C with an optional argument"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index aaeb611..83a769e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -395,9 +395,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		usage[unb++] = strbuf_detach(&sb, NULL);
 	}
 
-	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
+	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
 	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
 		const char *s;
+		const char *argh;
 		struct option *o;
 
 		if (!sb.len)
@@ -419,6 +420,20 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
+
+		/* Possible argument name hint */
+		argh = s;
+		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
+			--s;
+		if (s != sb.buf && s != argh) {
+			char *a;
+			o->argh = a = xmemdupz(s, argh - s);
+			while (a = strchr(a, '_'))
+				*a = ' ';
+		}
+		if (s == sb.buf)
+			s = argh;
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
