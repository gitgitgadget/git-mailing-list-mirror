From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-config: handle --file option with relative pathname properly
Date: Tue, 9 Oct 2007 12:49:32 +0000
Message-ID: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 14:49:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEWY-0003Z7-IC
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbXJIMtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbXJIMtN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:49:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56377 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751771AbXJIMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:49:13 -0400
Received: (qmail 1185 invoked by uid 1000); 9 Oct 2007 12:49:32 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60395>

When calling git-config not from the top level directory of a repository,
it changes directory before trying to open the config file specified
through the --file option, which then fails if the config file was
specified by a relative pathname.  This patch adjusts the pathname to
the config file if applicable.

The problem was noticed by Joey Hess, reported through
 http://bugs.debian.org/445208

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-config.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 0a605e0..c2708ba 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -165,7 +165,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
 	char* value;
-	setup_git_directory_gently(&nongit);
+	const char *name = setup_git_directory_gently(&nongit);
 
 	while (1 < argc) {
 		if (!strcmp(argv[1], "--int"))
@@ -189,7 +189,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
-			setenv(CONFIG_ENVIRONMENT, argv[2], 1);
+			if (argv[2][0] == '/')
+				name = argv[2];
+			else
+				name = name ? prefix_filename(name, strlen(name), argv[2]) : argv[2];
+			setenv(CONFIG_ENVIRONMENT, name, 1);
 			argc--;
 			argv++;
 		}
-- 
1.5.3.4
