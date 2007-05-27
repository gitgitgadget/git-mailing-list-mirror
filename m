From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Allow contrib new-workdir to link into bare repositories
Date: Sat, 26 May 2007 23:09:27 -0400
Message-ID: <20070527030927.GA32530@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 27 05:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs98X-00031s-2b
	for gcvg-git@gmane.org; Sun, 27 May 2007 05:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbXE0DJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 23:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXE0DJf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 23:09:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36617 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbXE0DJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 23:09:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hs989-0006Tn-7H; Sat, 26 May 2007 23:09:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B7FA920FBAE; Sat, 26 May 2007 23:09:27 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48513>

On one particular system I like to keep a cluster of bare Git
repositories and spawn new-workdirs off of them.  Since the bare
repositories don't have working directories associated with them
they don't have a .git/ subdirectory that hosts the repository we
are linking to.

Using a bare repository as the backing repository for a workdir
created by this script does require that the user delete core.bare
from the repository's configuration file, so that Git auto-senses
the bareness of a repository based on pathname information, and
not based on the config file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/workdir/git-new-workdir |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 9877b98..f2a3615 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -20,17 +20,19 @@ new_workdir=$2
 branch=$3
 
 # want to make sure that what is pointed to has a .git directory ...
-test -d "$orig_git/.git" || die "\"$orig_git\" is not a git repository!"
+git_dir=$(cd "$orig_git" 2>/dev/null &&
+  git rev-parse --git-dir 2>/dev/null) ||
+  die "\"$orig_git\" is not a git repository!"
 
 # don't link to a workdir
-if test -L "$orig_git/.git/config"
+if test -L "$git_dir/config"
 then
 	die "\"$orig_git\" is a working directory only, please specify" \
 		"a complete repository."
 fi
 
 # make sure the the links use full paths
-orig_git=$(cd "$orig_git"; pwd)
+git_dir=$(cd "$git_dir"; pwd)
 
 # create the workdir
 mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
@@ -45,13 +47,13 @@ do
 		mkdir -p "$(dirname "$new_workdir/.git/$x")"
 		;;
 	esac
-	ln -s "$orig_git/.git/$x" "$new_workdir/.git/$x"
+	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
 done
 
 # now setup the workdir
 cd "$new_workdir"
 # copy the HEAD from the original repository as a default branch
-cp "$orig_git/.git/HEAD" .git/HEAD
+cp "$git_dir/HEAD" .git/HEAD
 # checkout the branch (either the same as HEAD from the original repository, or
 # the one that was asked for)
 git checkout -f $branch
-- 
1.5.2.789.g8ee1
