From: Jeff King <peff@peff.net>
Subject: [PATCH] Avoid slowness when timewarping large trees.
Date: Sat, 25 Mar 2006 04:39:57 -0500
Message-ID: <20060325093957.GA27832@coredump.intra.peff.net>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net> <20060324105543.GA2543@coredump.intra.peff.net> <7v3bh814z4.fsf@assigned-by-dhcp.cox.net> <20060324112246.GA5220@coredump.intra.peff.net> <20060324164352.GA20684@spearce.org> <20060325093641.GA26284@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz
X-From: git-owner@vger.kernel.org Sat Mar 25 10:40:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5Fe-0002Av-FT
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWCYJkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWCYJkA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:40:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:53467 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751132AbWCYJj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 04:39:59 -0500
Received: (qmail 72534 invoked from network); 25 Mar 2006 09:39:57 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 25 Mar 2006 09:39:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Mar 2006 04:39:57 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, pasky@suse.cz
Content-Disposition: inline
In-Reply-To: <20060325093641.GA26284@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17969>


tree_timewarp was calling read, egrep, and rm in an O(N) loop where N is
the number of changed files between two trees. This caused a bottleneck
when seeking/switching/merging between trees with many changed files.

Signed-off-by: Jeff King <peff@peff.net>


---

This is a repost of the initial patch featuring a few cleanups suggested
by Junio. 

 cg-Xlib |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

5f79b37a0eb85ff4f643e70a7f2823e68e9d9ca4
diff --git a/cg-Xlib b/cg-Xlib
index 5896df7..1a9bd4f 100644
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -363,12 +363,9 @@ tree_timewarp()
 
 	# Kill gone files
 	git-diff-tree -r "$base" "$branch" |
-		while IFS=$'\t' read header file; do
-			# match ":100755 000000 14d43b1abf... 000000000... D"
-			if echo "$header" | egrep "^:([^ ][^ ]* ){4}D" >/dev/null; then
-				rm -- "$file"
-			fi
-		done
+		# match ":100755 000000 14d43b1abf... 000000000... D"
+		sed -ne 's/^:[^\t]* D\t//p' |
+		xargs rm -f --
 	git-checkout-index -u -f -a
 
 	# FIXME: Can produce bogus "contains only garbage" messages.
-- 
1.2.4
