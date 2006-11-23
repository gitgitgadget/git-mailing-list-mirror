X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 23:58:35 +0100
Message-ID: <20061123225835.30071.99265.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 23 Nov 2006 22:58:57 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32166>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNWn-0006w4-BI for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934217AbWKWW6i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 17:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934241AbWKWW6i
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:58:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61834 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S934217AbWKWW6h (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:58:37 -0500
Received: (qmail 30081 invoked from network); 23 Nov 2006 23:58:36 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 23 Nov 2006 23:58:36 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

and --use-immingled-remote can be used to get the original behaviour;
it is also implied by --bare.

We get confused, frustrated and data-losing users *daily* on #git now
because git-clone still produces the crippled repositories having the
remote and local heads freely mixed together.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-clone.txt |   20 ++++++++++++++------
 git-clone.sh                |   14 +++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8606047..b1ad79f 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--use-separate-remote] <repository> [<directory>]
+	  [--use-separate-remote | --use-immingled-remote] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
@@ -71,9 +72,10 @@ OPTIONS
 	Make a 'bare' GIT repository.  That is, instead of
 	creating `<directory>` and placing the administrative
 	files in `<directory>/.git`, make the `<directory>`
-	itself the `$GIT_DIR`. This implies `-n` option.  When
-	this option is used, neither the `origin` branch nor the
-	default `remotes/origin` file is created.
+	itself the `$GIT_DIR`. This implies the `-n` and
+	`--use-immingled-remote' option.  When this option is used,
+	neither the `origin` branch nor the default `remotes/origin`
+	file is created.
 
 --origin <name>::
 -o <name>::
@@ -97,8 +99,14 @@ OPTIONS
 
 --use-separate-remote::
 	Save remotes heads under `$GIT_DIR/remotes/origin/` instead
-	of `$GIT_DIR/refs/heads/`.  Only the master branch is saved
-	in the latter.
+	of `$GIT_DIR/refs/heads/`.  Only the local master branch is
+	saved in the latter. This is the default.
+
+--use-immingled-remote::
+	Save remotes heads in the same namespace as the local heads,
+	`$GIT_DIR/refs/heads/'.  In regular repositories, this is
+	a legacy setup git-clone created by default in older Git
+	versions.  It is also still implied by `--bare'.
 
 <repository>::
 	The (possibly remote) repository to clone from.  It can
diff --git a/git-clone.sh b/git-clone.sh
index 3f006d1..9ed4135 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--use-immingled-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -115,7 +115,7 @@ bare=
 reference=
 origin=
 origin_override=
-use_separate_remote=
+use_separate_remote=t
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -134,7 +134,10 @@ while
 	  template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote)
+		# default
 		use_separate_remote=t ;;
+	*,--use-immingled-remote)
+		use_separate_remote= ;;
 	1,--reference) usage ;;
 	*,--reference)
 		shift; reference="$1" ;;
@@ -169,18 +172,15 @@ repo="$1"
 test -n "$repo" ||
     die 'you must specify a repository to clone.'
 
-# --bare implies --no-checkout
+# --bare implies --no-checkout and --use-immingled-remote
 if test yes = "$bare"
 then
 	if test yes = "$origin_override"
 	then
 		die '--bare and --origin $origin options are incompatible.'
 	fi
-	if test t = "$use_separate_remote"
-	then
-		die '--bare and --use-separate-remote options are incompatible.'
-	fi
 	no_checkout=yes
+	use_separate_remote=
 fi
 
