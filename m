From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't allow contrib/workdir/git-new-workdir to trash existing dirs
Date: Wed, 5 Sep 2007 23:33:41 -0400
Message-ID: <20070906033341.GA32447@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT87s-0000Hd-MD
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 05:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506AbXIFDdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 23:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbXIFDdr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 23:33:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37335 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757487AbXIFDdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 23:33:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT87X-0008AB-K8; Wed, 05 Sep 2007 23:33:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4210E20FBAE; Wed,  5 Sep 2007 23:33:42 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57811>

Recently I found that doing a sequence like the following:

  git-new-workdir a b
  ...
  git-new-workdir a b

by accident will cause a (and now also b) to have an infinite cycle
in its refs directory.  This is caused by git-new-workdir trying
to create the "refs" symlink over again, only during the second
time it is being created within a's refs directory and is now also
pointing back at a's refs.

This causes confusion in git as suddenly branches are named things
like "refs/refs/refs/refs/refs/refs/refs/heads/foo" instead of the
more commonly accepted "refs/heads/foo".  Plenty of commands start
to see ambiguous ref names and others just take ages to compute.

git-clone has the same safety check, so git-new-workdir should
behave just like it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/workdir/git-new-workdir |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index c6e154a..2838546 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -48,6 +48,12 @@ then
 		"a complete repository."
 fi
 
+# don't recreate a workdir over an existing repository
+if test -e "$new_workdir"
+then
+	die "destination directory '$new_workdir' already exists."
+fi
+
 # make sure the the links use full paths
 git_dir=$(cd "$git_dir"; pwd)
 
-- 
1.5.3.1.840.g0fedbc
