From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] gitweb: Separate printing of git_tree row into git_print_tree_entry
Date: Thu, 31 Aug 2006 00:35:07 +0200
Message-ID: <200608310035.07585.jnareb@gmail.com>
References: <200608310030.33512.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 00:37:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIYgR-0002iI-3F
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 00:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWH3WhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 18:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWH3WhP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 18:37:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7397 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932214AbWH3WhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 18:37:13 -0400
Received: by nf-out-0910.google.com with SMTP id x30so271645nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 15:37:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HqXWaWNm0r/pgxT6Wtwqg/RLYqcGpYj8mclxP7dltbNPrcvBpcou+vfjFTX1H8PFOsxNaI3S3Mi9rQvBKPhpuqGpOQZdC134mWqGe7PJmxzKRu6Z7O2y7Xv4vRIOeyq/IEMl6PZnVVekxr+N0x0CBXj7Wiojcioo2or2pKfWlp4=
Received: by 10.49.29.3 with SMTP id g3mr322145nfj;
        Wed, 30 Aug 2006 15:37:12 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id o9sm377359nfa.2006.08.30.15.37.11;
        Wed, 30 Aug 2006 15:37:11 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608310030.33512.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26234>

This is preparation for "tree blame" (similar to what ViewVC shows)
output, i.e. for each entry give commit where it was changed.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This could be applied even though it is proof-of-concept series,
but I think it would be better to separate git_tree_body rather,
although perhaps something like git_print_tree_entry subroutine
is a good idea.

 gitweb/gitweb.perl |  103 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 84a13fd..d8b94a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1462,6 +1462,62 @@ sub git_print_simplified_log {
 		-remove_title => $remove_title);
 }
 
+# print tree entry (row of git_tree), but without encompassing <tr> element
+sub git_print_tree_entry {
+	my ($t, $basedir, $hash_base, $have_blame) = @_;
+
+	my %base_key = ();
+	$base_key{hash_base} = $hash_base if defined $hash_base;
+
+	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	if ($t->{'type'} eq "blob") {
+		print "<td class=\"list\">" .
+		      $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}", %base_key),
+		              -class => "list"}, esc_html($t->{'name'})) .
+		      "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              "blob");
+		if ($have_blame) {
+			print " | " .
+				$cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
+				                       file_name=>"$basedir$t->{'name'}", %base_key)},
+				        "blame");
+		}
+		if (defined $hash_base) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print " | " .
+		      $cgi->a({-href => href(action=>"blob_plain",
+		                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
+		              "raw") .
+		      "</td>\n";
+
+	} elsif ($t->{'type'} eq "tree") {
+		print "<td class=\"list\">" .
+		      $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              esc_html($t->{'name'})) .
+		      "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              "tree");
+		if (defined $hash_base) {
+			print " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			                             file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print "</td>\n";
+	}
+}
+
 ## ......................................................................
 ## functions printing large fragments of HTML
 
@@ -2499,14 +2555,13 @@ sub git_tree {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
-	my %base_key = ();
 	my $base = "";
 	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-		$base_key{hash_base} = $hash_base;
 		git_print_page_nav('tree','', $hash_base);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
+		undef $hash_base;
 		print "<div class=\"page_nav\">\n";
 		print "<br/><br/></div>\n";
 		print "<div class=\"title\">$hash</div>\n";
@@ -2528,48 +2583,8 @@ sub git_tree {
 		}
 		$alternate ^= 1;
 
-		print "<td class=\"mode\">" . mode_str($t{'mode'}) . "</td>\n";
-		if ($t{'type'} eq "blob") {
-			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t{'hash'},
-			                             file_name=>"$base$t{'name'}", %base_key),
-			              -class => "list"}, esc_html($t{'name'})) .
-			      "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$t{'hash'},
-			                             file_name=>"$base$t{'name'}", %base_key)},
-			              "blob");
-			if ($have_blame) {
-				print " | " .
-					$cgi->a({-href => href(action=>"blame", hash=>$t{'hash'},
-					                       file_name=>"$base$t{'name'}", %base_key)},
-					        "blame");
-			}
-			print " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-			                             hash=>$t{'hash'}, file_name=>"$base$t{'name'}")},
-			              "history") .
-			      " | " .
-			      $cgi->a({-href => href(action=>"blob_plain",
-			                             hash=>$t{'hash'}, file_name=>"$base$t{'name'}")},
-			              "raw") .
-			      "</td>\n";
-		} elsif ($t{'type'} eq "tree") {
-			print "<td class=\"list\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t{'hash'},
-			                             file_name=>"$base$t{'name'}", %base_key)},
-			              esc_html($t{'name'})) .
-			      "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"tree", hash=>$t{'hash'},
-			                             file_name=>"$base$t{'name'}", %base_key)},
-			              "tree") .
-			      " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-			                             file_name=>"$base$t{'name'}")},
-			              "history") .
-			      "</td>\n";
-		}
+		git_print_tree_entry(\%t, $base, $hash_base, $have_blame);
+
 		print "</tr>\n";
 	}
 	print "</table>\n" .
-- 
1.4.1.1
