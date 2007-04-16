From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [PATCH 4/7] gitweb: Add treediff view
Date: Mon, 16 Apr 2007 22:20:10 +0200
Message-ID: <20070416202010.GB2592@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <85de402216e82cc0f220df9d27370a33538a232a.1176659094.git.mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdXgS-00048I-Gk
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 22:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030943AbXDPUUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 16:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030953AbXDPUUO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 16:20:14 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35752 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030943AbXDPUUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 16:20:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id A9F87683E788;
	Mon, 16 Apr 2007 22:20:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSlUMw8xse19; Mon, 16 Apr 2007 22:20:10 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2CED7683E780; Mon, 16 Apr 2007 22:20:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85de402216e82cc0f220df9d27370a33538a232a.1176659094.git.mkoegler@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44693>

git_treediff supports comparing different trees. A tree can be specified
either as hash or as base hash and filename.
---
New version, as I found a bug in the expiration handling code.

I removed the parent links for now, as they require more discussion.

This patch uses empty fp/f for the root directory and does not propagte f to fp.
Patch 6 adds this.

 gitweb/gitweb.perl |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1551d95..c2dc82d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -450,6 +450,8 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"treediff" => \&git_treediff,
+	"treediff_plain" => \&git_treediff_plain,
 	"snapshot" => \&git_snapshot,
 	"object" => \&git_object,
 	# those below don't need $project
@@ -4174,6 +4176,120 @@ sub git_commitdiff_plain {
 	git_commitdiff('plain');
 }
 
+sub git_treediff {
+	my $format = shift || 'html';
+	my $expires = '+1d';
+
+	# non-textual hash id's can be cached
+	if (defined $hash && $hash !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_parent && $hash_parent !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_base && $hash_base !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_parent_base && $hash_parent_base !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	}
+
+	# we need to prepare $formats_nav before any parameter munging
+	my $formats_nav;
+	if ($format eq 'html') {
+		$formats_nav =
+			$cgi->a({-href => href(action=>"treediff_plain",
+								   hash=>$hash, hash_parent=>$hash_parent,
+								   hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
+								   file_name=>$file_name, file_parent=>$file_parent)},
+					"raw");
+	}
+
+	if (!defined $hash) {
+		if (!defined $hash_base) {
+			die_error(undef,'tree parameter missing');
+		}
+		$hash = $hash_base;
+		$hash .= ":".$file_name if (defined $file_name);
+	}
+	
+	if (!defined $hash_parent) {
+		if (!defined $hash_parent_base) {
+			die_error(undef,'tree parameter missing');
+		}
+		$hash_parent = $hash_parent_base;
+		$hash_parent .= ":".$file_parent if (defined $file_parent);
+	}
+
+	# read treediff
+	my $fd;
+	my @difftree;
+	if ($format eq 'html') {
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+		"--no-commit-id", "--patch-with-raw", "--full-index",
+		$hash_parent, $hash, "--"
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
+		'-p', $hash_parent, $hash, "--"
+			or die_error(undef, "Open git-diff-tree failed");
+		
+	} else {
+		die_error(undef, "Unknown treediff format");
+	}
+
+	# write header
+	if ($format eq 'html') {
+		git_header_html(undef, $expires);
+		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
+			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+		} else {
+			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
+			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
+		}
+		print "<div class=\"page_body\">\n";
+		
+	} elsif ($format eq 'plain') {
+		my $filename = basename($project) . "-$hash-$hash_parent.patch";
+		
+		print $cgi->header(
+						   -type => 'text/plain',
+						   -charset => 'utf-8',
+						   -expires => $expires,
+						   -content_disposition => 'inline; filename="' . "$filename" . '"');
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
1.5.1.1.85.gf1888
