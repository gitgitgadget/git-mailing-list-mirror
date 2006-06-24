From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: setup indexes correctly for ancestors and
 incremental imports
Date: Sat, 24 Jun 2006 23:13:08 +1200
Message-ID: <11511475882820-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 13:13:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu64c-0001Aj-9k
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbWFXLNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbWFXLNH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:13:07 -0400
Received: from bm-3a.paradise.net.nz ([203.96.152.182]:19941 "EHLO
	linda-3.paradise.net.nz") by vger.kernel.org with ESMTP
	id S1752208AbWFXLNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:13:05 -0400
Received: from smtp-1.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-3.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0J1D001Y235S1D@linda-3.paradise.net.nz> for
 git@vger.kernel.org; Sat, 24 Jun 2006 23:13:04 +1200 (NZST)
Received: from localhost.localdomain
 (203-79-116-174.cable.paradise.net.nz [203.79.116.174])
	by smtp-1.paradise.net.nz (Postfix) with ESMTP id 34BFD421750; Sat,
 24 Jun 2006 23:13:04 +1200 (NZST)
To: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
X-Mailer: git-send-email 1.4.1.rc1.g59c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22501>

Two bugs had slipped in the "keep one index per branch during import"
patch. Both incremental imports and new branches would see an
empty tree for their initial commit. Now we cover all the relevant
cases, checking whether we actually need to setup the index before
preparing the actual commit, and doing it.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---
 git-cvsimport.perl |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
old mode 100644
new mode 100755
index d961b7b..1c1fd02
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -813,11 +813,26 @@ while(<CVS>) {
 			unless ($index{$branch}) {
 			    $index{$branch} = tmpnam();
 			    $ENV{GIT_INDEX_FILE} = $index{$branch};
-			    system("git-read-tree", $branch);
+			}
+			if ($ancestor) {
+			    system("git-read-tree", $ancestor);
 			    die "read-tree failed: $?\n" if $?;
 			} else {
+			    unless ($index{$branch}) {
+				$index{$branch} = tmpnam();
+				$ENV{GIT_INDEX_FILE} = $index{$branch};
+				system("git-read-tree", $branch);
+				die "read-tree failed: $?\n" if $?;
+			    }
+			}    
+		} else {
+			# just in case
+			unless ($index{$branch}) {
+			    $index{$branch} = tmpnam();
 			    $ENV{GIT_INDEX_FILE} = $index{$branch};
-		        }
+			    system("git-read-tree", $branch);
+			    die "read-tree failed: $?\n" if $?;
+			}
 		}
 		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
-- 
1.4.1.rc1.g59c8
