X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/n] [take 3] gitweb: New improved patchset view
Date: Tue, 31 Oct 2006 15:22:31 +0100
Message-ID: <200610311522.32228.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 14:23:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tg43SwGykQGCq+9WwVMIZX15XWmTHXNKkUWKD1YySHIgigrg41RBTLIdBNAcRkg7GPVHqLMS2flSFQkzF4giJMSEgJuGddMX1/H/ao0/j3IVBrC+4vXZdZXuW7AvO8l9cfctOQ1lCJmohNPWpefxnSqbx/mYCwZtlUxG40DWpcs=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30583>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeuVl-0006Gu-8A for gcvg-git@gmane.org; Tue, 31 Oct
 2006 15:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422840AbWJaOWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 09:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWJaOWZ
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 09:22:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:49107 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422840AbWJaOWY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 09:22:24 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1456464ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 06:22:23 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr6177943ugl; Tue, 31 Oct 2006
 06:22:23 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 50sm4335370ugb.2006.10.31.06.22.21; Tue, 31 Oct
 2006 06:22:22 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Replace "gitweb diff header" with its full sha1 of blobs and replace
it by "git diff" header and extended diff header. Change also somewhat
highlighting of diffs.

Added `file_type_long' subroutine to convert file mode in octal to
file type description (only for file modes which used by git).

Changes:
* "gitweb diff header" which looked for example like below:
    file:_<sha1 before>_ -> file:_<sha1 after>_
  where 'file' is file type and '<sha1>' is full sha1 of blob is
  changed to
    diff --git _a/<file before>_ _b/<file after>_
  In both cases links are visible and use default link style. If file
  is added, a/<file> is not hyperlinked, if file is deleted, b/<file>
  is not hyperlinked.
* there is added "extended diff header", with <path> and <hash>
  hyperlinked (and <hash> shortened to 7 characters), and <mode>
  explained: '<mode>' is extended to '<mode> (<file type description>)',
  where added text is slightly lighter to easy distinguish that it
  was added (and it is difference from git-diff output).
* from-file/to-file two-line header lines have slightly darker color
  than removed/added lines.
* chunk header has now delicate line above for easier finding chunk
  boundary, and top margin of 2px, both barely visible.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It still does not output empty patches. This is to be adressed
in later patch.

As usual, you can see it at work at my web page
  http://roke (.) dyndns (.) info/cgi-bin/gitweb/gitweb.cgi

Comments?

 gitweb/gitweb.css  |   66 +++++++++++++++----
 gitweb/gitweb.perl |  187 
++++++++++++++++++++++++++++++++++------------------
 2 files changed, 176 insertions(+), 77 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 0eda982..87dbc52 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -291,40 +291,82 @@ td.mode {
 	font-family: monospace;
 }
 
-div.diff a.list {
+/* styling of diffs (patchsets): commitdiff and blobdiff views */
+div.diff.header,
+div.diff.extended_header {
+	white-space: normal;
+}
+
+div.diff.header {
+	font-weight: bold;
+
+	background-color: #edece6;
+
+	margin-top: 4px;
+	padding: 4px 0px 2px 0px;
+	border: solid #d9d8d1;
+	border-width: 1px 0px 1px 0px;
+}
+
+div.diff.header a.path {
+	text-decoration: underline;
+}
+
+div.diff.extended_header,
+div.diff.extended_header a.path,
+div.diff.extended_header a.hash {
+	color: #777777;
+}
+
+div.diff.extended_header .info {
+	color: #b0b0b0;
+}
+
+div.diff.extended_header {
+	background-color: #f6f5ee;
+	padding: 2px 0px 2px 0px;
+}
+
+div.diff a.path,
+div.diff a.hash {
 	text-decoration: none;
 }
 
-div.diff a.list:hover {
+div.diff a.path:hover,
+div.diff a.hash:hover {
 	text-decoration: underline;
 }
 
-div.diff.to_file a.list,
-div.diff.to_file,
+div.diff.to_file a.path,
+div.diff.to_file {
+	color: #007000;
+}
+
 div.diff.add {
 	color: #008800;
 }
 
-div.diff.from_file a.list,
-div.diff.from_file,
+div.diff.from_file a.path,
+div.diff.from_file {
+	color: #aa0000;
+}
+
 div.diff.rem {
 	color: #cc0000;
 }
 
 div.diff.chunk_header {
 	color: #990099;
+
+	border: dotted #ffe0ff;
+	border-width: 1px 0px 0px 0px;
+	margin-top: 2px;
 }
 
 div.diff.incomplete {
 	color: #cccccc;
 }
 
-div.diff_info {
-	font-family: monospace;
-	color: #000099;
-	background-color: #edece6;
-	font-style: italic;
-}
 
 div.index_include {
 	border: solid #d9d8d1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4554067..c22fcc5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -732,6 +732,32 @@ sub file_type {
 	}
 }
 
+# convert file mode in octal to file type description string
+sub file_type_long {
+	my $mode = shift;
+
+	if ($mode !~ m/^[0-7]+$/) {
+		return $mode;
+	} else {
+		$mode = oct $mode;
+	}
+
+	if (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		if ($mode & S_IXUSR) {
+			return "executable";
+		} else {
+			return "file";
+		};
+	} else {
+		return "unknown";
+	}
+}
+
+
 ## 
----------------------------------------------------------------------
 ## functions returning short HTML fragments, or transforming HTML 
fragments
 ## which don't beling to other sections
@@ -2055,7 +2081,9 @@ sub git_patchset_body {
 	my $patch_idx = 0;
 	my $in_header = 0;
 	my $patch_found = 0;
+	my $skip_patch = 0;
 	my $diffinfo;
+	my (%from, %to);
 
 	print "<div class=\"patchset\">\n";
 
@@ -2065,6 +2093,8 @@ sub git_patchset_body {
 
 		if ($patch_line =~ m/^diff /) { # "git diff" header
 			# beginning of patch (in patchset)
+			$skip_patch = 0;
+
 			if ($patch_found) {
 				# close previous patch
 				print "</div>\n"; # class="patch"
@@ -2074,96 +2104,123 @@ sub git_patchset_body {
 			}
 			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 
+			# read and prepare patch information
 			if (ref($difftree->[$patch_idx]) eq "HASH") {
+				# pre-parsed (or generated by hand)
 				$diffinfo = $difftree->[$patch_idx];
 			} else {
 				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
 			}
+			$from{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+			$to{'file'}   = $diffinfo->{'to_file'}   || $diffinfo->{'file'};
+			if ($diffinfo->{'status'} ne "A") { # not new (added) file
+				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+				                     hash=>$diffinfo->{'from_id'},
+				                     file_name=>$from{'file'});
+			}
+			if ($diffinfo->{'status'} ne "D") { # not deleted file
+				$to{'href'} = href(action=>"blob", hash_base=>$hash,
+				                   hash=>$diffinfo->{'to_id'},
+				                   file_name=>$to{'file'});
+			}
 			$patch_idx++;
 
-			# for now, no extended header, hence we skip empty patches
-			# companion to	next LINE if $in_header;
+			# for now we skip empty patches
 			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) { # no change
 				$in_header = 1;
+				$skip_patch = 0;
 				next LINE;
 			}
 
-			if ($diffinfo->{'status'} eq "A") { # added
-				print "<div class=\"diff_info\">" . 
file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, 
file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'}) . " (new)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "D") { # deleted
-				print "<div class=\"diff_info\">" . 
file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", 
hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, 
file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) . " (deleted)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "R" || # renamed
-			         $diffinfo->{'status'} eq "C" || # copied
-			         $diffinfo->{'status'} eq "2") { # with two filenames (from 
git_blobdiff)
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", 
hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, 
file_name=>$diffinfo->{'from_file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, 
file_name=>$diffinfo->{'to_file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
-
-			} else { # modified, mode changed, ...
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", 
hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, 
file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, 
file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
+			# print "git diff" header
+			$patch_line =~ s!^(diff (.*?) )a/.*$!$1!;
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
 			}
 
-			#print "<div class=\"diff extended_header\">\n";
+			print "<div class=\"diff header\">$patch_line</div>\n";
+			print "<div class=\"diff extended_header\">\n";
 			$in_header = 1;
 			next LINE;
+		} else {
+			# actual skipping of empty patches
+			next LINE if $skip_patch;
 		} # start of patch in patchset
 
+		if ($in_header) {
+			if ($patch_line !~ m/^---/) {
+				# match <path>
+				if ($patch_line =~ s!^((copy|rename) from ).*$!$1! && 
$from{'href'}) {
+					$patch_line .= $cgi->a({-href=>$from{'href'}, -class=>"path"},
+					                        esc_path($from{'file'}));
+				}
+				if ($patch_line =~ s!^((copy|rename) to ).*$!$1! && $to{'href'}) {
+					$patch_line = $cgi->a({-href=>$to{'href'}, -class=>"path"},
+					                      esc_path($to{'file'}));
+				}
+				# match <mode>
+				if ($patch_line =~ m/\s(\d{6})$/) {
+					$patch_line .= '<span class="info"> (' .
+					               file_type_long($1) .
+					               ')</span>';
+				}
+				# match <hash>
+				if ($patch_line =~ m/^index/) {
+					my ($from_link, $to_link);
+					if ($from{'href'}) {
+						$from_link = $cgi->a({-href=>$from{'href'}, -class=>"hash"},
+						                     substr($diffinfo->{'from_id'},0,7));
+					} else {
+						$from_link = '0' x 7;
+					}
+					if ($to{'href'}) {
+						$to_link = $cgi->a({-href=>$to{'href'}, -class=>"hash"},
+						                   substr($diffinfo->{'to_id'},0,7));
+					} else {
+						$to_link = '0' x 7;
+					}
+					my ($from_id, $to_id) = ($diffinfo->{'from_id'}, 
$diffinfo->{'to_id'});
+					$patch_line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+				}
+				print $patch_line . "<br/>\n";
 
-		if ($in_header && $patch_line =~ m/^---/) {
-			#print "</div>\n"; # class="diff extended_header"
-			$in_header = 0;
+			} else {
+				#$in_header && $patch_line =~ m/^---/;
+				print "</div>\n"; # class="diff extended_header"
+				$in_header = 0;
+
+				if ($from{'href'}) {
+					$patch_line = '--- a/' .
+					              $cgi->a({-href=>$from{'href'}, -class=>"path"},
+					                      esc_path($from{'file'}));
+				}
+				print "<div class=\"diff from_file\">$patch_line</div>\n";
 
-			my $file = $diffinfo->{'from_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", 
hash_base=>$hash_parent,
-			                               hash=>$diffinfo->{'from_id'}, 
file_name=>$file),
-			                -class => "list"}, esc_path($file));
-			$patch_line =~ s|a/.*$|a/$file|g;
-			print "<div class=\"diff from_file\">$patch_line</div>\n";
+				$patch_line = <$fd>;
+				chomp $patch_line;
 
-			$patch_line = <$fd>;
-			chomp $patch_line;
+				#$patch_line =~ m/^+++/;
+				if ($to{'href'}) {
+					$patch_line = '+++ b/' .
+					              $cgi->a({-href=>$to{'href'}, -class=>"path"},
+					                      esc_html($to{'file'}));
+				}
+				print "<div class=\"diff to_file\">$patch_line</div>\n";
 
-			#$patch_line =~ m/^+++/;
-			$file    = $diffinfo->{'to_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                               hash=>$diffinfo->{'to_id'}, 
file_name=>$file),
-			                -class => "list"}, esc_path($file));
-			$patch_line =~ s|b/.*|b/$file|g;
-			print "<div class=\"diff to_file\">$patch_line</div>\n";
+			}
 
 			next LINE;
 		}
-		next LINE if $in_header;
 
 		print format_diff_line($patch_line);
 	}
-- 
1.4.3.3
