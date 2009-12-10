From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Thu, 10 Dec 2009 23:45:43 +0000
Message-ID: <1260488743-25855-7-git-send-email-warthog9@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <1260488743-25855-3-git-send-email-warthog9@kernel.org>
 <1260488743-25855-4-git-send-email-warthog9@kernel.org>
 <1260488743-25855-5-git-send-email-warthog9@kernel.org>
 <1260488743-25855-6-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsjR-0005wO-P4
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbZLJXrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757768AbZLJXrN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:47:13 -0500
Received: from hera.kernel.org ([140.211.167.34]:39935 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757586AbZLJXrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:47:01 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANk0AB026016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:46:00 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANk0p4026015;
	Thu, 10 Dec 2009 23:46:00 GMT
X-Mailer: git-send-email 1.6.5.5
In-Reply-To: <1260488743-25855-6-git-send-email-warthog9@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135056>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This is an attempt to break out the default values & associated
documentation from the main gitweb file so that it's easier to
browse / read and understand without the associated code involved.

This helps by making defaults self contained with their documentation
making it easier for someone to read through things and find what
they want

This is also a not-so-subtle start of trying to break up gitweb into
separate files for easier maintainability, having everything in a
single file is just a mess and makes the whole thing more complicated
than it needs to be.  This is a bit of a baby step towards breaking it
up for easier maintenance.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 .gitignore                  |    1 +
 Makefile                    |   15 +-
 gitweb/Makefile             |    2 +-
 gitweb/gitweb.perl          |  515 +++++--------------------------------------
 gitweb/gitweb_defaults.perl |  468 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 537 insertions(+), 464 deletions(-)
 create mode 100644 gitweb/gitweb_defaults.perl


--------------1.6.5.2
Content-Type: text/x-patch; name="0006-GITWEB-Separate-defaults-from-main-file.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0006-GITWEB-Separate-defaults-from-main-file.patch"

diff --git a/.gitignore b/.gitignore
index ac02a58..5e48102 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
+/gitweb/gitweb_defaults.pl
 /test-chmtime
 /test-ctype
 /test-date
diff --git a/Makefile b/Makefile
index 8db9d01..2c5f139 100644
--- a/Makefile
+++ b/Makefile
@@ -1510,14 +1510,16 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	mv $@+ $@
 
 .PHONY: gitweb
-gitweb: gitweb/gitweb.cgi
+gitweb: gitweb/gitweb.cgi gitweb/gitweb_defaults.pl
 ifdef JSMIN
-OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
-gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
+OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js gitweb/gitweb_defaults.pl
+gitweb/gitweb.cgi gitweb/gitweb_defaults.pl: gitweb/gitweb.perl gitweb/gitweb.min.js gitweb/gitweb_defaults.perl
 else
-OTHER_PROGRAMS += gitweb/gitweb.cgi
-gitweb/gitweb.cgi: gitweb/gitweb.perl
+OTHER_PROGRAMS += gitweb/gitweb.cgi gitweb/gitweb_defaults.pl
+gitweb/gitweb.cgi: gitweb/gitweb_defaults.pl
+gitweb/gitweb.cgi gitweb/gitweb_defaults.pl: gitweb/gitweb.perl gitweb/gitweb_defaults.perl
 endif
+	#$(QUIET_GEN)$(RM) $@ $@+ &&
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
@@ -1539,7 +1541,7 @@ endif
 	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
+	    $(patsubst %.cgi,%.perl,$(patsubst %.pl, %.perl, $@)) >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
@@ -1913,6 +1915,7 @@ clean:
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(RM) gitweb/gitweb.cgi
+	$(RM) gitweb/gitweb_defaults.pl
 	$(MAKE) -C perl clean
 endif
 	$(MAKE) -C templates/ clean
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 8d318b3..2bd421a 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -1,6 +1,6 @@
 SHELL = /bin/bash
 
-FILES = gitweb.cgi
+FILES = gitweb.cgi gitweb_defaults.pl
 
 .PHONY: $(FILES)
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b44371..fd41539 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -36,466 +36,67 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
-# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
-# needed and used only for URLs with nonempty PATH_INFO
-our $base_url = $my_url;
-
-# When the script is used as DirectoryIndex, the URL does not contain the name
-# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
-# have to do it ourselves. We make $path_info global because it's also used
-# later on.
 #
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
-	}
-}
-
-# core git executable to use
-# this can just be "git" if your webserver has a sensible PATH
-our $GIT = "++GIT_BINDIR++/git";
-
-# absolute fs-path which will be prepended to the project path
-#our $projectroot = "/pub/scm";
-our $projectroot = "++GITWEB_PROJECTROOT++";
-
-# fs traversing limit for getting project list
-# the number is relative to the projectroot
-our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
-
-# target of the home link on top of all pages
-our $home_link = $my_uri || "/";
-
-# string of the home link on top of all pages
-our $home_link_str = "++GITWEB_HOME_LINK_STR++";
-
-# name of your site or organization to appear in page titles
-# replace this with something more descriptive for clearer bookmarks
-our $site_name = "++GITWEB_SITENAME++"
-                 || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
-
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
-
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
-
-# Pixel sizes for icons and avatars. If the default font sizes or lineheights
-# are changed, it may be appropriate to change these values too via
-# $GITWEB_CONFIG.
-our %avatar_size = (
-	'default' => 16,
-	'double'  => 32
+# Define and than setup our configuration 
+#
+our(
+	$VERSION,
+	$path_info,
+	$GIT,
+	$projectroot,
+	$project_maxdepth,
+	$home_link,
+	$home_link_str,
+	$site_name,
+	$site_header,
+	$home_text,
+	$site_footer,
+	@stylesheets,
+	$stylesheet,
+	$logo,
+	$favicon,
+	$javascript,
+	$logo_url,
+	$logo_label,
+	$projects_list,
+	$projects_list_description_width,
+	$default_projects_order,
+	$export_ok,
+	$export_auth_hook,
+	$strict_export,
+	@git_base_url_list,
+	$default_blob_plain_mimetype,
+	$default_text_plain_charset,
+	$mimetypes_file,
+	$missmatch_git,
+	$gitlinkurl,
+	$maxload,
+	$cache_enable,
+	$minCacheTime,
+	$maxCacheTime,
+	$cachedir,
+	$backgroundCache,
+	$nocachedata,
+	$nocachedatabin,
+	$fullhashpath,
+	$fullhashbinpath,
+	$export_auth_hook,
+	%known_snapshot_format_aliases,
+	%known_snapshot_formats,
+	$path_info,
+	$fallback_encoding,
+	%avatar_size,
+	$project_maxdepth,
+	$headerRefresh,
+	$base_url,
+	$projects_list_description_width,
+	$default_projects_order,
+	$prevent_xss,
+	@diff_opts,
+	%feature
 );
 
-# This is here to allow for missmatch git & gitweb versions
-our $missmatch_git = '';
-
-#This is here to deal with an extra link on the summary pages - if it's left blank
-# this link will not be shwon.  If it's set, this will be prepended to the repo and used
-our $gitlinkurl = '';
-
-# Used to set the maximum load that we will still respond to gitweb queries.
-# if we exceed this than we do the processing to figure out if there's a mirror
-# and redirect to it, or to just return 503 server busy
-our $maxload = 300;
-
-# This enables/disables the caching layer in gitweb.  This currently only supports the
-# 'dumb' file based caching layer, primarily used on git.kernel.org.  this is reasonably
-# effective but it has the downside of requiring a huge amount of disk space if there
-# are a number of repositories involved.  It is not uncommon for git.kernel.org to have
-# on the order of 80G - 120G accumulate over the course of a few months.  It is recommended
-# that the cache directory be periodically completely deleted, and this is safe to perform.
-# Suggested mechanism
-# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
-# Value is binary. 0 = disabled (default), 1 = enabled.
-our $cache_enable = 0;
-
-# Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
-# if we calculate the cache to be under this number of seconds we set the cache timeout 
-# to this minimum.
-# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
-our $minCacheTime = 20;
-
-# Used to set the maximum cache timeout for the dynamic caching algorithm.  Basically
-# if we calculate the cache to exceed this number of seconds we set the cache timeout 
-# to this maximum.
-# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
-our $maxCacheTime = 1200;
-
-# If you need to change the location of the caching directory, override this
-# otherwise this will probably do fine for you
-our $cachedir = 'cache';
-
-# If this is set (to 1) cache will do it's best to always display something instead
-# of making someone wait for the cache to update.  This will launch the cacheUpdate
-# into the background and it will lock a <file>.bg file and will only lock the 
-# actual cache file when it needs to write into it.  In theory this will make 
-# gitweb seem more responsive at the price of possibly stale data.
-our $backgroundCache = 1;
-
-# Used to set the maximum cache file life.  If a cache files last modify time exceeds
-# this value, it will assume that the data is just too old, and HAS to be regenerated
-# instead of trying to display the existing cache data.
-# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
-# 18000 = 5 hours
-our $maxCacheLife = 18000;
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
-);
+do 'gitweb_defaults.pl';
 
 sub gitweb_get_feature {
 	my ($name) = @_;
diff --git a/gitweb/gitweb_defaults.perl b/gitweb/gitweb_defaults.perl
new file mode 100644
index 0000000..ede0daf
--- /dev/null
+++ b/gitweb/gitweb_defaults.perl
@@ -0,0 +1,468 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
+# (C) 2005, Christian Gierke
+#
+# This program is licensed under the GPLv2
+
+# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
+# needed and used only for URLs with nonempty PATH_INFO
+$base_url = $my_url;
+
+# When the script is used as DirectoryIndex, the URL does not contain the name
+# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
+# have to do it ourselves. We make $path_info global because it's also used
+# later on.
+#
+# Another issue with the script being the DirectoryIndex is that the resulting
+# $my_url data is not the full script URL: this is good, because we want
+# generated links to keep implying the script name if it wasn't explicitly
+# indicated in the URL we're handling, but it means that $my_url cannot be used
+# as base URL.
+# Therefore, if we needed to strip PATH_INFO, then we know that we have
+# to build the base URL ourselves:
+$path_info = $ENV{"PATH_INFO"};
+if ($path_info) {
+	if ($my_url =~ s,\Q$path_info\E$,, &&
+	    $my_uri =~ s,\Q$path_info\E$,, &&
+	    defined $ENV{'SCRIPT_NAME'}) {
+		$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+	}
+}
+
+# core git executable to use
+# this can just be "git" if your webserver has a sensible PATH
+$GIT = "++GIT_BINDIR++/git";
+
+# absolute fs-path which will be prepended to the project path
+#our $projectroot = "/pub/scm";
+$projectroot = "++GITWEB_PROJECTROOT++";
+
+# fs traversing limit for getting project list
+# the number is relative to the projectroot
+$project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
+
+# target of the home link on top of all pages
+$home_link = $my_uri || "/";
+
+# string of the home link on top of all pages
+$home_link_str = "++GITWEB_HOME_LINK_STR++";
+
+# name of your site or organization to appear in page titles
+# replace this with something more descriptive for clearer bookmarks
+$site_name = "++GITWEB_SITENAME++"
+                 || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
+
+# filename of html text to include at top of each page
+$site_header = "++GITWEB_SITE_HEADER++";
+# html text to include at home page
+$home_text = "++GITWEB_HOMETEXT++";
+# filename of html text to include at bottom of each page
+$site_footer = "++GITWEB_SITE_FOOTER++";
+
+# URI of stylesheets
+@stylesheets = ("++GITWEB_CSS++");
+# URI of a single stylesheet, which can be overridden in GITWEB_CONFIG.
+$stylesheet = undef;
+# URI of GIT logo (72x27 size)
+$logo = "++GITWEB_LOGO++";
+# URI of GIT favicon, assumed to be image/png type
+$favicon = "++GITWEB_FAVICON++";
+# URI of gitweb.js (JavaScript code for gitweb)
+$javascript = "++GITWEB_JS++";
+
+# URI and label (title) of GIT logo link
+#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_label = "git documentation";
+$logo_url = "http://git-scm.com/";
+$logo_label = "git homepage";
+
+# source of projects list
+$projects_list = "++GITWEB_LIST++";
+
+# the width (in characters) of the projects list "Description" column
+$projects_list_description_width = 25;
+
+# default order of projects list
+# valid values are none, project, descr, owner, and age
+$default_projects_order = "project";
+
+# show repository only if this file exists
+# (only effective if this variable evaluates to true)
+$export_ok = "++GITWEB_EXPORT_OK++";
+
+# show repository only if this subroutine returns true
+# when given the path to the project, for example:
+#    sub { return -e "$_[0]/git-daemon-export-ok"; }
+$export_auth_hook = undef;
+
+# only allow viewing of repositories also shown on the overview page
+$strict_export = "++GITWEB_STRICT_EXPORT++";
+
+# list of git base URLs used for URL to where fetch project from,
+# i.e. full URL is "$git_base_url/$project"
+@git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
+
+# default blob_plain mimetype and default charset for text/plain blob
+$default_blob_plain_mimetype = 'text/plain';
+$default_text_plain_charset  = undef;
+
+# file to use for guessing MIME types before trying /etc/mime.types
+# (relative to the current git repository)
+$mimetypes_file = undef;
+
+# assume this charset if line contains non-UTF-8 characters;
+# it should be valid encoding (see Encoding::Supported(3pm) for list),
+# for which encoding all byte sequences are valid, for example
+# 'iso-8859-1' aka 'latin1' (it is decoded without checking, so it
+# could be even 'utf-8' for the old behavior)
+$fallback_encoding = 'latin1';
+
+# rename detection options for git-diff and git-diff-tree
+# - default is '-M', with the cost proportional to
+#   (number of removed files) * (number of new files).
+# - more costly is '-C' (which implies '-M'), with the cost proportional to
+#   (number of changed files + number of removed files) * (number of new files)
+# - even more costly is '-C', '--find-copies-harder' with cost
+#   (number of files in the original tree) * (number of new files)
+# - one might want to include '-B' option, e.g. '-B', '-M'
+@diff_opts = ('-M'); # taken from git_commit
+
+# Disables features that would allow repository owners to inject script into
+# the gitweb domain.
+$prevent_xss = 0;
+
+# information about snapshot formats that gitweb is capable of serving
+%known_snapshot_formats = (
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
+%known_snapshot_format_aliases = (
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
+%avatar_size = (
+	'default' => 16,
+	'double'  => 32
+);
+
+# This is here to allow for missmatch git & gitweb versions
+$missmatch_git = '';
+
+#This is here to deal with an extra link on the summary pages - if it's left blank
+# this link will not be shwon.  If it's set, this will be prepended to the repo and used
+$gitlinkurl = '';
+
+# Used to set the maximum load that we will still respond to gitweb queries.
+# if we exceed this than we do the processing to figure out if there's a mirror
+# and redirect to it, or to just return 503 server busy
+$maxload = 300;
+
+# This enables/disables the caching layer in gitweb.  This currently only supports the
+# 'dumb' file based caching layer, primarily used on git.kernel.org.  this is reasonably
+# effective but it has the downside of requiring a huge amount of disk space if there
+# are a number of repositories involved.  It is not uncommon for git.kernel.org to have
+# on the order of 80G - 120G accumulate over the course of a few months.  It is recommended
+# that the cache directory be periodically completely deleted, and this is safe to perform.
+# Suggested mechanism
+# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
+# Value is binary. 0 = disabled (default), 1 = enabled.
+$cache_enable = 0;
+
+# Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
+# if we calculate the cache to be under this number of seconds we set the cache timeout 
+# to this minimum.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+$minCacheTime = 20;
+
+# Used to set the maximum cache timeout for the dynamic caching algorithm.  Basically
+# if we calculate the cache to exceed this number of seconds we set the cache timeout 
+# to this maximum.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+$maxCacheTime = 1200;
+
+# If you need to change the location of the caching directory, override this
+# otherwise this will probably do fine for you
+$cachedir = 'cache';
+
+# If this is set (to 1) cache will do it's best to always display something instead
+# of making someone wait for the cache to update.  This will launch the cacheUpdate
+# into the background and it will lock a <file>.bg file and will only lock the 
+# actual cache file when it needs to write into it.  In theory this will make 
+# gitweb seem more responsive at the price of possibly stale data.
+$backgroundCache = 1;
+
+# Used to set the maximum cache file life.  If a cache files last modify time exceeds
+# this value, it will assume that the data is just too old, and HAS to be regenerated
+# instead of trying to display the existing cache data.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+# 18000 = 5 hours
+$maxCacheLife = 18000;
+
+# You define site-wide feature defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+%feature = (
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
+);
+1;

--------------1.6.5.2--
