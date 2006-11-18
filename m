X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Buffer diff header to deal with split patches + git_patchset_body refactoring
Date: Sat, 18 Nov 2006 23:35:39 +0100
Message-ID: <1163889344537-git-send-email-jnareb@gmail.com>
References: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:33 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GIL4GBBqM4uI0G6emIW9PCgEptuKoTONCZcUwt5gSASIoix5rtFtRjjJuVjBQyq75J0ldwPtkNIrWX57BaJNmbPUFKQ82wxXrGNkLh+wa17es2dUsnlmLjPUNGLito3eNvExp4Xwd4AyGOpbXbyPPPrMp2EpEmqDnLVBEbxZIzw=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <1163889342877-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31804>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYlZ-0001jk-98 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755281AbWKRWeW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbWKRWeW
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:5395 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755272AbWKRWeU
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:20 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953026ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:19 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr3566356ugg.1163889259495; Sat, 18
 Nov 2006 14:34:19 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 54sm6066456ugp.2006.11.18.14.34.18; Sat, 18 Nov 2006 14:34:19 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZiIS015351; Sat, 18 Nov 2006 23:35:44 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZiIM015350; Sat, 18 Nov 2006 23:35:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There are some cases when one line from "raw" git-diff output (raw format)
corresponds to more than one patch in the patchset git-diff output. To deal
with this buffer git diff header and extended diff header (everything up to
actual patch) to check from information from "index <hash>..<hash>" extended
header line if the patch corresponds to the same or next difftree raw line.

This could also be used to gather information needed for hyperlinking, and
used for printing gitweb quoted filenames, from extended diff header instead
of raw git-diff output.

While at it, refactor git_patchset_body subroutine from the event-driven,
AWK-like state-machine parsing to sequential parsing: for each patch
parse (and output) git diff header, parse extended diff header, parse two-line
from-file/to-file diff header, parse patch itself; patch ends with the end
of input [file] or the line matching m/^diff /.

For better understanding the code, there were added assertions in the
comments a la Carp::Assert module. Just in case there is commented out code
dealing with unexpected end of input (should not happen, hence commented
out).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
While starting to write buffering part of this patch I have realized
that git_patchset_body needs refactoring. I think it is now much more
readable, at least for people who know the patch format.

 gitweb/gitweb.perl |  235 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 136 insertions(+), 99 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2482fe..bf58c3b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2202,31 +2202,56 @@ sub git_patchset_body {
 	my ($fd, $difftree, $hash, $hash_parent) = @_;
 
 	my $patch_idx = 0;
-	my $in_header = 0;
-	my $patch_found = 0;
+	my $patch_line;
 	my $diffinfo;
 	my (%from, %to);
+	my ($from_id, $to_id);
 
 	print "<div class=\"patchset\">\n";
 
-	LINE:
-	while (my $patch_line = <$fd>) {
+	# skip to first patch
+	while ($patch_line = <$fd>) {
 		chomp $patch_line;
 
-		if ($patch_line =~ m/^diff /) { # "git diff" header
-			# beginning of patch (in patchset)
-			if ($patch_found) {
-				# close extended header for previous empty patch
-				if ($in_header) {
-					print "</div>\n" # class="diff extended_header"
-				}
-				# close previous patch
-				print "</div>\n"; # class="patch"
-			} else {
-				# first patch in patchset
-				$patch_found = 1;
+		last if ($patch_line =~ m/^diff /);
+	}
+
+ PATCH:
+	while ($patch_line) {
+		my @diff_header;
+
+		# git diff header
+		#assert($patch_line =~ m/^diff /) if DEBUG;
+		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
+		push @diff_header, $patch_line;
+
+		# extended diff header
+	EXTENDED_HEADER:
+		while ($patch_line = <$fd>) {
+			chomp $patch_line;
+
+			last EXTENDED_HEADER if ($patch_line =~ m/^--- /);
+
+			if ($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
+				$from_id = $1;
+				$to_id   = $2;
 			}
-			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
+
+			push @diff_header, $patch_line;
+		}
+		#last PATCH unless $patch_line;
+		my $last_patch_line = $patch_line;
+
+		# check if current patch belong to current raw line
+		# and parse raw git-diff line if needed
+		if (defined $diffinfo &&
+		    $diffinfo->{'from_id'} eq $from_id &&
+		    $diffinfo->{'to_id'}   eq $to_id) {
+			# this is split patch
+			print "<div class=\"patch cont\">\n";
+		} else {
+			# advance raw git-diff output if needed
+			$patch_idx++ if defined $diffinfo;
 
 			# read and prepare patch information
 			if (ref($difftree->[$patch_idx]) eq "HASH") {
@@ -2247,100 +2272,112 @@ sub git_patchset_body {
 				                   hash=>$diffinfo->{'to_id'},
 				                   file_name=>$to{'file'});
 			}
-			$patch_idx++;
-
-			# print "git diff" header
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
-			print "<div class=\"diff header\">$patch_line</div>\n";
-			print "<div class=\"diff extended_header\">\n";
-			$in_header = 1;
-			next LINE;
+			# this is first patch for raw difftree line with $patch_idx index
+			# we index @$difftree array from 0, but number patches from 1
+			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 		}
 
-		if ($in_header) {
-			if ($patch_line !~ m/^---/) {
-				# match <path>
-				if ($patch_line =~ s!^((copy|rename) from ).*$!$1! && $from{'href'}) {
-					$patch_line .= $cgi->a({-href=>$from{'href'}, -class=>"path"},
-					                        esc_path($from{'file'}));
-				}
-				if ($patch_line =~ s!^((copy|rename) to ).*$!$1! && $to{'href'}) {
-					$patch_line = $cgi->a({-href=>$to{'href'}, -class=>"path"},
-					                      esc_path($to{'file'}));
-				}
-				# match <mode>
-				if ($patch_line =~ m/\s(\d{6})$/) {
-					$patch_line .= '<span class="info"> (' .
-					               file_type_long($1) .
-					               ')</span>';
+		# print "git diff" header
+		$patch_line = shift @diff_header;
+		$patch_line =~ s!^(diff (.*?) )"?a/.*$!$1!;
+		if ($from{'href'}) {
+			$patch_line .= $cgi->a({-href => $from{'href'}, -class => "path"},
+			                       'a/' . esc_path($from{'file'}));
+		} else { # file was added
+			$patch_line .= 'a/' . esc_path($from{'file'});
+		}
+		$patch_line .= ' ';
+		if ($to{'href'}) {
+			$patch_line .= $cgi->a({-href => $to{'href'}, -class => "path"},
+			                       'b/' . esc_path($to{'file'}));
+		} else { # file was deleted
+			$patch_line .= 'b/' . esc_path($to{'file'});
+		}
+		print "<div class=\"diff header\">$patch_line</div>\n";
+
+		# print extended diff header
+		print "<div class=\"diff extended_header\">\n" if (@diff_header > 0);
+	EXTENDED_HEADER:
+		foreach $patch_line (@diff_header) {
+			# match <path>
+			if ($patch_line =~ s!^((copy|rename) from ).*$!$1! && $from{'href'}) {
+				$patch_line .= $cgi->a({-href=>$from{'href'}, -class=>"path"},
+				                        esc_path($from{'file'}));
+			}
+			if ($patch_line =~ s!^((copy|rename) to ).*$!$1! && $to{'href'}) {
+				$patch_line = $cgi->a({-href=>$to{'href'}, -class=>"path"},
+				                      esc_path($to{'file'}));
+			}
+			# match <mode>
+			if ($patch_line =~ m/\s(\d{6})$/) {
+				$patch_line .= '<span class="info"> (' .
+				               file_type_long($1) .
+				               ')</span>';
+			}
+			# match <hash>
+			if ($patch_line =~ m/^index/) {
+				my ($from_link, $to_link);
+				if ($from{'href'}) {
+					$from_link = $cgi->a({-href=>$from{'href'}, -class=>"hash"},
+					                     substr($diffinfo->{'from_id'},0,7));
+				} else {
+					$from_link = '0' x 7;
 				}
-				# match <hash>
-				if ($patch_line =~ m/^index/) {
-					my ($from_link, $to_link);
-					if ($from{'href'}) {
-						$from_link = $cgi->a({-href=>$from{'href'}, -class=>"hash"},
-						                     substr($diffinfo->{'from_id'},0,7));
-					} else {
-						$from_link = '0' x 7;
-					}
-					if ($to{'href'}) {
-						$to_link = $cgi->a({-href=>$to{'href'}, -class=>"hash"},
-						                   substr($diffinfo->{'to_id'},0,7));
-					} else {
-						$to_link = '0' x 7;
-					}
-					my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
-					$patch_line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+				if ($to{'href'}) {
+					$to_link = $cgi->a({-href=>$to{'href'}, -class=>"hash"},
+					                   substr($diffinfo->{'to_id'},0,7));
+				} else {
+					$to_link = '0' x 7;
 				}
-				print $patch_line . "<br/>\n";
-
-			} else {
-				#$in_header && $patch_line =~ m/^---/;
-				print "</div>\n"; # class="diff extended_header"
-				$in_header = 0;
+				#affirm {
+				#	my ($from_hash, $to_hash) =
+				#		($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/);
+				#	my ($from_id, $to_id) =
+				#		($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
+				#	($from_hash eq $from_id) && ($to_hash eq $to_id);
+				#} if DEBUG;
+				my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
+				$patch_line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
+			}
+			print $patch_line . "<br/>\n";
+		}
+		print "</div>\n"  if (@diff_header > 0); # class="diff extended_header"
+
+		# from-file/to-file diff header
+		$patch_line = $last_patch_line;
+		#assert($patch_line =~ m/^---/) if DEBUG;
+		if ($from{'href'}) {
+			$patch_line = '--- a/' .
+			              $cgi->a({-href=>$from{'href'}, -class=>"path"},
+			                      esc_path($from{'file'}));
+		}
+		print "<div class=\"diff from_file\">$patch_line</div>\n";
 
-				if ($from{'href'}) {
-					$patch_line = '--- a/' .
-					              $cgi->a({-href=>$from{'href'}, -class=>"path"},
-					                      esc_path($from{'file'}));
-				}
-				print "<div class=\"diff from_file\">$patch_line</div>\n";
+		$patch_line = <$fd>;
+		#last PATCH unless $patch_line;
+		chomp $patch_line;
 
-				$patch_line = <$fd>;
-				chomp $patch_line;
+		#assert($patch_line =~ m/^+++/) if DEBUG;
+		if ($to{'href'}) {
+			$patch_line = '+++ b/' .
+			              $cgi->a({-href=>$to{'href'}, -class=>"path"},
+			                      esc_path($to{'file'}));
+		}
+		print "<div class=\"diff to_file\">$patch_line</div>\n";
 
-				#$patch_line =~ m/^+++/;
-				if ($to{'href'}) {
-					$patch_line = '+++ b/' .
-					              $cgi->a({-href=>$to{'href'}, -class=>"path"},
-					                      esc_path($to{'file'}));
-				}
-				print "<div class=\"diff to_file\">$patch_line</div>\n";
+		# the patch itself
+	LINE:
+		while ($patch_line = <$fd>) {
+			chomp $patch_line;
 
-			}
+			next PATCH if ($patch_line =~ m/^diff /);
 
-			next LINE;
+			print format_diff_line($patch_line);
 		}
 
-		print format_diff_line($patch_line);
+	} continue {
+		print "</div>\n"; # class="patch"
 	}
-	print "</div>\n" if $in_header; # extended header
-
-	print "</div>\n" if $patch_found; # class="patch"
 
 	print "</div>\n"; # class="patchset"
 }
-- 
1.4.3.4
