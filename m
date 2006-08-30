From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] gitweb: Move git-ls-tree output parsing to parse_ls_tree_line
Date: Thu, 31 Aug 2006 00:32:15 +0200
Message-ID: <200608310032.15543.jnareb@gmail.com>
References: <200608310030.33512.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 00:37:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIYgQ-0002iI-Ey
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 00:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWH3WhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 18:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWH3WhO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 18:37:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13541 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932216AbWH3WhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 18:37:12 -0400
Received: by nf-out-0910.google.com with SMTP id x30so271641nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 15:37:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=av1VTd4M+zCrHkAJJ1oHNq2ItHEN1a/0ltsLGx8xYupoeaXrYqotCXmb1YoHrKq2wwyTrKaKzDuHfhXCSuve5BwkpP1rtbueR+NF++DaRwbIRaLqlqxhVWyZ3yBCTGeuuii5WYFZtIm2BSpOWJ69ymXCw57uno76sKrRiD5a51U=
Received: by 10.49.75.2 with SMTP id c2mr301060nfl;
        Wed, 30 Aug 2006 15:37:11 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id o9sm377359nfa.2006.08.30.15.37.09;
        Wed, 30 Aug 2006 15:37:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608310030.33512.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26233>

Add new subroutine parse_ls_tree_line and use it in git_tree.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch could be applied regardless of the fact that this 
"tree_blame" view series is proof-of-concept series.

 gitweb/gitweb.perl |   62 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa7f62a..84a13fd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1021,6 +1021,27 @@ sub parse_difftree_raw_line {
 	return wantarray ? %res : \%res;
 }
 
+# parse line of git-ls-tree output
+sub parse_ls_tree_line ($;%) {
+	my $line = shift;
+	my %opts = @_;
+	my %res;
+
+	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+
+	$res{'mode'} = $1;
+	$res{'type'} = $2;
+	$res{'hash'} = $3;
+	if ($opts{'-z'}) {
+		$res{'name'} = $4;
+	} else {
+		$res{'name'} = unquote($4);
+	}
+
+	return wantarray ? %res : \%res;
+}
+
 ## ......................................................................
 ## parse to array of hashes functions
 
@@ -2498,51 +2519,54 @@ sub git_tree {
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	foreach my $line (@entries) {
-		#'100644	blob	0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
-		my $t_mode = $1;
-		my $t_type = $2;
-		my $t_hash = $3;
-		my $t_name = validate_input($4);
+		my %t = parse_ls_tree_line($line, -z => 1);
+
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td class=\"mode\">" . mode_str($t_mode) . "</td>\n";
-		if ($t_type eq "blob") {
+
+		print "<td class=\"mode\">" . mode_str($t{'mode'}) . "</td>\n";
+		if ($t{'type'} eq "blob") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key),
-			              -class => "list"}, esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"blob", hash=>$t{'hash'},
+			                             file_name=>"$base$t{'name'}", %base_key),
+			              -class => "list"}, esc_html($t{'name'})) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+			      $cgi->a({-href => href(action=>"blob", hash=>$t{'hash'},
+			                             file_name=>"$base$t{'name'}", %base_key)},
 			              "blob");
 			if ($have_blame) {
 				print " | " .
-					$cgi->a({-href => href(action=>"blame", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+					$cgi->a({-href => href(action=>"blame", hash=>$t{'hash'},
+					                       file_name=>"$base$t{'name'}", %base_key)},
 					        "blame");
 			}
 			print " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-			                             hash=>$t_hash, file_name=>"$base$t_name")},
+			                             hash=>$t{'hash'}, file_name=>"$base$t{'name'}")},
 			              "history") .
 			      " | " .
 			      $cgi->a({-href => href(action=>"blob_plain",
-			                             hash=>$t_hash, file_name=>"$base$t_name")},
+			                             hash=>$t{'hash'}, file_name=>"$base$t{'name'}")},
 			              "raw") .
 			      "</td>\n";
-		} elsif ($t_type eq "tree") {
+		} elsif ($t{'type'} eq "tree") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
-			              esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"tree", hash=>$t{'hash'},
+			                             file_name=>"$base$t{'name'}", %base_key)},
+			              esc_html($t{'name'})) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)},
+			      $cgi->a({-href => href(action=>"tree", hash=>$t{'hash'},
+			                             file_name=>"$base$t{'name'}", %base_key)},
 			              "tree") .
 			      " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base, file_name=>"$base$t_name")},
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             file_name=>"$base$t{'name'}")},
 			              "history") .
 			      "</td>\n";
 		}
-- 
1.4.1.1
