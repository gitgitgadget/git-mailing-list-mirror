From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] grep -P: allow optional argument specifying the pager
 (or editor)
Date: Fri, 26 Mar 2010 11:49:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003261149270.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 26 11:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv76t-0002qM-DT
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 11:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab0CZKtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 06:49:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:59044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751702Ab0CZKtp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 06:49:45 -0400
Received: (qmail invoked by alias); 26 Mar 2010 10:49:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 26 Mar 2010 11:49:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i2ncKEgNiUiRdAqKWuZ1k+Pzer91dCM5OAbIvhG
	Th8y+jnbOdZ6Zg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143221>


Suppose you want to edit all files that contain a specific search term.
Of course, you can do something totally trivial such as

	git grep -z -e <term> | xargs -0r vi +/<term>

but maybe you are happy that the same will be achieved by

	git grep -Ovi <term>

now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-grep.txt |    6 +++---
 builtin-grep.c             |   21 ++++++++++++---------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ab3bb77..1b7e32d 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
-	   [-O | --open-files-in-pager]
+	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -102,8 +102,8 @@ OPTIONS
 	For better compatibility with 'git diff', --name-only is a
 	synonym for --files-with-matches.
 
--O::
---open-files-in-pager::
+-O [<pager>]::
+--open-files-in-pager [<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
diff --git a/builtin-grep.c b/builtin-grep.c
index 233c772..a23f0dc 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -753,7 +753,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int cached = 0;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
-	int show_in_pager = 0;
+	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
@@ -838,8 +838,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
-			"show matching files in the pager"),
+		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
+			"pager", "show matching files in the pager",
+			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -893,16 +894,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_in_pager) {
-		const char *pager = getenv("GIT_PAGER");
-		if (!pager)
-			pager = getenv("PAGER");
-		if (!pager)
-			pager = "less";
+		if (show_in_pager == default_pager) {
+			show_in_pager = getenv("GIT_PAGER");
+			if (!show_in_pager)
+				show_in_pager = getenv("PAGER");
+			if (!show_in_pager)
+				show_in_pager = "less";
+		}
 		opt.name_only = 1;
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
 		opt.output = append_path;
-		string_list_append(pager, &path_list);
+		string_list_append(show_in_pager, &path_list);
 		use_threads = 0;
 	}
 
-- 
1.6.4.313.g3d9e3
