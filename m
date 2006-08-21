From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Use parse_difftree_raw_line in git_difftree_body
Date: Mon, 21 Aug 2006 23:08:52 +0200
Message-ID: <200608212308.53231.jnareb@gmail.com>
References: <200608212307.00712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 21 23:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFH19-0000mQ-Lj
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 23:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHUVJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWHUVJF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 17:09:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:31005 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751119AbWHUVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 17:09:04 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1994315nfa
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 14:09:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ilfm5lbDhDhIpUCPdDBm9p/rzVf1DANTlcSqpeBnF5jxGQxDwhKXUxfS6V4s5/0IhGl1WuEOwGbC7EJSr2Y8d92W7uc9C6Yu6Zf01Zz6+NuwB0+w9aGL5Hz3n1ByPmOhIaUgURrOhOQX936lMSxkNPWYtMXXp4Q6wFYwkoES9yU=
Received: by 10.48.210.20 with SMTP id i20mr68808nfg;
        Mon, 21 Aug 2006 14:09:03 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id d2sm334118nfe.2006.08.21.14.09.01;
        Mon, 21 Aug 2006 14:09:02 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608212307.00712.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25821>

Use newly introduced parse_difftree_raw_line function in the
git_difftree_body subroutine.  While at it correct error in
parse_difftree_raw_line (unquote is unprototyped function), and
add comment explaining this function.

It also refactors git_difftree_body somewhat, and tries to fit
it in 80 columns.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
These two patches probably could be collapsed into one commit.

 gitweb/gitweb.perl |  178 ++++++++++++++++++++++++++++------------------------
 1 files changed, 97 insertions(+), 81 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 824fc53..31a1824 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -918,6 +918,7 @@ sub parse_ref {
 	return %ref_item;
 }
 
+# parse line of git-diff-tree "raw" output
 sub parse_difftree_raw_line {
 	my $line = shift;
 	my %res;
@@ -932,7 +933,7 @@ sub parse_difftree_raw_line {
 		$res{'status'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
-			($res{'from_file'}, $res{'to_file'}) = map(unquote, split("\t", $7));
+			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
 		} else {
 			$res{'file'} = unquote($7);
 		}
@@ -1355,18 +1356,7 @@ sub git_difftree_body {
 	print "<table class=\"diff_tree\">\n";
 	my $alternate = 0;
 	foreach my $line (@{$difftree}) {
-		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
-		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
-		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
-			next;
-		}
-		my $from_mode = $1;
-		my $to_mode = $2;
-		my $from_id = $3;
-		my $to_id = $4;
-		my $status = $5;
-		my $similarity = $6; # score
-		my $file = validate_input(unquote($7));
+		my %diff = parse_difftree_raw_line($line);
 
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
@@ -1375,105 +1365,131 @@ sub git_difftree_body {
 		}
 		$alternate ^= 1;
 
-		if ($status eq "A") { # created
-			my $mode_chng = "";
-			if (S_ISREG(oct $to_mode)) {
-				$mode_chng = sprintf(" with mode: %04o", (oct $to_mode) & 0777);
+		my ($to_mode_oct, $to_mode_str, $to_file_type);
+		my ($from_mode_oct, $from_mode_str, $from_file_type);
+		if ($diff{'to_mode'} ne ('0' x 6)) {
+			$to_mode_oct = oct $diff{'to_mode'};
+			if (S_ISREG($to_mode_oct)) { # only for regular file
+				$to_mode_str = sprintf("%04o", $to_mode_oct & 0777); # permission bits
 			}
+			$to_file_type = file_type($diff{'to_mode'});
+		}
+		if ($diff{'from_mode'} ne ('0' x 6)) {
+			$from_mode_oct = oct $diff{'from_mode'};
+			if (S_ISREG($to_mode_oct)) { # only for regular file
+				$from_mode_str = sprintf("%04o", $from_mode_oct & 0777); # permission bits
+			}
+			$from_file_type = file_type($diff{'from_mode'});
+		}
+
+		if ($diff{'status'} eq "A") { # created
+			my $mode_chng = "<span class=\"file_status new\">[new $to_file_type";
+			$mode_chng   .= " with mode: $to_mode_str" if $to_mode_str;
+			$mode_chng   .= "]</span>";
 			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file),
-			              -class => "list"}, esc_html($file)) .
+			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			              -class => "list"}, esc_html($diff{'file'})) .
 			      "</td>\n" .
-			      "<td><span class=\"file_status new\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
+			      "<td>$mode_chng</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob") .
+			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			              "blob") .
 			      "</td>\n";
 
-		} elsif ($status eq "D") { # deleted
+		} elsif ($diff{'status'} eq "D") { # deleted
+			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$file),
-			               -class => "list"}, esc_html($file)) . "</td>\n" .
-			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
+			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+			                             hash_base=>$parent, file_name=>$diff{'file'}),
+			               -class => "list"}, esc_html($diff{'file'})) .
+			      "</td>\n" .
+			      "<td>$mode_chng</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$file)}, "blob") . " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$parent, file_name=>$file)}, "history") .
-			      "</td>\n"
+			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+			                             hash_base=>$parent, file_name=>$diff{'file'})},
+			              "blob") .
+			      " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$parent,
+			                             file_name=>$diff{'file'})},\
+			              "history") .
+			      "</td>\n";
 
-		} elsif ($status eq "M" || $status eq "T") { # modified, or type changed
+		} elsif ($diff{'status'} eq "M" || $diff{'status'} eq "T") { # modified, or type changed
 			my $mode_chnge = "";
-			if ($from_mode != $to_mode) {
-				$mode_chnge = " <span class=\"file_status mode_chnge\">[changed";
-				if (((oct $from_mode) & S_IFMT) != ((oct $to_mode) & S_IFMT)) {
-					$mode_chnge .= " from " . file_type($from_mode) . " to " . file_type($to_mode);
+			if ($diff{'from_mode'} != $diff{'to_mode'}) {
+				$mode_chnge = "<span class=\"file_status mode_chnge\">[changed";
+				if ($from_file_type != $to_file_type) {
+					$mode_chnge .= " from $from_file_type to $to_file_type";
 				}
-				if (((oct $from_mode) & 0777) != ((oct $to_mode) & 0777)) {
-					if (S_ISREG($from_mode) && S_ISREG($to_mode)) {
-						$mode_chnge .= sprintf(" mode: %04o->%04o", (oct $from_mode) & 0777, (oct $to_mode) & 0777);
-					} elsif (S_ISREG($to_mode)) {
-						$mode_chnge .= sprintf(" mode: %04o", (oct $to_mode) & 0777);
+				if (($from_mode_oct & 0777) != ($to_mode_oct & 0777)) {
+					if ($from_mode_str && $to_mode_str) {
+						$mode_chnge .= " mode: $from_mode_str->$to_mode_str";
+					} elsif ($to_mode_str) {
+						$mode_chnge .= " mode: $to_mode_str";
 					}
 				}
 				$mode_chnge .= "]</span>\n";
 			}
 			print "<td>";
-			if ($to_id ne $from_id) { # modified
-				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file),
-				              -class => "list"}, esc_html($file));
-			} else { # mode changed
-				print $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file),
-				              -class => "list"}, esc_html($file));
+			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
+				print $cgi->a({-href => href(action=>"blobdiff", hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+				                             hash_base=>$hash, file_name=>$diff{'file'}),
+				              -class => "list"}, esc_html($diff{'file'}));
+			} else { # only mode changed
+				print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+				                             hash_base=>$hash, file_name=>$diff{'file'}),
+				              -class => "list"}, esc_html($diff{'file'}));
 			}
 			print "</td>\n" .
 			      "<td>$mode_chnge</td>\n" .
 			      "<td class=\"link\">" .
-				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
-			if ($to_id ne $from_id) { # modified
-				print " | " . $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
-			}
-			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
-			print "</td>\n";
-
-		} elsif ($status eq "R") { # renamed
-			my ($from_file, $to_file) = split "\t", $file;
-			my $mode_chng = "";
-			if ($from_mode != $to_mode) {
-				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
-			}
-			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file),
-			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
-			      "<td><span class=\"file_status moved\">[moved from " .
-			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$from_file),
-			              -class => "list"}, esc_html($from_file)) .
-			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
-			if ($to_id ne $from_id) {
+				$cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+				                       hash_base=>$hash, file_name=>$diff{'file'})},
+				        "blob");
+			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
 				print " | " .
-				      $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$to_file, file_parent=>$from_file)}, "diff");
+					$cgi->a({-href => href(action=>"blobdiff", hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                       hash_base=>$hash, file_name=>$diff{'file'})},
+					        "diff");
 			}
+			print " | " .
+				$cgi->a({-href => href(action=>"history",
+				                       hash_base=>$hash, file_name=>$diff{'file'})},
+				        "history");
 			print "</td>\n";
 
-		} elsif ($status eq "C") { # copied
-			my ($from_file, $to_file) = split "\t", $file;
+		} elsif ($diff{'status'} eq "R" || $diff{'status'} eq "C") { # renamed or copied
+			my %status_name = ('R' => 'moved', 'C' => 'copied');
+			my $nstatus = $status_name{$diff{'status'}};
 			my $mode_chng = "";
-			if ($from_mode != $to_mode) {
-				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
+			if ($diff{'from_mode'} != $diff{'to_mode'}) {
+				# mode also for directories, so we cannot use $to_mode_str
+				$mode_chng = sprintf(", mode: %04o", $to_mode_oct & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file),
-			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
-			      "<td><span class=\"file_status copied\">[copied from " .
-			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$from_file),
-			              -class => "list"}, esc_html($from_file)) .
-			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
+			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
+			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'}),
+			              -class => "list"}, esc_html($diff{'to_file'})) . "</td>\n" .
+			      "<td><span class=\"file_status $nstatus\">[$nstatus from " .
+			      $cgi->a({-href => href(action=>"blob", hash_base=>$parent,
+			                             hash=>$diff{'from_id'}, file_name=>$diff{'from_file'}),
+			              -class => "list"}, esc_html($diff{'from_file'})) .
+			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
-			if ($to_id ne $from_id) {
+			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
+			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'})},
+			              "blob");
+			if ($diff{'to_id'} ne $diff{'from_id'}) {
 				print " | " .
-				      $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$to_file, file_parent=>$from_file)}, "diff");
+					$cgi->a({-href => href(action=>"blobdiff", hash_base=>$hash,
+					                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                       file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+					        "diff");
 			}
 			print "</td>\n";
+
 		} # we should not encounter Unmerged (U) or Unknown (X) status
 		print "</tr>\n";
 	}
-- 
1.4.1.1
