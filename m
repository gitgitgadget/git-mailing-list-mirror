X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/n] gitweb: Output also empty patches in "commitdiff" view
Date: Tue, 31 Oct 2006 17:36:27 +0100
Message-ID: <200610311736.27910.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 16:36:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qilxQE3A2KYc6Y/b4BnI8kpU7CBYyhPvIuAwZfz29taxvtuJi/u01MsGx4k8ki8veq9OKwluKyCOoGsenQIA898rVfBLKad70cBr5HTaksTSO+PlE56vYVtITtqicxYL0yvgWR441Ae5bGrzqpIaIPlRCSiiqo8DL1HM/jmvvsQ=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30590>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GewbC-0002Xo-15 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 17:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423466AbWJaQgV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 11:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423574AbWJaQgV
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 11:36:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:8479 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423466AbWJaQgU
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 11:36:20 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1494603ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 08:36:18 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr6389963ugl; Tue, 31 Oct 2006
 08:36:18 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id o24sm5243142ugd.2006.10.31.08.36.17; Tue, 31 Oct
 2006 08:36:18 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Remove skipping over empty patches (i.e. patches which consist solely
of extended headers) in git_patchset_body, and add links to those
header-only patches in git_difftree_body (but not generate blobdiff
links when there were no change in file contents).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
As promised...

 gitweb/gitweb.perl |   67 +++++++++++++++++++++-------------------------------
 1 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 542dbca..e0f7a3f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1998,19 +1998,19 @@ sub git_difftree_body {
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
 			print "<td class=\"link\">";
-			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
-				if ($action eq 'commitdiff') {
-					# link to patch
-					$patchno++;
-					print $cgi->a({-href => "#patch$patchno"}, "patch");
-				} else {
-					print $cgi->a({-href => href(action=>"blobdiff",
-					                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-					                             hash_base=>$hash, hash_parent_base=>$parent,
-					                             file_name=>$diff{'file'})},
-					              "diff");
-				}
-				print " | ";
+			if ($action eq 'commitdiff') {
+				# link to patch
+				$patchno++;
+				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				      " | ";
+			} elsif ($diff{'to_id'} ne $diff{'from_id'}) {
+				# "commit" view and modified file (not onlu mode changed)
+				print $cgi->a({-href => href(action=>"blobdiff",
+				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+				                             hash_base=>$hash, hash_parent_base=>$parent,
+				                             file_name=>$diff{'file'})},
+				              "diff") .
+				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 			                             file_name=>$diff{'file'})},
@@ -2038,19 +2038,19 @@ sub git_difftree_body {
 			              -class => "list"}, esc_path($diff{'from_file'})) .
 			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">";
-			if ($diff{'to_id'} ne $diff{'from_id'}) {
-				if ($action eq 'commitdiff') {
-					# link to patch
-					$patchno++;
-					print $cgi->a({-href => "#patch$patchno"}, "patch");
-				} else {
-					print $cgi->a({-href => href(action=>"blobdiff",
-					                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-					                             hash_base=>$hash, hash_parent_base=>$parent,
-					                             file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
-					              "diff");
-				}
-				print " | ";
+			if ($action eq 'commitdiff') {
+				# link to patch
+				$patchno++;
+				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				      " | ";
+			} elsif ($diff{'to_id'} ne $diff{'from_id'}) {
+				# "commit" view and modified file (not only pure rename or copy)
+				print $cgi->a({-href => href(action=>"blobdiff",
+				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+				                             hash_base=>$hash, hash_parent_base=>$parent,
+				                             file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+				              "diff") .
+				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 			                             file_name=>$diff{'from_file'})},
@@ -2072,7 +2072,6 @@ sub git_patchset_body {
 	my $patch_idx = 0;
 	my $in_header = 0;
 	my $patch_found = 0;
-	my $skip_patch = 0;
 	my $diffinfo;
 	my (%from, %to);
 
@@ -2084,8 +2083,6 @@ sub git_patchset_body {
 
 		if ($patch_line =~ m/^diff /) { # "git diff" header
 			# beginning of patch (in patchset)
-			$skip_patch = 0;
-
 			if ($patch_found) {
 				# close previous patch
 				print "</div>\n"; # class="patch"
@@ -2116,13 +2113,6 @@ sub git_patchset_body {
 			}
 			$patch_idx++;
 
-			# for now we skip empty patches
-			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) { # no change
-				$in_header = 1;
-				$skip_patch = 0;
-				next LINE;
-			}
-
 			# print "git diff" header
 			$patch_line =~ s!^(diff (.*?) )a/.*$!$1!;
 			if ($from{'href'}) {
@@ -2143,10 +2133,7 @@ sub git_patchset_body {
 			print "<div class=\"diff extended_header\">\n";
 			$in_header = 1;
 			next LINE;
-		} else {
-			# actual skipping of empty patches
-			next LINE if $skip_patch;
-		} # start of patch in patchset
+		}
 
 		if ($in_header) {
 			if ($patch_line !~ m/^---/) {
-- 
1.4.3.3
