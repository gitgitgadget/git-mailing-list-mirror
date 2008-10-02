From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: refactor input parameters parse/validation
Date: Thu,  2 Oct 2008 02:10:30 +0200
Message-ID: <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnI-00017h-F0
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbYJBAKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYJBAKL
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:11 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:2546 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYJBAKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:08 -0400
Received: by ik-out-1112.google.com with SMTP id c30so567813ika.5
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ws/0cgPDblXi+i2/KXCX7I/9E7goaUcUf9MaBH/OsJw=;
        b=KVmRxIqxkygRCS2Ytp23KPhp8xDIMqVP0NkJHIYY13djcBttF3yLZ/GE/oaqr/Nh9g
         NTro8SMdDXgYXpU5yu0a+dXbkqLCPIAkxOtVjZs7pM0QOB9GKEEIX885rzbrgc1xrqFu
         ckN7PB5GmddMycl7B7ZmSkhWodGiPWIa57CTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UIeXSx4biOmy4+QL2K/WCqIhOnP6YDFNSJfMuG56HLjOk3FCmhRNJvI8RSk3kaUbOb
         eea09cWK9/sxip3qbJPv3jGcaWDlk9Mhi16u6NfJPUfoLOgXbIeO5QGXFQRGY27CDd4H
         h4AQ+RlMb5z3kaS7tK0/bGIpLrr2ytEr73Ar0=
Received: by 10.210.24.12 with SMTP id 12mr1598314ebx.187.1222906205899;
        Wed, 01 Oct 2008 17:10:05 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 7sm1109852eyg.0.2008.10.01.17.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97281>

Since input parameters can now be obtained both from CGI parameters and
PATH_INFO, we would like most of the code to be agnostic about the way
parameters were retrieved.

We thus collect all the parameters into the new %input_params hash,
removing the need for ad-hoc kludgy code in href(). As much of the
parameters validation code is now shared between CGI and PATH_INFO,
although this requires PATH_INFO parsing to be interleaved into the main
code instead of being factored out into its own routine.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |  336 ++++++++++++++++++++++++++++------------------------
 1 files changed, 183 insertions(+), 153 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f088681..ec4326f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -28,8 +28,10 @@ our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
 # if we're called with PATH_INFO, we have to strip that
-# from the URL to find our real URL
-if (my $path_info = $ENV{"PATH_INFO"}) {
+# from the URL to find our real URL. PATH_INFO is kept
+# as it's used later on for parameter extraction
+my $path_info = $ENV{"PATH_INFO"};
+if ($path_info) {
 	$my_url =~ s,\Q$path_info\E$,,;
 	$my_uri =~ s,\Q$path_info\E$,,;
 }
@@ -390,15 +392,111 @@ $projects_list ||= $projectroot;
 
 # ======================================================================
 # input validation and dispatch
-our $action = $cgi->param('a');
-if (defined $action) {
-	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
-		die_error(400, "Invalid action parameter");
+
+# input parameters can be collected from a variety of sources (presently, CGI
+# and PATH_INFO), so we define an %input_params hash that collects them all
+# together during validation: this allows subsequent uses (e.g. href()) to be
+# agnostic of the parameter origin
+
+my %input_params = ();
+
+# input parameters are stored with the long parameter name as key, so we need
+# the name -> CGI key mapping here. This will also be used in the href
+# subroutine to convert parameters to their CGI equivalent.
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
+# fill %input_params with the CGI parameters. All values except for 'opt'
+# should be single values, but opt can be an array. We should probably
+# build an array of parameters that can be multi-valued, but since for the time
+# being it's only this one, we just single it out
+while (my ($name, $symbol) = each %cgi_param_mapping) {
+	if ($symbol eq 'opt') {
+		$input_params{$name} = [$cgi->param($symbol)];
+	} else {
+		$input_params{$name} = $cgi->param($symbol);
 	}
 }
 
-# parameters which are pathnames
-our $project = $cgi->param('p');
+# next, we want to parse PATH_INFO (which was already stored in $path_info at
+# the beginning). This is a little hairy because PATH_INFO parsing needs some
+# form of parameter validation, so we interleave parsing and validation.
+#
+# The accepted PATH_INFO syntax is $project/$action/$hash or
+# $project/$action/$hash_base:$file_name, where $action may be missing (mostly for
+# backwards compatibility), so we need to parse and validate the parameters in
+# this same order.
+
+# clear $path_info of any leading /
+$path_info =~ s,^/+,,;
+
+our $project = $input_params{'project'};
+if ($path_info && !defined $project) {
+	# if $project was not defined by CGI, we try to extract it from
+	# $path_info
+	$project = $path_info;
+	$project =~ s,/+$,,;
+	while ($project && !check_head_link("$projectroot/$project")) {
+		$project =~ s,/*[^/]*$,,;
+	}
+	$input_params{'project'} = $project;
+} else {
+	# otherwise, we suppress $path_info parsing altogether
+	$path_info = undef;
+}
+
+# project name validation
 if (defined $project) {
 	if (!validate_pathname($project) ||
 	    !(-d "$projectroot/$project") ||
@@ -408,16 +506,66 @@ if (defined $project) {
 		undef $project;
 		die_error(404, "No such project");
 	}
+
+	# we purge the $project name from the $path_info, preparing it for
+	# subsequent parameters extraction
+	$path_info =~ s,^\Q$project\E/*,, if defined $path_info;
+} else {
+	# we also suppress $path_info parsing if no project was defined
+	$path_info = undef;
+}
+
+# action parsing/validation
+our $action = $input_params{'action'};
+if ($path_info && !defined $action) {
+	# next comes the action
+	$action = $path_info;
+	$action =~ s,/.*$,,;
+	if (exists $actions{$action}) {
+		# remove the action from $path_info, and sync %input_params
+		$path_info =~ s,^$action/*,,;
+		$input_params{'action'} = $action;
+	} else {
+		$action  = undef;
+	}
+} elsif (defined $action && !exists $actions{$action}) {
+	die_error(400, "Invalid action parameter");
+}
+
+# we can now parse ref and pathnames in PATH_INFO
+if ($path_info) {
+	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	if (defined $pathname) {
+		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
+		# we could use git_get_type(branch:pathname), but it needs $git_dir
+		$pathname =~ s,^/+,,;
+		if (!$pathname || substr($pathname, -1) eq "/") {
+			$input_params{'action'} ||= "tree";
+			$pathname =~ s,/$,,;
+		} else {
+			$input_params{'action'}  ||= "blob_plain";
+		}
+		$input_params{'hash_base'} ||= $refname;
+		$input_params{'file_name'} ||= $pathname;
+	} elsif (defined $refname) {
+		# we got "project.git/branch"
+		$input_params{'action'}    ||= "shortlog";
+		$input_params{'hash'}      ||= $refname;
+		$input_params{'hash_base'} ||= $refname;
+	}
 }
 
-our $file_name = $cgi->param('f');
+# and now the rest of the validation
+
+# parameters which are pathnames
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
@@ -425,21 +573,21 @@ if (defined $file_parent) {
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
@@ -450,19 +598,19 @@ my %allowed_options = (
 	"--no-merges" => [ qw(rss atom log shortlog history) ],
 );
 
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
+# CGI, and $cgi->param() returns the empty array in array context
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
@@ -470,23 +618,23 @@ if (defined $hash_parent_base) {
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
@@ -495,93 +643,6 @@ if (defined $searchtext) {
 	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
-# dispatch
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
-
-	# next comes the action
-	$action = $path_info;
-	$action =~ s,/.*$,,;
-	if (exists $actions{$action}) {
-		$path_info =~ s,^$action/*,,;
-	} else {
-		$action  = undef;
-	}
-
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
-	if (defined $pathname) {
-		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
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
-		$action    ||= "shortlog";
-		$hash      ||= validate_refname($refname);
-		$hash_base ||= validate_refname($refname);
-	}
-}
-evaluate_path_info();
-
 # path to the current git repository
 our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
@@ -615,43 +676,12 @@ sub href (%) {
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
-			if (!exists $params{$name}) {
-				# the parameter we want to recycle may be either part of the
-				# list of CGI parameter, or recovered from PATH_INFO
-				if ($cgi->param($symbol)) {
-					# to allow for multivalued params we use arrayref form
-					$params{$name} = [ $cgi->param($symbol) ];
-				} else {
-					no strict 'refs';
-					$params{$name} = $$name if $$name;
-				}
-			}
+		while (my ($name, $val) = each %input_params) {
+			$params{$name} = $input_params{$name}
+				unless (exists $params{$name});
 		}
 	}
 
@@ -669,8 +699,8 @@ sub href (%) {
 
 	# now encode the parameters explicitly
 	my @result = ();
-	for (my $i = 0; $i < @mapping; $i += 2) {
-		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
+	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
+		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
 		if (defined $params{$name}) {
 			if (ref($params{$name}) eq "ARRAY") {
 				foreach my $par (@{$params{$name}}) {
@@ -4006,7 +4036,7 @@ sub git_search_grep_body {
 ## actions
 
 sub git_project_list {
-	my $order = $cgi->param('o');
+	my $order = $input_params{'order'};
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(400, "Unknown order parameter");
 	}
@@ -4029,7 +4059,7 @@ sub git_project_list {
 }
 
 sub git_forks {
-	my $order = $cgi->param('o');
+	my $order = $input_params{'order'};
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(400, "Unknown order parameter");
 	}
@@ -4562,7 +4592,7 @@ sub git_snapshot {
 	my @supported_fmts = gitweb_check_feature('snapshot');
 	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
 
-	my $format = $cgi->param('sf');
+	my $format = $input_params{'snapshot_format'};
 	if (!@supported_fmts) {
 		die_error(403, "Snapshots not allowed");
 	}
-- 
1.5.6.5
