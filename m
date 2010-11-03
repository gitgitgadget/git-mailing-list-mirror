From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH] clone: Deprecate the --recursive option in favor of --recurse-submodules
Date: Wed, 03 Nov 2010 19:41:59 +0100
Message-ID: <4CD1ACF7.6040108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 19:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDiHf-0006I7-IQ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 19:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab0KCSmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 14:42:02 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58849 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab0KCSmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 14:42:00 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 98F0916D0E4FE;
	Wed,  3 Nov 2010 19:41:59 +0100 (CET)
Received: from [93.240.112.6] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PDiHX-0007C0-00; Wed, 03 Nov 2010 19:41:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Sfn+GV1JZs/JW+8hVBRyBYWEH8HEJ/aWQJC2L
	JgtfQQcqJ9FQor3juTPxRVUbnXGtBSshmYEbDBm46Cr5u3lLZW
	+0q+gGNCiPXmMAlRHzTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160634>

Since 1.6.5 "git clone" honors the --recursive option to recursively check
out submodules too. As this option can easily be misinterpreted when it is
added to other commands like "git grep", add the new --recurse-submodules
option to avoid confusing it with other types of recursion.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


At the GitTogether some of us were talking about a sane option name for
recursing submodules which should then be used consistently by all
commands (maybe with the exception of "git submodule", as --recursive
there has a pretty obvious meaning). For my first recursion patches a
few months ago I started with --recurse-submodules but then I noticed
that "git clone" already used "--recursive" for the same purpose, and
for consistency reasons I switched to using that too. But especially
when looking at recursive grep it is really easy to misinterpret
--recursive, so the idea came up to use --recurse-submodules everywhere.

Opinions?


 Documentation/git-clone.txt |    5 +++--
 builtin/clone.c             |   10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ab72933..1768cef 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
+	  [--depth <depth>] [--recurse-submodules] [--] <repository> [<directory>]

 DESCRIPTION
 -----------
@@ -166,13 +166,14 @@ objects from the source repository into a pack in the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.

---recursive::
+--recurse-submodules::
 	After the clone is created, initialize all submodules within,
 	using their default settings. This is equivalent to running
 	`git submodule update --init --recursive` immediately after
 	the clone is finished. This option is ignored if the cloned
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	This option replaces the now deprecated `--recursive`.

 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..91e7fab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -43,7 +43,7 @@ static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
-static int option_verbosity;
+static int option_verbosity, option_recurse_submodules;
 static int option_progress;

 static struct option builtin_clone_options[] = {
@@ -65,6 +65,8 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOLEAN('s', "shared", &option_shared,
 		    "setup as shared repository"),
 	OPT_BOOLEAN(0, "recursive", &option_recursive,
+		    "initialize submodules in the clone (deprecated)"),
+	OPT_BOOLEAN(0, "recurse_submodules", &option_recurse_submodules,
 		    "initialize submodules in the clone"),
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
@@ -659,7 +661,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				sha1_to_hex(our_head_points_at->old_sha1), "1",
 				NULL);

-		if (!err && option_recursive)
+		if (option_recursive) {
+			warning("--recursive is deprecated; use --recurse-submodules instead.");
+			option_recurse_submodules = 1;
+		}
+		if (!err && option_recurse_submodules)
 			err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
 	}

-- 
1.7.3.2.213.g5fe186
