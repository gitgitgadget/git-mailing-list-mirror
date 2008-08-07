From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFH] filter-branch: ancestor detection weirdness
Date: Fri,  8 Aug 2008 01:54:02 +0200
Message-ID: <1218153242-18837-1-git-send-email-trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch>
Cc: Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 01:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRFJp-0002LK-CL
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 01:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYHGXx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 19:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYHGXx4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 19:53:56 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34476 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbYHGXxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 19:53:55 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:53:53 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:53:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.19.g3c9ba
In-Reply-To: <200808080148.27384.trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Aug 2008 23:53:53.0660 (UTC) FILETIME=[D8FCB3C0:01C8F8E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91613>

THIS WILL VERY LIKELY NOT WORK IN ALL CASES.

Use git rev-list -1 -- <subdir> to discover a random ancestor, instead
of more correct boundary detection.  Oddly enough, this _increases_
success rate with Jan's repository and --all.  May break randomly with
more complicated args.
---

Maybe someone understands what's going on and can fix the underlying
bug...

 git-filter-branch.sh |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 182822a..52b2bdf 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -325,15 +325,9 @@ while read ref
 do
 	sha1=$(git rev-parse "$ref"^0)
 	test -f "$workdir"/../map/$sha1 && continue
-	# Assign the boundarie(s) in the set of rewritten commits
-	# as the replacement commit(s).
-	# (This would look a bit nicer if --not --stdin worked.)
-	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
-		git rev-list $ref --boundary --stdin |
-		sed -n "s/^-//p")
-	do
-		map $p >> "$workdir"/../map/$sha1
-	done
+	# Assign the first commit not pruned as the replacement.
+	candidate=$(git rev-list $ref -1 -- "$filter_subdir")
+	test "$candidate" && map "$candidate" > "$workdir"/../map/$sha1
 done < "$tempdir"/heads
 
 # Finally update the refs
-- 
1.6.0.rc2.19.g3c9ba
