From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] var: accept multiple variables on the command line
Date: Tue, 13 Nov 2012 11:52:47 -0500
Message-ID: <20121113165247.GC12626@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJjW-0007Sv-8d
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab2KMQwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:52:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47546 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2KMQww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:52:52 -0500
Received: (qmail 26526 invoked by uid 107); 13 Nov 2012 16:53:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:53:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:52:47 -0500
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209636>

Git-var currently only accepts a single value to print. This
is inefficient if the caller is interested in finding
multiple values, as they must invoke git-var multiple times.

This patch lets callers specify multiple variables, and
prints one per line.

Signed-off-by: Jeff King <peff@peff.net>
---
This will later let us get the "explicit" flag for free.

 Documentation/git-var.txt |  9 +++++++--
 builtin/var.c             | 13 +++++++------
 t/t0007-git-var.sh        | 29 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100755 t/t0007-git-var.sh

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 67edf58..53abba5 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -9,11 +9,16 @@ git-var - Show a git logical variable
 SYNOPSIS
 --------
 [verse]
-'git var' ( -l | <variable> )
+'git var' ( -l | <variable>... )
 
 DESCRIPTION
 -----------
-Prints a git logical variable.
+Prints one or more git logical variables, separated by newlines.
+
+Note that some variables may contain newlines themselves (e.g.,
+`GIT_EDITOR`), and it is therefore possible to receive ambiguous output
+when requesting multiple variables. This can be mitigated by putting any
+such variables at the end of the list.
 
 OPTIONS
 -------
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53..49b48f5 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -73,8 +73,7 @@ static int show_config(const char *var, const char *value, void *cb)
 
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
-	const char *val = NULL;
-	if (argc != 2)
+	if (argc < 2)
 		usage(var_usage);
 
 	if (strcmp(argv[1], "-l") == 0) {
@@ -83,11 +82,13 @@ int cmd_var(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 	git_config(git_default_config, NULL);
-	val = read_var(argv[1]);
-	if (!val)
-		usage(var_usage);
 
-	printf("%s\n", val);
+	while (*++argv) {
+		const char *val = read_var(*argv);
+		if (!val)
+			usage(var_usage);
+		printf("%s\n", val);
+	}
 
 	return 0;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
new file mode 100755
index 0000000..45a5f66
--- /dev/null
+++ b/t/t0007-git-var.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='basic sanity checks for git var'
+. ./test-lib.sh
+
+test_expect_success 'get GIT_AUTHOR_IDENT' '
+	test_tick &&
+	echo "A U Thor <author@example.com> 1112911993 -0700" >expect &&
+	git var GIT_AUTHOR_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get GIT_COMMITTER_IDENT' '
+	test_tick &&
+	echo "C O Mitter <committer@example.com> 1112912053 -0700" >expect &&
+	git var GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git var can show multiple values' '
+	cat >expect <<-\EOF &&
+	A U Thor <author@example.com> 1112912053 -0700
+	C O Mitter <committer@example.com> 1112912053 -0700
+	EOF
+	git var GIT_AUTHOR_IDENT GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.0.207.gdf2154c
