From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Escape --upload-pack from expr.
Date: Tue, 30 Jan 2007 13:11:49 -0500
Message-ID: <20070130181149.GA26655@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxT9-0003XU-Em
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbXA3SLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbXA3SLx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:11:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030194AbXA3SLw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:11:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBxSK-0006xu-P6; Tue, 30 Jan 2007 13:11:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5FAB620FBAE; Tue, 30 Jan 2007 13:11:49 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38179>

Recent commit ae1dffcb28ee89a23f8d2747be65e17c8eab1690 by Junio
changed the way --upload-pack was passed around between clone,
fetch and ls-remote and modified the handling of the command
line parameter parsing.

Unfortunately FreeBSD 6.1 insists that the expression

  expr --upload-pack=git-upload-pack : '-[^=]*=\(.*\)'

is illegal, as the --upload-pack option is not supported by their
implementation of expr.

Elsewhere in Git we use z as a leading prefix of both arguments,
ensuring the -- isn't seen by expr.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I did a quick search, I don't think there are any others.

 git-clone.sh     |    2 +-
 git-fetch.sh     |    2 +-
 git-ls-remote.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 3d83acb..4ddfa77 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -123,7 +123,7 @@ while
 		shift
 		upload_pack="--upload-pack=$1" ;;
 	*,--upload-pack=*)
-		upload_pack=--upload-pack=$(expr "$1" : '-[^=]*=\(.*\)') ;;
+		upload_pack=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 	1,--depth) usage;;
 	*,--depth)
 		shift
diff --git a/git-fetch.sh b/git-fetch.sh
index c1f6e1e..357cac2 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -37,7 +37,7 @@ do
 		;;
 	--upl=*|--uplo=*|--uploa=*|--upload=*|\
 	--upload-=*|--upload-p=*|--upload-pa=*|--upload-pac=*|--upload-pack=*)
-		exec=--upload-pack=$(expr "$1" : '-[^=]*=\(.*\)')
+		exec=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 		shift
 		;;
 	-f|--f|--fo|--for|--forc|--force)
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index e6f574b..8ea5c5e 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -27,7 +27,7 @@ do
 	shift;;
   -u=*|--u=*|--up=*|--upl=*|--uplo=*|--uploa=*|--upload=*|\
   --upload-=*|--upload-p=*|--upload-pa=*|--upload-pac=*|--upload-pack=*)
-	exec=--upload-pack=$(expr "$1" : '-[^=]*=\(.*\)')
+	exec=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 	shift;;
   --)
   shift; break ;;
-- 
1.5.0.rc2.81.g73a2
