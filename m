From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Add history and blame to git_difftree_body()
Date: Wed, 27 Sep 2006 17:24:49 -0700 (PDT)
Message-ID: <20060928002449.64051.qmail@web31802.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-476788578-1159403089=:63135"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 28 02:25:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjiK-0004NV-Fb
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031284AbWI1AYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031285AbWI1AYw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:24:52 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:5456 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031284AbWI1AYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:24:50 -0400
Received: (qmail 64053 invoked by uid 60001); 28 Sep 2006 00:24:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=I093yk+nLuCyODH7RsJNC8/QnDoNYEtRrTYAxd40MONlKynUPQq1wKscMZyzdo/RqWYoMK38Z6pKHWDcXexavBnMF9AbozvTV5b9hT4zQV1eW/TN7ruuZ30H9LmCqla5liAcu7ePQ219fzmj13r3mFwHqyhEjKfTvXQtBz7033g=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Wed, 27 Sep 2006 17:24:49 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27956>

--0-476788578-1159403089=:63135
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Add blame and history to Deleted files.
Add blame and history to Modified or Type changed files.
Add blame and history to Renamed or Copied files.

This allows us to do
	blame->commit->blame->commit->blame->...
instead of
	blame->commit->file->blame->commit->file->blame->...
which is longer and easier to get wrong.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

--0-476788578-1159403089=:63135
Content-Type: text/plain; name="p3.txt"
Content-Description: 3222950043-p3.txt
Content-Disposition: inline; filename="p3.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c87f60e..f772fa3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1721,9 +1721,12 @@ sub git_difftree_body {
 				print $cgi->a({-href => "#patch$patchno"}, "patch");
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
+						     file_name=>$diff{'file'})},
+				      "blame") . " | ";
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                             file_name=>$diff{'file'})},
-			              "history");
+						     file_name=>$diff{'file'})},
+				      "history");
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "M" || $diff{'status'} eq "T") { # modified, or type changed
@@ -1763,8 +1766,11 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
-			print $cgi->a({-href => href(action=>"history",
-						     hash_base=>$hash, file_name=>$diff{'file'})},
+			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
+						     file_name=>$diff{'file'})},
+				      "blame") . " | ";
+			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
+						     file_name=>$diff{'file'})},
 				      "history");
 			print "</td>\n";
 
@@ -1790,17 +1796,22 @@ sub git_difftree_body {
 				if ($action eq 'commitdiff') {
 					# link to patch
 					$patchno++;
-					print " | " .
-						$cgi->a({-href => "#patch$patchno"}, "patch");
+					print $cgi->a({-href => "#patch$patchno"}, "patch");
 				} else {
-					print " | " .
-						$cgi->a({-href => href(action=>"blobdiff",
-						                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-						                       hash_base=>$hash, hash_parent_base=>$parent,
-						                       file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
-						        "diff");
+					print $cgi->a({-href => href(action=>"blobdiff",
+								     hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+								     hash_base=>$hash, hash_parent_base=>$parent,
+								     file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+						      "diff");
 				}
+				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
+						     file_name=>$diff{'from_file'})},
+				      "blame") . " | ";
+			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
+						     file_name=>$diff{'from_file'})},
+				      "history");
 			print "</td>\n";
 
 		} # we should not encounter Unmerged (U) or Unknown (X) status
-- 
1.4.2.1.g271e


--0-476788578-1159403089=:63135--
