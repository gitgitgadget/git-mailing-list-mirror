From: Jeff King <peff@peff.net>
Subject: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 03:44:23 -0500
Message-ID: <20060324084423.GA30213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 24 09:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMhuS-0002UZ-HF
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 09:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWCXIoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 03:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWCXIoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 03:44:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:16885 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932509AbWCXIoZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 03:44:25 -0500
Received: (qmail 24595 invoked from network); 24 Mar 2006 08:44:23 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 Mar 2006 08:44:23 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2006 03:44:23 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17903>


tree_timewarp was calling read, egrep, and rm in an O(N) loop where N is
the number of changed files between two trees. This caused a bottleneck
when seeking/switching/merging between trees with many changed files.

On the historical linux tree, the time to cg-seek from the head to the
initial commit (a change of 19099 files) dropped from 2m35s to 21s.

---

 cg-Xlib |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

a9a160c0bd63973c53ba3aa74650728135d23ac7
diff --git a/cg-Xlib b/cg-Xlib
index a2f28cf..ceddeeb 100644
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -345,12 +345,9 @@ tree_timewarp()
 
 	# Kill gone files
 	git-diff-tree -r "$base" "$branch" |
-		while IFS=$'\t' read header file; do
-			# match ":100755 000000 14d43b1abf... 000000000... D"
-			if echo "$header" | egrep "^:([^ ][^ ]* ){4}D" >/dev/null; then
-				rm -- "$file"
-			fi
-		done
+		# match ":100755 000000 14d43b1abf... 000000000... D"
+		sed -ne 's/^:\([^ ][^ ]* \)\{4\}D\t//p' |
+		xargs rm --
 	git-checkout-index -u -f -a
 
 	# FIXME: Can produce bogus "contains only garbage" messages.
-- 
1.2.4
