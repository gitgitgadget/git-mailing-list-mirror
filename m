From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 05/11] gitweb: Create Gitweb::Request module
Date: Thu, 15 Jul 2010 12:59:05 +0530
Message-ID: <1279178951-23712-6-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:30:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZItU-0003HF-04
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546Ab0GOH3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:29:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49847 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab0GOH3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:29:39 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so136519pzk.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MUjxdE41/vqALppHNRP/nkm+F+I23aPP5VKSwsZnP9M=;
        b=FH727b065ouWh5xLKfi9Eq2KecdlEOW1GybGCTwIjxQRzcGqxy3gdzUtwmEAkiGC80
         Ple1BO3sTrg6FED/Si6Uj65+/EnpTFbJUzdon5dmQvbDpKJBzoF6e/uL9X+lD2tqDcSA
         6UATdYPJfxq997JUC02tRgndVCwRLcqVQ7Nm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tlWmswrpOmiziaEZaIYkUCfP6i8zlQFU+4+NO2KP3ozhcBetZVZ8pMbt4aoXhowNwR
         fS6zbNSOz2gB63U+ZNq01qVM8IAuajb25v/FtGNxzMaOPkpJuzZI0zD45ZIkCgWr925z
         ebw+BHV8gXFAJAaE0I7NnEasxyvRs9JSOOZoc=
Received: by 10.142.140.20 with SMTP id n20mr1875014wfd.334.1279178978707;
        Thu, 15 Jul 2010 00:29:38 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:29:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151053>

Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
to store and handle all the cgi params and related variables
regarding the gitweb.perl script.

This module is intended as standalone module, which does not require
(include) other gitweb' modules to avoid circular dependencies.

Subroutines moved:
	evaluate_uri
	evaluate_query_params

Update gitweb/Makefile to install Gitweb::Request module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile              |    1 +
 gitweb/gitweb.perl           |  130 +++++-------------------------------------
 gitweb/lib/Gitweb/Request.pm |  119 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 116 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Request.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 492b0fa..cd36dc6 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -114,6 +114,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # Modules: Gitweb::*
 GITWEB_MODULES += lib/Gitweb/Git.pm
 GITWEB_MODULES += lib/Gitweb/Config.pm
+GITWEB_MODULES += lib/Gitweb/Request.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b68cc71..90cb6eb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -29,11 +29,7 @@ binmode STDOUT, ':utf8';
 
 use Gitweb::Git;
 use Gitweb::Config;
-
-our $t0;
-if (eval { require Time::HiRes; 1; }) {
-	$t0 = [Time::HiRes::gettimeofday()];
-}
+use Gitweb::Request;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -44,42 +40,6 @@ BEGIN {
 # with their descriptions is listed in Gitweb::Config.
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
 # $GIT is from Gitweb::Git
 $GIT = "++GIT_BINDIR++/git";
 
@@ -198,42 +158,6 @@ sub check_loadavg {
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
@@ -269,27 +193,6 @@ our %actions = (
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
@@ -435,11 +338,8 @@ sub evaluate_path_info {
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
@@ -447,7 +347,7 @@ sub evaluate_and_validate_params {
 	}
 
 	# parameters which are pathnames
-	our $project = $input_params{'project'};
+	$project = $input_params{'project'};
 	if (defined $project) {
 		if (!validate_project($project)) {
 			undef $project;
@@ -455,14 +355,14 @@ sub evaluate_and_validate_params {
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
@@ -470,28 +370,28 @@ sub evaluate_and_validate_params {
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
@@ -504,7 +404,7 @@ sub evaluate_and_validate_params {
 		}
 	}
 
-	our $hash_parent_base = $input_params{'hash_parent_base'};
+	$hash_parent_base = $input_params{'hash_parent_base'};
 	if (defined $hash_parent_base) {
 		if (!validate_refname($hash_parent_base)) {
 			die_error(400, "Invalid hash parent base parameter");
@@ -512,24 +412,23 @@ sub evaluate_and_validate_params {
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
@@ -605,7 +504,6 @@ sub run_request {
 our $is_last_request = sub { 1 };
 our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
 our $CGI = 'CGI';
-our $cgi;
 sub configure_as_fcgi {
 	require CGI::Fast;
 	our $CGI = 'CGI::Fast';
diff --git a/gitweb/lib/Gitweb/Request.pm b/gitweb/lib/Gitweb/Request.pm
new file mode 100644
index 0000000..1581a94
--- /dev/null
+++ b/gitweb/lib/Gitweb/Request.pm
@@ -0,0 +1,119 @@
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
+our @EXPORT = qw($cgi $my_url $my_uri $base_url $path_info $home_link $action $project $file_name
+                 $file_parent $hash $hash_parent $hash_base $hash_parent_base @extra_options $page
+                 $searchtype $search_use_regexp $searchtext $search_regexp %input_params %allowed_options
+                 @cgi_param_mapping %cgi_param_mapping $t0 evaluate_query_params evaluate_uri);
+
+our $t0;
+if (eval { require Time::HiRes; 1; }) {
+	$t0 = [Time::HiRes::gettimeofday()];
+}
+
+our ($cgi, $my_url, $my_uri, $base_url, $path_info, $home_link);
+our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
+     $hash_parent_base, @extra_options, $page);
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
+1;
-- 
1.7.1.455.g8f441
