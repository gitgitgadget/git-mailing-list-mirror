From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] clone: Add an option to set up a mirror
Date: Fri, 1 Aug 2008 16:00:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 01 15:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOv8L-0008KY-0N
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 15:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbYHAN41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYHAN40
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 09:56:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:41511 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751612AbYHAN4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 09:56:25 -0400
Received: (qmail invoked by alias); 01 Aug 2008 13:56:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 01 Aug 2008 15:56:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aeAd80t6aPKtU9IR6uguBcaRY4KFIXdL4pMhjAR
	9AmLY6Th+KrrEj
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91066>


The command line

	$ git clone --mirror $URL

is now a short-hand for

	$ git clone --bare $URL
	$ (cd $(basename $URL) && git remote add --mirror origin $URL)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-clone.txt |    5 ++++-
 builtin-clone.c             |    9 ++++++++-
 t/t5601-clone.sh            |   10 ++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 26fd1b1..0e14e73 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git clone' [--template=<template_directory>]
-	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare]
+	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--depth <depth>] [--] <repository> [<directory>]
 
@@ -106,6 +106,9 @@ then the cloned repository will become corrupt.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
+--mirror::
+	Set up a mirror of the remote repository.  This implies --bare.
+
 --origin <name>::
 -o <name>::
 	Instead of using the remote name 'origin' to keep track
diff --git a/builtin-clone.c b/builtin-clone.c
index e086a40..a45179c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -33,7 +33,7 @@ static const char * const builtin_clone_usage[] = {
 	NULL
 };
 
-static int option_quiet, option_no_checkout, option_bare;
+static int option_quiet, option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
@@ -45,6 +45,8 @@ static struct option builtin_clone_options[] = {
 		    "don't create a checkout"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
+	OPT_BOOLEAN(0, "mirror", &option_mirror,
+		    "create a mirror repository (implies bare)"),
 	OPT_BOOLEAN('l', "local", &option_local,
 		    "to clone from a local repository"),
 	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
@@ -359,6 +361,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_no_hardlinks)
 		use_local_hardlinks = 0;
 
+	if (option_mirror)
+		option_bare = 1;
+
 	if (option_bare) {
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
@@ -446,7 +451,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	} else {
 		snprintf(branch_top, sizeof(branch_top),
 			 "refs/remotes/%s/", option_origin);
+	}
 
+	if (option_mirror || !option_bare) {
 		/* Configure the remote */
 		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
 		git_config_set(key, repo);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d785b3d..4b2533f 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -70,4 +70,14 @@ test_expect_success 'clone creates intermediate directories for bare repo' '
 
 '
 
+test_expect_success 'clone --mirror' '
+
+	git clone --mirror src mirror &&
+	test -f mirror/HEAD &&
+	test ! -f mirror/file &&
+	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
+	test "+refs/heads/*:refs/heads/*" = "$FETCH"
+
+'
+
 test_done
-- 
1.6.0.rc1.46.g279e5
