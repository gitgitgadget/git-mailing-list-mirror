From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Restore object-named links in item lists
Date: Tue, 24 Oct 2006 05:12:40 +0200
Message-ID: <20061024031240.2500.93420.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 05:12:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcCic-0003cZ-64
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWJXDMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWJXDMn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:12:43 -0400
Received: from rover.dkm.cz ([62.24.64.27]:43394 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932321AbWJXDMm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:12:42 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id F1C768BC3C;
	Tue, 24 Oct 2006 05:12:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29914>

This restores the redundant links removed earlier. It supersedes my patch
to stick slashes to tree entries.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4a2025c..695c632 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1793,16 +1793,18 @@ sub git_print_tree_entry {
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
 			        -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
 		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+					     file_name=>"$basedir$t->{'name'}", %base_key)},
+			      "blob");
 		if ($have_blame) {
-			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
+			print " | " .
+			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
 				                           file_name=>"$basedir$t->{'name'}", %base_key)},
 				            "blame");
 		}
 		if (defined $hash_base) {
-			if ($have_blame) {
-				print " | ";
-			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
@@ -1819,11 +1821,20 @@ sub git_print_tree_entry {
 		              esc_html($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+					     file_name=>"$basedir$t->{'name'}", %base_key)},
+			      "tree");
 		if (defined $hash_base) {
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
+		if ($have_snapshot) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
+			              "snapshot");
+		}
 		print "</td>\n";
 	}
 }
@@ -1903,6 +1914,9 @@ sub git_difftree_body {
 				print $cgi->a({-href => "#patch$patchno"}, "patch");
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+			                             hash_base=>$parent, file_name=>$diff{'file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 			                             file_name=>$diff{'file'})},
 			              "blame") . " | ";
@@ -1948,6 +1962,9 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+						     hash_base=>$hash, file_name=>$diff{'file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 			                             file_name=>$diff{'file'})},
 			              "blame") . " | ";
@@ -1988,6 +2005,9 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+						     hash_base=>$parent, file_name=>$diff{'from_file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 			                             file_name=>$diff{'from_file'})},
 			              "blame") . " | ";
@@ -2155,6 +2175,7 @@ sub git_shortlog_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
 		if (gitweb_have_snapshot()) {
