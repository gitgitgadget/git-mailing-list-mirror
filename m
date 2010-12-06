From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 08/24] gitweb: Add optional output caching
Date: Tue,  7 Dec 2010 00:10:53 +0100
Message-ID: <1291677069-6559-9-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEO-0008RS-1g
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab0LFXMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:07 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0LFXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:03 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OuhFasPbtEUM25G+Q68e+ri7CMmglFNaCZgr5XoLvzc=;
        b=DUsnLhVeXhbZ8kuOrArf2T/19A51kYe5T3KtFFCtBzHIqAGNY1iudiZs289eC7AbgJ
         iicgs6wRMrB2DBYoEIzuIoN9kBB452FdrKChkywJSTAAo/EbWZ8690ZD/IgNe5qMI1z/
         tSi62bwhv0zbrrVtKHHtZ18eNvuLtUpA+1Vc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dhZIbAGkn0+/6gcA+x969E2N9uhHbp4XZRo+MZyM48pfUgrp9dDENqDgwFOCN5qsNS
         0QvOHgGtLOZ0bjeowMDbpfHA1WmN+NIFAmsy2SpFFaePYh4PmJObglC/jWs9AzlaXG12
         wRwKxyed3Hsvj5A/5md2gkPCxIfRlwcJGPZFk=
Received: by 10.213.31.209 with SMTP id z17mr6693807ebc.45.1291677122224;
        Mon, 06 Dec 2010 15:12:02 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:01 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163041>

This commit actually adds output caching to gitweb, as we have now
minimal features required for it in GitwebCache::SimpleFileCache
(a 'dumb' but fast file-based cache engine).  To enable cache you need
(at least) set $caching_enabled to true in gitweb config, and copy
required modules alongside generated gitweb.cgi - this is described
in more detail in the new "Gitweb caching" section in gitweb/README.
"make install-gitweb" would install all modules alongside gitweb
itself.

Caching in theory can be done using any Perl module that implements
Cache::Cache compatibile get/set (method) interface.  The default is
to use GitwebCache::SimpleFileCache.  Capturing and caching output
is done via cache_output subroutine from GitwebCache::CacheOutput.

The cache_output subroutine in GitwebCache::CacheOutput currently uses
GitwebCache::Capture::Simple compatibile capturing engine passed as
one of parameters to cache_output subroutine.  The default is to use
GitwebCache::Capture::Simple package.

Capturing and caching is designed in such way that there is no
behaviour change if $caching_enabled is false.  If caching is not
enabled, then capturing is also turned off.

Enabling caching causes the following additional changes to gitweb
output:
* Disables content-type negotiation (choosing between 'text/html'
  mimetype and 'application/xhtml+xml') when caching, as there is no
  content-type negotiation done when retrieving page from cache.
  Use lowest common denominator of 'text/html' mimetype which can
  be used by all browsers.  This may change in the future.
* Disable optional timing info (how much time it took to generate the
  original page, and how many git commands it took), and in its place show
  unconditionally when page was originally generated (in GMT / UTC
  timezone).
* Disable 'blame_incremental' view, as it doesn't make sense without
  printing data as soon as it is generated (which would require tee-ing
  when capturing output for caching)... and it doesn't work currently
  anyway.  Alternate solution would be to run 'blame_incremental' view
  with caching disabled.


Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.

Check in the t9501-gitweb-standalone-http-status test that gitweb at
least correctly handles "404 Not Found" error pages also in the case
when gitweb caching is enabled.

Check in the t9502-gitweb-standalone-parse-output test that gitweb
produces the same output with and without caching, for first and
second run, with binary or text output.

All those tests make use of new gitweb_enable_caching subroutine added
to gitweb-lib.sh

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Gitweb caching tests are (almost) the same as in

  [PATCHv7.4 4/4] gitweb: Minimal testing of gitweb caching
  Message-Id: <1291404335-25541-4-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/162830/focus=162834

The difference is of course in setting up tests, i.e. in the contents
of gitweb_enable_caching function in t/gitweb-lib.sh.

Only the t9500 tests were present in previous version of this series.


One of differences from "Gitweb caching v7" by J.H. (and minimal fixup of
thereof) is that in "gitweb: File based caching layer (from git.kernel.org)"
hashed (internal) key is composed of $my_url ($cgi->url()) and
$ENV{'QUERY_STRING'}... which meant that it ignores path_info (which is
WRONG, as you can have different views that differ only in path_info part;
different views which shouldn't be lumped together under one cache key), and
that links which differ only in ordering of parameters (e.g. handcrafted
URL) would result in different cache keys.

I have chosen here to use href(-replay => 1, -full => 1, -path_info => 0) as
human-readable cache key, which means that if different link gives use the
same action then it gives us the same cache key.


NOTE: I had to put quick fix about base url, so sha1 of gitweb.perl preimage
might not match.

 gitweb/Makefile                           |    5 +
 gitweb/README                             |   58 ++++++++++++
 gitweb/gitweb.perl                        |  144 +++++++++++++++++++++++++----
 t/gitweb-lib.sh                           |   11 ++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 ++++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +++
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++++++
 7 files changed, 265 insertions(+), 19 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index e6029e1..d67c138 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -113,6 +113,11 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# gitweb output caching
+GITWEB_MODULES += GitwebCache/CacheOutput.pm
+GITWEB_MODULES += GitwebCache/SimpleFileCache.pm
+GITWEB_MODULES += GitwebCache/Capture/Simple.pm
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/README b/gitweb/README
index bf3664f..3dc01bd 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -246,6 +246,12 @@ not include variables usually directly set during build):
    http://www.andre-simon.de due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
+ * $caching_enabled
+   If true, gitweb would use caching to speed up generating response.
+   Currently supported is only output (response) caching.  See "Gitweb caching"
+   section below for details on how to configure and customize caching.
+   The default is false (caching is disabled).
+
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -317,6 +323,58 @@ You can use the following files in repository:
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
index cfa511c..3286709 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -270,6 +270,48 @@ our %highlight_ext = (
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
+
+# This enables/disables the caching layer in gitweb.  Currently supported
+# is only output (response) caching, similar to the one used on git.kernel.org.
+our $caching_enabled = 0;
+# Set to _initialized_ instance of cache interface implementing (at least)
+# get($key) and set($key, $data) methods (Cache::Cache and CHI interfaces),
+# or to name of class of cache interface implementing said methods.
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
+
+	# The number of subdirectories deep to cache object item.  This should be
+	# large enough that no cache directory has more than a few hundred
+	# objects.  Each non-leaf directory contains up to 256 subdirectories
+	# (00-ff).  Must be larger than 0.
+	'cache_depth' => 1,
+
+	# The (global) expiration time for objects placed in the cache, in seconds.
+	'expires_in' => 20,
+);
+# Set to _initialized_ instance of GitwebCache::Capture compatibile capturing
+# engine, i.e. one implementing ->new() constructor, and ->capture($code)
+# method.  If unset (default), the GitwebCache::Capture::Simple would be used.
+our $capture;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -1069,7 +1111,15 @@ sub dispatch {
 	    !$project) {
 		die_error(400, "Project needed");
 	}
-	$actions{$action}->();
+
+	if ($caching_enabled) {
+		# human readable key identifying gitweb output
+		my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
+
+		cache_output($cache, $capture, $output_key, $actions{$action});
+	} else {
+		$actions{$action}->();
+	}
 }
 
 sub reset_timer {
@@ -1085,6 +1135,8 @@ sub run_request {
 	evaluate_gitweb_config();
 	evaluate_git_version();
 	check_loadavg();
+	configure_caching()
+		if ($caching_enabled);
 
 	# $projectroot and $projects_list might be set in gitweb config file
 	$projects_list ||= $projectroot;
@@ -1157,6 +1209,42 @@ sub run {
 	1;
 }
 
+sub configure_caching {
+	if (!eval { require GitwebCache::CacheOutput; 1; }) {
+		# cache is configured _before_ handling request, so $cgi is not defined,
+		# so we can't just "die" with sending error message to web browser
+		#die_error(500, "Caching enabled and GitwebCache::CacheOutput not found");
+
+		# turn off caching and warn instead
+		$caching_enabled = 0;
+		warn "Caching enabled and GitwebCache::CacheOutput not found";
+	}
+	GitwebCache::CacheOutput->import();
+
+	# $cache might be initialized (instantiated) cache, i.e. cache object,
+	# or it might be name of class, or it might be undefined
+	unless (defined $cache && ref($cache)) {
+		$cache ||= 'GitwebCache::SimpleFileCache';
+		eval "require $cache";
+		die $@ if $@;
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
+	unless (defined $capture && ref($capture)) {
+		require GitwebCache::Capture::Simple;
+		$capture = GitwebCache::Capture::Simple->new();
+	}
+}
+
 run();
 
 if (defined caller) {
@@ -3420,7 +3508,9 @@ sub git_header_html {
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
@@ -3445,7 +3535,9 @@ sub git_header_html {
 EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
 	# unless we set the appropriate base URL
-	if ($ENV{'PATH_INFO'}) {
+	# if caching is enabled we can get it from cache for path_info when it
+	# is generated without path_info
+	if ($ENV{'PATH_INFO'} || $caching_enabled) {
 		print "<base href=\"".esc_url($base_url)."\" />\n";
 	}
 	# print out each stylesheet that exist, providing backwards capability
@@ -3594,17 +3686,25 @@ sub git_footer_html {
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
 
@@ -3613,8 +3713,8 @@ sub git_footer_html {
 	}
 
 	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
-	if (defined $action &&
-	    $action eq 'blame_incremental') {
+	if (!$caching_enabled &&
+	    defined $action && $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
@@ -3655,6 +3755,10 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+
+	# Do not cache error pages
+	capture_stop($cache, $capture) if ($capture && $caching_enabled);
+
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
 <div class="page_body">
@@ -5250,7 +5354,8 @@ sub git_tag {
 
 sub git_blame_common {
 	my $format = shift || 'porcelain';
-	if ($format eq 'porcelain' && $cgi->param('js')) {
+	if ($format eq 'porcelain' && $cgi->param('js') &&
+	    !$caching_enabled) {
 		$format = 'incremental';
 		$action = 'blame_incremental'; # for page title etc
 	}
@@ -5304,7 +5409,8 @@ sub git_blame_common {
 			or print "ERROR $!\n";
 
 		print 'END';
-		if (defined $t0 && gitweb_check_feature('timed')) {
+		if (!$caching_enabled &&
+		    defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
 			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
@@ -5324,7 +5430,7 @@ sub git_blame_common {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame", javascript=>0, -replay=>1)},
 			        "blame") . " (non-incremental)";
-	} else {
+	} elsif (!$caching_enabled) {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame_incremental", -replay=>1)},
 			        "blame") . " (incremental)";
@@ -5483,7 +5589,7 @@ sub git_blame {
 }
 
 sub git_blame_incremental {
-	git_blame_common('incremental');
+	git_blame_common(!$caching_enabled ? 'incremental' : undef);
 }
 
 sub git_blame_data {
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..4ce067f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,6 +52,17 @@ EOF
 	export SCRIPT_NAME
 }
 
+gitweb_enable_caching () {
+	test_expect_success 'enable caching' '
+		cat >>gitweb_config.perl <<-\EOF &&
+		$caching_enabled = 1;
+		$cache_options{"expires_in"} = -1;      # never expire cache for tests
+		$cache_options{"cache_root"} = "cache"; # to clear the right thing
+		EOF
+		rm -rf cache/
+	'
+}
+
 gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 21cd286..cc9cee5 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -677,4 +677,24 @@ test_expect_success HIGHLIGHT \
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+gitweb_enable_caching
+
+test_expect_success \
+	'caching enabled (project summary, first run, generating cache)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (project summary, second run, cached version)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (non-existent commit, not cached error page)' \
+	'gitweb_run "p=.git;a=commit;h=non-existent"'
+test_debug 'cat gitweb.log'
+
 test_done
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 2487da1..168e494 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -134,5 +134,18 @@ cat >>gitweb_config.perl <<\EOF
 our $maxload = undef;
 EOF
 
+# ----------------------------------------------------------------------
+# output caching
+
+gitweb_enable_caching
+
+test_expect_success 'caching enabled (non-existent commit, 404 error)' '
+	gitweb_run "p=.git;a=commit;h=non-existent" &&
+	grep "Status: 404 Not Found" gitweb.headers &&
+	grep "404 - Unknown commit object" gitweb.body
+'
+test_debug 'echo "headers" && cat gitweb.headers'
+test_debug 'echo "body"    && cat gitweb.body'
+
 
 test_done
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index dd83890..bc8cb92 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -112,4 +112,37 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+
+# ----------------------------------------------------------------------
+# whether gitweb with caching enabled produces the same output
+
+test_expect_success 'setup for caching tests (utf8 commit, binary file)' '
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	cp "$TEST_DIRECTORY"/test9200a.png image.png &&
+	git add image.png &&
+	git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
+	gitweb_run "p=.git;a=patch" &&
+	mv gitweb.body no_cache.html &&
+	gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+	mv gitweb.body no_cache.png
+'
+
+gitweb_enable_caching
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, HTML output, $desc" '
+		gitweb_run "p=.git;a=patch" &&
+		mv gitweb.body cache.html &&
+		test_cmp no_cache.html cache.html
+	'
+done
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, binary output, $desc" '
+		gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+		mv gitweb.body cache.png &&
+		cmp no_cache.png cache.png
+	'
+done
+
 test_done
-- 
1.7.3
