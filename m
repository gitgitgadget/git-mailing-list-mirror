From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] filter-branch: be more helpful when an annotated tag changes
Date: Fri,  8 Aug 2008 01:50:31 +0200
Message-ID: <1218153031-18443-1-git-send-email-trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch>
Cc: Jan Wielemaker <J.Wielemaker@uva.nl>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 01:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRFGX-0001PP-O3
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 01:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbYHGXu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbYHGXu0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 19:50:26 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20316 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592AbYHGXuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 19:50:25 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:50:24 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:50:23 +0200
X-Mailer: git-send-email 1.6.0.rc2.19.g3c9ba
In-Reply-To: <200808080148.27384.trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Aug 2008 23:50:23.0911 (UTC) FILETIME=[5BF78B70:01C8F8E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91612>

Previously, git-filter-branch failed if it attempted to update an
annotated tag.  Now we ignore this condition if --tag-name-filter is
given, so that we can later rewrite the tag.  If no such option was
provided, we warn the user that he might want to run with
--tag-name-filter cat to achieve the intended effect.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 182822a..a324cf0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -361,9 +361,17 @@ do
 	;;
 	$_x40)
 		echo "Ref '$ref' was rewritten"
-		git update-ref -m "filter-branch: rewrite" \
-				"$ref" $rewritten $sha1 ||
-			die "Could not rewrite $ref"
+		if ! git update-ref -m "filter-branch: rewrite" \
+					"$ref" $rewritten $sha1 2>/dev/null; then
+			if test $(git cat-file -t "$ref") = tag; then
+				if test -z "$filter_tag_name"; then
+					warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
+					warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
+				fi
+			else
+				die "Could not rewrite $ref"
+			fi
+		fi
 	;;
 	*)
 		# NEEDSWORK: possibly add -Werror, making this an error
-- 
1.6.0.rc2.19.g3c9ba
