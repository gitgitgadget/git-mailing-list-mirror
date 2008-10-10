From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: refactor input parameters parse/validation
Date: Fri, 10 Oct 2008 20:42:26 +0200
Message-ID: <1223664146-11937-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <20081010150108.GC29829@spearce.org>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 20:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoMxn-0006cA-07
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 20:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761014AbYJJSmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760940AbYJJSmb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 14:42:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:22368 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760281AbYJJSm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 14:42:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so406285fgg.17
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KGJX1VlxJB+NcYjtDW35RlYjzZPYeMZLuYJcQR8NApQ=;
        b=SSg44o6yhYfFnMuOM72GIlv2BsZdHR9Hpkpoe6NYBKwMQ29i1MJO5wLCaCrWqVlyMn
         VpdY0Lc+hV7o4JHuB8OcO+G/4d4bq4UDBstDPIHCGJU9CCtj5NJDS1Bc5YpRb6tJLEVv
         iFPqZ1/S77wnqynWz5emIzimOZ4Y/YM/fNZnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kZwBW07bd8tPRaAHR3seBJFrRyxsBarU2u2zaKAQhDYlWfiQPeFPMpLCv3HcZP/Efd
         ERw8ZkJff1+i8SJ0Z0hQluoeVTmWyVFKCPUcI7rckeXEMhtGyn7bzhOJcKmP+madUJhn
         CeCeWk77LGay13VOw4LWWx5idQi30NZQa/9ao=
Received: by 10.181.147.3 with SMTP id z3mr2067518bkn.17.1223664146859;
        Fri, 10 Oct 2008 11:42:26 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id e17sm2492814fke.10.2008.10.10.11.42.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Oct 2008 11:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <20081010150108.GC29829@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97953>

Since input parameters can be obtained both from CGI parameters and
PATH_INFO, we would like most of the code to be agnostic about the way
parameters were retrieved. We thus collect all the parameters into the
new %input_params hash, delaying validation after the collection is
completed.

Although the kludge removal is minimal at the moment, it makes life much
easier for future expansions such as more extensive PATH_INFO use or
other form of input such as command-line support.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |  315 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 178 insertions(+), 137 deletions(-)

This resend fixes a bug spotted by Shwan Pearce, where the global $action
instead of the local $input was used for action validation. Although the bug
itself didn't have any effect because validate_action was called on $action
anyway, it's still a logical error that needed squashing.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1116800..c5254af 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -29,7 +29,9 @@ our $my_uri = $cgi->url(-absolute => 1);
 
 # if we're called with PATH_INFO, we have to strip that
 # from the URL to find our real URL
-if (my $path_info = $ENV{"PATH_INFO"}) {
+# we make $path_info global because it's also used later on
+my $path_info = $ENV{"PATH_INFO"};
+if ($path_info) {
 	$my_url =~ s,\Q$path_info\E$,,;
 	$my_uri =~ s,\Q$path_info\E$,,;
 }
@@ -428,34 +430,155 @@ $projects_list ||= $projectroot;
 
 # ======================================================================
 # input validation and dispatch
-our $action = $cgi->param('a');
+
+# input parameters can be collected from a variety of sources (presently, CGI
+# and PATH_INFO), so we define an %input_params hash that collects them all
+# together during validation: this allows subsequent uses (e.g. href()) to be
+# agnostic of the parameter origin
+
+my %input_params = ();
+
+# input parameters are stored with the long parameter name as key. This will
+# also be used in the href subroutine to convert parameters to their CGI
+# equivalent, and since the href() usage is the most frequent one, we store
+# the name -> CGI key mapping here, instead of the reverse.
+#
+# XXX: Warning: If you touch this, check the search form for updating,
+# too.
+
+my @cgi_param_mapping = (
+	project => "p",
+	action => "a",
+	file_name => "f",
+	file_parent => "fp",
+	hash => "h",
+	hash_parent => "hp",
+	hash_base => "hb",
+	hash_parent_base => "hpb",
+	page => "pg",
+	order => "o",
+	searchtext => "s",
+	searchtype => "st",
+	snapshot_format => "sf",
+	extra_options => "opt",
+	search_use_regexp => "sr",
+);
+my %cgi_param_mapping = @cgi_param_mapping;
+
+# we will also need to know the possible actions, for validation
+my %actions = (
+	"blame" => \&git_blame,
+	"blobdiff" => \&git_blobdiff,
+	"blobdiff_plain" => \&git_blobdiff_plain,
+	"blob" => \&git_blob,
+	"blob_plain" => \&git_blob_plain,
+	"commitdiff" => \&git_commitdiff,
+	"commitdiff_plain" => \&git_commitdiff_plain,
+	"commit" => \&git_commit,
+	"forks" => \&git_forks,
+	"heads" => \&git_heads,
+	"history" => \&git_history,
+	"log" => \&git_log,
+	"rss" => \&git_rss,
+	"atom" => \&git_atom,
+	"search" => \&git_search,
+	"search_help" => \&git_search_help,
+	"shortlog" => \&git_shortlog,
+	"summary" => \&git_summary,
+	"tag" => \&git_tag,
+	"tags" => \&git_tags,
+	"tree" => \&git_tree,
+	"snapshot" => \&git_snapshot,
+	"object" => \&git_object,
+	# those below don't need $project
+	"opml" => \&git_opml,
+	"project_list" => \&git_project_list,
+	"project_index" => \&git_project_index,
+);
+
+# finally, we have the hash of allowed extra_options for the commands that
+# allow them
+my %allowed_options = (
+	"--no-merges" => [ qw(rss atom log shortlog history) ],
+);
+
+# fill %input_params with the CGI parameters. All values except for 'opt'
+# should be single values, but opt can be an array. We should probably
+# build an array of parameters that can be multi-valued, but since for the time
+# being it's only this one, we just single it out
+while (my ($name, $symbol) = each %cgi_param_mapping) {
+	if ($symbol eq 'opt') {
+		$input_params{$name} = [ $cgi->param($symbol) ];
+	} else {
+		$input_params{$name} = $cgi->param($symbol);
+	}
+}
+
+# now read PATH_INFO and update the parameter list for missing parameters
+sub evaluate_path_info {
+	return if defined $input_params{'project'};
+	return if !$path_info;
+	$path_info =~ s,^/+,,;
+	return if !$path_info;
+
+	# find which part of PATH_INFO is project
+	my $project = $path_info;
+	$project =~ s,/+$,,;
+	while ($project && !check_head_link("$projectroot/$project")) {
+		$project =~ s,/*[^/]*$,,;
+	}
+	return unless $project;
+	$input_params{'project'} = $project;
+
+	# do not change any parameters if an action is given using the query string
+	return if $input_params{'action'};
+	$path_info =~ s,^\Q$project\E/*,,;
+
+	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	if (defined $pathname) {
+		# we got "project.git/branch:filename" or "project.git/branch:dir/"
+		# we could use git_get_type(branch:pathname), but it needs $git_dir
+		$pathname =~ s,^/+,,;
+		if (!$pathname || substr($pathname, -1) eq "/") {
+			$input_params{'action'} = "tree";
+			$pathname =~ s,/$,,;
+		} else {
+			$input_params{'action'} = "blob_plain";
+		}
+		$input_params{'hash_base'} ||= $refname;
+		$input_params{'file_name'} ||= $pathname;
+	} elsif (defined $refname) {
+		# we got "project.git/branch"
+		$input_params{'action'} = "shortlog";
+		$input_params{'hash'} ||= $refname;
+	}
+}
+evaluate_path_info();
+
+our $action = $input_params{'action'};
 if (defined $action) {
-	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
+	if (!validate_action($action)) {
 		die_error(400, "Invalid action parameter");
 	}
 }
 
 # parameters which are pathnames
-our $project = $cgi->param('p');
+our $project = $input_params{'project'};
 if (defined $project) {
-	if (!validate_pathname($project) ||
-	    !(-d "$projectroot/$project") ||
-	    !check_head_link("$projectroot/$project") ||
-	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
-	    ($strict_export && !project_in_list($project))) {
+	if (!validate_project($project)) {
 		undef $project;
 		die_error(404, "No such project");
 	}
 }
 
-our $file_name = $cgi->param('f');
+our $file_name = $input_params{'file_name'};
 if (defined $file_name) {
 	if (!validate_pathname($file_name)) {
 		die_error(400, "Invalid file parameter");
 	}
 }
 
-our $file_parent = $cgi->param('fp');
+our $file_parent = $input_params{'file_parent'};
 if (defined $file_parent) {
 	if (!validate_pathname($file_parent)) {
 		die_error(400, "Invalid file parent parameter");
@@ -463,44 +586,41 @@ if (defined $file_parent) {
 }
 
 # parameters which are refnames
-our $hash = $cgi->param('h');
+our $hash = $input_params{'hash'};
 if (defined $hash) {
 	if (!validate_refname($hash)) {
 		die_error(400, "Invalid hash parameter");
 	}
 }
 
-our $hash_parent = $cgi->param('hp');
+our $hash_parent = $input_params{'hash_parent'};
 if (defined $hash_parent) {
 	if (!validate_refname($hash_parent)) {
 		die_error(400, "Invalid hash parent parameter");
 	}
 }
 
-our $hash_base = $cgi->param('hb');
+our $hash_base = $input_params{'hash_base'};
 if (defined $hash_base) {
 	if (!validate_refname($hash_base)) {
 		die_error(400, "Invalid hash base parameter");
 	}
 }
 
-my %allowed_options = (
-	"--no-merges" => [ qw(rss atom log shortlog history) ],
-);
-
-our @extra_options = $cgi->param('opt');
-if (defined @extra_options) {
-	foreach my $opt (@extra_options) {
-		if (not exists $allowed_options{$opt}) {
-			die_error(400, "Invalid option parameter");
-		}
-		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
-			die_error(400, "Invalid option parameter for this action");
-		}
+our @extra_options = @{$input_params{'extra_options'}};
+# @extra_options is always defined, since it can only be (currently) set from
+# CGI, and $cgi->param() returns the empty array in array context if the param
+# is not set
+foreach my $opt (@extra_options) {
+	if (not exists $allowed_options{$opt}) {
+		die_error(400, "Invalid option parameter");
+	}
+	if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
+		die_error(400, "Invalid option parameter for this action");
 	}
 }
 
-our $hash_parent_base = $cgi->param('hpb');
+our $hash_parent_base = $input_params{'hash_parent_base'};
 if (defined $hash_parent_base) {
 	if (!validate_refname($hash_parent_base)) {
 		die_error(400, "Invalid hash parent base parameter");
@@ -508,23 +628,23 @@ if (defined $hash_parent_base) {
 }
 
 # other parameters
-our $page = $cgi->param('pg');
+our $page = $input_params{'page'};
 if (defined $page) {
 	if ($page =~ m/[^0-9]/) {
 		die_error(400, "Invalid page parameter");
 	}
 }
 
-our $searchtype = $cgi->param('st');
+our $searchtype = $input_params{'searchtype'};
 if (defined $searchtype) {
 	if ($searchtype =~ m/[^a-z]/) {
 		die_error(400, "Invalid searchtype parameter");
 	}
 }
 
-our $search_use_regexp = $cgi->param('sr');
+our $search_use_regexp = $input_params{'search_use_regexp'};
 
-our $searchtext = $cgi->param('s');
+our $searchtext = $input_params{'searchtext'};
 our $search_regexp;
 if (defined $searchtext) {
 	if (length($searchtext) < 2) {
@@ -533,86 +653,11 @@ if (defined $searchtext) {
 	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
-# now read PATH_INFO and use it as alternative to parameters
-sub evaluate_path_info {
-	return if defined $project;
-	my $path_info = $ENV{"PATH_INFO"};
-	return if !$path_info;
-	$path_info =~ s,^/+,,;
-	return if !$path_info;
-	# find which part of PATH_INFO is project
-	$project = $path_info;
-	$project =~ s,/+$,,;
-	while ($project && !check_head_link("$projectroot/$project")) {
-		$project =~ s,/*[^/]*$,,;
-	}
-	# validate project
-	$project = validate_pathname($project);
-	if (!$project ||
-	    ($export_ok && !-e "$projectroot/$project/$export_ok") ||
-	    ($strict_export && !project_in_list($project))) {
-		undef $project;
-		return;
-	}
-	# do not change any parameters if an action is given using the query string
-	return if $action;
-	$path_info =~ s,^\Q$project\E/*,,;
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
-	if (defined $pathname) {
-		# we got "project.git/branch:filename" or "project.git/branch:dir/"
-		# we could use git_get_type(branch:pathname), but it needs $git_dir
-		$pathname =~ s,^/+,,;
-		if (!$pathname || substr($pathname, -1) eq "/") {
-			$action  ||= "tree";
-			$pathname =~ s,/$,,;
-		} else {
-			$action  ||= "blob_plain";
-		}
-		$hash_base ||= validate_refname($refname);
-		$file_name ||= validate_pathname($pathname);
-	} elsif (defined $refname) {
-		# we got "project.git/branch"
-		$action ||= "shortlog";
-		$hash   ||= validate_refname($refname);
-	}
-}
-evaluate_path_info();
-
 # path to the current git repository
 our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
 # dispatch
-my %actions = (
-	"blame" => \&git_blame,
-	"blobdiff" => \&git_blobdiff,
-	"blobdiff_plain" => \&git_blobdiff_plain,
-	"blob" => \&git_blob,
-	"blob_plain" => \&git_blob_plain,
-	"commitdiff" => \&git_commitdiff,
-	"commitdiff_plain" => \&git_commitdiff_plain,
-	"commit" => \&git_commit,
-	"forks" => \&git_forks,
-	"heads" => \&git_heads,
-	"history" => \&git_history,
-	"log" => \&git_log,
-	"rss" => \&git_rss,
-	"atom" => \&git_atom,
-	"search" => \&git_search,
-	"search_help" => \&git_search_help,
-	"shortlog" => \&git_shortlog,
-	"summary" => \&git_summary,
-	"tag" => \&git_tag,
-	"tags" => \&git_tags,
-	"tree" => \&git_tree,
-	"snapshot" => \&git_snapshot,
-	"object" => \&git_object,
-	# those below don't need $project
-	"opml" => \&git_opml,
-	"project_list" => \&git_project_list,
-	"project_index" => \&git_project_index,
-);
-
 if (!defined $action) {
 	if (defined $hash) {
 		$action = git_get_type($hash);
@@ -642,35 +687,12 @@ sub href (%) {
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
 
-	# XXX: Warning: If you touch this, check the search form for updating,
-	# too.
-
-	my @mapping = (
-		project => "p",
-		action => "a",
-		file_name => "f",
-		file_parent => "fp",
-		hash => "h",
-		hash_parent => "hp",
-		hash_base => "hb",
-		hash_parent_base => "hpb",
-		page => "pg",
-		order => "o",
-		searchtext => "s",
-		searchtype => "st",
-		snapshot_format => "sf",
-		extra_options => "opt",
-		search_use_regexp => "sr",
-	);
-	my %mapping = @mapping;
-
 	$params{'project'} = $project unless exists $params{'project'};
 
 	if ($params{-replay}) {
-		while (my ($name, $symbol) = each %mapping) {
+		while (my ($name, $symbol) = each %cgi_param_mapping) {
 			if (!exists $params{$name}) {
-				# to allow for multivalued params we use arrayref form
-				$params{$name} = [ $cgi->param($symbol) ];
+				$params{$name} = $input_params{$name};
 			}
 		}
 	}
@@ -689,8 +711,8 @@ sub href (%) {
 
 	# now encode the parameters explicitly
 	my @result = ();
-	for (my $i = 0; $i < @mapping; $i += 2) {
-		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
+	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
+		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
 		if (defined $params{$name}) {
 			if (ref($params{$name}) eq "ARRAY") {
 				foreach my $par (@{$params{$name}}) {
@@ -710,6 +732,25 @@ sub href (%) {
 ## ======================================================================
 ## validation, quoting/unquoting and escaping
 
+sub validate_action {
+	my $input = shift || return undef;
+	return undef unless exists $actions{$input};
+	return $input;
+}
+
+sub validate_project {
+	my $input = shift || return undef;
+	if (!validate_pathname($input) ||
+		!(-d "$projectroot/$input") ||
+		!check_head_link("$projectroot/$input") ||
+		($export_ok && !(-e "$projectroot/$input/$export_ok")) ||
+		($strict_export && !project_in_list($input))) {
+		return undef;
+	} else {
+		return $input;
+	}
+}
+
 sub validate_pathname {
 	my $input = shift || return undef;
 
@@ -4121,7 +4162,7 @@ sub git_search_grep_body {
 ## actions
 
 sub git_project_list {
-	my $order = $cgi->param('o');
+	my $order = $input_params{'order'};
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(400, "Unknown order parameter");
 	}
@@ -4149,7 +4190,7 @@ sub git_project_list {
 }
 
 sub git_forks {
-	my $order = $cgi->param('o');
+	my $order = $input_params{'order'};
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(400, "Unknown order parameter");
 	}
@@ -4697,7 +4738,7 @@ sub git_snapshot {
 	my @supported_fmts = gitweb_check_feature('snapshot');
 	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
 
-	my $format = $cgi->param('sf');
+	my $format = $input_params{'snapshot_format'};
 	if (!@supported_fmts) {
 		die_error(403, "Snapshots not allowed");
 	}
-- 
1.5.6.5
