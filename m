From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/6] gitweb: Add combined diff support to git_patchset_body
Date: Mon,  7 May 2007 01:10:05 +0200
Message-ID: <11784930121052-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpnf-00082c-Qi
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXEFXFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbXEFXFv
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:18946 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXEFXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:49 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1374488nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KHM970jQonPpqBshSRkvrsp+92F6LYDoxB4wkl16+NoxMrNihFd/xJpDSFeKvDEabphNkWfU9pU4XCGGXmTMmvbwN/etC/ubD84+jIiYRd5cQ8PSZJuoDw4EnCcsQpu3BFHQuBGefRyUXFv0v6QssArI6VhgR6CFG1he0LddoAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OfmFV3jwnwZoedI+dT4/Y0Ol97sexXYCPBa2Xkaj2eVEUglJ6NoGsQ4nja685lF0Tw9tk5FuOazO6lN1DflhQkX0u4nHvqTHok24ouC94/3EYG67rXmK0lpdD3DSTRaJfCFzX7lyOqBz4p28W8wciTRlUVyOInGhmWbq7DiXU/M=
Received: by 10.65.240.17 with SMTP id s17mr8850107qbr.1178492748474;
        Sun, 06 May 2007 16:05:48 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e13sm4770849qba.2007.05.06.16.05.45;
        Sun, 06 May 2007 16:05:47 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NACiG015916;
	Mon, 7 May 2007 01:10:12 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NACvQ015915;
	Mon, 7 May 2007 01:10:12 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46388>

Calling convention for combined diff similar to the one for
git_difftree_body subroutine: difftree info (first parameter) must be
result of calling git-diff-tree with -c/--cc option, and all parents
of a commit must be passed as last parameters. See also description in
  "gitweb: Add combined diff support to git_difftree_body"

This ability is not used yet.

Generating "src" file name for renames in combined diff was separated
into fill_from_file_info subroutine; git_difftree_body was modified to
use it. Currently git_difftree_body and git_patchset_body fills this
info separately.

The from-file line in two-line from-file/to-file header is not
hyperlinked: there can be more than one "from"/"src" file. This
differs from HTML output of ordinary (not combined) diff.

format_diff_line subroutine needs extra $from/$to parameters to format
combined diff patch line correctly.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Currently the following extended git diff header line in combined diff

	new file mode <mode>

gets its <mode> (filetype) explained like for appropriate extended
header lines for non-combined (ordinary) diff

	old mode <mode>
	new mode <mode>
	deleted file mode <mode>
	new file mode <mode>
	index <hash>..<hash> <mode>

while similar line

	deleted file mode <mode>,<mode>

does not get <mode> explained. Perhaps we should remove this addition,
or make explanation using tooltip (and perhaps <abbr> HTML element).

 gitweb/gitweb.perl |  221 ++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 181 insertions(+), 40 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c6a2fef..53ae0b8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -897,19 +897,34 @@ sub format_subject_html {
 sub format_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
-	my $char = substr($line, 0, 1);
 	my $diff_class = "";
 
 	chomp $line;
 
-	if ($char eq '+') {
-		$diff_class = " add";
-	} elsif ($char eq "-") {
-		$diff_class = " rem";
-	} elsif ($char eq "@") {
-		$diff_class = " chunk_header";
-	} elsif ($char eq "\\") {
-		$diff_class = " incomplete";
+	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
+		# combined diff
+		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
+		if ($line =~ m/^\@{3}/) {
+			$diff_class = " chunk_header";
+		} elsif ($line =~ m/^\\/) {
+			$diff_class = " incomplete";
+		} elsif ($prefix =~ tr/+/+/) {
+			$diff_class = " add";
+		} elsif ($prefix =~ tr/-/-/) {
+			$diff_class = " rem";
+		}
+	} else {
+		# assume ordinary diff
+		my $char = substr($line, 0, 1);
+		if ($char eq '+') {
+			$diff_class = " add";
+		} elsif ($char eq '-') {
+			$diff_class = " rem";
+		} elsif ($char eq '@') {
+			$diff_class = " chunk_header";
+		} elsif ($char eq "\\") {
+			$diff_class = " incomplete";
+		}
 	}
 	$line = untabify($line);
 	if ($from && $to && $line =~ m/^\@{2} /) {
@@ -930,6 +945,39 @@ sub format_diff_line {
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
 		return "<div class=\"diff$diff_class\">$line</div>\n";
+	} elsif ($from && $to && $line =~ m/^\@{3}/) {
+		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
+		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
+
+		@from_text = split(' ', $ranges);
+		for (my $i = 0; $i < @from_text; ++$i) {
+			($from_start[$i], $from_nlines[$i]) =
+				(split(',', substr($from_text[$i], 1)), 0);
+		}
+
+		$to_text   = pop @from_text;
+		$to_start  = pop @from_start;
+		$to_nlines = pop @from_nlines;
+
+		$line = "<span class=\"chunk_info\">$prefix ";
+		for (my $i = 0; $i < @from_text; ++$i) {
+			if ($from->{'href'}[$i]) {
+				$line .= $cgi->a({-href=>"$from->{'href'}[$i]#l$from_start[$i]",
+				                  -class=>"list"}, $from_text[$i]);
+			} else {
+				$line .= $from_text[$i];
+			}
+			$line .= " ";
+		}
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href=>"$to->{'href'}#l$to_start",
+			                  -class=>"list"}, $to_text);
+		} else {
+			$line .= $to_text;
+		}
+		$line .= " $prefix</span>" .
+		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		return "<div class=\"diff$diff_class\">$line</div>\n";
 	}
 	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
@@ -2233,6 +2281,39 @@ sub git_print_tree_entry {
 ## ......................................................................
 ## functions printing large fragments of HTML
 
+sub fill_from_file_info {
+	my ($diff, @parents) = @_;
+
+	$diff->{'from_file'} = [ ];
+	$diff->{'from_file'}[$diff->{'nparents'} - 1] = undef;
+	for (my $i = 0; $i < $diff->{'nparents'}; $i++) {
+		if ($diff->{'status'}[$i] eq 'R' ||
+		    $diff->{'status'}[$i] eq 'C') {
+			$diff->{'from_file'}[$i] =
+				git_get_path_by_hash($parents[$i], $diff->{'from_id'}[$i]);
+		}
+	}
+
+	return $diff;
+}
+
+# parameters can be strings, or references to arrays of strings
+sub from_ids_eq {
+	my ($a, $b) = @_;
+
+	if (ref($a) eq "ARRAY" && ref($b) eq "ARRAY" && @$a == @$b) {
+		for (my $i = 0; $i < @$a; ++$i) {
+			return 0 unless ($a->[$i] eq $b->[$i]);
+		}
+		return 1;
+	} elsif (!ref($a) && !ref($b)) {
+		return $a eq $b;
+	} else {
+		return 0;
+	}
+}
+
+
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
@@ -2260,6 +2341,8 @@ sub git_difftree_body {
 
 		if (exists $diff{'nparents'}) { # combined diff
 
+			fill_from_file_info(\%diff, @parents);
+
 			if ($diff{'to_id'} ne ('0' x 40)) {
 				# file exists in the result (child) commit
 				print "<td>" .
@@ -2288,16 +2371,12 @@ sub git_difftree_body {
 			for (my $i = 0; $i < $diff{'nparents'}; $i++) {
 				my $hash_parent = $parents[$i];
 				my $from_hash = $diff{'from_id'}[$i];
-				my $from_path = undef;
+				my $from_path = $diff{'from_file'}[$i];
 				my $status = $diff{'status'}[$i];
 
 				$has_history ||= ($status ne 'A');
 				$not_deleted ||= ($status ne 'D');
 
-				if ($status eq 'R' || $status eq 'C') {
-					$from_path = git_get_path_by_hash($hash_parent, $from_hash);
-				}
-
 				if ($status eq 'A') {
 					print "<td  class=\"link\" align=\"right\"> | </td>\n";
 				} elsif ($status eq 'D') {
@@ -2517,7 +2596,8 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, $hash_parent) = @_;
+	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($hash_parent) = $hash_parents[0];
 
 	my $patch_idx = 0;
 	my $patch_number = 0;
@@ -2555,6 +2635,9 @@ sub git_patchset_body {
 			if ($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
 				$from_id = $1;
 				$to_id   = $2;
+			} elsif ($patch_line =~ m/^index ((?:[0-9a-fA-F]{40},)+[0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
+				$from_id = [ split(',', $1) ];
+				$to_id   = $2;
 			}
 
 			push @diff_header, $patch_line;
@@ -2564,8 +2647,8 @@ sub git_patchset_body {
 		# check if current patch belong to current raw line
 		# and parse raw git-diff line if needed
 		if (defined $diffinfo &&
-		    $diffinfo->{'from_id'} eq $from_id &&
-		    $diffinfo->{'to_id'}   eq $to_id) {
+		    from_ids_eq($diffinfo->{'from_id'}, $from_id) &&
+		    $diffinfo->{'to_id'} eq $to_id) {
 			# this is split patch
 			print "<div class=\"patch cont\">\n";
 		} else {
@@ -2579,15 +2662,34 @@ sub git_patchset_body {
 			} else {
 				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
 			}
-			$from{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
-			$to{'file'}   = $diffinfo->{'to_file'}   || $diffinfo->{'file'};
-			if ($diffinfo->{'status'} ne "A") { # not new (added) file
-				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
-				                     hash=>$diffinfo->{'from_id'},
-				                     file_name=>$from{'file'});
+			if ($diffinfo->{'nparents'}) {
+				# combined diff
+				$from{'file'} = [];
+				$from{'href'} = [];
+				fill_from_file_info($diffinfo, @hash_parents)
+					unless exists $diffinfo->{'from_file'};
+				for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+					$from{'file'}[$i] = $diffinfo->{'from_file'}[$i] || $diffinfo->{'to_file'};
+					if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
+						$from{'href'}[$i] = href(action=>"blob",
+						                         hash_base=>$hash_parents[$i],
+						                         hash=>$diffinfo->{'from_id'}[$i],
+						                         file_name=>$from{'file'}[$i]);
+					} else {
+						$from{'href'}[$i] = undef;
+					}
+				}
 			} else {
-				delete $from{'href'};
+				$from{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+				if ($diffinfo->{'status'} ne "A") { # not new (added) file
+					$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+					                     hash=>$diffinfo->{'from_id'},
+					                     file_name=>$from{'file'});
+				} else {
+					delete $from{'href'};
+				}
 			}
+			$to{'file'} = $diffinfo->{'to_file'} || $diffinfo->{'file'};
 			if ($diffinfo->{'status'} ne "D") { # not deleted file
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
@@ -2602,19 +2704,34 @@ sub git_patchset_body {
 
 		# print "git diff" header
 		$patch_line = shift @diff_header;
-		$patch_line =~ s!^(diff (.*?) )"?a/.*$!$1!;
-		if ($from{'href'}) {
-			$patch_line .= $cgi->a({-href => $from{'href'}, -class => "path"},
-			                       'a/' . esc_path($from{'file'}));
-		} else { # file was added
-			$patch_line .= 'a/' . esc_path($from{'file'});
-		}
-		$patch_line .= ' ';
-		if ($to{'href'}) {
-			$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
-			                       'b/' . esc_path($to{'file'}));
-		} else { # file was deleted
-			$patch_line .= 'b/' . esc_path($to{'file'});
+		if ($diffinfo->{'nparents'}) {
+
+			# combined diff
+			$patch_line =~ s!^(diff (.*?) )"?.*$!$1!;
+			if ($to{'href'}) {
+				$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
+				                       esc_path($to{'file'}));
+			} else { # file was deleted
+				$patch_line .= esc_path($to{'file'});
+			}
+
+		} else {
+
+			$patch_line =~ s!^(diff (.*?) )"?a/.*$!$1!;
+			if ($from{'href'}) {
+				$patch_line .= $cgi->a({-href => $from{'href'}, -class => "path"},
+				                       'a/' . esc_path($from{'file'}));
+			} else { # file was added
+				$patch_line .= 'a/' . esc_path($from{'file'});
+			}
+			$patch_line .= ' ';
+			if ($to{'href'}) {
+				$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
+				                       'b/' . esc_path($to{'file'}));
+			} else { # file was deleted
+				$patch_line .= 'b/' . esc_path($to{'file'});
+			}
+
 		}
 		print "<div class=\"diff header\">$patch_line</div>\n";
 
@@ -2631,14 +2748,37 @@ sub git_patchset_body {
 				$patch_line .= $cgi->a({-href=>$to{'href'}, -class=>"path"},
 				                       esc_path($to{'file'}));
 			}
-			# match <mode>
+			# match single <mode>
 			if ($patch_line =~ m/\s(\d{6})$/) {
 				$patch_line .= '<span class="info"> (' .
 				               file_type_long($1) .
 				               ')</span>';
 			}
 			# match <hash>
-			if ($patch_line =~ m/^index/) {
+			if ($patch_line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
+				# can match only for combined diff
+				$patch_line = 'index ';
+				for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+					if ($from{'href'}[$i]) {
+						$patch_line .= $cgi->a({-href=>$from{'href'}[$i],
+						                        -class=>"hash"},
+						                       substr($diffinfo->{'from_id'}[$i],0,7));
+					} else {
+						$patch_line .= '0' x 7;
+					}
+					# separator
+					$patch_line .= ',' if ($i < $diffinfo->{'nparents'} - 1);
+				}
+				$patch_line .= '..';
+				if ($to{'href'}) {
+					$patch_line .= $cgi->a({-href=>$to{'href'}, -class=>"hash"},
+					                       substr($diffinfo->{'to_id'},0,7));
+				} else {
+					$patch_line .= '0' x 7;
+				}
+
+			} elsif ($patch_line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
+				# can match only for ordinary diff
 				my ($from_link, $to_link);
 				if ($from{'href'}) {
 					$from_link = $cgi->a({-href=>$from{'href'}, -class=>"hash"},
@@ -2674,7 +2814,8 @@ sub git_patchset_body {
 		}
 		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
-		if ($from{'href'} && $patch_line =~ m!^--- "?a/!) {
+		if (!$diffinfo->{'nparents'} && # not from-file line for combined diff
+		    $from{'href'} && $patch_line =~ m!^--- "?a/!) {
 			$patch_line = '--- a/' .
 			              $cgi->a({-href=>$from{'href'}, -class=>"path"},
 			                      esc_path($from{'file'}));
-- 
1.5.1.3
