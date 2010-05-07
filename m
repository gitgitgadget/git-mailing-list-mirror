From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/2] gitweb: Put all per-connection code in run() subroutine
Date: Fri,  7 May 2010 14:54:04 +0200
Message-ID: <1273236845-6523-2-git-send-email-jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 14:54:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAN4X-0003xh-Uu
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 14:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab0EGMyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 08:54:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59776 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0EGMyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 08:54:20 -0400
Received: by bwz19 with SMTP id 19so556611bwz.21
        for <git@vger.kernel.org>; Fri, 07 May 2010 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GU00twxFld1EqJ7TrFFxCV2m34XQka+B9y1LzUqBg7s=;
        b=wJmgK6W55rVPatE/MiJXAOeIrYdAEuN5tcnt5A7E8Vs+4UdoyGXBpbmDgHS5bYCVOS
         HsvArzYp77pOvIie4r137WnNMZUawVwZOAkCi0fOrFADVA7JIdHLF1iam3R+43JwdU3J
         Q14on8pRGz2BAHwx6RpsqkUqf87S/xKhvip+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dcz2dYMJISkPDZZHuo1sKJtkUBffJ3RrrG0wtvySGPgFV3roxKNKLnK8bvdmkqaQuA
         ibHTt0/nH6gRsOKi4r+jP9PGBELDL6je3ju4UEs9h8lQlykVAL9dfTdYmq3AoW+gQTYy
         NnjFO+xbA+N+zzKQQG9FCP22ksHS9Ot8bKO2U=
Received: by 10.204.24.134 with SMTP id v6mr72169bkb.204.1273236857980;
        Fri, 07 May 2010 05:54:17 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 14sm710017bwz.2.2010.05.07.05.54.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 05:54:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146533>

All code that is run per-connection (as opposed to those parts of gitweb
code that can be run once) is put into appropriate subroutines:
 - evaluate_uri
 - evaluate_gitweb_config
 - evaluate_git_version (here only because $GIT can be set in config)
 - check_loadavg (as soon as possible; $git_version must be defined)
 - evaluate_query_params (counterpart to evaluate_path_info)
 - evaluate_and_validate_params
 - evaluate_git_dir (requires $project)
 - configure_gitweb_features (@snapshot_fmts, $git_avatar)
 - dispatch (includes setting default $action)

The difference is best viewed with '-w', '--ignore-all-space' option,
because of reindent caused by putting code in subroutines.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch requires the following commit from 'jn/gitweb-caching-prep' branch
c42b00c (gitweb: Use nonlocal jump instead of 'exit' in die_error, 2010-04-24)

This is an RFC patch because selecting which parts of gitweb code are
run-once, and which parts are per-request (and are to be put into
subroutines and run from run() subroutine) is at, least in part, a bit
subjective.

 gitweb/gitweb.perl |  359 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 205 insertions(+), 154 deletions(-)

When ignoring whitespace changes (reindenting):

 gitweb/gitweb.perl |   67 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4074300..41bf992 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -28,34 +28,42 @@ BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
 
-our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
-our $my_url = $cgi->url();
-our $my_uri = $cgi->url(-absolute => 1);
 
-# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
-# needed and used only for URLs with nonempty PATH_INFO
-our $base_url = $my_url;
+our ($my_url, $my_uri, $base_url, $path_info, $home_link);
+sub evaluate_uri {
+	our $cgi;
 
-# When the script is used as DirectoryIndex, the URL does not contain the name
-# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
-# have to do it ourselves. We make $path_info global because it's also used
-# later on.
-#
-# Another issue with the script being the DirectoryIndex is that the resulting
-# $my_url data is not the full script URL: this is good, because we want
-# generated links to keep implying the script name if it wasn't explicitly
-# indicated in the URL we're handling, but it means that $my_url cannot be used
-# as base URL.
-# Therefore, if we needed to strip PATH_INFO, then we know that we have
-# to build the base URL ourselves:
-our $path_info = $ENV{"PATH_INFO"};
-if ($path_info) {
-	if ($my_url =~ s,\Q$path_info\E$,, &&
-	    $my_uri =~ s,\Q$path_info\E$,, &&
-	    defined $ENV{'SCRIPT_NAME'}) {
-		$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+	our $my_url = $cgi->url();
+	our $my_uri = $cgi->url(-absolute => 1);
+
+	# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
+	# needed and used only for URLs with nonempty PATH_INFO
+	our $base_url = $my_url;
+
+	# When the script is used as DirectoryIndex, the URL does not contain the name
+	# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
+	# have to do it ourselves. We make $path_info global because it's also used
+	# later on.
+	#
+	# Another issue with the script being the DirectoryIndex is that the resulting
+	# $my_url data is not the full script URL: this is good, because we want
+	# generated links to keep implying the script name if it wasn't explicitly
+	# indicated in the URL we're handling, but it means that $my_url cannot be used
+	# as base URL.
+	# Therefore, if we needed to strip PATH_INFO, then we know that we have
+	# to build the base URL ourselves:
+	our $path_info = $ENV{"PATH_INFO"};
+	if ($path_info) {
+		if ($my_url =~ s,\Q$path_info\E$,, &&
+		    $my_uri =~ s,\Q$path_info\E$,, &&
+		    defined $ENV{'SCRIPT_NAME'}) {
+			$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+		}
 	}
+
+	# target of the home link on top of all pages
+	our $home_link = $my_uri || "/";
 }
 
 # core git executable to use
@@ -70,9 +78,6 @@ our $projectroot = "++GITWEB_PROJECTROOT++";
 # the number is relative to the projectroot
 our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
 
-# target of the home link on top of all pages
-our $home_link = $my_uri || "/";
-
 # string of the home link on top of all pages
 our $home_link_str = "++GITWEB_HOME_LINK_STR++";
 
@@ -566,15 +571,18 @@ sub filter_snapshot_fmts {
 		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
 }
 
-our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
-our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
-# die if there are errors parsing config file
-if (-e $GITWEB_CONFIG) {
-	do $GITWEB_CONFIG;
-	die $@ if $@;
-} elsif (-e $GITWEB_CONFIG_SYSTEM) {
-	do $GITWEB_CONFIG_SYSTEM;
-	die $@ if $@;
+our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
+sub evaluate_gitweb_config {
+	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
+	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
+	# die if there are errors parsing config file
+	if (-e $GITWEB_CONFIG) {
+		do $GITWEB_CONFIG;
+		die $@ if $@;
+	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
+		do $GITWEB_CONFIG_SYSTEM;
+		die $@ if $@;
+	}
 }
 
 # Get loadavg of system, to compare against $maxload.
@@ -600,13 +608,16 @@ sub get_loadavg {
 }
 
 # version of the core git binary
-our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
-$number_of_git_cmds++;
-
-$projects_list ||= $projectroot;
+our $git_version;
+sub evaluate_git_version {
+	our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+	$number_of_git_cmds++;
+}
 
-if (defined $maxload && get_loadavg() > $maxload) {
-	die_error(503, "The load average on the server is too high");
+sub check_loadavg {
+	if (defined $maxload && get_loadavg() > $maxload) {
+		die_error(503, "The load average on the server is too high");
+	}
 }
 
 # ======================================================================
@@ -693,11 +704,15 @@ our %allowed_options = (
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
 # being it's only this one, we just single it out
-while (my ($name, $symbol) = each %cgi_param_mapping) {
-	if ($symbol eq 'opt') {
-		$input_params{$name} = [ $cgi->param($symbol) ];
-	} else {
-		$input_params{$name} = $cgi->param($symbol);
+sub evaluate_query_params {
+	our $cgi;
+
+	while (my ($name, $symbol) = each %cgi_param_mapping) {
+		if ($symbol eq 'opt') {
+			$input_params{$name} = [ $cgi->param($symbol) ];
+		} else {
+			$input_params{$name} = $cgi->param($symbol);
+		}
 	}
 }
 
@@ -844,149 +859,185 @@ sub evaluate_path_info {
 		}
 	}
 }
-evaluate_path_info();
 
-our $action = $input_params{'action'};
-if (defined $action) {
-	if (!validate_action($action)) {
-		die_error(400, "Invalid action parameter");
+our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
+     $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
+     $searchtext, $search_regexp);
+sub evaluate_and_validate_params {
+	our $action = $input_params{'action'};
+	if (defined $action) {
+		if (!validate_action($action)) {
+			die_error(400, "Invalid action parameter");
+		}
 	}
-}
 
-# parameters which are pathnames
-our $project = $input_params{'project'};
-if (defined $project) {
-	if (!validate_project($project)) {
-		undef $project;
-		die_error(404, "No such project");
+	# parameters which are pathnames
+	our $project = $input_params{'project'};
+	if (defined $project) {
+		if (!validate_project($project)) {
+			undef $project;
+			die_error(404, "No such project");
+		}
 	}
-}
 
-our $file_name = $input_params{'file_name'};
-if (defined $file_name) {
-	if (!validate_pathname($file_name)) {
-		die_error(400, "Invalid file parameter");
+	our $file_name = $input_params{'file_name'};
+	if (defined $file_name) {
+		if (!validate_pathname($file_name)) {
+			die_error(400, "Invalid file parameter");
+		}
 	}
-}
 
-our $file_parent = $input_params{'file_parent'};
-if (defined $file_parent) {
-	if (!validate_pathname($file_parent)) {
-		die_error(400, "Invalid file parent parameter");
+	our $file_parent = $input_params{'file_parent'};
+	if (defined $file_parent) {
+		if (!validate_pathname($file_parent)) {
+			die_error(400, "Invalid file parent parameter");
+		}
 	}
-}
 
-# parameters which are refnames
-our $hash = $input_params{'hash'};
-if (defined $hash) {
-	if (!validate_refname($hash)) {
-		die_error(400, "Invalid hash parameter");
+	# parameters which are refnames
+	our $hash = $input_params{'hash'};
+	if (defined $hash) {
+		if (!validate_refname($hash)) {
+			die_error(400, "Invalid hash parameter");
+		}
 	}
-}
 
-our $hash_parent = $input_params{'hash_parent'};
-if (defined $hash_parent) {
-	if (!validate_refname($hash_parent)) {
-		die_error(400, "Invalid hash parent parameter");
+	our $hash_parent = $input_params{'hash_parent'};
+	if (defined $hash_parent) {
+		if (!validate_refname($hash_parent)) {
+			die_error(400, "Invalid hash parent parameter");
+		}
 	}
-}
 
-our $hash_base = $input_params{'hash_base'};
-if (defined $hash_base) {
-	if (!validate_refname($hash_base)) {
-		die_error(400, "Invalid hash base parameter");
+	our $hash_base = $input_params{'hash_base'};
+	if (defined $hash_base) {
+		if (!validate_refname($hash_base)) {
+			die_error(400, "Invalid hash base parameter");
+		}
 	}
-}
 
-our @extra_options = @{$input_params{'extra_options'}};
-# @extra_options is always defined, since it can only be (currently) set from
-# CGI, and $cgi->param() returns the empty array in array context if the param
-# is not set
-foreach my $opt (@extra_options) {
-	if (not exists $allowed_options{$opt}) {
-		die_error(400, "Invalid option parameter");
-	}
-	if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
-		die_error(400, "Invalid option parameter for this action");
+	our @extra_options = @{$input_params{'extra_options'}};
+	# @extra_options is always defined, since it can only be (currently) set from
+	# CGI, and $cgi->param() returns the empty array in array context if the param
+	# is not set
+	foreach my $opt (@extra_options) {
+		if (not exists $allowed_options{$opt}) {
+			die_error(400, "Invalid option parameter");
+		}
+		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
+			die_error(400, "Invalid option parameter for this action");
+		}
 	}
-}
 
-our $hash_parent_base = $input_params{'hash_parent_base'};
-if (defined $hash_parent_base) {
-	if (!validate_refname($hash_parent_base)) {
-		die_error(400, "Invalid hash parent base parameter");
+	our $hash_parent_base = $input_params{'hash_parent_base'};
+	if (defined $hash_parent_base) {
+		if (!validate_refname($hash_parent_base)) {
+			die_error(400, "Invalid hash parent base parameter");
+		}
 	}
-}
 
-# other parameters
-our $page = $input_params{'page'};
-if (defined $page) {
-	if ($page =~ m/[^0-9]/) {
-		die_error(400, "Invalid page parameter");
+	# other parameters
+	our $page = $input_params{'page'};
+	if (defined $page) {
+		if ($page =~ m/[^0-9]/) {
+			die_error(400, "Invalid page parameter");
+		}
 	}
-}
 
-our $searchtype = $input_params{'searchtype'};
-if (defined $searchtype) {
-	if ($searchtype =~ m/[^a-z]/) {
-		die_error(400, "Invalid searchtype parameter");
+	our $searchtype = $input_params{'searchtype'};
+	if (defined $searchtype) {
+		if ($searchtype =~ m/[^a-z]/) {
+			die_error(400, "Invalid searchtype parameter");
+		}
 	}
-}
 
-our $search_use_regexp = $input_params{'search_use_regexp'};
+	our $search_use_regexp = $input_params{'search_use_regexp'};
 
-our $searchtext = $input_params{'searchtext'};
-our $search_regexp;
-if (defined $searchtext) {
-	if (length($searchtext) < 2) {
-		die_error(403, "At least two characters are required for search parameter");
+	our $searchtext = $input_params{'searchtext'};
+	our $search_regexp;
+	if (defined $searchtext) {
+		if (length($searchtext) < 2) {
+			die_error(403, "At least two characters are required for search parameter");
+		}
+		$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 	}
-	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
 # path to the current git repository
 our $git_dir;
-$git_dir = "$projectroot/$project" if $project;
+sub evaluate_git_dir {
+	our $git_dir = "$projectroot/$project" if $project;
+}
 
-# list of supported snapshot formats
-our @snapshot_fmts = gitweb_get_feature('snapshot');
-@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+our (@snapshot_fmts, $git_avatar);
+sub configure_gitweb_features {
+	# list of supported snapshot formats
+	our @snapshot_fmts = gitweb_get_feature('snapshot');
+	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
-# check that the avatar feature is set to a known provider name,
-# and for each provider check if the dependencies are satisfied.
-# if the provider name is invalid or the dependencies are not met,
-# reset $git_avatar to the empty string.
-our ($git_avatar) = gitweb_get_feature('avatar');
-if ($git_avatar eq 'gravatar') {
-	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
-} elsif ($git_avatar eq 'picon') {
-	# no dependencies
-} else {
-	$git_avatar = '';
+	# check that the avatar feature is set to a known provider name,
+	# and for each provider check if the dependencies are satisfied.
+	# if the provider name is invalid or the dependencies are not met,
+	# reset $git_avatar to the empty string.
+	our ($git_avatar) = gitweb_get_feature('avatar');
+	if ($git_avatar eq 'gravatar') {
+		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+	} elsif ($git_avatar eq 'picon') {
+		# no dependencies
+	} else {
+		$git_avatar = '';
+	}
 }
 
 # dispatch
-if (!defined $action) {
-	if (defined $hash) {
-		$action = git_get_type($hash);
-	} elsif (defined $hash_base && defined $file_name) {
-		$action = git_get_type("$hash_base:$file_name");
-	} elsif (defined $project) {
-		$action = 'summary';
-	} else {
-		$action = 'project_list';
+sub dispatch {
+	if (!defined $action) {
+		if (defined $hash) {
+			$action = git_get_type($hash);
+		} elsif (defined $hash_base && defined $file_name) {
+			$action = git_get_type("$hash_base:$file_name");
+		} elsif (defined $project) {
+			$action = 'summary';
+		} else {
+			$action = 'project_list';
+		}
 	}
+	if (!defined($actions{$action})) {
+		die_error(400, "Unknown action");
+	}
+	if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+	    !$project) {
+		die_error(400, "Project needed");
+	}
+	$actions{$action}->();
 }
-if (!defined($actions{$action})) {
-	die_error(400, "Unknown action");
-}
-if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
-    !$project) {
-	die_error(400, "Project needed");
+
+sub run {
+	our $t0 = [Time::HiRes::gettimeofday()]
+		if defined $t0;
+
+	evaluate_uri();
+	evaluate_gitweb_config();
+	evaluate_git_version();
+	check_loadavg();
+
+	# $projectroot and $projects_list might be set in gitweb config file
+	$projects_list ||= $projectroot;
+
+	evaluate_query_params();
+	evaluate_path_info();
+	evaluate_and_validate_params();
+	evaluate_git_dir();
+
+	configure_gitweb_features();
+
+	dispatch();
+
+ DONE_GITWEB:
+	1;
 }
-$actions{$action}->();
-DONE_GITWEB:
-1;
+our $cgi = CGI->new();
+run();
 
 ## ======================================================================
 ## action links
-- 
1.7.0.1
