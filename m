From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Restructure projects list generation
Date: Sat, 26 Feb 2011 23:06:50 +0100
Message-ID: <20110226215230.5333.92839.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 23:07:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtSIn-0004i0-Nk
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 23:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab1BZWHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 17:07:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1BZWHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 17:07:30 -0500
Received: by wyg36 with SMTP id 36so2640781wyg.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=Qfan5ja8XDt55JuUt9n6NdVxDrEQp6dAfwQWg3cEmr0=;
        b=rkekZiKNvUmPeFqoyl8Mpib9rJzSHPnZgtY9SKz25JLtSVA5Y0VjJZQtSzkyRRzpqF
         ofJS9CNiexcUlohtL24M3Hkf6f+q6xGfEniM/nEWF7At1/WEcry1OmWMXD3k48+O7+mz
         XzTROl2v1WXh4FNDu7K5u6zr44nWWuYagMPEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=QE7L5BuHoG3Uy5uNFbJEAcH7x9S+f6T8Tbio4pusZNQfXVLU5V/Nqm2Ow4GjXL8Ekr
         OOObTK7DBi8luNZFJhdhupXX7KSZyuY73f9ArTgqEq1CA+34wQOaTui1q65LIU7T4sj/
         gGurdCrajzjJVbZiytgdEasVLqiNfAaXF476s=
Received: by 10.216.19.139 with SMTP id n11mr3199740wen.78.1298758048711;
        Sat, 26 Feb 2011 14:07:28 -0800 (PST)
Received: from localhost.localdomain (abvw99.neoplus.adsl.tpnet.pl [83.8.220.99])
        by mx.google.com with ESMTPS id t11sm1084316wes.41.2011.02.26.14.07.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 14:07:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1QM6oFn005440;
	Sat, 26 Feb 2011 23:07:00 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167996>

Extract filtering out forks (which is done if 'forks' feature is
enabled) into filter_forks_from_projects_list subroutine, and
searching projects (via projects search form, or via content tags)
into search_projects_list subroutine.

Both are now run _before_ displaying projects, and not while printing;
this allow to know upfront if there were any found projects.  Gitweb
now can and do print 'No such projects found' if user searches for
phrase which does not correspond to any project (any repository).
This also would allow splitting projects list into pages, if we so
desire.

Filtering out forks and marking repository (project) as having forks
is now consolidated into one subroutine (special case of handling
forks in git_get_projects_list only for $projects_list being file is
now removed).  Forks handling is also cleaned up and simplified, which
might mean some changes in output.  $pr->{'forks'} now contains
un-filled list of forks; we can now also detect situation where the
way for having forks is prepared, but there are no forks yet.

Sorting projects got also refactored in a very straight way into
sort_projects_list subroutine.

The interaction between forks, content tags and searching is now made
more explicit: searching whether by tag, or via search form turns off
fork filtering (gitweb searches also forks, and will show all
results).  If 'ctags' feature is disabled, then searching by tag is
too.

The t9500 test now includes some basic test for 'forks' and 'ctags'
features.


Generating list of projects by scanning given directory is now also a
bit simplified wrt. handling filtering; it is byproduct of extracting
forks filtering to separate subroutine.

While at it we now detect that there are no projects and respond with
"404 No projects found" also for 'project_index' and 'opml' actions.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It is marked _currently_ as a RFC, because while it *looks* like it
finds forks correctly (at least when $projects_list is directory), the
algorithm for detecting forks is changed... though IMVHO the code is
cleaner.

 gitweb/gitweb.perl                     |  219 +++++++++++++++++++++-----------
 t/t9500-gitweb-standalone-no-errors.sh |   49 +++++++
 2 files changed, 191 insertions(+), 77 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b9369d..bc60158 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2643,21 +2643,23 @@ sub git_get_project_url_list {
 }
 
 sub git_get_projects_list {
-	my ($filter) = @_;
+	my $filter = shift || '';
 	my @list;
 
-	$filter ||= '';
 	$filter =~ s/\.git$//;
 
-	my $check_forks = gitweb_check_feature('forks');
-
 	if (-d $projects_list) {
 		# search in directory
-		my $dir = $projects_list . ($filter ? "/$filter" : '');
+		my $dir = $projects_list;
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
-		my $pfxlen = length("$dir");
-		my $pfxdepth = ($dir =~ tr!/!!);
+		my $pfxlen = length("$projects_list");
+		my $pfxdepth = ($projects_list =~ tr!/!!);
+		# when filtering, search only given subdirectory
+		if ($filter) {
+			$dir .= "/$filter";
+			$dir =~ s!/+$!!;
+		}
 
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
@@ -2672,14 +2674,14 @@ sub git_get_projects_list {
 				# only directories can be git repositories
 				return unless (-d $_);
 				# don't traverse too deep (Find is super slow on os x)
+				# $project_maxdepth excludes depth of $projectroot
 				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
 					$File::Find::prune = 1;
 					return;
 				}
 
-				my $subdir = substr($File::Find::name, $pfxlen + 1);
+				my $path = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				my $path = ($filter ? "$filter/" : '') . $subdir;
 				if (check_export_ok("$projectroot/$path")) {
 					push @list, { path => $path };
 					$File::Find::prune = 1;
@@ -2692,7 +2694,6 @@ sub git_get_projects_list {
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-		my %paths;
 		open my $fd, '<', $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
@@ -2703,32 +2704,9 @@ sub git_get_projects_list {
 			if (!defined $path) {
 				next;
 			}
-			if ($filter ne '') {
-				# looking for forks;
-				my $pfx = substr($path, 0, length($filter));
-				if ($pfx ne $filter) {
-					next PROJECT;
-				}
-				my $sfx = substr($path, length($filter));
-				if ($sfx !~ /^\/.*\.git$/) {
-					next PROJECT;
-				}
-			} elsif ($check_forks) {
-			PATH:
-				foreach my $filter (keys %paths) {
-					# looking for forks;
-					my $pfx = substr($path, 0, length($filter));
-					if ($pfx ne $filter) {
-						next PATH;
-					}
-					my $sfx = substr($path, length($filter));
-					if ($sfx !~ /^\/.*\.git$/) {
-						next PATH;
-					}
-					# is a fork, don't include it in
-					# the list
-					next PROJECT;
-				}
+			# if $filter is rpovided, check if $path begins with $filter
+			if ($filter && $path !~ m!^\Q$filter\E/!) {
+				next;
 			}
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
@@ -2736,8 +2714,6 @@ sub git_get_projects_list {
 					owner => to_utf8($owner),
 				};
 				push @list, $pr;
-				(my $forks_path = $path) =~ s/\.git$//;
-				$paths{$forks_path}++;
 			}
 		}
 		close $fd;
@@ -2745,6 +2721,67 @@ sub git_get_projects_list {
 	return @list;
 }
 
+# this assumes that forks follow immediately forked projects:
+# [ ..., 'repo.git', 'repo/fork.git', ...]; if not, set second
+# parameter to true value to sort projects by path first.
+sub filter_forks_from_projects_list {
+	my ($projects, $need_sorting) = @_;
+
+	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
+		if ($need_sorting);
+
+	my (@filtered, $last_pr);
+ PROJECT:
+	foreach my $pr (@$projects) {
+		if ($last_pr &&
+		    $pr->{'path'} =~ m!^\Q$last_pr\E/!) {
+			# this is fork, add it to 'forks' and skip it
+			push @{$filtered[-1]->{'forks'}}, $pr;
+			next PROJECT;
+		}
+		($last_pr = $pr->{'path'}) =~ s/\.git$//;
+		if ($last_pr !~ m!/*$! && -d "$projectroot/$last_pr") {
+			# it was not foo/.git, and there can be forks
+			$pr->{'forks'} = [];
+		}
+		push @filtered, $pr;
+	}
+
+	return @filtered;
+}
+
+# note: fill_project_list_info must be run first,
+# for 'descr_long' and 'ctags' to be filled
+sub search_projects_list {
+	my ($projlist, %opts) = @_;
+	my $tagfilter  = $opts{'tagfilter'};
+	my $searchtext = $opts{'searchtext'};
+
+	return @$projlist
+		unless ($tagfilter || $searchtext);
+
+	my @projects;
+ PROJECT:
+	foreach my $pr (@$projlist) {
+
+		if ($tagfilter) {
+			next unless ref($pr->{'ctags'}) eq 'HASH';
+			next unless
+				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
+		}
+
+		if ($searchtext) {
+			next unless
+				$pr->{'path'} =~ /$searchtext/ ||
+				$pr->{'descr_long'} =~ /$searchtext/;
+		}
+
+		push @projects, $pr;
+	}
+
+	return @projects;
+}
+
 our $gitweb_project_owner = undef;
 sub git_get_project_list_from_file {
 
@@ -4727,7 +4764,7 @@ sub git_patchset_body {
 # project in the list, removing invalid projects from returned list
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
-	my ($projlist, $check_forks) = @_;
+	my $projlist = shift;
 	my @projects;
 
 	my $show_ctags = gitweb_check_feature('ctags');
@@ -4747,23 +4784,36 @@ sub fill_project_list_info {
 		if (!defined $pr->{'owner'}) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
-		if ($check_forks) {
-			my $pname = $pr->{'path'};
-			if (($pname =~ s/\.git$//) &&
-			    ($pname !~ /\/$/) &&
-			    (-d "$projectroot/$pname")) {
-				$pr->{'forks'} = "-d $projectroot/$pname";
-			} else {
-				$pr->{'forks'} = 0;
-			}
+		if ($show_ctags) {
+			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
-		$show_ctags and $pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		push @projects, $pr;
 	}
 
 	return @projects;
 }
 
+sub sort_projects_list {
+	my ($projlist, $order) = @_;
+	my @projects;
+
+	my %order_info = (
+		project => { key => 'path', type => 'str' },
+		descr => { key => 'descr_long', type => 'str' },
+		owner => { key => 'owner', type => 'str' },
+		age => { key => 'age', type => 'num' }
+	);
+	my $oi = $order_info{$order};
+	return @$projlist unless defined $oi;
+	if ($oi->{'type'} eq 'str') {
+		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projlist;
+	} else {
+		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projlist;
+	}
+
+	return @projects;
+}
+
 # print 'sort by' <th> element, generating 'sort by $name' replay link
 # if that order is not selected
 sub print_sort_th {
@@ -4790,28 +4840,39 @@ sub format_sort_th {
 sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+	my @projects = @$projlist;
 
 	my $check_forks = gitweb_check_feature('forks');
-	my @projects = fill_project_list_info($projlist, $check_forks);
+	my $show_ctags  = gitweb_check_feature('ctags');
+	my $tagfilter = $show_ctags ? $cgi->param('by_tag') : undef;
+	$check_forks = undef
+		if ($tagfilter || $searchtext);
+
+	# filtering out forks before filling info allows to do less work
+	@projects = filter_forks_from_projects_list(\@projects)
+		if ($check_forks);
+	@projects = fill_project_list_info(\@projects);
+	# searching projects require filling to be run before it
+	@projects = search_projects_list(\@projects,
+	                                 'searchtext' => $searchtext,
+	                                 'tagfilter'  => $tagfilter)
+		if ($tagfilter || $searchtext);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
-	my %order_info = (
-		project => { key => 'path', type => 'str' },
-		descr => { key => 'descr_long', type => 'str' },
-		owner => { key => 'owner', type => 'str' },
-		age => { key => 'age', type => 'num' }
-	);
-	my $oi = $order_info{$order};
-	if ($oi->{'type'} eq 'str') {
-		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
-	} else {
-		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
+	# short circuit
+	if ($from > $to) {
+		print "<center>\n".
+		      "<b>No such projects found</b><br />\n".
+		      "Click ".$cgi->a({-href=>href(project=>undef)},"here")." to view all projects<br />\n".
+		      "</center>\n<br />\n";
+		return;
 	}
 
-	my $show_ctags = gitweb_check_feature('ctags');
+	@projects = sort_projects_list(\@projects, $order);
+
 	if ($show_ctags) {
 		my %ctags;
 		foreach my $p (@projects) {
@@ -4837,32 +4898,26 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 	my $alternate = 1;
-	my $tagfilter = $cgi->param('by_tag');
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
 
-		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tagfilter } keys %{$pr->{'ctags'}};
-		next if $searchtext and not $pr->{'path'} =~ /$searchtext/
-			and not $pr->{'descr_long'} =~ /$searchtext/;
-		# Weed out forks or non-matching entries of search
-		if ($check_forks) {
-			my $forkbase = $project; $forkbase ||= ''; $forkbase =~ s#\.git$#/#;
-			$forkbase="^$forkbase" if $forkbase;
-			next if not $searchtext and not $tagfilter and $show_ctags
-				and $pr->{'path'} =~ m#$forkbase.*/.*#; # regexp-safe
-		}
-
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+
 		if ($check_forks) {
 			print "<td>";
 			if ($pr->{'forks'}) {
-				print "<!-- $pr->{'forks'} -->\n";
-				print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
+				my $nforks = scalar @{$pr->{'forks'}};
+				if ($nforks > 0) {
+					print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks"),
+					               -title => "$nforks forks"}, "+");
+				} else {
+					print $cgi->span({-title => "$nforks forks"}, "+");
+				}
 			}
 			print "</td>\n";
 		}
@@ -5343,7 +5398,10 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list($project);
+	my @projects = git_get_projects_list();
+	if (!@projects) {
+		die_error(404, "No projects found");
+	}
 
 	print $cgi->header(
 		-type => 'text/plain',
@@ -5385,7 +5443,11 @@ sub git_summary {
 	my $check_forks = gitweb_check_feature('forks');
 
 	if ($check_forks) {
+		# find forks of a project
 		@forklist = git_get_projects_list($project);
+		# filter out forks of forks
+		@forklist = filter_forks_from_projects_list(\@forklist)
+			if (@forklist);
 	}
 
 	git_header_html();
@@ -7305,6 +7367,9 @@ sub git_atom {
 
 sub git_opml {
 	my @list = git_get_projects_list();
+	if (!@list) {
+		die_error(404, "No projects found");
+	}
 
 	print $cgi->header(
 		-type => 'text/xml',
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 35c151d..0dc573d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -591,4 +591,53 @@ test_expect_success HIGHLIGHT \
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 
+# ----------------------------------------------------------------------
+# forks of projects
+
+cat >>gitweb_config.perl <<-\EOF &&
+$feature{'forks'}{'default'} = [1];
+EOF
+
+test_expect_success \
+	'forks: prepare' \
+	'git init --bare foo.git &&
+	 git --git-dir=foo.git --work-tree=. add file &&
+	 git --git-dir=foo.git --work-tree=. commit -m "Initial commit" &&
+	 echo "foo" > foo.git/description &&
+	 mkdir -p foo &&
+	 (cd foo &&
+	  git clone --shared --bare ../foo.git foo-forked.git &&
+	  echo "fork of foo" > foo-forked.git/description)'
+
+test_expect_success \
+	'forks: projects list' \
+	'gitweb_run'
+
+test_expect_success \
+	'forks: forks action' \
+	'gitweb_run "p=foo.git;a=forks"'
+
+# ----------------------------------------------------------------------
+# content tags (tag cloud)
+
+cat >>gitweb_config.perl <<-\EOF &&
+# we don't test _setting_ content tags, so any true value is good
+$feature{'ctags'}{'default'} = ['ctags_script.cgi'];
+EOF
+
+test_expect_success \
+	'ctags: tag cloud in projects list' \
+	'mkdir .git/ctags &&
+	 echo "2" > .git/ctags/foo &&
+	 echo "1" > .git/ctags/bar &&
+	gitweb_run'
+
+test_expect_success \
+	'ctags: search projects by existing tag' \
+	'gitweb_run "by_tag=foo"'
+
+test_expect_success \
+	'ctags: search projects by non existent tag' \
+	'gitweb_run "by_tag=non-existent"'
+
 test_done
