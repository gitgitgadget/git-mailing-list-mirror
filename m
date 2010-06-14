From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 10/17] gitweb: Add optional output caching (from gitweb/cache.pm)
Date: Mon, 14 Jun 2010 18:08:22 +0200
Message-ID: <1276531710-22945-11-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEw-0002Dq-FS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab0FNQJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab0FNQIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:54 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oREw9VpfN4SF3wPP2q60uD6LsrYVLdRnVwnxdK7kocg=;
        b=JwsA63A4La/VCLW1lgujILA7xSVJxacQjVBqw7ROgnl03+OSP+VrsNtA6lZU6RHaty
         vfWoZ5LO8vuHcAtkO4m2juWlhi8Ee4SxCGMWaaCvD4FHVGktxV9AaTa4g85viwaWuZtz
         8QhLYPY+HyJXuKNQlR0rkiDRz/dSbn4AHJBRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j4kWEVReNsVyYePTMz+qa6Oz3i+uKsGquvsTT3rJhMfaWO5QdpFYHGVK/H1QbBsMsm
         MZPKlD/l/q0ggcEmHFOzmcebk8ry5ucp0CEx4Sn2RWSZ0O9ia5AFMziP5FKvgFWIyMGn
         WB/J6yV6Z8mAbnUcTwG+3fEGuNj6yti1NTu1E=
Received: by 10.223.47.130 with SMTP id n2mr5666955faf.55.1276531733446;
        Mon, 14 Jun 2010 09:08:53 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149114>

This commit actually adds output caching to gitweb, as we have now
minimal features required for it in GitwebCache::SimpleFileCache
(a 'dumb' but fast file-based cache engine).  To enable cache you need
(at least) set $caching_enabled to true in gitweb config, and copy
gitweb/cache.pm alongside generated gitweb.cgi - this is described
in more detail in the new "Gitweb caching" section in gitweb/README.

Caching in theory can be done using any Perl module that implements
Cache::Cache compatibile get/set (method) interface.  The default is
to use GitwebCache::SimpleFileCache from gitweb/cache.pm.  Capturing
and caching output is done via cache_output subroutine from
GitwebCache::CacheOutput, also in gitweb/cache.pm.

The cache_output subroutine in GitwebCache::CacheOutput currently
captures output using GitwebCache::Capture::SelectFH package, which in
turn uses select(FILEHANDLE) to change default filehandle for output.
This means that a "print" or a "printf" (or a "write") in gitweb
source without a filehandle would be captured.  To change mode of
filehandle used for capturing correctly, "binmode STDOUT, <mode>" had
to be changed to "binmode select(), <mode>".

Capturing and caching is designed in such way that there is no
behaviour change if $caching_enabled is false.  If caching is not
enabled, then capturing is also turned off.

Enabling caching causes the following additional changes to gitweb
output:
* Disables content-type negotiation (choosing between 'text/html'
  mimetype and 'application/xhtml+xml') when caching, as there is no
  content-type negotiation done when retrieving page from cache.
  Use lowest common denominator of 'text/html' mimetype which can
  be used by all browsers.
* Disable optional timing info (how much time it took to generate the
  original page, and how many git commands it took), and in its place show
  unconditionally when page was originally generated (in GMT / UTC
  timezone).
* Disable 'blame_incremental' view, as it doesn't make sense without
  printing data as soon as it is generated (which would require tee-ing
  when capturing output for caching)... and it doesn't work currently
  anyway.

Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.


To be implemented (from original patch by J.H.):
* adaptive cache expiration, based on average system load
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/Makefile                        |    6 ++
 gitweb/README                          |   58 +++++++++++++++
 gitweb/gitweb.perl                     |  127 ++++++++++++++++++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |   19 +++++
 4 files changed, 187 insertions(+), 23 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d2401e1..025060b 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -111,6 +111,12 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# gitweb output caching
+GITWEB_MODULES += lib/GitwebCache/CacheOutput.pm
+GITWEB_MODULES += lib/GitwebCache/SimpleFileCache.pm
+GITWEB_MODULES += lib/GitwebCache/Capture.pm
+GITWEB_MODULES += lib/GitwebCache/Capture/SelectFH.pm
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/README b/gitweb/README
index 0e19be8..9b3e5d7 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -236,6 +236,11 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $caching_enabled
+   If true, gitweb would use caching to speed up generating response.
+   Currently supported is only output (response) caching.  See "Gitweb caching"
+   section below for details on how to configure and customize caching.
+   The default is false (caching is disabled).
 
 
 Projects list file format
@@ -308,6 +313,59 @@ You can use the following files in repository:
    descriptions.
 
 
+Gitweb caching
+~~~~~~~~~~~~~~
+
+Currently gitweb supports only output (HTTP response) caching, similar
+to the one used on http://git.kernel.org.  To turn it on, set 
+$caching_enabled variable to true value in gitweb config file, i.e.:
+
+   our $caching_enabled = 1;
+
+You can choose which caching engine should gitweb use by setting $cache
+variable to _initialized_ instance of cache interface, e.g.:
+
+   use CHI;
+   our $cache = CHI->new( driver => 'Memcached',
+   	servers => [ "10.0.0.15:11211", "10.0.0.15:11212" ],
+   	l1_cache => { driver => 'FastMmap', root_dir => '/var/cache/gitweb' }
+   );
+
+Alternatively you can set $cache variable to the name of cache class,
+e.g.:
+
+   use Cache::FileCache;
+   our $cache = 'Cache::FileCache';
+
+In this case caching engine should support Cache::Cache or CHI names for
+cache config (see below), and ignore unrecognized options.  Such caching
+engine should also implement (at least) ->get($key) and ->set($key, $data)
+methods (Cache::Cache and CHI compatible interface).
+
+If $cache is left unset (if it is left undefined), then gitweb would use
+GitwebCache::SimpleFileCache as caching engine.  This engine is 'dumb' (but
+fast) file based caching layer, currently without any support for cache size
+limiting, or even removing expired / grossly expired entries.  It has
+therefore the downside of requiring a huge amount of disk space if there are
+a number of repositories involved.  It is not uncommon for git.kernel.org to
+have on the order of 80G - 120G accumulate over the course of a few months.
+It is therefore recommended that the cache directory be periodically
+completely deleted; this operation is safe to perform.  Suggested mechanism
+(substitute $cachedir for actual path to gitweb cache):
+
+   # mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+
+Site-wide cache options are defined in %cache_options hash.  Those options
+apply only when $cache is unset (GitwebCache::SimpleFileCache is used), or
+if $cache is name of cache class (e.g. $cache = 'Cache::FileCache').  You
+can override cache options in gitweb config, e.g.:
+
+   $cache_options{'expires_in'} = 60; # 60 seconds = 1 minute
+
+Please read comments for %cache_options entries in gitweb/gitweb.perl for
+description of available cache options.
+
+
 Webserver configuration
 -----------------------
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bb81e14..6772f6e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -236,6 +236,41 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
+# This enables/disables the caching layer in gitweb.  Currently supported
+# is only output (response) caching, similar to the one used on git.kernel.org.
+our $caching_enabled = 0;
+# Set to _initialized_ instance of cache interface implementing (at least)
+# get($key) and set($key, $data) methods (Cache::Cache and CHI interfaces).
+# If unset, GitwebCache::SimpleFileCache would be used, which is 'dumb'
+# (but fast) file based caching layer, currently without any support for
+# cache size limiting.  It is therefore recommended that the cache directory
+# be periodically completely deleted; this operation is safe to perform.
+# Suggested mechanism:
+# mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+our $cache;
+# You define site-wide cache options defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %cache_options = (
+	# The location in the filesystem that will hold the root of the cache.
+	# This directory will be created as needed (if possible) on the first
+	# cache set.  Note that either this directory must exists and web server
+	# has to have write permissions to it, or web server must be able to
+	# create this directory.
+	# Possible values:
+	# * 'cache' (relative to gitweb),
+	# * File::Spec->catdir(File::Spec->tmpdir(), 'gitweb-cache'),
+	# * '/var/cache/gitweb' (FHS compliant, requires being set up),
+	'cache_root' => 'cache',
+	# The number of subdirectories deep to cache object item.  This should be
+	# large enough that no cache directory has more than a few hundred
+	# objects.  Each non-leaf directory contains up to 256 subdirectories
+	# (00-ff).  Must be larger than 0.
+	'cache_depth' => 1,
+	# The (global) expiration time for objects placed in the cache, in seconds.
+	'expires_in' => 20,
+);
+
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -995,7 +1030,37 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
-$actions{$action}->();
+
+if ($caching_enabled) {
+	if (!eval { require GitwebCache::CacheOutput; 1; }) {
+		die_error(500, "Caching enabled and GitwebCache::CacheOutput not found");
+	}
+	GitwebCache::CacheOutput->import();
+
+	# $cache might be initialized (instantiated) cache, i.e. cache object,
+	# or it might be name of class, or it might be undefined
+	unless (defined $cache && ref($cache)) {
+		$cache ||= 'GitwebCache::SimpleFileCache';
+		$cache = $cache->new({
+			%cache_options,
+			#'cache_root' => '/tmp/cache',
+			#'cache_depth' => 2,
+			#'expires_in' => 20, # in seconds (CHI compatibile)
+			# (Cache::Cache compatibile initialization)
+			'default_expires_in' => $cache_options{'expires_in'},
+			# (CHI compatibile initialization)
+			'root_dir' => $cache_options{'cache_root'},
+			'depth' => $cache_options{'cache_depth'},
+		});
+	}
+
+	# human readable key identifying gitweb output
+	my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
+
+	cache_output($cache, $output_key, $actions{$action});
+} else {
+	$actions{$action}->();
+}
 
 DONE_GITWEB:
 if (defined caller) {
@@ -3230,7 +3295,9 @@ sub git_header_html {
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
 	# we have to do this because MSIE sometimes globs '*/*', pretending to
 	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') &&
+	# Disable content-type negotiation when caching (use mimetype good for all).
+	if (!$caching_enabled &&
+	    defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
 	    $cgi->Accept('application/xhtml+xml') != 0) {
 		$content_type = 'application/xhtml+xml';
@@ -3404,17 +3471,25 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
-	if (defined $t0 && gitweb_check_feature('timed')) {
+	# timing info doesn't make much sense with output (response) caching,
+	# so when caching is enabled gitweb prints the time of page generation
+	if ((defined $t0 || $caching_enabled) &&
+	    gitweb_check_feature('timed')) {
 		print "<div id=\"generating_info\">\n";
-		print 'This page took '.
-		      '<span id="generating_time" class="time_span">'.
-		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
-		      ' seconds </span>'.
-		      ' and '.
-		      '<span id="generating_cmd">'.
-		      $number_of_git_cmds.
-		      '</span> git commands '.
-		      " to generate.\n";
+		if ($caching_enabled) {
+			print 'This page was generated at '.
+			      gmtime( time() )." GMT\n";
+		} else {
+			print 'This page took '.
+			      '<span id="generating_time" class="time_span">'.
+			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+			      ' seconds </span>'.
+			      ' and '.
+			      '<span id="generating_cmd">'.
+			      $number_of_git_cmds.
+			      '</span> git commands '.
+			      " to generate.\n";
+		}
 		print "</div>\n"; # class="page_footer"
 	}
 
@@ -3423,8 +3498,8 @@ sub git_footer_html {
 	}
 
 	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
-	if (defined $action &&
-	    $action eq 'blame_incremental') {
+	if (!$caching_enabled &&
+	    defined $action && $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
@@ -3465,6 +3540,10 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+
+	# Do not cache error pages
+	capture_stop() if ($caching_enabled);
+
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
 <div class="page_body">
@@ -4246,7 +4325,7 @@ sub git_patchset_body {
 	while ($patch_line) {
 
 		# parse "git diff" header line
-		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {
+		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {#"#"'
 			# $1 is from_name, which we do not use
 			$to_name = unquote($2);
 			$to_name =~ s!^b/!!;
@@ -5060,7 +5139,8 @@ sub git_tag {
 
 sub git_blame_common {
 	my $format = shift || 'porcelain';
-	if ($format eq 'porcelain' && $cgi->param('js')) {
+	if ($format eq 'porcelain' && $cgi->param('js') &&
+	    !$caching_enabled) {
 		$format = 'incremental';
 		$action = 'blame_incremental'; # for page title etc
 	}
@@ -5114,7 +5194,8 @@ sub git_blame_common {
 			or print "ERROR $!\n";
 
 		print 'END';
-		if (defined $t0 && gitweb_check_feature('timed')) {
+		if (!$caching_enabled &&
+		    defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
 			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
@@ -5134,7 +5215,7 @@ sub git_blame_common {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame", javascript=>0, -replay=>1)},
 			        "blame") . " (non-incremental)";
-	} else {
+	} elsif (!$caching_enabled) {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame_incremental", -replay=>1)},
 			        "blame") . " (incremental)";
@@ -5293,7 +5374,7 @@ sub git_blame {
 }
 
 sub git_blame_incremental {
-	git_blame_common('incremental');
+	git_blame_common(!$caching_enabled ? 'incremental' : undef);
 }
 
 sub git_blame_data {
@@ -5373,9 +5454,9 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
-	binmode STDOUT, ':raw';
+	binmode select(), ':raw';
 	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode select(), ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 }
 
@@ -5655,9 +5736,9 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
+	binmode select(), ':raw';
 	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode select(), ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 }
 
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 63b6b06..aeb471d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -647,4 +647,23 @@ test_expect_success \
 	 gitweb_run "p=.git;a=summary"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+cat >>gitweb_config.perl <<\EOF
+$caching_enabled = 1;
+$cache_options{'expires_in'} = -1; # never expire cache for tests
+EOF
+rm -rf cache
+
+test_expect_success \
+	'caching enabled (project summary, first run)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (project summary, second run)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
 test_done
-- 
1.7.0.1
