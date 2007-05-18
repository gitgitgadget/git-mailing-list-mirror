From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use run_command_v_opt_cd when checking out a submodule
Date: Sat, 19 May 2007 00:48:07 +0200
Message-ID: <20070518224807.GH10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <1179516307425-git-send-email-skimo@liacs.nl> <20070518220014.GD10475@steel.home> <20070518222015.GE10475@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBFB-0007g1-LO
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbXERWsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbXERWsL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:48:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45385 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735AbXERWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:48:10 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo58) (RZmta 6.5)
	with ESMTP id J04794j4IMfn71 ; Sat, 19 May 2007 00:48:07 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C0A19277BD;
	Sat, 19 May 2007 00:48:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A0D34D195; Sat, 19 May 2007 00:48:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070518222015.GE10475@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47674>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 entry.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 96a4a60..0316c74 100644
--- a/entry.c
+++ b/entry.c
@@ -166,7 +166,6 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 
 static int checkout_submodule(const char *path, struct cache_entry *ce, const struct checkout *state)
 {
-	static char cwd[PATH_MAX];
 	const char *gitdirenv;
 	const char *args[10];
 	int argc;
@@ -175,12 +174,6 @@ static int checkout_submodule(const char *path, struct cache_entry *ce, const st
 	if (!state->submodules)
 		return 0;
 
-	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
-		die("Unable to read current working directory");
-
-	if (chdir(path))
-		die("Cannot move to '%s'", path);
-
 	argc = 0;
 	args[argc++] = "checkout";
 	if (state->force)
@@ -190,12 +183,9 @@ static int checkout_submodule(const char *path, struct cache_entry *ce, const st
 
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	unsetenv(GIT_DIR_ENVIRONMENT);
-	err = run_command_v_opt(args, RUN_GIT_CMD);
+	err = run_command_v_opt_cd(args, RUN_GIT_CMD, path);
 	setenv(GIT_DIR_ENVIRONMENT, gitdirenv, 1);
 
-	if (chdir(cwd))
-		die("Cannot come back to cwd");
-
 	if (err)
 		return error("failed to run git-checkout in submodule '%s'", path);
 
-- 
1.5.2.rc3.83.gbbb0
