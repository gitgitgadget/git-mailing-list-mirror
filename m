X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 00:51:37 +0100
Message-ID: <200610300051.37896.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 23:52:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F0ShejQjT46KHqhS7+J0Jcg8syaYRDXdXOfa+ErU6ZYMX2neaD3bRvNUCIOayN+n+wfhkMEk8Q6ItFjAEHs5QbX9RzOdwQWw/kjely44/912z/zUMGAUR++TswmWSpHjbdQfqTuG3G8bh3zhercLiy+oy3qCWPZuvN2et62uvrk=
User-Agent: KMail/1.9.3
In-Reply-To: <200610291122.30852.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30474>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeKRL-0002Fx-S7 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 00:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030458AbWJ2Xvj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 18:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWJ2Xvj
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 18:51:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:14364 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030458AbWJ2Xvi
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 18:51:38 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1027177ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 15:51:37 -0800 (PST)
Received: by 10.67.93.6 with SMTP id v6mr3223970ugl; Sun, 29 Oct 2006
 15:51:37 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 59sm2558564ugf.2006.10.29.15.51.36; Sun, 29 Oct
 2006 15:51:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Replace "gitweb diff header" with its full sha1 of blobs and replace
it by "git diff" header and extended diff header. Change also somewhat
highlighting of diffs.

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
  explained: '<mode>' is extended to '<mode> (<file type>)'.
* <file> hyperlinking should work also when <file> is originally
  quoted. For now we present filename quoted. This needed changes to
  parse_difftree_raw_line subroutine. And doesn't work: perhaps
  unquote is broken.
* from-file/to-file two-line header lines have slightly darker color
  than removed/added lines.
* chunk header has now delicate line above for easier finding chunk
  boundary, and top margin of 1px.

WORK IN PROGRESS: might not work (and actually doesn't work correctly)
for strange filenames, i.e. filenames contaning either metacharacters
or having TAB, LF, backslash or doublequote in them.

Code should be much more clean, by the way.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |   46 +++++++++++---
 gitweb/gitweb.perl |  178 +++++++++++++++++++++++++++++++++-------------------
 2 files changed, 151 insertions(+), 73 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 83d900d..3aeceed 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -303,6 +303,33 @@ td.mode {
 	font-family: monospace;
 }
 
+
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
+div.diff.extended_header,
+div.diff.extended_header a.list {
+	color: #777777;
+}
+
+div.diff.extended_header {
+	background-color: #f6f5ee;
+	padding: 2px 0px 2px 0px;
+}
+
 div.diff a.list {
 	text-decoration: none;
 }
@@ -312,31 +339,34 @@ div.diff a.list:hover {
 }
 
 div.diff.to_file a.list,
-div.diff.to_file,
+div.diff.to_file {
+	color: #007000;
+}
+
 div.diff.add {
 	color: #008800;
 }
 
 div.diff.from_file a.list,
-div.diff.from_file,
+div.diff.from_file {
+	color: #aa0000;
+}
+
 div.diff.rem {
 	color: #cc0000;
 }
 
 div.diff.chunk_header {
 	color: #990099;
+	border: dotted #ffbbff;
+	border-width: 1px 0px 0px 0px;
+	margin-top: 1px;
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
index cbab3c9..a5a140c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1255,9 +1255,12 @@ sub parse_difftree_raw_line {
 		$res{'status'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
-			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
+			($res{'from_file_raw'}, $res{'to_file_raw'}) = split("\t", $7);
+			$res{'from_file'} = unquote($res{'from_file_raw'});
+			$res{'to_file'}   = unquote($res{'to_file_raw'});
 		} else {
-			$res{'file'} = unquote($7);
+			$res{'file_raw'} = $7;
+			$res{'file'} = unquote($res{'file_raw'});
 		}
 	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
@@ -2023,7 +2026,9 @@ sub git_patchset_body {
 	my $patch_idx = 0;
 	my $in_header = 0;
 	my $patch_found = 0;
+	my $skip_patch = 0;
 	my $diffinfo;
+	my (%from, %to);
 
 	print "<div class=\"patchset\">\n";
 
@@ -2033,6 +2038,8 @@ sub git_patchset_body {
 
 		if ($patch_line =~ m/^diff /) { # "git diff" header
 			# beginning of patch (in patchset)
+			$skip_patch = 0;
+
 			if ($patch_found) {
 				# close previous patch
 				print "</div>\n"; # class="patch"
@@ -2042,96 +2049,137 @@ sub git_patchset_body {
 			}
 			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 
+			# read and prepare patch information
 			if (ref($difftree->[$patch_idx]) eq "HASH") {
+				# pre-parsed (or generated by hand)
 				$diffinfo = $difftree->[$patch_idx];
 			} else {
 				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
 			}
+			if ($diffinfo->{'status'} ne "A") { # not new (added) file
+				$from{'name'} = $diffinfo->{'from_file_raw'} || $diffinfo->{'file_raw'};
+				 # because of "a/file" not a/"file"
+				$from{'quoted'} = ($from{'name'} =~ s/^"(.*)"$/$1/);
+
+				my $file = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+				                     hash=>$diffinfo->{'from_id'}, file_name=>$file);
+			}
+			if ($diffinfo->{'status'} ne "D") { # not deleted file
+				$to{'name'} = $diffinfo->{'to_file_raw'} || $diffinfo->{'file_raw'};
+				# because of "b/file" not b/"file"
+				$to{'quoted'} = ($to{'name'} =~ s/^"(.*)"$/$1/);
+
+				my $file = $diffinfo->{'to_file'} || $diffinfo->{'file'};
+				$to{'href'} = href(action=>"blob", hash_base=>$hash,
+				                   hash=>$diffinfo->{'to_id'}, file_name=>$file);
+			}
 			$patch_idx++;
 
 			# for now we skip empty patches
 			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) {
 				# no change, empty patch
 				$in_header = 1;
+				$skip_patch = 0;
 				next LINE;
 			}
 
-			if ($diffinfo->{'status'} eq "A") { # added
-				print "<div class=\"diff_info\">" . file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'}) . " (new)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "D") { # deleted
-				print "<div class=\"diff_info\">" . file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) . " (deleted)" .
-				      "</div>\n"; # class="diff_info"
-
-			} elsif ($diffinfo->{'status'} eq "R" || # renamed
-			         $diffinfo->{'status'} eq "C" || # copied
-			         $diffinfo->{'status'} eq "2") { # with two filenames (from git_blobdiff)
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'from_file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'to_file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
-
-			} else { # modified, mode changed, ...
-				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo->{'from_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) .
-				      " -> " .
-				      file_type($diffinfo->{'to_mode'}) . ":" .
-				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'});
-				print "</div>\n"; # class="diff_info"
+			# print "git diff" header
+			if ($from{'name'}) {
+				my $from_link = $cgi->a({-href => $from{'href'}, -class => "path"},
+				                        'a/' . esc_html($from{'name'}));
+				my ($q, $qq) = $from{'quoted'} ? ('"', '&quot;') : ('', '');
+				$patch_line =~ s|${q}a/\Q$from{'name'}\E${q}|${qq}$from_link${qq}|;
+			} else {
+				# at least one of %from and %to must be set
+				$patch_line =~ s|(["]?a/\Q$to{'name'}\E["]?)|esc_html($1)|e;
+			}
+			if ($to{'name'}) {
+				my $to_link = $cgi->a({-href => $to{'href'}, -class => "path"},
+				                      'b/' . esc_html($to{'name'}));
+				my ($q, $qq) = $to{'quoted'} ? ('"', '&quot;') : ('', '');
+				$patch_line =~ s|${q}b/\Q$to{'name'}\E${q}$|${qq}$to_link${qq}|;
+			} else {
+				# at least one of %from and %to must be set
+				$patch_line =~ s|(["]?b/\Q$from{'name'}\E["]?)$|esc_html($1)|e;
 			}
 
-			#print "<div class=\"diff extended_header\">\n";
+			print "<div class=\"diff header\">$patch_line</div>\n";
+			print "<div class=\"diff extended_header\">\n";
 			$in_header = 1;
 			next LINE;
+		} else {
+			next LINE if $skip_patch;
 		} # start of patch in patchset
 
+		if ($in_header) {
+			if ($patch_line !~ m/^---/) {
+				# match <path>
+				if ($patch_line =~ m!^(copy|rename) from ! && $from{'name'}) {
+					my $qq = $from{'quoted'} ? '&quot;' : '';
+					my $from_link = $cgi->a({-href=>$from{'href'},-class=>"list"},
+					                        esc_html($from{'name'}));
+					$patch_line =~ s!from .*$!from $qq$from_link$qq!;
+				}
+				if ($patch_line =~ m!^(copy|rename) to ! && $to{'name'}) {
+					my $qq = $to{'quoted'} ? '&quot;' : '';
+					my $to_link = $cgi->a({-href=>$to{'href'},-class=>"list"},
+					                      esc_html($to{'name'}));
+					$patch_line =~ s!to .*$!to $qq$to_link$qq!;
+				}
+				# match <mode>
+				if ($patch_line =~ m/\s(\d{6})$/) {
+					$patch_line .= '<span class="info"> (' . file_type($1) . ')</span>';
+				}
+				# match <hash>
+				if ($patch_line =~ m/^index/) {
+					my ($from_link, $to_link);
+					if ($from{'href'}) {
+						$from_link = $cgi->a({-href=>$from{'href'},-class=>"list"},
+						                     substr($diffinfo->{'from_id'},0,7));
+					} else {
+						$from_link = '0' x 7;
+					}
+					if ($to{'href'}) {
+						$to_link = $cgi->a({-href=>$to{'href'},-class=>"list"},
+						                   substr($diffinfo->{'to_id'},0,7));
+					} else {
+						$to_link = '0' x 7;
+					}
+					my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
+					$patch_line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+				}
+				print $patch_line . "<br/>\n";
 
-		if ($in_header && $patch_line =~ m/^---/) {
-			#print "</div>\n"; # class="diff extended_header"
-			$in_header = 0;
+			} else {
+				#$patch_line =~ m/^---/;
+				print "</div>\n"; # class="diff extended_header"
+				$in_header = 0;
+
+				if ($from{'name'}) {
+					my $qq = $from{'quoted'} ? '&quot;' : '';
+					my $from_link = $cgi->a({-href=>$from{'href'},-class=>"list"},
+					                        esc_html($from{'name'}));
+					$patch_line =~ s!["]?a/.*$!${qq}a/$from_link${qq}!;
+				}
+				print "<div class=\"diff from_file\">$patch_line</div>\n";
 
-			my $file = $diffinfo->{'from_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
-			$patch_line =~ s|a/.*$|a/$file|g;
-			print "<div class=\"diff from_file\">$patch_line</div>\n";
+				$patch_line = <$fd>;
+				chomp $patch_line;
 
-			$patch_line = <$fd>;
-			chomp $patch_line;
+				#$patch_line =~ m/^+++/;
+				if ($to{'name'}) {
+					my $qq = $to{'quoted'} ? '&quot;' : '';
+					my $from_link = $cgi->a({-href=>$to{'href'},-class=>"list"},
+					                        esc_html($to{'name'}));
+					$patch_line =~ s!["]?b/.*$!${qq}b/$from_link${qq}!;
+				}
+				print "<div class=\"diff to_file\">$patch_line</div>\n";
 
-			#$patch_line =~ m/^+++/;
-			$file    = $diffinfo->{'to_file'};
-			$file  ||= $diffinfo->{'file'};
-			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
-			                -class => "list"}, esc_html($file));
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
