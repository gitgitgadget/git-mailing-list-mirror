From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 9/9] gitweb: Add optional output caching
Date: Thu, 23 Dec 2010 00:58:24 +0100
Message-ID: <20101222235823.7998.15358.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYaR-0000Ba-EN
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab0LVX7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:59:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36099 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab0LVX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:59:08 -0500
Received: by fxm20 with SMTP id 20so6640202fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=OgSpopkCHmj+SgDHSFQvaXqfNTS3wgybhsTqqFK1M+Y=;
        b=GbnVSHzM0NbpdUPQQG7t6eTVAHf3alFGIMiouEzqvKrTXc44bslsixKmHQ+DjPbf+i
         da/RbSu2dxLF0EuHDUrkjT7bVAiv0cjwCi059RHPlMRagPj7E7Spy6H3RkLfE8qypHU6
         iDy0m/QFmqTQU80Fmkf4+Tl5wdcNHKi6AagD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=U8yu6NSdcreYEfawy1q8k2nd0XLmOXY/vQZcAdU2DHzS7eZs+xRYan+7fsIOks7lAK
         ozuZchwOaLLuXEZE2XvqoO8tPV1xb84jSg9E/z/6NZl1OXu5GaGOVJ7buwk8SOaLGDKs
         vu3E+c8gv9D2R43bFEyCqIzyu7IwQJZJhdmEY=
Received: by 10.223.71.200 with SMTP id i8mr232683faj.142.1293062346438;
        Wed, 22 Dec 2010 15:59:06 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id a2sm1858030faw.22.2010.12.22.15.58.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:59:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNwOAT008216;
	Thu, 23 Dec 2010 00:58:34 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164110>



This commit actually adds output caching to gitweb, as we have now
minimal features required for it in GitwebCache::FileCacheWithLocking
(a 'dumb' but fast file-based cache engine).  To enable cache you need
(at least) set $caching_enabled to true in gitweb config, and copy
required modules alongside generated gitweb.cgi - this is described
in more detail in the new "Gitweb caching" section in gitweb/README.
"make install-gitweb" would install all modules alongside gitweb
itself.

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

 gitweb/Makefile                           |    5 +
 gitweb/README                             |   46 +++++++
 gitweb/gitweb.perl                        |  190 ++++++++++++++++++++++++++---
 gitweb/lib/GitwebCache/CacheOutput.pm     |    2 
 t/gitweb-lib.sh                           |   11 ++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 +++
 t/t9501-gitweb-standalone-http-status.sh  |   13 ++
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++++
 8 files changed, 299 insertions(+), 21 deletions(-)
 mode change 100644 => 100755 t/gitweb-lib.sh


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
index 4a67393..efe3b2c 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -258,6 +258,12 @@ not include variables usually directly set during build):
    their default values before every request, so if you want to change
    them, be sure to set this variable to true or a code reference effecting
    the desired changes.  The default is true.
+ * $caching_enabled
+   If true, gitweb would use caching to speed up generating response.
+   Currently supported is only output (response) caching.  See "Gitweb caching"
+   section below for details on how to configure and customize caching.
+   The default is false (caching is disabled).
+
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -329,6 +335,46 @@ You can use the following files in repository:
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
+You can choose which caching engine should gitweb use by setting
+$cache variable to _initialized_ instance of cache interface, or to
+the name of cache class.
+
+Currenly though only cache which implements non-standard ->compute_fh()
+method is supported.  Provided GitwebCache::FileCacheWithLocking implements
+this method; it is the default caching engine used if $cache is not defined.
+
+The GitwebCache::FileCacheWithLocking is 'dumb' (but fast) file based
+caching engine, currently without any support for cache size limiting, or
+even removing expired / grossly expired entries.  It has therefore the
+downside of requiring a huge amount of disk space if there are a number of
+repositories involved.  It is not uncommon for git.kernel.org to have on the
+order of 80G - 120G accumulate over the course of a few months.  It is
+therefore recommended that the cache directory be periodically completely
+deleted; this operation is safe to perform.  Suggested mechanism (substitute
+$cachedir for actual path to gitweb cache):
+
+   # mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+
+Site-wide cache options are defined in %cache_options hash.  Those options
+apply only when $cache is unset (GitwebCache::FileCacheWithLocking is used),
+or if $cache is name of cache class.  You can override cache options in
+gitweb config, e.g.:
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
index 880fdf2..eb02b6b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -268,6 +268,71 @@ our %highlight_ext = (
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
+
+# This enables/disables the caching layer in gitweb.  Currently supported
+# is only output (response) caching, similar to the one used on git.kernel.org.
+our $caching_enabled = 0;
+# Set to _initialized_ instance of cache interface implementing (for now)
+# compute_fh($key, $code) method (non-standard CHI-inspired interface),
+# or to name of class of cache interface implementing said method.
+# If unset, GitwebCache::FileCacheWithLocking would be used, which is 'dumb'
+# (but fast) file based caching layer, currently without any support for
+# cache size limiting.  It is therefore recommended that the cache directory
+# be periodically completely deleted; this operation is safe to perform.
+#
+# Suggested mechanism to clear cache:
+#   mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+# where $cachedir is directory where cache is, i.e. $cache_options{'cache_root'}
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
+
+	# How to handle runtime errors occurring during cache gets and cache
+	# sets.  Options are:
+	#  * "die" (the default) - call die() with an appropriate message
+	#  * "warn" - call warn() with an appropriate message
+	#  * "ignore" - do nothing
+	#  * <coderef> - call this code reference with an appropriate message
+	# Note that gitweb catches 'die <message>' via custom handle_errors_html
+	# handler, set via set_message() from CGI::Carp.  'warn <message>' are
+	# written to web server logs.
+	#
+	# The default is to use cache_error_handler, which wraps die_error.
+	# Only first argument passed to cache_error_handler is used (c.f. CHI)
+	'on_error' => \&cache_error_handler,
+
+	# Extra options passed to GitwebCache::CacheOutput::cache_output subroutine
+	'cache_output' => {
+		# Enable caching of error pages (boolean).  Default is false.
+		'-cache_errors' => 0,
+	},
+);
+# Set to _initialized_ instance of GitwebCache::Capture::ToFile
+# compatibile capturing engine, i.e. one implementing ->new()
+# constructor, and ->capture($code, $file) method.  If unset
+# (default), the GitwebCache::Capture::ToFile would be used.
+our $capture;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -1121,7 +1186,16 @@ sub dispatch {
 	    !$project) {
 		die_error(400, "Project needed");
 	}
-	$actions{$action}->();
+
+	if ($caching_enabled) {
+		# human readable key identifying gitweb output
+		my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
+
+		cache_output($cache, $capture, $output_key, $actions{$action},
+			%{$cache_options{'cache_output'}});
+	} else {
+		$actions{$action}->();
+	}
 }
 
 sub reset_timer {
@@ -1147,6 +1221,8 @@ sub run_request {
 		}
 	}
 	check_loadavg();
+	configure_caching()
+		if ($caching_enabled);
 
 	# $projectroot and $projects_list might be set in gitweb config file
 	$projects_list ||= $projectroot;
@@ -1210,7 +1286,7 @@ sub run {
 			if $pre_dispatch_hook;
 
 		eval { run_request() };
-		if (defined $@ && !ref($@)) {
+		if ($@ && !ref($@)) {
 			# some Perl error, but not one thrown by die_error
 			die_error(undef, undef, $@, -error_handler => 1);
 		}
@@ -1227,6 +1303,49 @@ sub run {
 	1;
 }
 
+sub configure_caching {
+	if (!eval { require GitwebCache::CacheOutput; 1; }) {
+		die_error(500,
+			"Caching enabled and error loading GitwebCache::CacheOutput",
+			esc_html($@));
+
+		# turn off caching and warn instead
+		#$caching_enabled = 0;
+		#warn "Caching enabled and GitwebCache::CacheOutput not found";
+	}
+	GitwebCache::CacheOutput->import();
+
+	# $cache might be initialized (instantiated) cache, i.e. cache object,
+	# or it might be name of class, or it might be undefined
+	unless (defined $cache && ref($cache)) {
+		$cache ||= 'GitwebCache::FileCacheWithLocking';
+		eval "require $cache";
+		if ($@) {
+			die_error(500,
+				"Error loading $cache",
+				esc_html($@));
+		}
+
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
+			'on_get_error' => $cache_options{'on_error'},
+			'on_set_error' => $cache_options{'on_error'},
+		});
+	}
+	unless (defined $capture && ref($capture)) {
+		require GitwebCache::Capture::ToFile;
+		$capture = GitwebCache::Capture::ToFile->new();
+	}
+}
+
 run();
 
 if (defined caller) {
@@ -3597,7 +3716,9 @@ sub git_header_html {
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
@@ -3622,7 +3743,9 @@ sub git_header_html {
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
@@ -3739,17 +3862,25 @@ sub git_footer_html {
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
-		      tv_interval($t0, [ gettimeofday() ]).
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
+			      tv_interval($t0, [ gettimeofday() ]).
+			      ' seconds </span>'.
+			      ' and '.
+			      '<span id="generating_cmd">'.
+			      $number_of_git_cmds.
+			      '</span> git commands '.
+			      " to generate.\n";
+		}
 		print "</div>\n"; # class="page_footer"
 	}
 
@@ -3758,8 +3889,8 @@ sub git_footer_html {
 	}
 
 	print qq!<script type="text/javascript" src="!.esc_url($javascript).qq!"></script>\n!;
-	if (defined $action &&
-	    $action eq 'blame_incremental') {
+	if (!$caching_enabled &&
+	    defined $action && $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
@@ -3800,6 +3931,7 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
 <div class="page_body">
@@ -3819,6 +3951,22 @@ EOF
 		unless ($opts{'-error_handler'});
 }
 
+# custom error handler for caching engine (Internal Server Error)
+sub cache_error_handler {
+	my $error = shift;
+
+	# just rethrow error that came from die_error
+	# thrown from $actions{$action}->()
+	die $error if (ref $error);
+
+	$error = to_utf8($error);
+	$error =
+		"Error in caching layer: <i>".ref($cache)."</i><br>\n".
+		CGI::escapeHTML($error);
+	# die_error() would exit
+	die_error(undef, undef, $error);
+}
+
 ## ----------------------------------------------------------------------
 ## functions printing or outputting HTML: navigation
 
@@ -5554,7 +5702,8 @@ sub git_tag {
 
 sub git_blame_common {
 	my $format = shift || 'porcelain';
-	if ($format eq 'porcelain' && $cgi->param('js')) {
+	if ($format eq 'porcelain' && $cgi->param('js') &&
+	    !$caching_enabled) {
 		$format = 'incremental';
 		$action = 'blame_incremental'; # for page title etc
 	}
@@ -5608,7 +5757,8 @@ sub git_blame_common {
 			or print "ERROR $!\n";
 
 		print 'END';
-		if (defined $t0 && gitweb_check_feature('timed')) {
+		if (!$caching_enabled &&
+		    defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
 			      tv_interval($t0, [ gettimeofday() ]).
 			      ' '.$number_of_git_cmds;
@@ -5628,7 +5778,7 @@ sub git_blame_common {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame", javascript=>0, -replay=>1)},
 			        "blame") . " (non-incremental)";
-	} else {
+	} elsif (!$caching_enabled) {
 		$formats_nav .=
 			$cgi->a({-href => href(action=>"blame_incremental", -replay=>1)},
 			        "blame") . " (incremental)";
@@ -5787,7 +5937,7 @@ sub git_blame {
 }
 
 sub git_blame_incremental {
-	git_blame_common('incremental');
+	git_blame_common(!$caching_enabled ? 'incremental' : undef);
 }
 
 sub git_blame_data {
diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 4a75a7f..792ddb7 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -64,7 +64,7 @@ sub cache_output {
 	if (defined $fh || defined $filename) {
 		# set binmode only if $fh is defined (is a filehandle)
 		# File::Copy::copy opens files given by filename in binary mode
-		binmode $fh,    ':raw' if (defined $h);
+		binmode $fh,    ':raw' if (defined $fh);
 		binmode STDOUT, ':raw';
 		File::Copy::copy($fh || $filename, \*STDOUT);
 	}
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
old mode 100644
new mode 100755
index b9bb95f..4ce067f
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
