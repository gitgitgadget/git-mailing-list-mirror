From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Thu, 28 Jun 2007 12:52:08 +0200
Message-ID: <20070628105208.GA11105@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 12:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3rcI-0001QP-R5
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 12:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762914AbXF1KwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 06:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762879AbXF1KwX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 06:52:23 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:53037 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762828AbXF1KwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 06:52:21 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l5SAq98c013795;
	Thu, 28 Jun 2007 12:52:14 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 05FE33C4C2; Thu, 28 Jun 2007 12:52:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51094>

git-clone supports cloning from a repo with detached HEAD,
but if this HEAD is not behind any branch tip then it
would not have been fetched over dumb http, resulting in a

	fatal: Not a valid object name HEAD

Since 928c210a, this would also happen on a http repo
with a HEAD that is a symbolic link where someone has
forgotton to run update-server-info.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>
---
 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index bd44ce1..cdbbc20 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -70,7 +70,8 @@ Perhaps git-update-server-info needs to be run there?"
 		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
-	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
+	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" &&
+	git-http-fetch $v -a $(cat "$GIT_DIR/REMOTE_HEAD") "$1" ||
 	rm -f "$GIT_DIR/REMOTE_HEAD"
 }
 
-- 
1.5.2.2.585.g9cc0-dirty
