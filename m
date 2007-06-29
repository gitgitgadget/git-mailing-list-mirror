From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Fri, 29 Jun 2007 10:31:08 +0200
Message-ID: <20070629083108.GA14747@liacs.nl>
References: <20070628105208.GA11105@liacs.nl> <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Bsy-0005NI-9M
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 10:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbXF2IbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbXF2IbW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 04:31:22 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:36129 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbXF2IbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 04:31:21 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l5T8V9d1002894;
	Fri, 29 Jun 2007 10:31:14 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id EA3643C009; Fri, 29 Jun 2007 10:31:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51163>

git-clone supports cloning from a repo with detached HEAD,
but if this HEAD is not behind any branch tip then it
would not have been fetched over dumb http, resulting in a

	fatal: Not a valid object name HEAD

Since 928c210a, this would also happen on a http repo
with a HEAD that is a symbolic link where someone has
forgotton to run update-server-info.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>
---
On Thu, Jun 28, 2007 at 05:02:18PM -0700, Junio C Hamano wrote:
> Ok.  But I think the change regresses when the remote side is
> actually on a particular branch, and is using symref to
> represent $GIT_DIR/HEAD.

Updated patch tested on both symbolic links and symrefs.

skimo

 git-clone.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index bd44ce1..4cbf60f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -72,6 +72,17 @@ Perhaps git-update-server-info needs to be run there?"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
 	rm -f "$GIT_DIR/REMOTE_HEAD"
+	if test -f "$GIT_DIR/REMOTE_HEAD"; then
+		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+		case "$head_sha1" in
+		'ref: refs/'*)
+			;;
+		*)
+			git-http-fetch $v -a "$head_sha1" "$1" ||
+			rm -f "$GIT_DIR/REMOTE_HEAD"
+			;;
+		esac
+	fi
 }
 
 quiet=
-- 
1.5.2.2.585.g9cc0-dirty
