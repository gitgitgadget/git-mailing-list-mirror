X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Finish restoring "blob" links in git_difftree_body
Date: Sun, 19 Nov 2006 22:51:39 +0100
Message-ID: <1163973099476-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sun, 19 Nov 2006 21:50:25 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=DvDhO47GMrghCWibrT2SXF4uZRffMcz2qP/VUP4XSC0Phaq5koFqmB6+lhKVc/heav8mSCenMojmZBugRVSgtMstAhJqH6E+QVoiAjfG5biQ7jlLu6l+wVhKIOlf2iKsojijJtKp7M7jigBPHnb/0OU15jC3zUSLZq4HjJTotmE=
X-Mailer: git-send-email 1.4.3.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31867>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GluYQ-0007Zp-RV for gcvg-git@gmane.org; Sun, 19 Nov
 2006 22:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933386AbWKSVuS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbWKSVuS
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 16:50:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:27444 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933386AbWKSVuQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 16:50:16 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1061131ugc for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 13:50:15 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr6168625ugm.1163973014811; Sun, 19
 Nov 2006 13:50:14 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 53sm5213168ugn.2006.11.19.13.50.13; Sun, 19 Nov 2006 13:50:14 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAJLpe6u026769; Sun, 19 Nov 2006 22:51:41 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAJLpd5r026768; Sun, 19 Nov 2006 22:51:39 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This finishes work started by commit 4777b0141a4812177390da4b6ebc9d40ac3da4b5
  "gitweb: Restore object-named links in item lists"
by Petr Baudis. It brings back rest of "blob" links in difftree-raw
like part of "commit" and "commitdiff" views, namely in
git_difftree_body subroutine.

Now the td.link table cell has the following links:
 * link to diff ("blobdiff" view) in "commit" view, if applicable
   (there is no link to uninteresting creation/deletion diff), or
   link to patch anchor in "commitdiff" view.
 * link to current version of file ("blob" view), with the obvious
   exception of file deletion, where it is link to the parent
   version.
 * link to "blame" view, if it is enabled, and file was not just
   created (i.e. it has any history).
 * link to history of the file ("history" view), again with sole
   exception of the case of new file.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This goes in the opposite version to the previous patch
  " gitweb: Remove redundant "blob" links from git_difftree_body"
in the 10/n series.

 gitweb/gitweb.perl |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a32a6b7..ce185d9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2092,7 +2092,11 @@ sub git_difftree_body {
 				# link to patch
 				$patchno++;
 				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			              "blob") . " | ";
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "D") { # deleted
@@ -2112,13 +2116,11 @@ sub git_difftree_body {
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff{'file'})},
-				      "blob") . " | ";
+			              "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href =>
-						   href(action=>"blame",
-							hash_base=>$parent,
-							file_name=>$diff{'file'})},
-					      "blame") . " | ";
+				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
+				                             file_name=>$diff{'file'})},
+				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
 			                             file_name=>$diff{'file'})},
@@ -2163,13 +2165,12 @@ sub git_difftree_body {
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-						     hash_base=>$hash, file_name=>$diff{'file'})},
-				      "blob") . " | ";
+			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			               "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href => href(action=>"blame",
-							     hash_base=>$hash,
-							     file_name=>$diff{'file'})},
-					      "blame") . " | ";
+				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
+				                             file_name=>$diff{'file'})},
+				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
 			                             file_name=>$diff{'file'})},
@@ -2208,17 +2209,16 @@ sub git_difftree_body {
 				              "diff") .
 				      " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-						     hash_base=>$parent, file_name=>$diff{'from_file'})},
-				      "blob") . " | ";
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			                             hash_base=>$parent, file_name=>$diff{'to_file'})},
+			              "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href => href(action=>"blame",
-							     hash_base=>$hash,
-							     file_name=>$diff{'to_file'})},
-					      "blame") . " | ";
+				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
+				                             file_name=>$diff{'to_file'})},
+				              "blame") . " | ";
 			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                            file_name=>$diff{'from_file'})},
+			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
+			                            file_name=>$diff{'to_file'})},
 			              "history");
 			print "</td>\n";
 
-- 
1.4.3.4
