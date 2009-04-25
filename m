From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3 v2] rev-parse: add --sq-quote to shell quote arguments
Date: Sat, 25 Apr 2009 06:55:26 +0200
Message-ID: <20090425065526.46540d0c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 07:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxa0M-0000Z0-9T
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 07:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZDYE4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 00:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbZDYE4r
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 00:56:47 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:53856 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZDYE4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 00:56:46 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 04D2D940024;
	Sat, 25 Apr 2009 06:56:38 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id F18A1940055;
	Sat, 25 Apr 2009 06:56:35 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117536>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-parse.txt |   35 ++++++++++++++++++++++++++++++++++-
 builtin-rev-parse.c             |   15 +++++++++++++++
 2 files changed, 49 insertions(+), 1 deletions(-)

	Changes compared to the previous version are:

	- the documentation now explain how --sq and --sq-quote are different,
	- the example has been replaced by the one Junio gave.

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index fba30b1..0fa8156 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -30,6 +30,11 @@ OPTIONS
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
 
+--sq-quote::
+	Use 'git-rev-parse' in shell quoting mode (see SQ-QUOTE
+	section below). In contrast to the `--sq` option below, this
+	mode does only quoting. Nothing else is done to command input.
+
 --revs-only::
 	Do not output flags and parameters not meant for
 	'git-rev-list' command.
@@ -64,7 +69,8 @@ OPTIONS
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
 	newlines (e.g. when using pickaxe `-S` with
-	'git-diff-\*').
+	'git-diff-\*'). In contrast to the `--sq-quote` option,
+	the command input is still interpreted as usual.
 
 --not::
 	When showing object names, prefix them with '{caret}' and
@@ -406,6 +412,33 @@ C?        option C with an optional argument"
 eval `echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?`
 ------------
 
+SQ-QUOTE
+--------
+
+In `--sq-quote` mode, 'git-rev-parse' echoes on the standard output a
+single line suitable for `sh(1)` `eval`. This line is made by
+normalizing the arguments following `--sq-quote`. Nothing other than
+quoting the arguments is done.
+
+If you want command input to still be interpreted as usual by
+'git-rev-parse' before the output is shell quoted, see the `--sq`
+option.
+
+Example
+~~~~~~~
+
+------------
+$ cat >your-git-script.sh <<\EOF
+#!/bin/sh
+args=$(git rev-parse --sq-quote "$@")   # quote user-supplied arguments
+command="git frotz -n24 $args"          # and use it inside a handcrafted
+                                        # command line
+eval "$command"
+EOF
+
+$ sh your-git-script.sh "a b'c"
+------------
+
 EXAMPLES
 --------
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 22c6d6a..c5b3d6e 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -402,6 +402,18 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int cmd_sq_quote(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (argc)
+		sq_quote_argv(&buf, argv, 0);
+	printf("%s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 static void die_no_single_rev(int quiet)
 {
 	if (quiet)
@@ -419,6 +431,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
 
+	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
+		return cmd_sq_quote(argc - 2, argv + 2);
+
 	prefix = setup_git_directory();
 	git_config(git_default_config, NULL);
 	for (i = 1; i < argc; i++) {
-- 
1.6.3.rc1.112.g17e25
