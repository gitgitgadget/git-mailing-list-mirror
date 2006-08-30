From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] gitweb: Add "tree_blame" view (WIP)
Date: Thu, 31 Aug 2006 00:36:54 +0200
Message-ID: <200608310036.54710.jnareb@gmail.com>
References: <200608310030.33512.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 00:37:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIYgb-0002lo-3N
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 00:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWH3WhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWH3WhS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 18:37:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13541 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932218AbWH3WhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 18:37:14 -0400
Received: by nf-out-0910.google.com with SMTP id x30so271641nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 15:37:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OV5WhlQGNgLKRtF+F0tXFZ1XO6Xj6i+wiFXYO3KQeVFtwS5PqQI82RfN3DqkTUUGzhG8RWBOWR3uZWtkq13+XPjBYeo7pe8IUnP+mFAcz7JjivEtN9T5guLblF1lFB+IUSsaoLTQ2VLNv1qPlZJXQrzlXX+/0VuV5S8I6dbFnEg=
Received: by 10.49.8.15 with SMTP id l15mr354900nfi;
        Wed, 30 Aug 2006 15:37:13 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id o9sm377359nfa.2006.08.30.15.37.12;
        Wed, 30 Aug 2006 15:37:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608310030.33512.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26235>

Adds git_tree_blame subroutine, for the "tree_blame" view, similar to
the ViewVC output.  It means having the commit, date and author of
last change to the file (blob) or directory (tree) in given tree in
addition to the default "tree" view info.

The git_tree_blame subroutine contains 3 implementations: one using
git-diff-tree to detect when file was changed (works only on blobs,
and not on trees/directories), one comparing output of git-ls-tree to
check what changed between revisions, and one (default used) looking
at two first commits in the blob or tree history.

While at it, add 'year' field to the parse_date output; add "blame"
link to the list of links for tree entries in directory listing in
git_print_tree_entry; add support for 'order' parameter to href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  344 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 344 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b193bc6..130609b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -264,6 +264,7 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"tree_blame" => \&git_tree_blame,
 	"snapshot" => \&git_snapshot,
 	# those below don't need $project
 	"opml" => \&git_opml,
@@ -298,6 +299,7 @@ sub href(%) {
 		hash_parent_base => "hpb",
 		page => "pg",
 		searchtext => "s",
+		order => "o",
 	);
 	my %mapping = @mapping;
 
@@ -804,6 +806,7 @@ sub parse_date {
 	$date{'hour'} = $hour;
 	$date{'minute'} = $min;
 	$date{'mday'} = $mday;
+	$date{'year'} = 1900+$year;
 	$date{'day'} = $days[$wday];
 	$date{'month'} = $months[$mon];
 	$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000",
@@ -1508,6 +1511,12 @@ sub git_print_tree_entry {
 		      $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
 		              "tree");
+		if ($have_blame) {
+			print " | " .
+				$cgi->a({-href => href(action=>"tree_blame", hash=>$t->{'hash'},
+				                       file_name=>"$basedir$t->{'name'}", %base_key)},
+				        "blame");
+		}
 		if (defined $hash_base) {
 			print " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
@@ -2592,6 +2601,341 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub git_tree_blame {
+	my $version = shift || 'rev-list';
+
+	# check permission
+	my $have_blame = gitweb_check_feature('blame');
+	if (!$have_blame) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+	# get sort order parameter
+	my $order = $cgi->param('o');
+	if (defined $order && $order !~ m/[+-]?age|[+-]?author|[+-]?mode|[+-]?name/) {
+		die_error(undef, "Unknown order parameter");
+	}
+	# check hash
+	if (!defined $hash) {
+		$hash = git_get_head_hash($project);
+		if (defined $file_name) {
+			my $base = $hash_base || $hash;
+			$hash = git_get_hash_by_path($base, $file_name, "tree");
+		}
+	}
+	# check hash_base
+	if (!defined $hash_base) {
+		$hash_base = $hash;
+	}
+	# check if we have starting (base) commit
+	my %co = parse_commit($hash_base);
+	if (!%co) {
+		die_error(undef, "Base commit not defined");
+	}
+	# set basedir (dirname for entries)
+	my $basedir;
+	if (defined $file_name) {
+		$basedir = "$file_name/";
+	}
+
+	# read tree
+	$/ = "\0";
+	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash
+		or die_error(undef, "Open git-ls-tree failed");
+	my @entries = map { chomp; $_ } <$fd>;
+	close $fd
+		or die_error(undef, "Reading git-ls-tree failed");
+	$/ = "\n";
+
+	# parse tree
+	@entries = map {
+		scalar parse_ls_tree_line($_, -z => 1);
+	} @entries;
+
+	## !!! two versions: one using git-diff-tree, without directories,
+	## !!! second using git-ls-files, with directories, slower.
+
+	# blame
+	my $tofind = scalar @entries;
+	my %idx;
+	for (my $i = 0; $i < @entries; $i++) {
+		$idx{"$basedir$entries[$i]{'name'}"} = $i;
+	}
+	my $commit = $hash_base;
+
+	if ($version eq 'diff-tree') {
+		open $fd, "-|", "$GIT rev-list $commit -- $basedir/" .
+			"| $GIT diff-tree -r -- $basedir/"
+			or die_error(undef, "Open git-rev-list or git-diff-tree failed");
+
+		while ($tofind > 0 && (my $line = <$fd>)) {
+			chomp $line;
+			my %diffinfo = parse_difftree_raw_line($line);
+			if ($diffinfo{'commit'}) {
+				$commit = $diffinfo{'commit'};
+			} else {
+				my $name = $diffinfo{'to_name'} || $diffinfo{'name'};
+				my $fullname = $basedir . $name;
+				if (!exists $entries[$idx{$fullname}]{'commit'}) {
+					$entries[$idx{$fullname}]{'commit'} = $commit;
+					$entries[$idx{$fullname}]{'added'} =
+						($diffinfo{'status'} eq 'A');
+					$tofind--;
+				}
+			}
+		}
+
+	} elsif ($version eq 'ls-tree') {
+
+	TOFIND:
+		while ($tofind > 0) {
+			# workaround the lack of git-ls-tree --stdin
+			open $fd, "-|", $GIT, "rev-list", "--max-count=100", "--remove-empty",
+				"$commit^", "--", $basedir
+					or die_error(undef, "Open git-rev-list failed");
+			my @revlist = map { chomp; $_ } <$fd>;
+			close $fd
+				or die_error(undef, "Reading git-rev-list failed");
+
+			# exit if no revisions found
+			last unless @revlist;
+
+			$/ = "\0";
+			my $prev_commit = $commit;
+		COMMIT:
+			foreach $commit (@revlist) {
+				# read tree
+				open my $fd, "-|", $GIT, "ls-tree", '-z', $commit, "--", $basedir
+					or die_error(undef, "Open git-ls-tree failed");
+				my @ls_tree = map {	chomp; $_ } <$fd>;
+				close $fd
+					or die_error(undef, "Reading git-ls-tree failed");
+				# parse tree
+				@ls_tree = map {
+					scalar parse_ls_tree_line($_, -z => 1);
+				} @ls_tree;
+
+				# find unchanged
+				my %unchanged;
+				my %changed;
+				foreach my $entry (@ls_tree) {
+					if (exists $idx{"$entry->{'name'}"} &&
+					    $entry->{'hash'} eq $entries[$idx{"$entry->{'name'}"}]{'hash'}) {
+						$unchanged{"$entry->{'name'}"} = 1;
+					}
+					if (exists $idx{"$entry->{'name'}"} &&
+					    $entry->{'hash'} ne $entries[$idx{"$entry->{'name'}"}]{'hash'}) {
+						$changed{"$entry->{'name'}"} = 1;
+					}
+				}
+
+				# find those with changed id, and those that vanished
+				foreach my $entry (@entries) {
+					my $fullname = "$basedir$entry->{'name'}";
+					if (!$unchanged{$fullname} &&
+					    !exists $entry->{'commit'}) {
+						$entry->{'commit'} = $prev_commit;
+						$entry->{'added'} =
+							!$changed{$fullname};
+						$tofind--;
+					}
+				}
+				last TOFIND if $tofind <= 0;
+
+			} continue {
+				$prev_commit = $commit;
+			}
+			$/ = "\n";
+
+			$commit = $revlist[-1];
+		}
+
+		# 'import' case: we attribute 'not found yet' to the last commit
+		if ($tofind > 0) {
+			foreach my $entry (@entries) {
+				if (!exists $entry->{'commit'}) {
+					$entry->{'commit'} = $commit;
+					$entry->{'added'} = 1;
+				}
+			}
+		}
+
+	} elsif ($version eq 'rev-list') {
+
+		foreach my $entry (@entries) {
+			my $fullname = "$basedir$entry->{'name'}";
+
+			open $fd, "-|", $GIT, "rev-list", "--max-count=2",
+				$hash_base, "--", $fullname
+				or die_error(undef, "Open git-rev-list failed");
+			my @revlist = map { chomp; $_ } <$fd>;
+			close $fd
+				or die_error(undef, "Reading git-rev-list failed");
+
+			if ($#revlist >= 0) {
+				$entry->{'commit'} = $revlist[0];
+				$entry->{'added'} = 1
+					if (@revlist == 1);
+			}
+		}
+
+	} else {
+		die_error(undef, "Unknown tree_blame version parameter");
+	}
+
+	# blame postprocessing
+	foreach my $entry (@entries) {
+		if (my %entry_co = parse_commit($entry->{'commit'})) {
+			$entry->{'title'}  = $entry_co{'title'};
+			$entry->{'epoch'}  = $entry_co{'author_epoch'};
+			$entry->{'author'} = $entry_co{'author_name'};
+			if ($entry_co{'author'} =~ m/<([^@>]+)\@/) {
+				$entry->{'author'} = $1;
+			}
+		}
+	}
+
+
+	### ----------------------------------------------
+	# page header
+	my $refs = git_get_references();
+	my $ref = format_ref_marker($refs, $hash_base);
+	git_header_html();
+	git_print_page_nav('tree_blame','', $hash_base, $hash, $hash_base);
+	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
+	git_print_page_path($file_name, 'tree', $hash_base);
+	print "<div class=\"page_body\">\n";
+	print "<table class=\"tree blame\" cellspacing=\"0\">\n";
+
+	# sort and print table header
+	print "<thead>\n" .
+	      "<tr>\n";
+	print "<th>Commit</th>\n";
+	if ($order =~ m/^([-+]?)age$/) {
+		my $sign = "$1" ? "${1}1" : -1;
+		@entries = sort {
+			if (exists $a->{'commit'} && exists $b->{'commit'}) {
+				$sign*($a->{'epoch'} <=> $b->{'epoch'});
+			} else {
+				0;
+			}
+		} @entries;
+		print "<th>Date</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(action=>$action, hash=>$hash,
+		                             hash_base=>$hash_base, file_name=>$file_name,
+		                             order=>'age'),
+		              -class => "header"}, "Date") .
+		      "</th>\n";
+	}
+	if ($order =~ m/^([-+]?)author$/) {
+		my $sign = "${1}1";
+		@entries = sort {
+			if (exists $a->{'commit'} && exists $b->{'commit'}) {
+				$sign*($a->{'author'} cmp $b->{'author'});
+			} else {
+				0;
+			}
+		} @entries;
+		print "<th>Author</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(action=>$action, hash=>$hash,
+		                             hash_base=>$hash_base, file_name=>$file_name,
+		                             order=>'author'),
+		              -class => "header"}, "Author") .
+		      "</th>\n";
+	}
+	if ($order =~ m/^([-+]?)mode$/) {
+		my $sign = "${1}1";
+		@entries = sort {
+			if (exists $a->{'commit'} && exists $b->{'commit'}) {
+				$sign*($a->{'mode'} <=> $b->{'mode'});
+			} else {
+				0;
+			}
+		} @entries;
+		print "<th>Mode</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(action=>$action, hash=>$hash,
+		                             hash_base=>$hash_base, file_name=>$file_name,
+		                             order=>'mode'),
+		              -class => "header"}, "Mode") .
+		      "</th>\n";
+	}
+	if ($order =~ m/^([-+]?)name$/) {
+		my $sign = "${1}1";
+		@entries = sort {
+			if (exists $a->{'commit'} && exists $b->{'commit'}) {
+				$sign*($a->{'name'} cmp $b->{'name'});
+			} else {
+				0;
+			}
+		} @entries;
+		print "<th>Filename</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(action=>$action, hash=>$hash,
+		                             hash_base=>$hash_base, file_name=>$file_name,
+		                             order=>'name'),
+		              -class => "header"}, "Filename") .
+		      "</th>\n";
+	}
+	print <<HTML;
+<th>Link</th>
+</tr>
+</thead>
+<tbody>
+HTML
+
+	# print tree
+	my $alternate = 0;
+	foreach my $entry (@entries) {
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+
+		if ($entry->{'commit'}) {
+			print $cgi->start_td({-class => "sha1", -title => $entry->{'title'}}) .
+			      ($entry->{'added'} ? "<strike>" : "") .
+			      $cgi->a({-href => href(action=>"commit", hash=>$entry->{'commit'},
+			                             file_name=>$entry->{'name'})},
+			              esc_html(substr($entry->{'commit'}, 0, 8))) .
+			      ($entry->{'added'} ? "</strike>" : "") .
+			      "</td>";
+			my %ad = parse_date($entry->{'epoch'});
+			my (undef,undef,undef,undef,undef,$current_year) = gmtime();
+			my $date_str;
+			if ($ad{'year'} == 1900+$current_year) {
+				$date_str = sprintf "%3s % 2u %02d:%02d",
+					$ad{'month'}, $ad{'mday'}, $ad{'hour'}, $ad{'minute'};
+			} else {
+				$date_str = sprintf "%3s % 2u % 5d",
+					$ad{'month'}, $ad{'mday'}, $ad{'year'};
+			}
+			$date_str =~ s/ /&nbsp;/g;
+			print "<td>$date_str</td>\n";
+			print "<td>$entry->{'author'}</td>\n";
+		} else {
+			print "<td></td>\n" .
+			      "<td></td>\n" .
+			      "<td></td>\n";
+		}
+		git_print_tree_entry($entry, $basedir, $hash_base,
+		                     $have_blame && defined $hash_base);
+
+		print "</tr>\n";
+	}
+	print "</tbody>\n" .
+	      "</table>\n" .
+	      "</div>";
+	git_footer_html();
+}
+
 sub git_snapshot {
 
 	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-- 
1.4.1.1
