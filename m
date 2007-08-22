From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix new-workdir (again) to work on bare repositories
Date: Tue, 21 Aug 2007 21:50:12 -0400
Message-ID: <20070822015012.GA11085@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 03:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INfMU-0006wp-Da
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 03:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbXHVBuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXHVBuR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 21:50:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33386 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbXHVBuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 21:50:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INfMB-0004yg-6F; Tue, 21 Aug 2007 21:50:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E9ADE20FBAE; Tue, 21 Aug 2007 21:50:12 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56343>

My day-job workflow involves using multiple workdirs attached to a
bunch of bare repositories.  Such repositories are stored inside of
a directory called "foo.git", which means `git rev-parse --git-dir`
will return "." and not ".git".  Under such conditions new-workdir
was getting confused about where the Git repository it was supplied
is actually located.

If we get "." for the result of --git-dir query it means we should
use the user supplied path as-is, and not attempt to perform any
magic on it, as the path is directly to the repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/workdir/git-new-workdir |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 3ff6bd1..119cff9 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -24,10 +24,14 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
   git rev-parse --git-dir 2>/dev/null) ||
   die "\"$orig_git\" is not a git repository!"
 
-if test "$git_dir" = ".git"
-then
+case "$git_dir" in
+.git)
 	git_dir="$orig_git/.git"
-fi
+	;;
+.)
+	git_dir=$orig_git
+	;;
+esac
 
 # don't link to a workdir
 if test -L "$git_dir/config"
-- 
1.5.3.rc6
