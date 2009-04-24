From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] rev-parse: add --sq-quote to shell quote arguments
Date: Fri, 24 Apr 2009 08:28:59 +0200
Message-ID: <20090424062902.3705.44704.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxExq-0007Fu-J2
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 08:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZDXGbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 02:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZDXGbK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 02:31:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:35191 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbZDXGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 02:31:09 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5111494009A;
	Fri, 24 Apr 2009 08:31:00 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5AFA69400AC;
	Fri, 24 Apr 2009 08:30:58 +0200 (CEST)
X-git-sha1: f1e80dd63d4ce0273246ec79a18894df890a7836 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117412>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-parse.txt |   18 ++++++++++++++++++
 builtin-rev-parse.c             |   15 +++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index fba30b1..239704c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -30,6 +30,9 @@ OPTIONS
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
 
+--sq-quote::
+	Use 'git-rev-parse' in shell quoting mode (see SQ-QUOTE section below).
+
 --revs-only::
 	Do not output flags and parameters not meant for
 	'git-rev-list' command.
@@ -406,6 +409,21 @@ C?        option C with an optional argument"
 eval `echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?`
 ------------
 
+SQ-QUOTE
+--------
+
+In `--sq-quote` mode, 'git-rev-parse' echoes on the standard output a
+single line suitable for `sh(1)` `eval`. This line is made by
+normalizing the arguments following `--sq-quote`.
+
+Example
+~~~~~~~
+
+------------
+$ git rev-parse --sq-quote "'''" '"""' "arg with space"
+ ''\'''\'''\''' '"""' 'arg with space'
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
