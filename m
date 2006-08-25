From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 17/19] gitweb: git_blobdiff_plain is git_blobdiff('plain')
Date: Fri, 25 Aug 2006 21:14:49 +0200
Message-ID: <200608252114.50142.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:35:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGhSy-0005vB-8P
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWHYTfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWHYTfh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:35:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49811 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422806AbWHYTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:35:36 -0400
Received: by nf-out-0910.google.com with SMTP id o25so877287nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:35:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FL1nOvQ9w9qKedPK7SZHSSKJXkd0HkeRXdAos4ettUukdUgIS7HJErcYTOYF4Mkl72opba7QaRSkiHxjlL8YkOBooBJg7zTdvDWJMQNHb2Fmtmu/Rr3Ir32NZT/VhnPj8Yg1chfx5RptdXUdLip/yNthZtPZoSDsmBC51Utb8CM=
Received: by 10.49.92.18 with SMTP id u18mr5817270nfl;
        Fri, 25 Aug 2006 12:35:35 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id d2sm2934344nfe.2006.08.25.12.35.34;
        Fri, 25 Aug 2006 12:35:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26012>

git_blobdiff and git_blobdiff_plain are now collapsed into one
subroutine git_blobdiff, with format (currently 'html' which is
default format corresponding to git_blobdiff, and 'plain'
corresponding to git_blobdiff_plain) specified in argument.

blobdiff_plain format is now generated either by git-diff-tree
or by git-diff.  Added X-Git-Url: header.  From-file and to-file name
in header are corrected.

Note that for now commitdiff_plain does not detect renames 
and copying, while blobdiff_plain does.

While at it, set expires to "+1d" for non-textual hash ids.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   95 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9be2b2c..b20640e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2815,9 +2815,12 @@ sub git_commit {
 }
 
 sub git_blobdiff {
+	my $format = shift || 'html';
+
 	my $fd;
 	my @difftree;
 	my %diffinfo;
+	my $expires;
 
 	# preparing $fd and %diffinfo for git_patchset_body
 	# new style URI
@@ -2866,6 +2869,12 @@ sub git_blobdiff {
 		$hash_parent ||= $diffinfo{'from_id'};
 		$hash        ||= $diffinfo{'to_id'};
 
+		# non-textual hash id's can be cached
+		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
+		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
+			$expires = '+1d';
+		}
+
 		# open patch output
 		open $fd, "-|", $GIT, "diff-tree", '-r', '-p', '-M', '-C', $hash_parent_base, $hash_base,
 			"--", $file_name
@@ -2894,7 +2903,14 @@ sub git_blobdiff {
 			$diffinfo{'from_file'} = $hash_parent;
 			$diffinfo{'to_file'}   = $hash;
 		}
 
+		# non-textual hash id's can be cached
+		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
+		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
+			$expires = '+1d';
+		}
+
+		# open patch output
 		#open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
 		open $fd, "-|", $GIT, "diff", '-p', $hash, $hash_parent
 			or die_error(undef, "Open git-diff failed");
@@ -2904,40 +2920,67 @@ sub git_blobdiff {
 	}
 
 	# header
-	my $formats_nav =
-		$cgi->a({-href => href(action=>"blobdiff_plain",
-		                       hash=>$hash, hash_parent=>$hash_parent,
-		                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
-		                       file_name=>$file_name, file_parent=>$file_parent)},
-		        "plain");
-	git_header_html();
-	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
-	} else {
-		print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
-		print "<div class=\"title\">$hash vs $hash_parent</div>\n";
-	}
-	if (defined $file_name) {
-		git_print_page_path($file_name, "blob", $hash_base);
+	if ($format eq 'html') {
+		my $formats_nav =
+			$cgi->a({-href => href(action=>"blobdiff_plain",
+			                       hash=>$hash, hash_parent=>$hash_parent,
+			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
+			                       file_name=>$file_name, file_parent=>$file_parent)},
+			        "plain");
+		git_header_html(undef, $expires);
+		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
+			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+		} else {
+			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
+			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
+		}
+		if (defined $file_name) {
+			git_print_page_path($file_name, "blob", $hash_base);
+		} else {
+			print "<div class=\"page_path\"></div>\n";
+		}
+
+	} elsif ($format eq 'plain') {
+		print $cgi->header(
+			-type => 'text/plain',
+			-charset => 'utf-8',
+			-expires => $expires,
+			-content_disposition => qq(inline; filename="${file_name}.patch"));
+
+		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+
 	} else {
-		print "<div class=\"page_path\"></div>\n";
+		die_error(undef, "Unknown blobdiff format");
 	}
 
 	# patch
-	print "<div class=\"page_body\">\n";
+	if ($format eq 'html') {
+		print "<div class=\"page_body\">\n";
 
-	git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
-	close $fd;
+		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		close $fd;
 
-	print "</div>\n"; # class="page_body"
-	git_footer_html();
+		print "</div>\n"; # class="page_body"
+		git_footer_html();
+
+	} else {
+		while (my $line = <$fd>) {
+			$line =~ s!a/($hash|$hash_parent)!a/$diffinfo{'from_file'}!g;
+			$line =~ s!b/($hash|$hash_parent)!b/$diffinfo{'to_file'}!g;
+
+			print $line;
+
+			last if $line =~ m!^\+\+\+!;
+		}
+		local $/ = undef;
+		print <$fd>;
+		close $fd;
+	}
 }
 
 sub git_blobdiff_plain {
-	mkdir($git_temp, 0700);
-	print $cgi->header(-type => "text/plain", -charset => 'utf-8');
-	git_diff_print($hash_parent, $file_name || $hash_parent, $hash, $file_name || $hash, "plain");
+	git_blobdiff('plain');
 }
 
 sub git_commitdiff {
-- 
1.4.1.1
