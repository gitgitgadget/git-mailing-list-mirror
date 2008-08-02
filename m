From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] clone: Add an option to set up a mirror
Date: Sat, 2 Aug 2008 21:38:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808022126270.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7vr697l01j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 21:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPMtj-0006Bw-ES
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 21:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761399AbYHBTeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761393AbYHBTef
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 15:34:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:50907 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759434AbYHBTed (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 15:34:33 -0400
Received: (qmail invoked by alias); 02 Aug 2008 19:34:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 02 Aug 2008 21:34:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MfiVbR0MMbmvloePaFwv4ZcL2DzO5qkcW3z9Znx
	yRzyVz4T+9YVWE
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vr697l01j.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91172>


The command line

	$ git clone --mirror $URL

is now a short-hand for

	$ git clone --bare $URL
	$ (cd $(basename $URL) && git remote add --mirror origin $URL)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Interdiff to follow.

 Documentation/git-clone.txt |    5 ++++-
 builtin-clone.c             |   24 ++++++++++++++++++++----
 t/t5601-clone.sh            |   10 ++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

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
index e086a40..ecdcefa 100644
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
@@ -345,6 +347,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	char branch_top[256], key[256], value[256];
 	struct strbuf reflog_msg;
 	struct transport *transport = NULL;
+	char *src_ref_prefix = "refs/heads/";
 
 	struct refspec refspec;
 
@@ -359,6 +362,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_no_hardlinks)
 		use_local_hardlinks = 0;
 
+	if (option_mirror)
+		option_bare = 1;
+
 	if (option_bare) {
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
@@ -440,26 +446,36 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-		strcpy(branch_top, "refs/heads/");
+		if (option_mirror)
+			src_ref_prefix = "refs/";
+		strcpy(branch_top, src_ref_prefix);
 
 		git_config_set("core.bare", "true");
 	} else {
 		snprintf(branch_top, sizeof(branch_top),
 			 "refs/remotes/%s/", option_origin);
+	}
 
+	if (option_mirror || !option_bare) {
 		/* Configure the remote */
+		if (option_mirror) {
+			snprintf(key, sizeof(key),
+					"remote.%s.mirror", option_origin);
+			git_config_set(key, "true");
+		}
+
 		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
 		git_config_set(key, repo);
 
 		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
 		snprintf(value, sizeof(value),
-				"+refs/heads/*:%s*", branch_top);
+				"+%s*:%s*", src_ref_prefix, branch_top);
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
 	refspec.force = 0;
 	refspec.pattern = 1;
-	refspec.src = "refs/heads/";
+	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top;
 
 	if (path && !is_bundle)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d785b3d..9cd5ef4 100755
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
+	test "+refs/*:refs/*" = "$FETCH"
+
+'
+
 test_done
-- 
1.6.0.rc1.70.g91e1d
