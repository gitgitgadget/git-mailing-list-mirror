X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Wed, 8 Nov 2006 11:48:56 +0100
Message-ID: <200611081148.57243.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 10:50:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c6MJGC/rXSB06gpzAqqW54MKgk1lhT0dVyw3OcZwK1r/lkmi+EIloUmy6TUvWrNF352Qy+Jy6xcCF7YkpX5KYpB12wXwE25ADvZdOKb8FO5YFdb/fKNl4vSgcv5AMnEIgKF5BafSw+g119wlsiAN7ajqacyi3D0sm9PEp/7SFd8=
User-Agent: KMail/1.9.3
In-Reply-To: <200611081147.52952.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31137>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghl00-0001gj-S1 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 11:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752917AbWKHKtf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 05:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbWKHKtf
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 05:49:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:27086 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752917AbWKHKtd
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 05:49:33 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1476064ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 02:49:32 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr10653064ugl.1162982971441; Wed, 08
 Nov 2006 02:49:31 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm7626498uge.2006.11.08.02.49.30; Wed, 08 Nov
 2006 02:49:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Extend unquote subroutine, which unquotes quoted and escaped filenames
which git may return, to deal not only with octal char sequence
quoting, but also quoting ordinary characters including '\"' and '\\'
which are respectively quoted '"' and '\', and to deal also with
C escape sequences including '\t' for TAB and '\n' for LF.

Add esc_path subroutine for gitweb quoting and HTML escaping filenames
(currently it does equivalent of ls' --hide-control-chars, which means
showing undisplayable characters (including '\n' and '\t') as '?'
(question mark) character.  Convert gitweb to use esc_path instead of
simply esc_html to print pathnames.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I hope I catched all the places where esc_html should be replaced by
esc_path.

 gitweb/gitweb.perl |   72 ++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c46629f..32926f9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -584,12 +584,46 @@ sub esc_html ($;%) {
 	return $str;
 }
 
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	$str = esc_html($str);
+	$str =~ s/[[:cntrl:]]/?/g; # like --hide-control-chars in ls
+	return $str;
+}
+
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
+
+	sub unq {
+		my $seq = shift;
+		my %es = ( # character escape codes, aka escape sequences
+			't' => "\t",   # tab            (HT, TAB)
+			'n' => "\n",   # newline        (NL)
+			'r' => "\r",   # return         (CR)
+			'f' => "\f",   # form feed      (FF)
+			'b' => "\b",   # backspace      (BS)
+			'a' => "\a",   # alarm (bell)   (BEL)
+			'e' => "\e",   # escape         (ESC)
+			'v' => "\013", # vertical tab   (VT)
+		);
+
+		if ($seq =~ m/^[0-7]{1,3}$/) {
+			# octal char sequence
+			return chr(oct($seq));
+		} elsif (exists $es{$seq}) {
+			# C escape sequence, aka character escape code
+			return $es{$seq}
+		}
+		# quoted ordinary character
+		return $seq;
+	}
+
 	if ($str =~ m/^"(.*)"$/) {
+		# needs unquoting
 		$str = $1;
-		$str =~ s/\\([0-7]{1,3})/chr(oct($1))/eg;
+		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
 	}
 	return $str;
 }
@@ -1520,7 +1554,7 @@ sub git_header_html {
 		if (defined $action) {
 			$title .= "/$action";
 			if (defined $file_name) {
-				$title .= " - " . esc_html($file_name);
+				$title .= " - " . esc_path($file_name);
 				if ($action eq "tree" && $file_name !~ m|/$|) {
 					$title .= "/";
 				}
@@ -1791,20 +1825,20 @@ sub git_print_page_path {
 			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
-			              -title => $fullname}, esc_html($dir));
+			              -title => $fullname}, esc_path($dir));
 			print " / ";
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => $name}, esc_html($basename));
+			              -title => $name}, esc_path($basename));
 		} elsif (defined $type && $type eq 'tree') {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => $name}, esc_html($basename));
+			              -title => $name}, esc_path($basename));
 			print " / ";
 		} else {
-			print esc_html($basename);
+			print esc_path($basename);
 		}
 	}
 	print "<br/></div>\n";
@@ -1876,7 +1910,7 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
-			        -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
+			        -class => "list"}, esc_path($t->{'name'})) . "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 					     file_name=>"$basedir$t->{'name'}", %base_key)},
@@ -1903,7 +1937,7 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              esc_html($t->{'name'}));
+		              esc_path($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
@@ -1968,7 +2002,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-			              -class => "list"}, esc_html($diff{'file'}));
+			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
 			print "<td class=\"link\">";
@@ -1984,7 +2018,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff{'file'}),
-			               -class => "list"}, esc_html($diff{'file'}));
+			               -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
 			print "<td class=\"link\">";
@@ -2024,7 +2058,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-			              -class => "list"}, esc_html($diff{'file'}));
+			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
 			print "<td class=\"link\">";
@@ -2064,11 +2098,11 @@ sub git_difftree_body {
 			print "<td>" .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
 			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'}),
-			              -class => "list"}, esc_html($diff{'to_file'})) . "</td>\n" .
+			              -class => "list"}, esc_path($diff{'to_file'})) . "</td>\n" .
 			      "<td><span class=\"file_status $nstatus\">[$nstatus from " .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$parent,
 			                             hash=>$diff{'from_id'}, file_name=>$diff{'from_file'}),
-			              -class => "list"}, esc_html($diff{'from_file'})) .
+			              -class => "list"}, esc_path($diff{'from_file'})) .
 			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
@@ -2191,7 +2225,7 @@ sub git_patchset_body {
 			$file  ||= $diffinfo->{'file'};
 			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
 			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
+			                -class => "list"}, esc_path($file));
 			$patch_line =~ s|a/.*$|a/$file|g;
 			print "<div class=\"diff from_file\">$patch_line</div>\n";
 
@@ -2203,7 +2237,7 @@ sub git_patchset_body {
 			$file  ||= $diffinfo->{'file'};
 			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
 			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
+			                -class => "list"}, esc_path($file));
 			$patch_line =~ s|b/.*|b/$file|g;
 			print "<div class=\"diff to_file\">$patch_line</div>\n";
 
@@ -3521,8 +3555,8 @@ sub git_blobdiff {
 
 	} else {
 		while (my $line = <$fd>) {
-			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_html($diffinfo{'from_file'})!eg;
-			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_html($diffinfo{'to_file'})!eg;
+			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_path($diffinfo{'from_file'})!eg;
+			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_path($diffinfo{'to_file'})!eg;
 
 			print $line;
 
@@ -3879,7 +3913,7 @@ sub git_search {
 						print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
 						                             hash=>$set{'id'}, file_name=>$set{'file'}),
 						              -class => "list"},
-						              "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
+						              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
 						      "<br/>\n";
 					}
 					print "</td>\n" .
@@ -4014,7 +4048,7 @@ XML
 			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
 				next;
 			}
-			my $file = esc_html(unquote($7));
+			my $file = esc_path(unquote($7));
 			$file = to_utf8($file);
 			print "$file<br/>\n";
 		}
-- 
1.4.3.4
