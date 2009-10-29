From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] add autoupdate feature
Date: Wed, 28 Oct 2009 20:24:25 -0400
Message-ID: <20091029002425.GC1057@sigill.intra.peff.net>
References: <20091029002229.GA986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Ioa-0000Ug-Qr
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZJ2AYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZJ2AYX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:24:23 -0400
Received: from peff.net ([208.65.91.99]:38816 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbZJ2AYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:24:22 -0400
Received: (qmail 13825 invoked by uid 107); 29 Oct 2009 00:28:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 28 Oct 2009 20:28:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2009 20:24:25 -0400
Content-Disposition: inline
In-Reply-To: <20091029002229.GA986@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131545>

Users can't be bothered to keep their software up to date, so
we must do it for them.  Whenever any git command is
invoked, this patch checks for new releases of git at
kernel.org, and automatically upgrades your version of git.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Sam Vilain <sam@vilain.net>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Nick Edelen <sirnot@gmail.com>
Signed-off-by: "J.H." <warthog9@kernel.org>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore          |    1 +
 Makefile            |    1 +
 git-autoupdate.perl |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c               |    9 +++++++-
 4 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 git-autoupdate.perl

diff --git a/.gitignore b/.gitignore
index cf0d8b9..5a2703d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@ git-annotate
 git-apply
 git-archimport
 git-archive
+git-autoupdate
 git-bisect
 git-bisect--helper
 git-blame
diff --git a/Makefile b/Makefile
index ae4b9fc..ba386a4 100644
--- a/Makefile
+++ b/Makefile
@@ -335,6 +335,7 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_PERL += git-add--interactive.perl
+SCRIPT_PERL += git-autoupdate.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
diff --git a/git-autoupdate.perl b/git-autoupdate.perl
new file mode 100644
index 0000000..c8ca10b
--- /dev/null
+++ b/git-autoupdate.perl
@@ -0,0 +1,58 @@
+#!/usr/bin/perl
+
+use LWP::Simple;
+use strict;
+
+my $ROOT = "http://kernel.org/pub/software/scm/git";
+
+my $us = our_git_version();
+my $them = latest_git_version();
+
+if (compare_versions($us, $them) < 0) {
+	print STDERR <<EOF;
+A new version of git is available! Auto-installing version $them.
+EOF
+}
+else {
+	exit 0;
+}
+
+upgrade($them);
+exit 42;
+
+sub our_git_version {
+	local $_ = `git version`;
+	/^git version (.*?)(\.\d+\.g[a-f0-9]+)?(\.dirty)?$/
+		or die "unable to read git version: $_";
+	return $1;
+}
+
+sub latest_git_version {
+	local $_ = get("$ROOT/");
+	my @versions = /git-([0-9.]+)\.tar\.gz/g
+		or die "unable to find any git versions at $ROOT";
+	# git version numbers have always sorted lexicographically so far,
+	# so let's just assume that will be the case forever
+	return (sort @versions)[-1];
+}
+
+sub compare_versions {
+	# let's assume lexicographical sorting again
+	return $_[0] cmp $_[1];
+}
+
+sub upgrade {
+	my $version = shift;
+	my $fn = "git-$version.tar.gz";
+	getstore("$ROOT/$fn", "/tmp/$fn") == 200
+		or die "unable to fetch $ROOT/$fn";
+	my $rc = system qq(
+		cd /tmp &&
+		gunzip -c $fn | tar xf - &&
+		cd git-$version &&
+		git config-mak >config.mak &&
+		make install
+	);
+	$rc == 0 or die "failed to upgrade git";
+	system("less /tmp/git-$version/RelNotes");
+}
diff --git a/git.c b/git.c
index 01ddf06..959ad52 100644
--- a/git.c
+++ b/git.c
@@ -462,10 +462,17 @@ int main(int argc, const char **argv)
 
 	if (!getenv("GIT_NOSPLASH") && !(argv[1] && !strcmp(argv[1], "splash"))) {
 		const char *a[] = { "splash", NULL };
-		const char *e[] = { "GIT_NOSPLASH=1", NULL };
+		const char *e[] = { "GIT_NOSPLASH=1", "GIT_NOAUTOUPDATE=1", NULL };
 		run_command_v_opt_cd_env(a, RUN_GIT_CMD, NULL, e);
 	}
 
+	if (!getenv("GIT_NOAUTOUPDATE")) {
+		const char *a[] = { "autoupdate", NULL };
+		const char *e[] = { "GIT_NOSPLASH=1", "GIT_NOAUTOUPDATE=1", NULL };
+		if (run_command_v_opt_cd_env(a, RUN_GIT_CMD, NULL, e) == 42)
+			exit(run_command_v_opt_cd_env(argv, 0, NULL, e));
+	}
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
-- 
1.6.5.1.3.g9d77a
