From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add splash screen
Date: Wed, 28 Oct 2009 20:24:00 -0400
Message-ID: <20091029002400.GA1057@sigill.intra.peff.net>
References: <20091029002229.GA986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IoC-0000KR-8R
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbZJ2AX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbZJ2AX6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:23:58 -0400
Received: from peff.net ([208.65.91.99]:38812 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682AbZJ2AX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:23:57 -0400
Received: (qmail 13782 invoked by uid 107); 29 Oct 2009 00:27:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 28 Oct 2009 20:27:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2009 20:24:00 -0400
Content-Disposition: inline
In-Reply-To: <20091029002229.GA986@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131543>

Because bash completion is so slow to start, we need to
entertain users with a splash screen, so reuse the one from
git-gui.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Sam Vilain <sam@vilain.net>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Nick Edelen <sirnot@gmail.com>
Signed-off-by: "J.H." <warthog9@kernel.org>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore    |    1 +
 Makefile      |    3 +++
 git-splash.sh |    4 ++++
 git.c         |    6 ++++++
 4 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 git-splash.sh

diff --git a/.gitignore b/.gitignore
index 51a37b1..1e547e7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,3 +190,4 @@ cscope*
 *.pdb
 Debug/
 Release/
+git-splash
diff --git a/Makefile b/Makefile
index fea237b..36e1a61 100644
--- a/Makefile
+++ b/Makefile
@@ -329,6 +329,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-splash.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -1352,6 +1353,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
+sharedir_SQ = $(subst ','\'',$(sharedir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -1428,6 +1430,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's|@@SHAREDIR@@|$(sharedir_SQ)|' \
 	    -e $(BROKEN_PATH_FIX) \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
diff --git a/git-splash.sh b/git-splash.sh
new file mode 100644
index 0000000..fc2e6f7
--- /dev/null
+++ b/git-splash.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+echo 'source @@SHAREDIR@@/git-gui/lib/logo.tcl; pack [git_logo .logo]; after 3000 exit' |
+wish
diff --git a/git.c b/git.c
index 9883009..86dcfee 100644
--- a/git.c
+++ b/git.c
@@ -459,6 +459,12 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "git-help";
 
+	if (!getenv("GIT_NOSPLASH") && !(argv[1] && !strcmp(argv[1], "splash"))) {
+		const char *a[] = { "splash", NULL };
+		const char *e[] = { "GIT_NOSPLASH=1", NULL };
+		run_command_v_opt_cd_env(a, RUN_GIT_CMD, NULL, e);
+	}
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
-- 
1.6.5.1.3.g9d77a
