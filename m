From: skimo@liacs.nl
Subject: [PATCH 18/22] git-clone: add --submodules for cloning submodules
Date: Thu, 24 May 2007 00:23:07 +0200
Message-ID: <11799589933189-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFn-0003VS-Tl
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbXEWWXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757700AbXEWWXs
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:48 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33758 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014AbXEWWXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:38 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNL6R011607;
	Thu, 24 May 2007 00:23:26 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 4AB747DDB0; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48200>

From: Sven Verdoolaege <skimo@kotnet.org>

When the --submodules option is specified, git-clone will search
for submodule.<submodule>.url options in the remote configuration
and clone each submodule using the first url that it can use from
the local site.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/git-clone.txt |    6 +++++-
 git-clone.sh                |   16 ++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 644bf12..565155b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] <repository> [<directory>]
+	  [--depth <depth>] [--submodules] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -105,6 +105,10 @@ OPTIONS
 	with a long history, and would want to send in a fixes
 	as patches.
 
+--submodules::
+	Clone submodules specified in (remote) configuration parameters
+	submodule.<submodule>.url.
+
 <repository>::
 	The (possibly remote) repository to clone from.  It can
 	be any URL git-fetch supports.
diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..a51b887 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] [--submodules] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -88,6 +88,7 @@ origin_override=
 use_separate_remote=t
 depth=
 no_progress=
+submodules=
 test -t 1 || no_progress=--no-progress
 while
 	case "$#,$1" in
@@ -138,6 +139,8 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	*,--su|*,--sub|*,--subm|*,--submo|*,--submod|*,--submodu|*,--submodul|\
+	*,--submodule|*,--submodules) submodules="--submodules" ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -156,6 +159,10 @@ then
 	then
 		die '--bare and --origin $origin options are incompatible.'
 	fi
+	if test -n "$submodules"
+	then
+		die '--bare and --submodules origin options are incompatible.'
+	fi
 	no_checkout=yes
 	use_separate_remote=
 fi
@@ -401,10 +408,15 @@ then
 		git-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
 
+	if test -n "$submodules"
+	then
+		git-config core.submodules true
+	fi
+
 	case "$no_checkout" in
 	'')
 		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
-		git-read-tree -m -u $v HEAD HEAD
+		git-read-tree -m -u $v $submodules HEAD HEAD
 	esac
 fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
-- 
1.5.2.784.g5532e
