X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Mon, 30 Oct 2006 19:58:23 +0100
Message-ID: <200610301958.23334.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 19:06:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FOGu0qMM8Z2f4kHXjOGG/qsmnCvGJ6PFEMqDavDQV5CDb7bwxp0Wn26zGn624KmfstrlSmoi+nEsMLBhXH9bHzwAaZmPNTxEvv5pSG4sErXnJ1ZMyOxEkc+ppdokKIes93BS8lBnBpzUELDHFhekRvg3/QQRAVVfzGc3jiQoNxk=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30505>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecMC-0003My-Es for gcvg-git@gmane.org; Mon, 30 Oct
 2006 19:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161373AbWJ3S7S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 13:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWJ3S7R
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 13:59:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26283 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161383AbWJ3S7N
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 13:59:13 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1226222ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 10:59:10 -0800 (PST)
Received: by 10.67.93.7 with SMTP id v7mr4707507ugl; Mon, 30 Oct 2006
 10:59:09 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 53sm3684599ugn.2006.10.30.10.59.08; Mon, 30 Oct
 2006 10:59:09 -0800 (PST)
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
By the way, testing this patch uncovered some errors in gitweb, some
related to files with strange name, some unrelated. I'll address them
in further patches. They are:

  1. Using m/..\t(.+)$/; to catch filename instead of m/..\t(.+)$/s;

  2. Lack of '--' after $hash/$hash_base parameter which gives error
     if there exist branch (ref) and file (or directory) with the same
     name

The current implementation of esc_path is meant as preliminary: if you
have better idea for quoting names in gitweb, please tell us, or better
send code/patches.


 gitweb/gitweb.perl |   68 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec46b80..a15e916 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -563,12 +563,42 @@ sub esc_html {
 	return $str;
 }
 
+# quote unsafe characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	$str = esc_html($str);
+	$str =~ s/[[:cntrl:]\a\b\e\f\n\r\t\011]/?/g; # like --hide-control-chars in ls
+	return $str;
+}
+
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
+
+	sub unq {
+		my $seq = shift;
+		my %es = (
+			't' => "\t", # tab            (HT, TAB)
+			'n' => "\n", # newline        (NL)
+			'r' => "\r", # return         (CR)
+			'f' => "\f", # form feed      (FF)
+			'b' => "\b", # backspace      (BS)
+			'a' => "\a", # alarm (bell)   (BEL)
+			#'e' => "\e", # escape        (ESC)
+			'v' => "\011", # vertical tab (VT)
+		);
+
+		# octal char sequence
+		return chr(oct($seq))  if ($seq =~ m/^[0-7]{1,3}$/);
+		# C escape sequence (this includes '\n' (LF) and '\t' (TAB))
+		return $es{$seq}       if ($seq =~ m/^[abefnrtv]$/);
+		# quted ordinary character (this includes '\\' and '\"')
+		return $seq;
+	}
+
 	if ($str =~ m/^"(.*)"$/) {
 		$str = $1;
-		$str =~ s/\\([0-7]{1,3})/chr(oct($1))/eg;
+		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
 	}
 	return $str;
 }
@@ -1435,7 +1465,7 @@ sub git_header_html {
 		if (defined $action) {
 			$title .= "/$action";
 			if (defined $file_name) {
-				$title .= " - " . esc_html($file_name);
+				$title .= " - " . esc_path($file_name);
 				if ($action eq "tree" && $file_name !~ m|/$|) {
 					$title .= "/";
 				}
@@ -1706,20 +1736,20 @@ sub git_print_page_path {
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
@@ -1791,7 +1821,7 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
-			        -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
+			        -class => "list"}, esc_path($t->{'name'})) . "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 					     file_name=>"$basedir$t->{'name'}", %base_key)},
@@ -1818,7 +1848,7 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              esc_html($t->{'name'}));
+		              esc_path($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
@@ -1883,7 +1913,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-			              -class => "list"}, esc_html($diff{'file'}));
+			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
 			print "<td class=\"link\">";
@@ -1899,7 +1929,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff{'file'}),
-			               -class => "list"}, esc_html($diff{'file'}));
+			               -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
 			print "<td class=\"link\">";
@@ -1939,7 +1969,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-			              -class => "list"}, esc_html($diff{'file'}));
+			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
 			print "<td class=\"link\">";
@@ -1979,11 +2009,11 @@ sub git_difftree_body {
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
 			if ($diff{'to_id'} ne $diff{'from_id'}) {
@@ -2113,7 +2143,7 @@ sub git_patchset_body {
 			$file  ||= $diffinfo->{'file'};
 			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
 			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
+			                -class => "list"}, esc_path($file));
 			$patch_line =~ s|a/.*$|a/$file|g;
 			print "<div class=\"diff from_file\">$patch_line</div>\n";
 
@@ -2125,7 +2155,7 @@ sub git_patchset_body {
 			$file  ||= $diffinfo->{'file'};
 			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
 			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
+			                -class => "list"}, esc_path($file));
 			$patch_line =~ s|b/.*|b/$file|g;
 			print "<div class=\"diff to_file\">$patch_line</div>\n";
 
@@ -3373,8 +3403,8 @@ sub git_blobdiff {
 
 	} else {
 		while (my $line = <$fd>) {
-			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_html($diffinfo{'from_file'})!eg;
-			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_html($diffinfo{'to_file'})!eg;
+			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_path($diffinfo{'from_file'})!eg;
+			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_path($diffinfo{'to_file'})!eg;
 
 			print $line;
 
@@ -3729,7 +3759,7 @@ sub git_search {
 						print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
 						                             hash=>$set{'id'}, file_name=>$set{'file'}),
 						              -class => "list"},
-						              "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
+						              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
 						      "<br/>\n";
 					}
 					print "</td>\n" .
@@ -3863,7 +3893,7 @@ XML
 			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
 				next;
 			}
-			my $file = esc_html(unquote($7));
+			my $file = esc_path(unquote($7));
 			$file = to_utf8($file);
 			print "$file<br/>\n";
 		}
-- 
1.4.3.3
