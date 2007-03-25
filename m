From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: Add treediff
Date: Sun, 25 Mar 2007 22:34:22 +0200
Message-ID: <11748548623081-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621755-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQM-0003O4-PI
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXCYUec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbXCYUeb
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:31 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60120 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbXCYUeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 289A2735D749;
	Sun, 25 Mar 2007 22:34:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3j0Pd1V3qZN6; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 79A49735D74A; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11748548621755-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43068>

treediff supports comparing different trees. A tree can be specified
either as hash or as base hash and filename.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |  131 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 95723c7..52c0c13 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -446,6 +446,8 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"treediff" => \&git_treediff,
+	"treediff_plain" => \&git_treediff_plain,
 	"snapshot" => \&git_snapshot,
 	"object" => \&git_object,
 	# those below don't need $project
@@ -4242,6 +4244,135 @@ sub git_commitdiff_plain {
 	git_commitdiff('plain');
 }
 
+
+sub git_treediff {
+	my $format = shift || 'html';
+	my $from = $file_parent || "";
+	my $to = $file_name || "";
+
+	if (!defined $hash) {
+		if (!defined $hash_base) {
+			die_error('','tree parameter missing');
+		}
+		$hash = $hash_base;
+		$hash .= ":".$file_name if (defined $file_name);
+	}
+
+	if (!defined $hash_parent) {
+		if (!defined $hash_parent_base) {
+			die_error('','tree parameter missing');
+		}
+		$hash_parent = $hash_parent_base;
+		$hash_parent .= ":".$file_parent if (defined $file_parent);
+	}
+
+	# we need to prepare $formats_nav before any parameter munging
+	my $formats_nav;
+	if ($format eq 'html') {
+		$formats_nav =
+			$cgi->a({-href => href(action=>"treediff_plain",
+			                       hash=>$hash, hash_parent=>$hash_parent,
+			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
+			                       file_name=>$file_name, file_parent=>$file_parent)},
+			        "raw");
+
+		if (defined $hash_parent_base && (my %co = parse_commit($hash_parent_base))) {
+	 		$formats_nav .= " | from: ".
+				$cgi->a({-href => href(action=>"commit",
+			        	               hash=>$hash_parent_base)},
+				        "commit")
+				." | ".
+				$cgi->a({-href => href(action=>"commitdiff",
+				                       hash=>$hash_parent_base)},
+				        "commitdiff")
+				." | ".
+				$cgi->a({-href => href(action=>"tree",
+						       hash=>$co{'tree'},
+				                       hash_base=>$hash_parent_base)},
+				        "tree");
+		}
+	}
+
+	# read treediff
+	my $fd;
+	my @difftree;
+	if ($format eq 'html') {
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			"--no-commit-id", "--patch-with-raw", "--full-index",
+			$hash_parent, $hash, "--"
+			or die_error(undef, "Open git-diff-tree failed");
+
+		while (my $line = <$fd>) {
+			chomp $line;
+			# empty line ends raw part of diff-tree output
+			last unless $line;
+			push @difftree, $line;
+		}
+
+	} elsif ($format eq 'plain') {
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			'-p', $hash_parent, $hash, "--"
+			or die_error(undef, "Open git-diff-tree failed");
+
+	} else {
+		die_error(undef, "Unknown treediff format");
+	}
+
+	# non-textual hash id's can be cached
+	my $expires;
+	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = "+1d";
+	}
+
+	# write header
+	if ($format eq 'html') {
+
+		git_header_html(undef, $expires);
+		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
+			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+			print "<div class=\"title\">$hash_base:$from vs $hash_parent_base:$to</div>\n";
+		} else {
+			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
+			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
+		}
+		print "<div class=\"page_body\">\n";
+
+	} elsif ($format eq 'plain') {
+		my $filename = basename($project) . "-diff.patch";
+
+		print $cgi->header(
+			-type => 'text/plain',
+			-charset => 'utf-8',
+			-expires => $expires,
+			-content_disposition => 'inline; filename="' . "$filename" . '"');
+
+		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+		print "---\n\n";
+	}
+
+	# write patch
+	if ($format eq 'html') {
+		git_difftree_body(\@difftree, $hash_base, $hash_parent_base, $file_name, $file_parent);
+		print "<br/>\n";
+
+		git_patchset_body($fd, \@difftree, $hash_base, $hash_parent_base, $file_name, $file_parent);
+		close $fd;
+		print "</div>\n"; # class="page_body"
+		git_footer_html();
+
+	} elsif ($format eq 'plain') {
+		local $/ = undef;
+		print <$fd>;
+		close $fd
+			or print "Reading git-diff-tree failed\n";
+	}
+}
+
+sub git_treediff_plain {
+	git_treediff('plain');
+}
+
 sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_get_head_hash($project);
-- 
1.5.1.rc1.51.gb08b-dirty
