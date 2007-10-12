From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH amend] git-config: handle --file option with relative pathname properly
Date: Fri, 12 Oct 2007 11:32:51 +0000
Message-ID: <20071012113251.29941.qmail@7584201f340355.315fe32.mid.smarden.org>
References: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org> <470B8024.2050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIl2-0007PK-5L
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXJLLcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbXJLLcc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:32:32 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:47770 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753590AbXJLLcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:32:31 -0400
Received: (qmail 29942 invoked by uid 1000); 12 Oct 2007 11:32:51 -0000
Content-Disposition: inline
In-Reply-To: <470B8024.2050106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60676>

When calling git-config not from the top level directory of a repository,
it changes directory before trying to open the config file specified
through the --file option, which then fails if the config file was
specified by a relative pathname.  This patch adjusts the pathname to
the config file if applicable.

The problem was noticed by Joey Hess, reported through
 http://bugs.debian.org/445208

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Tue, Oct 09, 2007 at 03:20:36PM +0200, Johannes Sixt wrote:
> Gerrit Pape schrieb:
> >-                    setenv(CONFIG_ENVIRONMENT, argv[2], 1);
> >+                    if (argv[2][0] == '/')
>
> Please use is_absolute_path() here.

Okay.

> >+                            name = argv[2];
> >+                    else
> >+                            name = name ? prefix_filename(name,
> >strlen(name), argv[2]) : argv[2];
>
> Can't you avoid this ternary here? There's already an 'if' with the same
> 'else' branch.

Sure, thanks, Gerrit.

 builtin-config.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 0a605e0..4444d52 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -165,7 +165,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
 	char* value;
-	setup_git_directory_gently(&nongit);
+	const char *file = setup_git_directory_gently(&nongit);
 
 	while (1 < argc) {
 		if (!strcmp(argv[1], "--int"))
@@ -189,7 +189,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
-			setenv(CONFIG_ENVIRONMENT, argv[2], 1);
+			if (!is_absolute_path(argv[2]) && file)
+				file = prefix_filename(file, strlen(file),
+						       argv[2]);
+			else
+				file = argv[2];
+			setenv(CONFIG_ENVIRONMENT, file, 1);
 			argc--;
 			argv++;
 		}
-- 
1.5.3.4
