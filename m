From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10 (amended)] gitweb: Add support for hash_parent_base parameter for blobdiffs
Date: Thu, 24 Aug 2006 23:53:54 +0200
Message-ID: <200608242353.54869.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 23:54:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGN9F-0006aC-Se
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 23:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWHXVx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWHXVx6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 17:53:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030485AbWHXVx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 17:53:57 -0400
Received: by nf-out-0910.google.com with SMTP id o25so689469nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 14:53:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=asn9noXIkb0sCCyTqRCFgpSGvDcLGSS8mdEKYCmzmcuUhRzqzYncvm4gFVvvPbrdtHKP4QNSd5FCMeTwCXvja5O85PrKCz9vOeNG0DDPUeLCEXh0JYqopxM4fwSqmlg8BF2o+M6jiqf11o3GmCLxNsh3AqFbVfgsW9NWuI4CQME=
Received: by 10.49.8.1 with SMTP id l1mr4439842nfi;
        Thu, 24 Aug 2006 14:53:55 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id m15sm5262032nfc.2006.08.24.14.53.54;
        Thu, 24 Aug 2006 14:53:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25979>

Add support for hash_parent_base in input validation part and in
href() function.  Add proper hash_parent_base to all calls to blobdiff
and blobdiff_plain action URLs. Use hash_parent_base as hash_base for
blobs of hash_parent.

To be used in future rewrite of git_blobdiff and git_blobdiff_plain.

While at it, move project before action in ordering CGI parameters in
href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   37 +++++++++++++++++++++++++++----------
 1 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2e8259..a3553ad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -211,6 +211,13 @@ if (defined $hash_base) {
 	}
 }
 
+our $hash_parent_base = $cgi->param('hpb');
+if (defined $hash_parent_base) {
+	if (!validate_input($hash_parent_base)) {
+		die_error(undef, "Invalid hash parent base parameter");
+	}
+}
+
 our $page = $cgi->param('pg');
 if (defined $page) {
 	if ($page =~ m/[^0-9]$/) {
@@ -270,13 +277,14 @@ sub href(%) {
 	my %params = @_;
 
 	my @mapping = (
-		action => "a",
 		project => "p",
+		action => "a",
 		file_name => "f",
 		file_parent => "fp",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
+		hash_parent_base => "hpb",
 		page => "pg",
 		searchtext => "s",
 	);
@@ -1543,8 +1551,10 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
-				print $cgi->a({-href => href(action=>"blobdiff", hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-				                             hash_base=>$hash, file_name=>$diff{'file'}),
+				print $cgi->a({-href => href(action=>"blobdiff",
+				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+				                             hash_base=>$hash, hash_parent_base=>$parent,
+				                             file_name=>$diff{'file'}),
 				              -class => "list"}, esc_html($diff{'file'}));
 			} else { # only mode changed
 				print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
@@ -1559,8 +1569,10 @@ sub git_difftree_body {
 				        "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
 				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff", hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-					                       hash_base=>$hash, file_name=>$diff{'file'})},
+					$cgi->a({-href => href(action=>"blobdiff",
+					                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                       hash_base=>$hash, hash_parent_base=>$parent,
+					                       file_name=>$diff{'file'})},
 					        "diff");
 			}
 			print " | " .
@@ -1592,8 +1604,9 @@ sub git_difftree_body {
 			              "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) {
 				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff", hash_base=>$hash,
+					$cgi->a({-href => href(action=>"blobdiff",
 					                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                       hash_base=>$hash, hash_parent_base=>$parent,
 					                       file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
 					        "diff");
 			}
@@ -1793,8 +1806,10 @@ sub git_history_body {
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
 				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff", hash=>$blob_current, hash_parent=>$blob_parent,
-					                       hash_base=>$commit, file_name=>$file_name)},
+					$cgi->a({-href => href(action=>"blobdiff",
+					                       hash=>$blob_current, hash_parent=>$blob_parent,
+					                       hash_base=>$hash_base, hash_parent_base=>$commit,
+					                       file_name=>$file_name)},
 					        "diff to current");
 			}
 		}
@@ -2751,7 +2766,9 @@ sub git_blobdiff {
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my $formats_nav =
 			$cgi->a({-href => href(action=>"blobdiff_plain",
-			                       hash=>$hash, hash_parent=>$hash_parent)},
+			                       hash=>$hash, hash_parent=>$hash_parent,
+			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
+			                       file_name=>$file_name, file_parent=>$file_parent)},
 			        "plain");
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -2765,7 +2782,7 @@ HTML
 	print "<div class=\"page_body\">\n" .
 	      "<div class=\"diff_info\">blob:" .
 	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent,
-	                             hash_base=>$hash_base, file_name=>($file_parent || $file_name))},
+	                             hash_base=>$hash_parent_base, file_name=>($file_parent || $file_name))},
 	              $hash_parent) .
 	      " -> blob:" .
 	      $cgi->a({-href => href(action=>"blob", hash=>$hash,
-- 
1.4.1.1
