From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/6] gitweb: Split git_patchset_body into separate subroutines
Date: Fri, 08 Jun 2007 13:27:42 +0200
Message-ID: <20070608112636.3594.1340.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcY3-0001xy-5l
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968178AbXFHLWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967875AbXFHLWV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:22:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:51027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967847AbXFHLWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:22:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so929823ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:22:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=G8gdwlDJVuHo1y/H9OoaesCzKNONA0+hl6I6YbDdehfx5IOdHHqW39w1hQuvjrtYlsflRCVIuD8+/yHK8irOspGN2SoO+QvPrdw+cHW1tiFxOen4R11bZFnn39udp85w0Xkqy80VJjOZWnVdWeZ5IsSX5k4woDIlXehLjCl4ONs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=VPvTQzILxvYEB94TLbEr4BlPH0lh9xyI5l0wQPmNKDTdYchmnVZ0B8+K0uZVhb01E1P/HbOPUSnzgzou1Y/hpj+1zCcUMvLlAdlWTwqlJBc6bwYlOyLKM88Q8XAwLsYYv0MjhdSqhKgd0zbOi2FUT0sASEnDThVoiQ0OM9AfqT0=
Received: by 10.82.160.2 with SMTP id i2mr5129420bue.1181301738379;
        Fri, 08 Jun 2007 04:22:18 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 35sm5257563nfu.2007.06.08.04.22.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:22:17 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BRgFj003653;
	Fri, 8 Jun 2007 13:27:42 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49466>

This commit makes git_patchset_body easier to read, and reduces level of
nesting and indent level. It adds more lines that it removes because of
extra parameter passing in subroutines, and subroutine calls in
git_patchset_body. Also because there are few added comments.


Below there are descriptions of all split-off subroutines:

Separate formatting "git diff" header into format_git_diff_header_line.
While at it fix it so it always escapes pathname. It would be even more
useful if we decide to use `--cc' for merges, and need to generate by
hand empty patches for anchors.

Separate formatting extended (git) diff header lines into
format_extended_diff_header_line. This one is copied without changes.

Separate formatting two-lines from-file/to-file diff header into
format_diff_from_to_header subroutine. While at it fix it so it always
escapes pathname. Beware calling convention: it takes _two_ lines.

Separate generating %from and %to hashes (with info used among others to
generate hyperlinks) into parse_from_to_diffinfo subroutine. This one is
copied without changes.

Separate checking if file was deleted (and among others therefore does
not have link to the result file) into is_deleted subroutine. This would
allow us to easily change the algotithm to find if file is_deleted in
the result.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perhaps only first paragraph (and signoff line) should be in the
commit message, although I think those comments are useful. 

 gitweb/gitweb.perl |  313 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 202 insertions(+), 111 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4561d4e..aee4f23 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -954,7 +954,149 @@ sub format_subject_html {
 	}
 }
 
-# format patch (diff) line (rather not to be used for diff headers)
+# format git diff header line, i.e. "diff --(git|combined|cc) ..."
+sub format_git_diff_header_line {
+	my $line = shift;
+	my $diffinfo = shift;
+	my ($from, $to) = @_;
+
+	if ($diffinfo->{'nparents'}) {
+		# combined diff
+		$line =~ s!^(diff (.*?) )"?.*$!$1!;
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
+			                 esc_path($to->{'file'}));
+		} else { # file was deleted (no href)
+			$line .= esc_path($to->{'file'});
+		}
+	} else {
+		# "ordinary" diff
+		$line =~ s!^(diff (.*?) )"?a/.*$!$1!;
+		if ($from->{'href'}) {
+			$line .= $cgi->a({-href => $from->{'href'}, -class => "path"},
+			                 'a/' . esc_path($from->{'file'}));
+		} else { # file was added (no href)
+			$line .= 'a/' . esc_path($from->{'file'});
+		}
+		$line .= ' ';
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href => $to->{'href'}, -class => "path"},
+			                 'b/' . esc_path($to->{'file'}));
+		} else { # file was deleted
+			$line .= 'b/' . esc_path($to->{'file'});
+		}
+	}
+
+	return "<div class=\"diff header\">$line</div>\n";
+}
+
+# format extended diff header line, before patch itself
+sub format_extended_diff_header_line {
+	my $line = shift;
+	my $diffinfo = shift;
+	my ($from, $to) = @_;
+
+	# match <path>
+	if ($line =~ s!^((copy|rename) from ).*$!$1! && $from->{'href'}) {
+		$line .= $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+		                       esc_path($from->{'file'}));
+	}
+	if ($line =~ s!^((copy|rename) to ).*$!$1! && $to->{'href'}) {
+		$line .= $cgi->a({-href=>$to->{'href'}, -class=>"path"},
+		                 esc_path($to->{'file'}));
+	}
+	# match single <mode>
+	if ($line =~ m/\s(\d{6})$/) {
+		$line .= '<span class="info"> (' .
+		         file_type_long($1) .
+		         ')</span>';
+	}
+	# match <hash>
+	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
+		# can match only for combined diff
+		$line = 'index ';
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			if ($from->{'href'}[$i]) {
+				$line .= $cgi->a({-href=>$from->{'href'}[$i],
+				                  -class=>"hash"},
+				                 substr($diffinfo->{'from_id'}[$i],0,7));
+			} else {
+				$line .= '0' x 7;
+			}
+			# separator
+			$line .= ',' if ($i < $diffinfo->{'nparents'} - 1);
+		}
+		$line .= '..';
+		if ($to->{'href'}) {
+			$line .= $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
+			                 substr($diffinfo->{'to_id'},0,7));
+		} else {
+			$line .= '0' x 7;
+		}
+
+	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
+		# can match only for ordinary diff
+		my ($from_link, $to_link);
+		if ($from->{'href'}) {
+			$from_link = $cgi->a({-href=>$from->{'href'}, -class=>"hash"},
+			                     substr($diffinfo->{'from_id'},0,7));
+		} else {
+			$from_link = '0' x 7;
+		}
+		if ($to->{'href'}) {
+			$to_link = $cgi->a({-href=>$to->{'href'}, -class=>"hash"},
+			                   substr($diffinfo->{'to_id'},0,7));
+		} else {
+			$to_link = '0' x 7;
+		}
+		my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
+		$line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+	}
+
+	return $line . "<br/>\n";
+}
+
+# format from-file/to-file diff header
+sub format_diff_from_to_header {
+	my ($from_line, $to_line, $diffinfo, $from, $to) = @_;
+	my $line;
+	my $result = '';
+
+	$line = $from_line;
+	#assert($line =~ m/^---/) if DEBUG;
+	# no extra formatting "^--- /dev/null"
+	if ($line =~ m!^--- "?a/!) {
+		if (!$diffinfo->{'nparents'} && # multiple 'from'
+		    $from->{'href'}) {
+			$line = '--- a/' .
+			        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+			                esc_path($from->{'file'}));
+		} else {
+			$line = '--- a/' .
+			        esc_path($from->{'file'});
+		}
+	}
+	$result .= qq!<div class="diff from_file">$line</div>\n!;
+
+	$line = $to_line;
+	#assert($line =~ m/^\+\+\+/) if DEBUG;
+	# no extra formatting for "^+++ /dev/null"
+	if ($line =~ m!^\+\+\+ "?b/!) {
+		if ($to->{'href'}) {
+			$line = '+++ b/' .
+			        $cgi->a({-href=>$to->{'href'}, -class=>"path"},
+			                esc_path($to->{'file'}));
+		} else {
+			$line = '+++ b/' .
+			        esc_path($to->{'file'});
+		}
+	}
+	$result .= qq!<div class="diff to_file">$line</div>\n!;
+
+	return $result;
+}
+
+# format patch (diff) line (not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
@@ -1680,6 +1822,48 @@ sub parse_ls_tree_line ($;%) {
 	return wantarray ? %res : \%res;
 }
 
+# generates _two_ hashes, references to which are passed as 2 and 3 argument
+sub parse_from_to_diffinfo {
+	my ($diffinfo, $from, $to, @parents) = @_;
+
+	if ($diffinfo->{'nparents'}) {
+		# combined diff
+		$from->{'file'} = [];
+		$from->{'href'} = [];
+		fill_from_file_info($diffinfo, @parents)
+			unless exists $diffinfo->{'from_file'};
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			$from->{'file'}[$i] = $diffinfo->{'from_file'}[$i] || $diffinfo->{'to_file'};
+			if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
+				$from->{'href'}[$i] = href(action=>"blob",
+				                           hash_base=>$parents[$i],
+				                           hash=>$diffinfo->{'from_id'}[$i],
+				                           file_name=>$from->{'file'}[$i]);
+			} else {
+				$from->{'href'}[$i] = undef;
+			}
+		}
+	} else {
+		$from->{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+		if ($diffinfo->{'status'} ne "A") { # not new (added) file
+			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+			                       hash=>$diffinfo->{'from_id'},
+			                       file_name=>$from->{'file'});
+		} else {
+			delete $from->{'href'};
+		}
+	}
+
+	$to->{'file'} = $diffinfo->{'to_file'} || $diffinfo->{'file'};
+	if (!is_deleted($diffinfo)) { # file exists in result
+		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
+		                     hash=>$diffinfo->{'to_id'},
+		                     file_name=>$to->{'file'});
+	} else {
+		delete $to->{'href'};
+	}
+}
+
 ## ......................................................................
 ## parse to array of hashes functions
 
@@ -2387,6 +2571,11 @@ sub from_ids_eq {
 	}
 }
 
+sub is_deleted {
+	my $diffinfo = shift;
+
+	return $diffinfo->{'to_id'} eq ('0' x 40);
+}
 
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
@@ -2444,7 +2633,7 @@ sub git_difftree_body {
 			fill_from_file_info($diff, @parents)
 				unless exists $diff->{'from_file'};
 
-			if ($diff->{'to_id'} ne ('0' x 40)) {
+			if (!is_deleted($diff)) {
 				# file exists in the result (child) commit
 				print "<td>" .
 				      $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
@@ -2765,6 +2954,8 @@ sub git_patchset_body {
 			} else {
 				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
 			}
+			# modifies %from, %to hashes
+			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
 			if ($diffinfo->{'nparents'}) {
 				# combined diff
 				$from{'file'} = [];
@@ -2794,7 +2985,7 @@ sub git_patchset_body {
 			}
 
 			$to{'file'} = $diffinfo->{'to_file'} || $diffinfo->{'file'};
-			if ($diffinfo->{'to_id'} ne ('0' x 40)) { # file exists in result
+			if (!is_deleted($diffinfo)) { # file exists in result
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
 				                   file_name=>$to{'file'});
@@ -2808,105 +2999,15 @@ sub git_patchset_body {
 
 		# print "git diff" header
 		$patch_line = shift @diff_header;
-		if ($diffinfo->{'nparents'}) {
-
-			# combined diff
-			$patch_line =~ s!^(diff (.*?) )"?.*$!$1!;
-			if ($to{'href'}) {
-				$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
-				                       esc_path($to{'file'}));
-			} else { # file was deleted
-				$patch_line .= esc_path($to{'file'});
-			}
-
-		} else {
-
-			$patch_line =~ s!^(diff (.*?) )"?a/.*$!$1!;
-			if ($from{'href'}) {
-				$patch_line .= $cgi->a({-href => $from{'href'}, -class => "path"},
-				                       'a/' . esc_path($from{'file'}));
-			} else { # file was added
-				$patch_line .= 'a/' . esc_path($from{'file'});
-			}
-			$patch_line .= ' ';
-			if ($to{'href'}) {
-				$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
-				                       'b/' . esc_path($to{'file'}));
-			} else { # file was deleted
-				$patch_line .= 'b/' . esc_path($to{'file'});
-			}
-
-		}
-		print "<div class=\"diff header\">$patch_line</div>\n";
+		print format_git_diff_header_line($patch_line, $diffinfo,
+		                                  \%from, \%to);
 
 		# print extended diff header
 		print "<div class=\"diff extended_header\">\n" if (@diff_header > 0);
 	EXTENDED_HEADER:
 		foreach $patch_line (@diff_header) {
-			# match <path>
-			if ($patch_line =~ s!^((copy|rename) from ).*$!$1! && $from{'href'}) {
-				$patch_line .= $cgi->a({-href=>$from{'href'}, -class=>"path"},
-				                       esc_path($from{'file'}));
-			}
-			if ($patch_line =~ s!^((copy|rename) to ).*$!$1! && $to{'href'}) {
-				$patch_line .= $cgi->a({-href=>$to{'href'}, -class=>"path"},
-				                       esc_path($to{'file'}));
-			}
-			# match single <mode>
-			if ($patch_line =~ m/\s(\d{6})$/) {
-				$patch_line .= '<span class="info"> (' .
-				               file_type_long($1) .
-				               ')</span>';
-			}
-			# match <hash>
-			if ($patch_line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
-				# can match only for combined diff
-				$patch_line = 'index ';
-				for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
-					if ($from{'href'}[$i]) {
-						$patch_line .= $cgi->a({-href=>$from{'href'}[$i],
-						                        -class=>"hash"},
-						                       substr($diffinfo->{'from_id'}[$i],0,7));
-					} else {
-						$patch_line .= '0' x 7;
-					}
-					# separator
-					$patch_line .= ',' if ($i < $diffinfo->{'nparents'} - 1);
-				}
-				$patch_line .= '..';
-				if ($to{'href'}) {
-					$patch_line .= $cgi->a({-href=>$to{'href'}, -class=>"hash"},
-					                       substr($diffinfo->{'to_id'},0,7));
-				} else {
-					$patch_line .= '0' x 7;
-				}
-
-			} elsif ($patch_line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
-				# can match only for ordinary diff
-				my ($from_link, $to_link);
-				if ($from{'href'}) {
-					$from_link = $cgi->a({-href=>$from{'href'}, -class=>"hash"},
-					                     substr($diffinfo->{'from_id'},0,7));
-				} else {
-					$from_link = '0' x 7;
-				}
-				if ($to{'href'}) {
-					$to_link = $cgi->a({-href=>$to{'href'}, -class=>"hash"},
-					                   substr($diffinfo->{'to_id'},0,7));
-				} else {
-					$to_link = '0' x 7;
-				}
-				#affirm {
-				#	my ($from_hash, $to_hash) =
-				#		($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/);
-				#	my ($from_id, $to_id) =
-				#		($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
-				#	($from_hash eq $from_id) && ($to_hash eq $to_id);
-				#} if DEBUG;
-				my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
-				$patch_line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
-			}
-			print $patch_line . "<br/>\n";
+			print format_extended_diff_header_line($patch_line, $diffinfo,
+			                                       \%from, \%to);
 		}
 		print "</div>\n"  if (@diff_header > 0); # class="diff extended_header"
 
@@ -2918,24 +3019,14 @@ sub git_patchset_body {
 		}
 		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
-		if (!$diffinfo->{'nparents'} && # not from-file line for combined diff
-		    $from{'href'} && $patch_line =~ m!^--- "?a/!) {
-			$patch_line = '--- a/' .
-			              $cgi->a({-href=>$from{'href'}, -class=>"path"},
-			                      esc_path($from{'file'}));
-		}
-		print "<div class=\"diff from_file\">$patch_line</div>\n";
+		#assert($patch_line eq $last_patch_line) if DEBUG;
 
 		$patch_line = <$fd>;
 		chomp $patch_line;
+		#assert($patch_line =~ m/^\+\+\+/) if DEBUG;
 
-		#assert($patch_line =~ m/^+++/) if DEBUG;
-		if ($to{'href'} && $patch_line =~ m!^\+\+\+ "?b/!) {
-			$patch_line = '+++ b/' .
-			              $cgi->a({-href=>$to{'href'}, -class=>"path"},
-			                      esc_path($to{'file'}));
-		}
-		print "<div class=\"diff to_file\">$patch_line</div>\n";
+		print format_diff_from_to_header($last_patch_line, $patch_line,
+		                                 $diffinfo, \%from, \%to);
 
 		# the patch itself
 	LINE:
