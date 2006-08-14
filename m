From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9/9] gitweb: Separate printing difftree in git_commit into git_difftree_body
Date: Mon, 14 Aug 2006 02:18:33 +0200
Message-ID: <200608140218.33872.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVE-0001tP-7B
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWHNKQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWHNKQr
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:6797 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751989AbWHNKQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:44 -0400
Received: by nf-out-0910.google.com with SMTP id k26so20479nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z75Ek42aaCMAUbps8FL+HEH2H5Mpn5wzq/v95u0fOFSi2MhHO63dI4bpbU3Rci11SeM0emMkYLBL0GhFa+Z0GrG5Tz07wmiqVBSXsolAAu9vCeJfc55Oivkun4AbV6tPV29pKbmPedhTjTb6siTSyUMilNHHkt8pJ7qbUMlowUQ=
Received: by 10.49.43.2 with SMTP id v2mr999826nfj;
        Mon, 14 Aug 2006 03:16:42 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.41;
        Mon, 14 Aug 2006 03:16:42 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25338>

Separate printing difftree in git_commit into separate
git_difftree_body subroutine. Add support for "C" (copied) status. For
"M" and "C" add parameter 'fp' (filename parent) to the "diff" link;
currently not supported by git_blobdiff ("blobdiff" action).

Reindented, realigned, added comments.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    4 +
 gitweb/gitweb.perl |  237 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 146 insertions(+), 95 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 21ce99c..9013895 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -226,6 +226,10 @@ table.diff_tree span.file_status.mode_ch
 	color: #777777;
 }
 
+table.diff_tree span.file_status.copied {
+  color: #70a070;
+}
+
 /* age2: 60*60*24*2 <= age */
 table.project_list td.age2, table.blame td.age2 {
 	font-style: italic;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 15875a8..ab28caa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1136,6 +1136,145 @@ sub git_print_page_path {
 ## ......................................................................
 ## functions printing large fragments of HTML
 
+sub git_difftree_body {
+	my ($difftree, $parent) = @_;
+
+	print "<div class=\"list_head\">\n";
+	if ($#{$difftree} > 10) {
+		print(($#{$difftree} + 1) . " files changed:\n");
+	}
+	print "</div>\n";
+
+	print "<table class=\"diff_tree\">\n";
+	my $alternate = 0;
+	foreach my $line (@{$difftree}) {
+		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
+		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
+		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
+			next;
+		}
+		my $from_mode = $1;
+		my $to_mode = $2;
+		my $from_id = $3;
+		my $to_id = $4;
+		my $status = $5;
+		my $similarity = $6; # score
+		my $file = validate_input(unquote($7));
+
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+
+		if ($status eq "A") { # created
+			my $mode_chng = "";
+			if (S_ISREG(oct $to_mode)) {
+				$mode_chng = sprintf(" with mode: %04o", (oct $to_mode) & 0777);
+			}
+			print "<td>" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"),
+			              -class => "list"}, esc_html($file)) .
+			      "</td>\n" .
+			      "<td><span class=\"file_status new\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob") .
+			      "</td>\n";
+
+		} elsif ($status eq "D") { # deleted
+			print "<td>" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file"),
+			               -class => "list"}, esc_html($file)) . "</td>\n" .
+			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file")}, "blob") . " | " .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$parent;f=$file")}, "history") .
+			      "</td>\n"
+
+		} elsif ($status eq "M" || $status eq "T") { # modified, or type changed
+			my $mode_chnge = "";
+			if ($from_mode != $to_mode) {
+				$mode_chnge = " <span class=\"file_status mode_chnge\">[changed";
+				if (((oct $from_mode) & S_IFMT) != ((oct $to_mode) & S_IFMT)) {
+					$mode_chnge .= " from " . file_type($from_mode) . " to " . file_type($to_mode);
+				}
+				if (((oct $from_mode) & 0777) != ((oct $to_mode) & 0777)) {
+					if (S_ISREG($from_mode) && S_ISREG($to_mode)) {
+						$mode_chnge .= sprintf(" mode: %04o->%04o", (oct $from_mode) & 0777, (oct $to_mode) & 0777);
+					} elsif (S_ISREG($to_mode)) {
+						$mode_chnge .= sprintf(" mode: %04o", (oct $to_mode) & 0777);
+					}
+				}
+				$mode_chnge .= "]</span>\n";
+			}
+			print "<td>";
+			if ($to_id ne $from_id) { # modified
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file"),
+				              -class => "list"}, esc_html($file));
+			} else { # mode changed
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"),
+				              -class => "list"}, esc_html($file));
+			}
+			print "</td>\n" .
+			      "<td>$mode_chnge</td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob");
+			if ($to_id ne $from_id) { # modified
+				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file")}, "diff");
+			}
+			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash;f=$file")}, "history") . "\n";
+			print "</td>\n";
+
+		} elsif ($status eq "R") { # renamed
+			my ($from_file, $to_file) = split "\t", $file;
+			my $mode_chng = "";
+			if ($from_mode != $to_mode) {
+				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
+			}
+			print "<td>" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"),
+			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
+			      "<td><span class=\"file_status moved\">[moved from " .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$from_file"),
+			              -class => "list"}, esc_html($from_file)) .
+			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file")}, "blob");
+			if ($to_id ne $from_id) {
+				print " | " .
+				      $cgi->a({-href => "$my_uri?" .
+				              esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file;fp=$from_file")}, "diff");
+			}
+			print "</td>\n";
+
+		} elsif ($status eq "C") { # copied
+			my ($from_file, $to_file) = split "\t", $file;
+			my $mode_chng = "";
+			if ($from_mode != $to_mode) {
+				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
+			}
+			print "<td>" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"),
+			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
+			      "<td><span class=\"file_status copied\">[copied from " .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$from_file"),
+			              -class => "list"}, esc_html($from_file)) .
+			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file")}, "blob");
+			if ($to_id ne $from_id) {
+				print " | " .
+				      $cgi->a({-href => "$my_uri?" .
+				              esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file;fp=$from_file")}, "diff");
+			}
+			print "</td>\n";
+		} # we should not encounter Unmerged (U) or Unknown (X) status
+		print "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
@@ -2089,101 +2228,9 @@ sub git_commit {
 		}
 	}
 	print "</div>\n";
-	print "<div class=\"list_head\">\n";
-	if ($#difftree > 10) {
-		print(($#difftree + 1) . " files changed:\n");
-	}
-	print "</div>\n";
-	print "<table class=\"diff_tree\">\n";
-	my $alternate = 0;
-	foreach my $line (@difftree) {
-		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
-		# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M      rev-tree.c'
-		if ($line !~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
-			next;
-		}
-		my $from_mode = $1;
-		my $to_mode = $2;
-		my $from_id = $3;
-		my $to_id = $4;
-		my $status = $5;
-		my $similarity = $6;
-		my $file = validate_input(unquote($7));
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
-		if ($status eq "A") {
-			my $mode_chng = "";
-			if (S_ISREG(oct $to_mode)) {
-				$mode_chng = sprintf(" with mode: %04o", (oct $to_mode) & 0777);
-			}
-			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"), -class => "list"}, esc_html($file)) . "</td>\n" .
-			      "<td><span class=\"file_status new\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
-			      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob") . "</td>\n";
-		} elsif ($status eq "D") {
-			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file"), -class => "list"}, esc_html($file)) . "</td>\n" .
-			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file")}, "blob") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$parent;f=$file")}, "history") .
-			      "</td>\n"
-		} elsif ($status eq "M" || $status eq "T") {
-			my $mode_chnge = "";
-			if ($from_mode != $to_mode) {
-				$mode_chnge = " <span class=\"file_status mode_chnge\">[changed";
-				if (((oct $from_mode) & S_IFMT) != ((oct $to_mode) & S_IFMT)) {
-					$mode_chnge .= " from " . file_type($from_mode) . " to " . file_type($to_mode);
-				}
-				if (((oct $from_mode) & 0777) != ((oct $to_mode) & 0777)) {
-					if (S_ISREG($from_mode) && S_ISREG($to_mode)) {
-						$mode_chnge .= sprintf(" mode: %04o->%04o", (oct $from_mode) & 0777, (oct $to_mode) & 0777);
-					} elsif (S_ISREG($to_mode)) {
-						$mode_chnge .= sprintf(" mode: %04o", (oct $to_mode) & 0777);
-					}
-				}
-				$mode_chnge .= "]</span>\n";
-			}
-			print "<td>";
-			if ($to_id ne $from_id) {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file"), -class => "list"}, esc_html($file));
-			} else {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"), -class => "list"}, esc_html($file));
-			}
-			print "</td>\n" .
-			      "<td>$mode_chnge</td>\n" .
-			      "<td class=\"link\">";
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob");
-			if ($to_id ne $from_id) {
-				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file")}, "diff");
-			}
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash;f=$file")}, "history") . "\n";
-			print "</td>\n";
-		} elsif ($status eq "R") {
-			my ($from_file, $to_file) = split "\t", $file;
-			my $mode_chng = "";
-			if ($from_mode != $to_mode) {
-				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
-			}
-			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"), -class => "list"}, esc_html($to_file)) . "</td>\n" .
-			      "<td><span class=\"file_status moved\">[moved from " .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$from_file"), -class => "list"}, esc_html($from_file)) .
-			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file")}, "blob");
-			if ($to_id ne $from_id) {
-				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file")}, "diff");
-			}
-			print "</td>\n";
-		}
-		print "</tr>\n";
-	}
-	print "</table>\n";
+
+	git_difftree_body(\@difftree, $parent);
+
 	git_footer_html();
 }
 
-- 
1.4.1.1
