From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 04/11 GSoC] gitweb: Create Gitweb::Config module
Date: Tue, 22 Jun 2010 03:30:40 +0530
Message-ID: <1277157648-6029-5-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:03:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp55-00083O-Ij
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958Ab0FUWCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:02:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797Ab0FUWCc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:02:32 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so528092pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3q3r0/tgGhuNn/b2jShiaZYthVopCyQxc3R04PVIGxY=;
        b=ObqhVqoyT6E7Bl0UCPak6nvfZwyAS6QbFJN1QDhvlZjZQmUbFB1dWUUmIoZQc5NjSB
         KjEZrIZueqeVAss/nzNqcgIxjqf4G/YfkoqV/j7GLBkc3cHLL+xNzzcd3XO7GPoTGYII
         fUr1LJAYvfDYHpW89B+lDyQRx0xzElPvMeneg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Pa0BDOdFZSVwoJMGxuQCefbfiLORekPDL/uOEcFWALtiODyt5eJY49j8pLeuHiYLqK
         Pojv4InxNeoBMAqX/vCvoc2u15pm43KUqKdT9CNTG2gG956FtNpV18m6RkA5MiDY/qGN
         qs0KYaQCOfQwNjSf43kCj5EUGtoawjQjYc79Q=
Received: by 10.143.153.9 with SMTP id f9mr4110422wfo.29.1277157750895;
        Mon, 21 Jun 2010 15:02:30 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.02.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:02:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149449>

Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
to store all the configuration variables and subroutines
regarding the gitweb.perl script.

This module depends only on $git_dir from Gitweb::Git and
includes most of the configuration related variables and
subroutines (Including those required for configuration
of gitweb features)

Subroutines moved:
	evaluate_gitweb_config
	configure_gitweb_features
	filter_snapshot_fmts
	gitweb_get_feature
	gitweb_check_feature

Update gitweb/Makefile to install Gitweb::Config module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile             |    1 +
 gitweb/gitweb.perl          |  495 ++----------------------------------------
 gitweb/lib/Gitweb/Config.pm |  498 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 522 insertions(+), 472 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Config.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 229aead..ea59972 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -113,6 +113,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
 # Modules: Gitweb::*
 GITWEB_MODULES += lib/Gitweb/Git.pm
+GITWEB_MODULES += lib/Gitweb/Config.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 778ac13..b68cc71 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -28,6 +28,7 @@ use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
 use Gitweb::Git;
+use Gitweb::Config;
 
 our $t0;
 if (eval { require Time::HiRes; 1; }) {
@@ -38,7 +39,10 @@ BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
 
-our $version = "++GIT_VERSION++";
+# Only configuration variables with build-time overridable
+# defaults are listed below. The complete set of variables
+# with their descriptions is listed in Gitweb::Config.
+$version = "++GIT_VERSION++";
 
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
@@ -79,434 +83,31 @@ sub evaluate_uri {
 # $GIT is from Gitweb::Git
 $GIT = "++GIT_BINDIR++/git";
 
-# absolute fs-path which will be prepended to the project path
-#our $projectroot = "/pub/scm";
-our $projectroot = "++GITWEB_PROJECTROOT++";
+$projectroot = "++GITWEB_PROJECTROOT++";
+$project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
 
-# fs traversing limit for getting project list
-# the number is relative to the projectroot
-our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
-
-# string of the home link on top of all pages
-our $home_link_str = "++GITWEB_HOME_LINK_STR++";
-
-# name of your site or organization to appear in page titles
-# replace this with something more descriptive for clearer bookmarks
-our $site_name = "++GITWEB_SITENAME++"
+$home_link_str = "++GITWEB_HOME_LINK_STR++";
+$site_name = "++GITWEB_SITENAME++"
                  || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
+$site_header = "++GITWEB_SITE_HEADER++";
+$home_text = "++GITWEB_HOMETEXT++";
+$site_footer = "++GITWEB_SITE_FOOTER++";
 
-# filename of html text to include at top of each page
-our $site_header = "++GITWEB_SITE_HEADER++";
-# html text to include at home page
-our $home_text = "++GITWEB_HOMETEXT++";
-# filename of html text to include at bottom of each page
-our $site_footer = "++GITWEB_SITE_FOOTER++";
-
-# URI of stylesheets
-our @stylesheets = ("++GITWEB_CSS++");
-# URI of a single stylesheet, which can be overridden in GITWEB_CONFIG.
-our $stylesheet = undef;
-# URI of GIT logo (72x27 size)
-our $logo = "++GITWEB_LOGO++";
-# URI of GIT favicon, assumed to be image/png type
-our $favicon = "++GITWEB_FAVICON++";
-# URI of gitweb.js (JavaScript code for gitweb)
-our $javascript = "++GITWEB_JS++";
-
-# URI and label (title) of GIT logo link
-#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
-#our $logo_label = "git documentation";
-our $logo_url = "http://git-scm.com/";
-our $logo_label = "git homepage";
-
-# source of projects list
-our $projects_list = "++GITWEB_LIST++";
-
-# the width (in characters) of the projects list "Description" column
-our $projects_list_description_width = 25;
-
-# default order of projects list
-# valid values are none, project, descr, owner, and age
-our $default_projects_order = "project";
-
-# show repository only if this file exists
-# (only effective if this variable evaluates to true)
-our $export_ok = "++GITWEB_EXPORT_OK++";
-
-# show repository only if this subroutine returns true
-# when given the path to the project, for example:
-#    sub { return -e "$_[0]/git-daemon-export-ok"; }
-our $export_auth_hook = undef;
-
-# only allow viewing of repositories also shown on the overview page
-our $strict_export = "++GITWEB_STRICT_EXPORT++";
-
-# list of git base URLs used for URL to where fetch project from,
-# i.e. full URL is "$git_base_url/$project"
-our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
-
-# default blob_plain mimetype and default charset for text/plain blob
-our $default_blob_plain_mimetype = 'text/plain';
-our $default_text_plain_charset  = undef;
-
-# file to use for guessing MIME types before trying /etc/mime.types
-# (relative to the current git repository)
-our $mimetypes_file = undef;
-
-# assume this charset if line contains non-UTF-8 characters;
-# it should be valid encoding (see Encoding::Supported(3pm) for list),
-# for which encoding all byte sequences are valid, for example
-# 'iso-8859-1' aka 'latin1' (it is decoded without checking, so it
-# could be even 'utf-8' for the old behavior)
-our $fallback_encoding = 'latin1';
-
-# rename detection options for git-diff and git-diff-tree
-# - default is '-M', with the cost proportional to
-#   (number of removed files) * (number of new files).
-# - more costly is '-C' (which implies '-M'), with the cost proportional to
-#   (number of changed files + number of removed files) * (number of new files)
-# - even more costly is '-C', '--find-copies-harder' with cost
-#   (number of files in the original tree) * (number of new files)
-# - one might want to include '-B' option, e.g. '-B', '-M'
-our @diff_opts = ('-M'); # taken from git_commit
-
-# Disables features that would allow repository owners to inject script into
-# the gitweb domain.
-our $prevent_xss = 0;
-
-# information about snapshot formats that gitweb is capable of serving
-our %known_snapshot_formats = (
-	# name => {
-	# 	'display' => display name,
-	# 	'type' => mime type,
-	# 	'suffix' => filename suffix,
-	# 	'format' => --format for git-archive,
-	# 	'compressor' => [compressor command and arguments]
-	# 	                (array reference, optional)
-	# 	'disabled' => boolean (optional)}
-	#
-	'tgz' => {
-		'display' => 'tar.gz',
-		'type' => 'application/x-gzip',
-		'suffix' => '.tar.gz',
-		'format' => 'tar',
-		'compressor' => ['gzip']},
-
-	'tbz2' => {
-		'display' => 'tar.bz2',
-		'type' => 'application/x-bzip2',
-		'suffix' => '.tar.bz2',
-		'format' => 'tar',
-		'compressor' => ['bzip2']},
-
-	'txz' => {
-		'display' => 'tar.xz',
-		'type' => 'application/x-xz',
-		'suffix' => '.tar.xz',
-		'format' => 'tar',
-		'compressor' => ['xz'],
-		'disabled' => 1},
-
-	'zip' => {
-		'display' => 'zip',
-		'type' => 'application/x-zip',
-		'suffix' => '.zip',
-		'format' => 'zip'},
-);
+@stylesheets = ("++GITWEB_CSS++");
+$stylesheet = undef;
+$logo = "++GITWEB_LOGO++";
+$favicon = "++GITWEB_FAVICON++";
+$javascript = "++GITWEB_JS++";
 
-# Aliases so we understand old gitweb.snapshot values in repository
-# configuration.
-our %known_snapshot_format_aliases = (
-	'gzip'  => 'tgz',
-	'bzip2' => 'tbz2',
-	'xz'    => 'txz',
-
-	# backward compatibility: legacy gitweb config support
-	'x-gzip' => undef, 'gz' => undef,
-	'x-bzip2' => undef, 'bz2' => undef,
-	'x-zip' => undef, '' => undef,
-);
+$projects_list = "++GITWEB_LIST++";
 
-# Pixel sizes for icons and avatars. If the default font sizes or lineheights
-# are changed, it may be appropriate to change these values too via
-# $GITWEB_CONFIG.
-our %avatar_size = (
-	'default' => 16,
-	'double'  => 32
-);
+$export_ok = "++GITWEB_EXPORT_OK++";
+$strict_export = "++GITWEB_STRICT_EXPORT++";
 
-# Used to set the maximum load that we will still respond to gitweb queries.
-# If server load exceed this value then return "503 server busy" error.
-# If gitweb cannot determined server load, it is taken to be 0.
-# Leave it undefined (or set to 'undef') to turn off load checking.
-our $maxload = 300;
-
-# You define site-wide feature defaults here; override them with
-# $GITWEB_CONFIG as necessary.
-our %feature = (
-	# feature => {
-	# 	'sub' => feature-sub (subroutine),
-	# 	'override' => allow-override (boolean),
-	# 	'default' => [ default options...] (array reference)}
-	#
-	# if feature is overridable (it means that allow-override has true value),
-	# then feature-sub will be called with default options as parameters;
-	# return value of feature-sub indicates if to enable specified feature
-	#
-	# if there is no 'sub' key (no feature-sub), then feature cannot be
-	# overriden
-	#
-	# use gitweb_get_feature(<feature>) to retrieve the <feature> value
-	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
-	# is enabled
-
-	# Enable the 'blame' blob view, showing the last commit that modified
-	# each line in the file. This can be very CPU-intensive.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'blame'}{'default'} = [1];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'blame'}{'override'} = 1;
-	# and in project config gitweb.blame = 0|1;
-	'blame' => {
-		'sub' => sub { feature_bool('blame', @_) },
-		'override' => 0,
-		'default' => [0]},
-
-	# Enable the 'snapshot' link, providing a compressed archive of any
-	# tree. This can potentially generate high traffic if you have large
-	# project.
-
-	# Value is a list of formats defined in %known_snapshot_formats that
-	# you wish to offer.
-	# To disable system wide have in $GITWEB_CONFIG
-	# $feature{'snapshot'}{'default'} = [];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'snapshot'}{'override'} = 1;
-	# and in project config, a comma-separated list of formats or "none"
-	# to disable.  Example: gitweb.snapshot = tbz2,zip;
-	'snapshot' => {
-		'sub' => \&feature_snapshot,
-		'override' => 0,
-		'default' => ['tgz']},
-
-	# Enable text search, which will list the commits which match author,
-	# committer or commit text to a given string.  Enabled by default.
-	# Project specific override is not supported.
-	'search' => {
-		'override' => 0,
-		'default' => [1]},
-
-	# Enable grep search, which will list the files in currently selected
-	# tree containing the given string. Enabled by default. This can be
-	# potentially CPU-intensive, of course.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'grep'}{'default'} = [1];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'grep'}{'override'} = 1;
-	# and in project config gitweb.grep = 0|1;
-	'grep' => {
-		'sub' => sub { feature_bool('grep', @_) },
-		'override' => 0,
-		'default' => [1]},
-
-	# Enable the pickaxe search, which will list the commits that modified
-	# a given string in a file. This can be practical and quite faster
-	# alternative to 'blame', but still potentially CPU-intensive.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'pickaxe'}{'default'} = [1];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'pickaxe'}{'override'} = 1;
-	# and in project config gitweb.pickaxe = 0|1;
-	'pickaxe' => {
-		'sub' => sub { feature_bool('pickaxe', @_) },
-		'override' => 0,
-		'default' => [1]},
-
-	# Enable showing size of blobs in a 'tree' view, in a separate
-	# column, similar to what 'ls -l' does.  This cost a bit of IO.
-
-	# To disable system wide have in $GITWEB_CONFIG
-	# $feature{'show-sizes'}{'default'} = [0];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'show-sizes'}{'override'} = 1;
-	# and in project config gitweb.showsizes = 0|1;
-	'show-sizes' => {
-		'sub' => sub { feature_bool('showsizes', @_) },
-		'override' => 0,
-		'default' => [1]},
-
-	# Make gitweb use an alternative format of the URLs which can be
-	# more readable and natural-looking: project name is embedded
-	# directly in the path and the query string contains other
-	# auxiliary information. All gitweb installations recognize
-	# URL in either format; this configures in which formats gitweb
-	# generates links.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'pathinfo'}{'default'} = [1];
-	# Project specific override is not supported.
-
-	# Note that you will need to change the default location of CSS,
-	# favicon, logo and possibly other files to an absolute URL. Also,
-	# if gitweb.cgi serves as your indexfile, you will need to force
-	# $my_uri to contain the script name in your $GITWEB_CONFIG.
-	'pathinfo' => {
-		'override' => 0,
-		'default' => [0]},
-
-	# Make gitweb consider projects in project root subdirectories
-	# to be forks of existing projects. Given project $projname.git,
-	# projects matching $projname/*.git will not be shown in the main
-	# projects list, instead a '+' mark will be added to $projname
-	# there and a 'forks' view will be enabled for the project, listing
-	# all the forks. If project list is taken from a file, forks have
-	# to be listed after the main project.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'forks'}{'default'} = [1];
-	# Project specific override is not supported.
-	'forks' => {
-		'override' => 0,
-		'default' => [0]},
-
-	# Insert custom links to the action bar of all project pages.
-	# This enables you mainly to link to third-party scripts integrating
-	# into gitweb; e.g. git-browser for graphical history representation
-	# or custom web-based repository administration interface.
-
-	# The 'default' value consists of a list of triplets in the form
-	# (label, link, position) where position is the label after which
-	# to insert the link and link is a format string where %n expands
-	# to the project name, %f to the project path within the filesystem,
-	# %h to the current hash (h gitweb parameter) and %b to the current
-	# hash base (hb gitweb parameter); %% expands to %.
-
-	# To enable system wide have in $GITWEB_CONFIG e.g.
-	# $feature{'actions'}{'default'} = [('graphiclog',
-	# 	'/git-browser/by-commit.html?r=%n', 'summary')];
-	# Project specific override is not supported.
-	'actions' => {
-		'override' => 0,
-		'default' => []},
-
-	# Allow gitweb scan project content tags described in ctags/
-	# of project repository, and display the popular Web 2.0-ish
-	# "tag cloud" near the project list. Note that this is something
-	# COMPLETELY different from the normal Git tags.
-
-	# gitweb by itself can show existing tags, but it does not handle
-	# tagging itself; you need an external application for that.
-	# For an example script, check Girocco's cgi/tagproj.cgi.
-	# You may want to install the HTML::TagCloud Perl module to get
-	# a pretty tag cloud instead of just a list of tags.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'ctags'}{'default'} = ['path_to_tag_script'];
-	# Project specific override is not supported.
-	'ctags' => {
-		'override' => 0,
-		'default' => [0]},
-
-	# The maximum number of patches in a patchset generated in patch
-	# view. Set this to 0 or undef to disable patch view, or to a
-	# negative number to remove any limit.
-
-	# To disable system wide have in $GITWEB_CONFIG
-	# $feature{'patches'}{'default'} = [0];
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'patches'}{'override'} = 1;
-	# and in project config gitweb.patches = 0|n;
-	# where n is the maximum number of patches allowed in a patchset.
-	'patches' => {
-		'sub' => \&feature_patches,
-		'override' => 0,
-		'default' => [16]},
-
-	# Avatar support. When this feature is enabled, views such as
-	# shortlog or commit will display an avatar associated with
-	# the email of the committer(s) and/or author(s).
-
-	# Currently available providers are gravatar and picon.
-	# If an unknown provider is specified, the feature is disabled.
-
-	# Gravatar depends on Digest::MD5.
-	# Picon currently relies on the indiana.edu database.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'avatar'}{'default'} = ['<provider>'];
-	# where <provider> is either gravatar or picon.
-	# To have project specific config enable override in $GITWEB_CONFIG
-	# $feature{'avatar'}{'override'} = 1;
-	# and in project config gitweb.avatar = <provider>;
-	'avatar' => {
-		'sub' => \&feature_avatar,
-		'override' => 0,
-		'default' => ['']},
-
-	# Enable displaying how much time and how many git commands
-	# it took to generate and display page.  Disabled by default.
-	# Project specific override is not supported.
-	'timed' => {
-		'override' => 0,
-		'default' => [0]},
-
-	# Enable turning some links into links to actions which require
-	# JavaScript to run (like 'blame_incremental').  Not enabled by
-	# default.  Project specific override is currently not supported.
-	'javascript-actions' => {
-		'override' => 0,
-		'default' => [0]},
-
-	# Syntax highlighting support. This is based on Daniel Svensson's
-	# and Sham Chukoury's work in gitweb-xmms2.git.
-	# It requires the 'highlight' program present in $PATH,
-	# and therefore is disabled by default.
-
-	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'highlight'}{'default'} = [1];
-
-	'highlight' => {
-		'sub' => sub { feature_bool('highlight', @_) },
-		'override' => 0,
-		'default' => [0]},
-);
-
-sub gitweb_get_feature {
-	my ($name) = @_;
-	return unless exists $feature{$name};
-	my ($sub, $override, @defaults) = (
-		$feature{$name}{'sub'},
-		$feature{$name}{'override'},
-		@{$feature{$name}{'default'}});
-	# project specific override is possible only if we have project
-	if (!$override || !defined $git_dir) {
-		return @defaults;
-	}
-	if (!defined $sub) {
-		warn "feature $name is not overridable";
-		return @defaults;
-	}
-	return $sub->(@defaults);
-}
-
-# A wrapper to check if a given feature is enabled.
-# With this, you can say
-#
-#   my $bool_feat = gitweb_check_feature('bool_feat');
-#   gitweb_check_feature('bool_feat') or somecode;
-#
-# instead of
-#
-#   my ($bool_feat) = gitweb_get_feature('bool_feat');
-#   (gitweb_get_feature('bool_feat'))[0] or somecode;
-#
-sub gitweb_check_feature {
-	return (gitweb_get_feature(@_))[0];
-}
+@git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
 
+$GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
+$GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 
 sub feature_bool {
 	my $key = shift;
@@ -566,33 +167,6 @@ sub check_export_ok {
 		(!$export_auth_hook || $export_auth_hook->($dir)));
 }
 
-# process alternate names for backward compatibility
-# filter out unsupported (unknown) snapshot formats
-sub filter_snapshot_fmts {
-	my @fmts = @_;
-
-	@fmts = map {
-		exists $known_snapshot_format_aliases{$_} ?
-		       $known_snapshot_format_aliases{$_} : $_} @fmts;
-	@fmts = grep {
-		exists $known_snapshot_formats{$_} &&
-		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
-}
-
-our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
-sub evaluate_gitweb_config {
-	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
-	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
-	# die if there are errors parsing config file
-	if (-e $GITWEB_CONFIG) {
-		do $GITWEB_CONFIG;
-		die $@ if $@;
-	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
-		do $GITWEB_CONFIG_SYSTEM;
-		die $@ if $@;
-	}
-}
-
 # Get loadavg of system, to compare against $maxload.
 # Currently it requires '/proc/loadavg' present to get loadavg;
 # if it is not present it returns 0, which means no load checking.
@@ -968,26 +542,6 @@ sub evaluate_git_dir {
 	$git_dir = "$projectroot/$project" if $project;
 }
 
-our (@snapshot_fmts, $git_avatar);
-sub configure_gitweb_features {
-	# list of supported snapshot formats
-	our @snapshot_fmts = gitweb_get_feature('snapshot');
-	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
-
-	# check that the avatar feature is set to a known provider name,
-	# and for each provider check if the dependencies are satisfied.
-	# if the provider name is invalid or the dependencies are not met,
-	# reset $git_avatar to the empty string.
-	our ($git_avatar) = gitweb_get_feature('avatar');
-	if ($git_avatar eq 'gravatar') {
-		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
-	} elsif ($git_avatar eq 'picon') {
-		# no dependencies
-	} else {
-		$git_avatar = '';
-	}
-}
-
 # custom error handler: 'die <message>' is Internal Server Error
 sub handle_errors_html {
 	my $msg = shift; # it is already HTML escaped
@@ -2552,9 +2106,6 @@ sub git_get_projects_list {
 			follow_skip => 2, # ignore duplicates
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
-				# global variables
-				our $project_maxdepth;
-				our $projectroot;
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
new file mode 100644
index 0000000..c528595
--- /dev/null
+++ b/gitweb/lib/Gitweb/Config.pm
@@ -0,0 +1,498 @@
+#!/usr/bin/perl
+#
+# Gitweb::Config -- gitweb configuration package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Config;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(evaluate_gitweb_config gitweb_check_feature gitweb_get_feature configure_gitweb_features
+                 filter_snapshot_fmts %known_snapshot_formats $version $projectroot $project_maxdepth
+                 $projects_list @git_base_url_list $export_ok $strict_export $home_link_str $site_name
+                 $site_header $site_footer $home_text @stylesheets $stylesheet $logo $favicon $javascript
+                 $GITWEB_CONFIG $GITWEB_CONFIG_SYSTEM $logo_url $logo_label $export_auth_hook
+                 $projects_list_description_width $default_projects_order $default_blob_plain_mimetype
+                 $default_text_plain_charset $fallback_encoding @diff_opts $prevent_xss $maxload
+                 $git_avatar %avatar_size %feature @snapshot_fmts $mimetypes_file);
+
+use Gitweb::Git qw($git_dir);
+
+# The following variables are affected by build-time configuration
+# and hence their initialisation is put in gitweb.perl script
+
+our $version;
+
+# absolute fs-path which will be prepended to the project path
+#our $projectroot = "/pub/scm";
+our $projectroot;
+# fs traversing limit for getting project list
+# the number is relative to the projectroot
+our $project_maxdepth;
+# source of projects list
+our $projects_list;
+# list of git base URLs used for URL to where fetch project from,
+# i.e. full URL is "$git_base_url/$project"
+our @git_base_url_list;
+
+# show repository only if this file exists
+# (only effective if this variable evaluates to true)
+our $export_ok;
+# only allow viewing of repositories also shown on the overview page
+our $strict_export;
+
+# string of the home link on top of all pages
+our $home_link_str;
+# name of your site or organization to appear in page titles
+# replace this with something more descriptive for clearer bookmarks
+our $site_name;
+# filename of html text to include at top of each page
+our $site_header;
+# filename of html text to include at bottom of each page
+our $site_footer;
+# html text to include at home page
+our $home_text;
+
+# URI of stylesheets
+our @stylesheets;
+# URI of a single stylesheet, which can be overridden in GITWEB_CONFIG.
+our $stylesheet;
+# URI of GIT logo (72x27 size)
+our $logo;
+# URI of GIT favicon, assumed to be image/png type
+our $favicon;
+# URI of gitweb.js (JavaScript code for gitweb)
+our $javascript;
+
+# gitweb config
+our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
+
+# URI and label (title) of GIT logo link
+#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_label = "git documentation";
+our $logo_url = "http://git-scm.com/";
+our $logo_label = "git homepage";
+
+# the width (in characters) of the projects list "Description" column
+our $projects_list_description_width = 25;
+
+# default order of projects list
+# valid values are none, project, descr, owner, and age
+our $default_projects_order = "project";
+
+# show repository only if this subroutine returns true
+# when given the path to the project, for example:
+#    sub { return -e "$_[0]/git-daemon-export-ok"; }
+our $export_auth_hook = undef;
+
+# default blob_plain mimetype and default charset for text/plain blob
+our $default_blob_plain_mimetype = 'text/plain';
+our $default_text_plain_charset  = undef;
+
+# file to use for guessing MIME types before trying /etc/mime.types
+# (relative to the current git repository)
+our $mimetypes_file = undef;
+
+# assume this charset if line contains non-UTF-8 characters;
+# it should be valid encoding (see Encoding::Supported(3pm) for list),
+# for which encoding all byte sequences are valid, for example
+# 'iso-8859-1' aka 'latin1' (it is decoded without checking, so it
+# could be even 'utf-8' for the old behavior)
+our $fallback_encoding = 'latin1';
+
+# rename detection options for git-diff and git-diff-tree
+# - default is '-M', with the cost proportional to
+#   (number of removed files) * (number of new files).
+# - more costly is '-C' (which implies '-M'), with the cost proportional to
+#   (number of changed files + number of removed files) * (number of new files)
+# - even more costly is '-C', '--find-copies-harder' with cost
+#   (number of files in the original tree) * (number of new files)
+# - one might want to include '-B' option, e.g. '-B', '-M'
+our @diff_opts = ('-M'); # taken from git_commit
+
+# Disables features that would allow repository owners to inject script into
+# the gitweb domain.
+our $prevent_xss = 0;
+
+# information about snapshot formats that gitweb is capable of serving
+our %known_snapshot_formats = (
+	# name => {
+	# 	'display' => display name,
+	# 	'type' => mime type,
+	# 	'suffix' => filename suffix,
+	# 	'format' => --format for git-archive,
+	# 	'compressor' => [compressor command and arguments]
+	# 	                (array reference, optional)
+	# 	'disabled' => boolean (optional)}
+	#
+	'tgz' => {
+		'display' => 'tar.gz',
+		'type' => 'application/x-gzip',
+		'suffix' => '.tar.gz',
+		'format' => 'tar',
+		'compressor' => ['gzip']},
+
+	'tbz2' => {
+		'display' => 'tar.bz2',
+		'type' => 'application/x-bzip2',
+		'suffix' => '.tar.bz2',
+		'format' => 'tar',
+		'compressor' => ['bzip2']},
+
+	'txz' => {
+		'display' => 'tar.xz',
+		'type' => 'application/x-xz',
+		'suffix' => '.tar.xz',
+		'format' => 'tar',
+		'compressor' => ['xz'],
+		'disabled' => 1},
+
+	'zip' => {
+		'display' => 'zip',
+		'type' => 'application/x-zip',
+		'suffix' => '.zip',
+		'format' => 'zip'},
+);
+
+# Aliases so we understand old gitweb.snapshot values in repository
+# configuration.
+our %known_snapshot_format_aliases = (
+	'gzip'  => 'tgz',
+	'bzip2' => 'tbz2',
+	'xz'    => 'txz',
+
+	# backward compatibility: legacy gitweb config support
+	'x-gzip' => undef, 'gz' => undef,
+	'x-bzip2' => undef, 'bz2' => undef,
+	'x-zip' => undef, '' => undef,
+);
+
+# Pixel sizes for icons and avatars. If the default font sizes or lineheights
+# are changed, it may be appropriate to change these values too via
+# $GITWEB_CONFIG.
+our %avatar_size = (
+	'default' => 16,
+	'double'  => 32
+);
+
+# Used to set the maximum load that we will still respond to gitweb queries.
+# If server load exceed this value then return "503 server busy" error.
+# If gitweb cannot determined server load, it is taken to be 0.
+# Leave it undefined (or set to 'undef') to turn off load checking.
+our $maxload = 300;
+
+# You define site-wide feature defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %feature = (
+	# feature => {
+	# 	'sub' => feature-sub (subroutine),
+	# 	'override' => allow-override (boolean),
+	# 	'default' => [ default options...] (array reference)}
+	#
+	# if feature is overridable (it means that allow-override has true value),
+	# then feature-sub will be called with default options as parameters;
+	# return value of feature-sub indicates if to enable specified feature
+	#
+	# if there is no 'sub' key (no feature-sub), then feature cannot be
+	# overriden
+	#
+	# use gitweb_get_feature(<feature>) to retrieve the <feature> value
+	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
+	# is enabled
+
+	# Enable the 'blame' blob view, showing the last commit that modified
+	# each line in the file. This can be very CPU-intensive.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'blame'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'blame'}{'override'} = 1;
+	# and in project config gitweb.blame = 0|1;
+	'blame' => {
+		'sub' => sub { feature_bool('blame', @_) },
+		'override' => 0,
+		'default' => [0]},
+
+	# Enable the 'snapshot' link, providing a compressed archive of any
+	# tree. This can potentially generate high traffic if you have large
+	# project.
+
+	# Value is a list of formats defined in %known_snapshot_formats that
+	# you wish to offer.
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'snapshot'}{'default'} = [];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'snapshot'}{'override'} = 1;
+	# and in project config, a comma-separated list of formats or "none"
+	# to disable.  Example: gitweb.snapshot = tbz2,zip;
+	'snapshot' => {
+		'sub' => \&feature_snapshot,
+		'override' => 0,
+		'default' => ['tgz']},
+
+	# Enable text search, which will list the commits which match author,
+	# committer or commit text to a given string.  Enabled by default.
+	# Project specific override is not supported.
+	'search' => {
+		'override' => 0,
+		'default' => [1]},
+
+	# Enable grep search, which will list the files in currently selected
+	# tree containing the given string. Enabled by default. This can be
+	# potentially CPU-intensive, of course.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'grep'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'grep'}{'override'} = 1;
+	# and in project config gitweb.grep = 0|1;
+	'grep' => {
+		'sub' => sub { feature_bool('grep', @_) },
+		'override' => 0,
+		'default' => [1]},
+
+	# Enable the pickaxe search, which will list the commits that modified
+	# a given string in a file. This can be practical and quite faster
+	# alternative to 'blame', but still potentially CPU-intensive.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'pickaxe'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'pickaxe'}{'override'} = 1;
+	# and in project config gitweb.pickaxe = 0|1;
+	'pickaxe' => {
+		'sub' => sub { feature_bool('pickaxe', @_) },
+		'override' => 0,
+		'default' => [1]},
+
+	# Enable showing size of blobs in a 'tree' view, in a separate
+	# column, similar to what 'ls -l' does.  This cost a bit of IO.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'default'} = [0];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'override'} = 1;
+	# and in project config gitweb.showsizes = 0|1;
+	'show-sizes' => {
+		'sub' => sub { feature_bool('showsizes', @_) },
+		'override' => 0,
+		'default' => [1]},
+
+	# Make gitweb use an alternative format of the URLs which can be
+	# more readable and natural-looking: project name is embedded
+	# directly in the path and the query string contains other
+	# auxiliary information. All gitweb installations recognize
+	# URL in either format; this configures in which formats gitweb
+	# generates links.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'pathinfo'}{'default'} = [1];
+	# Project specific override is not supported.
+
+	# Note that you will need to change the default location of CSS,
+	# favicon, logo and possibly other files to an absolute URL. Also,
+	# if gitweb.cgi serves as your indexfile, you will need to force
+	# $my_uri to contain the script name in your $GITWEB_CONFIG.
+	'pathinfo' => {
+		'override' => 0,
+		'default' => [0]},
+
+	# Make gitweb consider projects in project root subdirectories
+	# to be forks of existing projects. Given project $projname.git,
+	# projects matching $projname/*.git will not be shown in the main
+	# projects list, instead a '+' mark will be added to $projname
+	# there and a 'forks' view will be enabled for the project, listing
+	# all the forks. If project list is taken from a file, forks have
+	# to be listed after the main project.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'forks'}{'default'} = [1];
+	# Project specific override is not supported.
+	'forks' => {
+		'override' => 0,
+		'default' => [0]},
+
+	# Insert custom links to the action bar of all project pages.
+	# This enables you mainly to link to third-party scripts integrating
+	# into gitweb; e.g. git-browser for graphical history representation
+	# or custom web-based repository administration interface.
+
+	# The 'default' value consists of a list of triplets in the form
+	# (label, link, position) where position is the label after which
+	# to insert the link and link is a format string where %n expands
+	# to the project name, %f to the project path within the filesystem,
+	# %h to the current hash (h gitweb parameter) and %b to the current
+	# hash base (hb gitweb parameter); %% expands to %.
+
+	# To enable system wide have in $GITWEB_CONFIG e.g.
+	# $feature{'actions'}{'default'} = [('graphiclog',
+	# 	'/git-browser/by-commit.html?r=%n', 'summary')];
+	# Project specific override is not supported.
+	'actions' => {
+		'override' => 0,
+		'default' => []},
+
+	# Allow gitweb scan project content tags described in ctags/
+	# of project repository, and display the popular Web 2.0-ish
+	# "tag cloud" near the project list. Note that this is something
+	# COMPLETELY different from the normal Git tags.
+
+	# gitweb by itself can show existing tags, but it does not handle
+	# tagging itself; you need an external application for that.
+	# For an example script, check Girocco's cgi/tagproj.cgi.
+	# You may want to install the HTML::TagCloud Perl module to get
+	# a pretty tag cloud instead of just a list of tags.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'ctags'}{'default'} = ['path_to_tag_script'];
+	# Project specific override is not supported.
+	'ctags' => {
+		'override' => 0,
+		'default' => [0]},
+
+	# The maximum number of patches in a patchset generated in patch
+	# view. Set this to 0 or undef to disable patch view, or to a
+	# negative number to remove any limit.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'patches'}{'default'} = [0];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'patches'}{'override'} = 1;
+	# and in project config gitweb.patches = 0|n;
+	# where n is the maximum number of patches allowed in a patchset.
+	'patches' => {
+		'sub' => \&feature_patches,
+		'override' => 0,
+		'default' => [16]},
+
+	# Avatar support. When this feature is enabled, views such as
+	# shortlog or commit will display an avatar associated with
+	# the email of the committer(s) and/or author(s).
+
+	# Currently available providers are gravatar and picon.
+	# If an unknown provider is specified, the feature is disabled.
+
+	# Gravatar depends on Digest::MD5.
+	# Picon currently relies on the indiana.edu database.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'avatar'}{'default'} = ['<provider>'];
+	# where <provider> is either gravatar or picon.
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'avatar'}{'override'} = 1;
+	# and in project config gitweb.avatar = <provider>;
+	'avatar' => {
+		'sub' => \&feature_avatar,
+		'override' => 0,
+		'default' => ['']},
+
+	# Enable displaying how much time and how many git commands
+	# it took to generate and display page.  Disabled by default.
+	# Project specific override is not supported.
+	'timed' => {
+		'override' => 0,
+		'default' => [0]},
+
+	# Enable turning some links into links to actions which require
+	# JavaScript to run (like 'blame_incremental').  Not enabled by
+	# default.  Project specific override is currently not supported.
+	'javascript-actions' => {
+		'override' => 0,
+		'default' => [0]},
+
+	# Syntax highlighting support. This is based on Daniel Svensson's
+	# and Sham Chukoury's work in gitweb-xmms2.git.
+	# It requires the 'highlight' program present in $PATH,
+	# and therefore is disabled by default.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'highlight'}{'default'} = [1];
+
+	'highlight' => {
+		'sub' => sub { feature_bool('highlight', @_) },
+		'override' => 0,
+		'default' => [0]},
+);
+
+sub evaluate_gitweb_config {
+	# die if there are errors parsing config file
+	if (-e $GITWEB_CONFIG) {
+		do $GITWEB_CONFIG;
+		die $@ if $@;
+	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
+		do $GITWEB_CONFIG_SYSTEM;
+		die $@ if $@;
+	}
+}
+
+
+sub gitweb_get_feature {
+	my ($name) = @_;
+	return unless exists $feature{$name};
+	my ($sub, $override, @defaults) = (
+		$feature{$name}{'sub'},
+		$feature{$name}{'override'},
+		@{$feature{$name}{'default'}});
+	# project specific override is possible only if we have project
+	if (!$override || !defined $git_dir) {
+		return @defaults;
+	}
+	if (!defined $sub) {
+		warn "feature $name is not overridable";
+		return @defaults;
+	}
+	return $sub->(@defaults);
+}
+
+# A wrapper to check if a given feature is enabled.
+# With this, you can say
+#
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+#   gitweb_check_feature('bool_feat') or somecode;
+#
+# instead of
+#
+#   my ($bool_feat) = gitweb_get_feature('bool_feat');
+#   (gitweb_get_feature('bool_feat'))[0] or somecode;
+#
+sub gitweb_check_feature {
+	return (gitweb_get_feature(@_))[0];
+}
+
+# process alternate names for backward compatibility
+# filter out unsupported (unknown) snapshot formats
+sub filter_snapshot_fmts {
+	my @fmts = @_;
+
+	@fmts = map {
+		exists $known_snapshot_format_aliases{$_} ?
+		       $known_snapshot_format_aliases{$_} : $_} @fmts;
+	@fmts = grep {
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
+}
+
+our (@snapshot_fmts, $git_avatar);
+sub configure_gitweb_features {
+	# list of supported snapshot formats
+	our @snapshot_fmts = gitweb_get_feature('snapshot');
+	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+
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
+}
+
+1;
-- 
1.7.1.454.g276eb9.dirty
