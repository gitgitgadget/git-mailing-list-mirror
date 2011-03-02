From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC] gitweb: Restructure projects list generation
Date: Wed, 2 Mar 2011 17:11:19 +0100
Message-ID: <201103021711.25241.jnareb@gmail.com>
References: <20110226215230.5333.92839.stgit@localhost.localdomain> <201102271603.13902.jnareb@gmail.com> <201103010202.01408.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 17:12:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puoeh-0004hy-VP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab1CBQL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:11:58 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41198 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1CBQLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:11:55 -0500
Received: by ewy6 with SMTP id 6so39240ewy.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=YhpqsSR9/e2R1xnmNLyCUUk8SfYWhqkRLfHRkz6+380=;
        b=TDFuCNCKXc1LL9GxgIlqOnIJKHTQoZ0PDOnKDFqa1usMNCA7wd+2tyPqpjEj6uajZM
         TrfZrTOQP7XN/wmp02o6jTexekjM3wg7F8XdkHN2Vm474604E5cY4JiIexix1ftQHQOs
         UpcUGnxtDjm/XIrIJLdFV+D3ZdUI8aMsCm89g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N0CLhM0ExY3RxBgALGEOCyTNYktfwF5+IqUw/xHXfjup5ZiRQ+/JznoKWCG8d+2C1f
         CniAGFPjMceL8r8SMJT45ATBzgLYcvLFkUy+vR5+wyJR3UOqU/UQjNnGHToFKWGXUDU3
         6TPutVPZckp/sXlhl5NHDbggUaqHThQNLi8AM=
Received: by 10.223.2.212 with SMTP id 20mr80101fak.46.1299082300562;
        Wed, 02 Mar 2011 08:11:40 -0800 (PST)
Received: from [192.168.1.13] (abvi92.neoplus.adsl.tpnet.pl [83.8.206.92])
        by mx.google.com with ESMTPS id b7sm58573faa.18.2011.03.02.08.11.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 08:11:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201103010202.01408.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168321>

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
now removed).  Forks handling is also cleaned up and simplified.
$pr->{'forks'} now contains un-filled list of forks; we can now also
detect situation where the way for having forks is prepared, but there
are no forks yet.

Sorting projects got also refactored in a very straight way (just
moving code) into sort_projects_list subroutine.

The interaction between forks, content tags and searching is now made
more explicit: searching whether by tag, or via search form turns off
fork filtering (gitweb searches also forks, and will show all
results).  If 'ctags' feature is disabled, then searching by tag is
too.

The t9500 test now includes some basic test for 'forks' and 'ctags'
features; the t9502 includes test checking if gitweb correctly filters
out forks.


Generating list of projects by scanning given directory is now also a
bit simplified wrt. handling filtering; it is byproduct of extracting
filtering forks to separate subroutine.

While at it we now detect that there are no projects and respond with
"404 No projects found" also for 'project_index' and 'opml' actions.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The main difference from previous version is that newly introduced
filter_forks_from_projects_list() no longer relies on the assumption
that forked project immediately precedes all of its forks... which is
not true when $porjects_list is a directory and we have e.g. such
situation:

  repo.git
  repo.related.git
  repo_other.git
  repo/fork.git

This issue was noticed by Jonathan Nieder.

filter_forks_from_projects_list() uses trie[1] (prefix tree) to find
which repositories are forks of other projects; directories are used
as "letters" in trie.  Algorithm to create trie and find prefix match
was created with some help of code of Tree::Tree[2] Perl module from
CPAN.

[1]: http://en.wikipedia.org/wiki/Trie
[2]: http://p3rl.org/Tree::Trie

This revision includes additionally tests in t9502 that correct
projects are filtered.


Note that before this commit filtering out forks worked only for
$projects_list being a file, it assumed that forks are always after
forked project (not very unreasonable), and used algorithm which is
O(<projects>^2).

Current code filters out projects only where it should, regardless
whether $projects_list is directory or a file, and trie-based
algorithm is O(<projects>) + O(<projects forked>*<max depth>).
Current code also consistently finds shortest prefix (important in
counting forks in case of forks of forks).


This is an RFC because I am not sure if I did tests in t9502 right
and efficient enough.

There is also question whether $pr->{'forks'} should be a list of
forks, or would having $pr->{'forks'} being number of forks be enough.

Refactoring sort_projects_list and fixing handling of $project_maxdepth
could be done in a separate patches.

 gitweb/gitweb.perl                        |  250 ++++++++++++++++++++---------
 t/t9500-gitweb-standalone-no-errors.sh    |   49 ++++++
 t/t9502-gitweb-standalone-parse-output.sh |   74 +++++++++
 3 files changed, 296 insertions(+), 77 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b9369d..996b647 100755
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
@@ -2745,6 +2721,98 @@ sub git_get_projects_list {
 	return @list;
 }
 
+# written with help of Tree::Trie module (Perl Artistic License, GPL compatibile)
+# as side effects it sets 'forks' field to list of forks for forked projects
+sub filter_forks_from_projects_list {
+	my $projects = shift;
+
+	my %trie; # prefix tree of directories (path components)
+	# generate trie out of those directories that might contain forks
+	foreach my $pr (@$projects) {
+		my $path = $pr->{'path'};
+		$path =~ s/\.git$//;      # forks of 'repo.git' are in 'repo/' directory
+		next if ($path =~ m!/$!); # skip non-bare repositories, e.g. 'repo/.git'
+		next unless ($path);      # skip '.git' repository: tests, git-instaweb
+		next unless (-d $path);   # containing directory exists
+		$pr->{'forks'} = [];      # there can be 0 or more forks of project
+
+		# add to trie
+		my @dirs = split('/', $path);
+		# walk the trie, until either runs out of components or out of trie
+		my $ref = \%trie;
+		while (scalar @dirs &&
+		       exists($ref->{$dirs[0]})) {
+			$ref = $ref->{shift @dirs};
+		}
+		# create rest of trie structure from rest of components
+		foreach my $dir (@dirs) {
+			$ref = $ref->{$dir} = {};
+		}
+		# create end marker, store $pr as a data
+		$ref->{''} = $pr if (!exists $ref->{''});
+	}
+
+	# filter out forks, by finding shortest prefix match for paths
+	my @filtered;
+ PROJECT:
+	foreach my $pr (@$projects) {
+		# trie lookup
+		my $ref = \%trie;
+	DIR:
+		foreach my $dir (split('/', $pr->{'path'})) {
+			if (exists $ref->{''}) {
+				# found [shortest] prefix, is a fork - skip it
+				push @{$ref->{''}{'forks'}}, $pr;
+				next PROJECT;
+			}
+			if (!exists $ref->{$dir}) {
+				# not in trie, cannot have prefix, not a fork
+				push @filtered, $pr;
+				next PROJECT;
+			}
+			# If the dir is there, we just walk one step down the trie.
+			$ref = $ref->{$dir};
+		}
+		# we ran out of trie
+		# (shouldn't happen: it's either no match, or end marker)
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
 
@@ -4727,7 +4795,7 @@ sub git_patchset_body {
 # project in the list, removing invalid projects from returned list
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
-	my ($projlist, $check_forks) = @_;
+	my $projlist = shift;
 	my @projects;
 
 	my $show_ctags = gitweb_check_feature('ctags');
@@ -4747,23 +4815,36 @@ sub fill_project_list_info {
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
@@ -4790,28 +4871,39 @@ sub format_sort_th {
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
@@ -4837,32 +4929,26 @@ sub git_project_list_body {
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
@@ -5343,7 +5429,10 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list($project);
+	my @projects = git_get_projects_list();
+	if (!@projects) {
+		die_error(404, "No projects found");
+	}
 
 	print $cgi->header(
 		-type => 'text/plain',
@@ -5385,7 +5474,11 @@ sub git_summary {
 	my $check_forks = gitweb_check_feature('forks');
 
 	if ($check_forks) {
+		# find forks of a project
 		@forklist = git_get_projects_list($project);
+		# filter out forks of forks
+		@forklist = filter_forks_from_projects_list(\@forklist)
+			if (@forklist);
 	}
 
 	git_header_html();
@@ -7305,6 +7398,9 @@ sub git_atom {
 
 sub git_opml {
 	my @list = git_get_projects_list();
+	if (!@list) {
+		die_error(404, "No projects found");
+	}
 
 	print $cgi->header(
 		-type => 'text/xml',
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index afac5b5..71ef0ac 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -595,4 +595,53 @@ test_expect_success HIGHLIGHT \
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 
+# ----------------------------------------------------------------------
+# forks of projects
+
+cat >>gitweb_config.perl <<\EOF &&
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
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index dd83890..731e64c 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -112,4 +112,78 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+# ----------------------------------------------------------------------
+# forks of projects
+
+test_expect_success 'forks: setup' '
+	git init --bare foo.git &&
+	echo file > file &&
+	git --git-dir=foo.git --work-tree=. add file &&
+	git --git-dir=foo.git --work-tree=. commit -m "Initial commit" &&
+	echo "foo" > foo.git/description &&
+	git clone --bare foo.git foo.bar.git &&
+	echo "foo.bar" > foo.bar.git/description &&
+	git clone --bare foo.git foo_baz.git &&
+	echo "foo_baz" > foo_baz.git/description &&
+	rm -fr   foo &&
+	mkdir -p foo &&
+	(
+		cd foo &&
+		git clone --shared --bare ../foo.git foo-forked.git &&
+		echo "fork of foo" > foo-forked.git/description
+	)
+'
+
+test_expect_success 'forks: not skipped unless "forks" feature enabled' '
+	gitweb_run "a=project_list" &&
+	grep -q ">\\.git<"               gitweb.body &&
+	grep -q ">foo\\.git<"            gitweb.body &&
+	grep -q ">foo_baz\\.git<"        gitweb.body &&
+	grep -q ">foo\\.bar\\.git<"      gitweb.body &&
+	grep -q ">foo_baz\\.git<"        gitweb.body &&
+	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
+	grep -q ">fork of .*<"           gitweb.body
+'
+
+cat >>gitweb_config.perl <<\EOF &&
+$feature{'forks'}{'default'} = [1];
+EOF
+
+test_expect_success 'forks: forks skipped if "forks" feature enabled' '
+	gitweb_run "a=project_list" &&
+	grep -q ">\\.git<"               gitweb.body &&
+	grep -q ">foo\\.git<"            gitweb.body &&
+	grep -q ">foo_baz\\.git<"        gitweb.body &&
+	grep -q ">foo\\.bar\\.git<"      gitweb.body &&
+	grep -q ">foo_baz\\.git<"        gitweb.body &&
+	grep -v ">foo/foo-forked\\.git<" gitweb.body &&
+	grep -v ">fork of .*<"           gitweb.body
+'
+
+test_expect_success 'forks: "forks" action for forked repository' '
+	gitweb_run "p=foo.git;a=forks" &&
+	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
+	grep -q ">fork of foo<"          gitweb.body
+'
+
+test_expect_success 'forks: can access forked repository' '
+	gitweb_run "p=foo/foo-forked.git;a=summary" &&
+	grep -q "200 OK"        gitweb.headers &&
+	grep -q ">fork of foo<" gitweb.body
+'
+
+test_expect_success 'forks: project_index lists all projects (incl. forks)' '
+	cat >expected <<-\EOF
+	.git
+	foo.bar.git
+	foo.git
+	foo/foo-forked.git
+	foo_baz.git
+	EOF
+	gitweb_run "a=project_index" &&
+	sed -e "s/ .*//" <gitweb.body | sort >actual &&
+	test_cmp expected actual
+'
+
+
 test_done
-- 
1.7.3
