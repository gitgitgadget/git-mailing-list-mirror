From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC 2/3] gitweb: Create Gitweb::Request module
Date: Thu,  3 Jun 2010 19:25:55 +0530
Message-ID: <1275573356-21466-2-git-send-email-pavan.sss1991@gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jun 03 15:56:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKAui-00076P-7m
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 15:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0FCN4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 09:56:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48483 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab0FCN4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 09:56:39 -0400
Received: by pwj2 with SMTP id 2so55490pwj.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S5wqWneX5snwJeu7qSBZzIgxyZ0s3PNcnxKUhYQJxwM=;
        b=PRm/EGeb9AJ1gZ5ujH/DVb006ykEu/jDBoLzu5yxetsiQS0QZils0IQYSNzDKBF3eL
         K+jZ8lr6oJegIIO3IZq0ttQdLXimjsij22GnP6puSbGIqhIB8P08o4gcp1wKcUVbD7vm
         j5shOlBU8+9U5UUcSw8EH4JFMTD2Ne9xSSt4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D3iiGG0O0/vJeKfP/HEFplK8wXkx3b1x6Bir6fIfJ7+v32pQYIw5Rv+XLt6+rvpXGr
         iSnZFOYD/6gVFFrAJjSPrp4w+Mn6QIiJkuQyAqIT6mK4K9wpuM/McvF6S6DfUsNpaXEi
         R86pt5LIyGG3ZbQiDSAVTq7RQSC8gfbEJAclU=
Received: by 10.142.196.7 with SMTP id t7mr6758263wff.151.1275573398981;
        Thu, 03 Jun 2010 06:56:38 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id v41sm65474wfh.21.2010.06.03.06.56.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 06:56:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.447.gfddfb
In-Reply-To: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148319>

Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
to store and handle all the cgi params and related variables
regarding the gitweb.perl script.

Subroutines moved:
	evaluate_uri
	evaluate_query_params
	evaluate_git_dir
	validate_pathname
	validate_refname

Subroutines yet to move: (Contains calls to not yet packages subs)
	evaluate_path_info
	evaluate_and _validate_params
	validate_action
	validate_project

Update gitweb/Makefile to install gitweb modules alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

This patch is based on branch 'pu' and previous patch.

 gitweb/Makefile              |    1 +
 gitweb/gitweb.perl           |  165 ++++--------------------------------------
 gitweb/lib/Gitweb/Request.pm |  156 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 151 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Request.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 45e176e..15646b2 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -113,6 +113,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
 # Files: gitweb/lib/Gitweb
 GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
+GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ef71656..2514b7a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -26,6 +26,7 @@ sub __DIR__ () {
 use lib __DIR__ . "/lib";
 
 use Gitweb::Config;
+use Gitweb::Request;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -33,42 +34,6 @@ BEGIN {
 
 $version = "++GIT_VERSION++";
 
-our ($my_url, $my_uri, $base_url, $path_info, $home_link);
-sub evaluate_uri {
-	our $cgi;
-
-	our $my_url = $cgi->url();
-	our $my_uri = $cgi->url(-absolute => 1);
-
-	# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
-	# needed and used only for URLs with nonempty PATH_INFO
-	our $base_url = $my_url;
-
-	# When the script is used as DirectoryIndex, the URL does not contain the name
-	# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
-	# have to do it ourselves. We make $path_info global because it's also used
-	# later on.
-	#
-	# Another issue with the script being the DirectoryIndex is that the resulting
-	# $my_url data is not the full script URL: this is good, because we want
-	# generated links to keep implying the script name if it wasn't explicitly
-	# indicated in the URL we're handling, but it means that $my_url cannot be used
-	# as base URL.
-	# Therefore, if we needed to strip PATH_INFO, then we know that we have
-	# to build the base URL ourselves:
-	our $path_info = $ENV{"PATH_INFO"};
-	if ($path_info) {
-		if ($my_url =~ s,\Q$path_info\E$,, &&
-		    $my_uri =~ s,\Q$path_info\E$,, &&
-		    defined $ENV{'SCRIPT_NAME'}) {
-			$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
-		}
-	}
-
-	# target of the home link on top of all pages
-	our $home_link = $my_uri || "/";
-}
-
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 $GIT = "++GIT_BINDIR++/git";
@@ -132,7 +97,6 @@ sub gitweb_get_feature {
 		$feature{$name}{'override'},
 		@{$feature{$name}{'default'}});
 	# project specific override is possible only if we have project
-	our $git_dir; # global variable, declared later
 	if (!$override || !defined $git_dir) {
 		return @defaults;
 	}
@@ -261,42 +225,6 @@ sub check_loadavg {
 # ======================================================================
 # input validation and dispatch
 
-# input parameters can be collected from a variety of sources (presently, CGI
-# and PATH_INFO), so we define an %input_params hash that collects them all
-# together during validation: this allows subsequent uses (e.g. href()) to be
-# agnostic of the parameter origin
-
-our %input_params = ();
-
-# input parameters are stored with the long parameter name as key. This will
-# also be used in the href subroutine to convert parameters to their CGI
-# equivalent, and since the href() usage is the most frequent one, we store
-# the name -> CGI key mapping here, instead of the reverse.
-#
-# XXX: Warning: If you touch this, check the search form for updating,
-# too.
-
-our @cgi_param_mapping = (
-	project => "p",
-	action => "a",
-	file_name => "f",
-	file_parent => "fp",
-	hash => "h",
-	hash_parent => "hp",
-	hash_base => "hb",
-	hash_parent_base => "hpb",
-	page => "pg",
-	order => "o",
-	searchtext => "s",
-	searchtype => "st",
-	snapshot_format => "sf",
-	extra_options => "opt",
-	search_use_regexp => "sr",
-	# this must be last entry (for manipulation from JavaScript)
-	javascript => "js"
-);
-our %cgi_param_mapping = @cgi_param_mapping;
-
 # we will also need to know the possible actions, for validation
 our %actions = (
 	"blame" => \&git_blame,
@@ -332,27 +260,6 @@ our %actions = (
 	"project_index" => \&git_project_index,
 );
 
-# finally, we have the hash of allowed extra_options for the commands that
-# allow them
-our %allowed_options = (
-	"--no-merges" => [ qw(rss atom log shortlog history) ],
-);
-
-# fill %input_params with the CGI parameters. All values except for 'opt'
-# should be single values, but opt can be an array. We should probably
-# build an array of parameters that can be multi-valued, but since for the time
-# being it's only this one, we just single it out
-sub evaluate_query_params {
-	our $cgi;
-
-	while (my ($name, $symbol) = each %cgi_param_mapping) {
-		if ($symbol eq 'opt') {
-			$input_params{$name} = [ $cgi->param($symbol) ];
-		} else {
-			$input_params{$name} = $cgi->param($symbol);
-		}
-	}
-}
 
 # now read PATH_INFO and update the parameter list for missing parameters
 sub evaluate_path_info {
@@ -498,11 +405,8 @@ sub evaluate_path_info {
 	}
 }
 
-our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
-     $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
-     $searchtext, $search_regexp);
 sub evaluate_and_validate_params {
-	our $action = $input_params{'action'};
+	$action = $input_params{'action'};
 	if (defined $action) {
 		if (!validate_action($action)) {
 			die_error(400, "Invalid action parameter");
@@ -510,7 +414,7 @@ sub evaluate_and_validate_params {
 	}
 
 	# parameters which are pathnames
-	our $project = $input_params{'project'};
+	$project = $input_params{'project'};
 	if (defined $project) {
 		if (!validate_project($project)) {
 			undef $project;
@@ -518,14 +422,14 @@ sub evaluate_and_validate_params {
 		}
 	}
 
-	our $file_name = $input_params{'file_name'};
+	$file_name = $input_params{'file_name'};
 	if (defined $file_name) {
 		if (!validate_pathname($file_name)) {
 			die_error(400, "Invalid file parameter");
 		}
 	}
 
-	our $file_parent = $input_params{'file_parent'};
+	$file_parent = $input_params{'file_parent'};
 	if (defined $file_parent) {
 		if (!validate_pathname($file_parent)) {
 			die_error(400, "Invalid file parent parameter");
@@ -533,28 +437,28 @@ sub evaluate_and_validate_params {
 	}
 
 	# parameters which are refnames
-	our $hash = $input_params{'hash'};
+	$hash = $input_params{'hash'};
 	if (defined $hash) {
 		if (!validate_refname($hash)) {
 			die_error(400, "Invalid hash parameter");
 		}
 	}
 
-	our $hash_parent = $input_params{'hash_parent'};
+	$hash_parent = $input_params{'hash_parent'};
 	if (defined $hash_parent) {
 		if (!validate_refname($hash_parent)) {
 			die_error(400, "Invalid hash parent parameter");
 		}
 	}
 
-	our $hash_base = $input_params{'hash_base'};
+	$hash_base = $input_params{'hash_base'};
 	if (defined $hash_base) {
 		if (!validate_refname($hash_base)) {
 			die_error(400, "Invalid hash base parameter");
 		}
 	}
 
-	our @extra_options = @{$input_params{'extra_options'}};
+	@extra_options = @{$input_params{'extra_options'}};
 	# @extra_options is always defined, since it can only be (currently) set from
 	# CGI, and $cgi->param() returns the empty array in array context if the param
 	# is not set
@@ -567,7 +471,7 @@ sub evaluate_and_validate_params {
 		}
 	}
 
-	our $hash_parent_base = $input_params{'hash_parent_base'};
+	$hash_parent_base = $input_params{'hash_parent_base'};
 	if (defined $hash_parent_base) {
 		if (!validate_refname($hash_parent_base)) {
 			die_error(400, "Invalid hash parent base parameter");
@@ -575,24 +479,23 @@ sub evaluate_and_validate_params {
 	}
 
 	# other parameters
-	our $page = $input_params{'page'};
+	$page = $input_params{'page'};
 	if (defined $page) {
 		if ($page =~ m/[^0-9]/) {
 			die_error(400, "Invalid page parameter");
 		}
 	}
 
-	our $searchtype = $input_params{'searchtype'};
+	$searchtype = $input_params{'searchtype'};
 	if (defined $searchtype) {
 		if ($searchtype =~ m/[^a-z]/) {
 			die_error(400, "Invalid searchtype parameter");
 		}
 	}
 
-	our $search_use_regexp = $input_params{'search_use_regexp'};
+	$search_use_regexp = $input_params{'search_use_regexp'};
 
-	our $searchtext = $input_params{'searchtext'};
-	our $search_regexp;
+	$searchtext = $input_params{'searchtext'};
 	if (defined $searchtext) {
 		if (length($searchtext) < 2) {
 			die_error(403, "At least two characters are required for search parameter");
@@ -601,12 +504,6 @@ sub evaluate_and_validate_params {
 	}
 }
 
-# path to the current git repository
-our $git_dir;
-sub evaluate_git_dir {
-	our $git_dir = "$projectroot/$project" if $project;
-}
-
 our (@snapshot_fmts, $git_avatar);
 sub configure_gitweb_features {
 	# list of supported snapshot formats
@@ -690,7 +587,6 @@ sub run_request {
 our $is_last_request = sub { 1 };
 our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
 our $CGI = 'CGI';
-our $cgi;
 sub evaluate_argv {
 	return unless (@ARGV);
 
@@ -885,39 +781,6 @@ sub validate_project {
 	}
 }
 
-sub validate_pathname {
-	my $input = shift || return undef;
-
-	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
-	# at the beginning, at the end, and between slashes.
-	# also this catches doubled slashes
-	if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
-		return undef;
-	}
-	# no null characters
-	if ($input =~ m!\0!) {
-		return undef;
-	}
-	return $input;
-}
-
-sub validate_refname {
-	my $input = shift || return undef;
-
-	# textual hashes are O.K.
-	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
-		return $input;
-	}
-	# it must be correct pathname
-	$input = validate_pathname($input)
-		or return undef;
-	# restrictions on ref name according to git-check-ref-format
-	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
-		return undef;
-	}
-	return $input;
-}
-
 # decode sequences of octets in utf8 into Perl's internal form,
 # which is utf-8 with utf8 flag set if needed.  gitweb writes out
 # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
diff --git a/gitweb/lib/Gitweb/Request.pm b/gitweb/lib/Gitweb/Request.pm
new file mode 100644
index 0000000..474e89d
--- /dev/null
+++ b/gitweb/lib/Gitweb/Request.pm
@@ -0,0 +1,156 @@
+#!/usr/bin/perl
+#
+# Gitweb::Request -- gitweb request(cgi) package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Request;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @ISA = qw(Exporter);
+our @EXPORT = qw($cgi $my_url $my_uri $base_url $path_info $home_link $action $project $file_name
+                 $file_parent $hash $hash_parent $hash_base $hash_parent_base @extra_options $page
+                 $git_dir $searchtype $search_use_regexp $searchtext $search_regexp %input_params
+                 @cgi_param_mapping %cgi_param_mapping %allowed_options &evaluate_query_params
+                 &evaluate_uri &evaluate_git_dir &validate_pathname &validate_refname);
+
+use Gitweb::Config qw($projectroot);
+
+our ($cgi, $my_url, $my_uri, $base_url, $path_info, $home_link);
+our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
+     $hash_parent_base, @extra_options, $page, $git_dir);
+our ($searchtype, $search_use_regexp, $searchtext, $search_regexp);
+
+# input parameters can be collected from a variety of sources (presently, CGI
+# and PATH_INFO), so we define an %input_params hash that collects them all
+# together during validation: this allows subsequent uses (e.g. href()) to be
+# agnostic of the parameter origin
+
+our %input_params = ();
+
+# input parameters are stored with the long parameter name as key. This will
+# also be used in the href subroutine to convert parameters to their CGI
+# equivalent, and since the href() usage is the most frequent one, we store
+# the name -> CGI key mapping here, instead of the reverse.
+#
+# XXX: Warning: If you touch this, check the search form for updating,
+# too.
+
+our @cgi_param_mapping = (
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
+	# this must be last entry (for manipulation from JavaScript)
+	javascript => "js"
+);
+our %cgi_param_mapping = @cgi_param_mapping;
+
+# finally, we have the hash of allowed extra_options for the commands that
+# allow them
+our %allowed_options = (
+	"--no-merges" => [ qw(rss atom log shortlog history) ],
+);
+
+# fill %input_params with the CGI parameters. All values except for 'opt'
+# should be single values, but opt can be an array. We should probably
+# build an array of parameters that can be multi-valued, but since for the time
+# being it's only this one, we just single it out
+sub evaluate_query_params {
+	while (my ($name, $symbol) = each %cgi_param_mapping) {
+		if ($symbol eq 'opt') {
+			$input_params{$name} = [ $cgi->param($symbol) ];
+		} else {
+			$input_params{$name} = $cgi->param($symbol);
+		}
+	}
+}
+
+sub evaluate_uri {
+	our $cgi;
+
+	our $my_url = $cgi->url();
+	our $my_uri = $cgi->url(-absolute => 1);
+
+	# Base URL for relative URLs in gitweb ($Gitweb::Config::logo, $Gitweb::Config::favicon, ...),
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
+	}
+
+	# target of the home link on top of all pages
+	our $home_link = $my_uri || "/";
+}
+
+sub evaluate_git_dir {
+	$git_dir = "$projectroot/$project" if $project;
+}
+
+
+sub validate_pathname {
+	my $input = shift || return undef;
+
+	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
+	# at the beginning, at the end, and between slashes.
+	# also this catches doubled slashes
+	if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
+		return undef;
+	}
+	# no null characters
+	if ($input =~ m!\0!) {
+		return undef;
+	}
+	return $input;
+}
+
+sub validate_refname {
+	my $input = shift || return undef;
+
+	# textual hashes are O.K.
+	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
+		return $input;
+	}
+	# it must be correct pathname
+	$input = validate_pathname($input)
+		or return undef;
+	# restrictions on ref name according to git-check-ref-format
+	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
+		return undef;
+	}
+	return $input;
+}
+
+1;
-- 
1.7.1.447.gfddfb
