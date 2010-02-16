From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Tue, 16 Feb 2010 20:36:39 +0100
Message-ID: <1266349005-15393-5-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTF7-0002i3-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226Ab0BPThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:17 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34515 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933212Ab0BPThI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:08 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2280988bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tEhUp6Ivbew+UiVmm08rSiykEdzjHlRIMcCyGKlVah4=;
        b=xMpypvZxmyQbo8CiCkLwobZQSyYZIAPvHY4V/IWjr6zV4SV/+L5BczITpioh7Kvelg
         6nFgdTG1OmCuDjQ1W9zptl4gceAk/mVY0RUjtuAp9wi/zlpU8jBS8pcXACg1RJB3G2Ov
         KuDLuEpjXrL57sM2qsI5ilh3R+ZyVY6A4XaYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VhC2B7Wk38xG/gwboClQpyS0SOJlx3wE3TdritfJ/PzU1RwFim9ce5Ngxz0g/1gBxy
         FcEg4HGp4HoR823GrFF7Pvq9SBNDzg7FhmwxThJGIIPhV05K3tWSKIxBxx79rCP0Ikkf
         3iqYeUrUI9hB3bTXQCKDHGqidc6EuKoUNVhWU=
Received: by 10.204.39.211 with SMTP id h19mr2302604bke.164.1266349023523;
        Tue, 16 Feb 2010 11:37:03 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:02 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140144>

This commit actually adds output caching to gitweb, as we have now
minimal features required for it in GitwebCache::SimpleFileCache
(a 'dumb' but fast file-based cache engine).  To enable cache you need
at least set $caching_enabled to true in gitweb config, and copy
gitweb/cache.pm alongside generated gitweb.cgi - this is described
in more detail in the new "Gitweb caching" section in gitweb/README.

Gitweb itself uses directly only cache_fetch, to get page from cache
or to generate page and save it to cache, and cache_stop, to be used
in die_error subroutine, as currently error pages are not cached.

The cache_fetch subroutine captures output by using select(FILEHANDLE)
to change default filehandle for output.  This means that a "print" or
a "printf" (or a "write") in gitweb source without a filehandle would
be captured.  To change mode of filehandle used for capturing correctly,
"binmode STDOUT, <mode>" was changed to "binmode select(), <mode>"; this
has no change if $caching_enabled is false, and capturing is turned off.
Capturing is done using in-memory file held in Perl scalar.

Using select(FILEHANDLE) is a bit fragile as a method of capturing
output, as it assumes that we always use "print" or "printf" without
filehandle, and use select() which returns default filehandle for
output in place of explicit STDOUT.  On the other hand it has the
advantage of being simple.  Alternate solutions include using tie
(like in CGI::Cache), or using PerlIO layers - but that requires
non-standard PerlIO::Util module.

It is assumed that data is saved to cache _converted_, and should
therefore be read from cache and printed to STDOUT in ':raw' (binary)
mode.

Enabling caching causes the following additional changes to gitweb
output:
* Disables content-type negotiation (choosing between 'text/html'
  mimetype and 'application/xhtml+xml') when caching, as there is no
  content-type negotiation done when retrieving page from cache.
  Use 'text/html' mimetype that can be used by all browsers.
* Disable timing info (how much time it took to generate original
  page, and how many git commands it took), and in its place show when
  page was originally generated (in GMT / UTC timezone).

Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.

In t9503-gitweb-caching , test that cache_fetch behaves correctly,
namely that it saves and restores action output in cache, and that it
prints generated output or cached output.


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
Differences from v2:
* "Capturing" gitweb output is done via changing default filehandle for
  'print' and 'printf' via select(FILEHANDLE), and using select() in place
  of STDOUT, e.g. in calls to binmode.  Not manipulating *STDOUT (which
  doesn't work correctly), not using PerlIO layers (which requires 
  non-standard PerlIO::Util module).

* cache_fetch changed signature from cache_fetch($cache, $action) to
  cache_fetch($cache, $key, $code), and is called as
    cache_fetch($cache, $output_key, $actions{$action});
  and not as
    cache_fetch($cache, $action);

  This decouples cache.pm from gitweb implementation, and allows to use
  'require $cache_pm;' in place of 'do $cache_pm;', and allows to simplify
  code in t/t9503/test_cache_interface.pl.

* cache_fetch code got reordered a bit to avoid duplicating code (printing
  captured and saved gitweb output or data from cache).

* cache.pm is loaded using 'require' instead of 'do'.  To allow this the
  directory where gitweb.cgi is in is added to @INC via 'use lib'.


Differences from relevant parts of J.H. patch:
* cache_fetch() subroutine is much, much simpler.  Well, it lacks most of
  the features of original cache_fetch() by J.H.: it doesn't have adaptive
  cache lifetime, nor locking to prevent 'stampeding herd' problem, nor
  serving stale data when waiting for cache regeneration, nor background
  data generation, nor activity indicator... but the cache_fetch() itself
  doesn't change much, as those features are added mainly via methods
  and subroutines cache_fetch() calls.

* Capturing gitweb output is done without need to modify gitweb to either
  save generated output into $output variable and print it or save in cache
  after it is generated in full (original J.H. patch in "Gitweb caching v2"),
  or changing all print statements to print to explicit filehandle which
  points to STDOUT if caching is disabled and to in-memory file if caching
  is enabled (modified J.H. patch in "Gitweb caching v5").

* It introduces $cache_pm variable, to be able to test caching in
  t/t9500-gitweb-standalone-no-errors.sh, but also to be able to install
  cache.pm in some other place than along gitweb.cgi.

* cache_fetch() changed signature, and it does not longer depends on 
  subroutines (like href()) and variables (like %actions) defined in 
  gitweb.perl.  This allows to simply 'require $cache_pm' instead of
  'do $cache_pm' (which also means that it can be installed as module
  in PERL5LIB etc.).

* Instead of using "binary" (sic!) valued $cache_enable (which means 0 or 1
  valued $cache_enable), a set of two variables is used.  The $cache
  variable can be used to select alternate caching engine / caching class.
  The $caching_enabled variable is used to actually enable/disable cache.

* The information about the time when page was generated is shown only if
  'timed' feature is enabled in gitweb config, and it is shown in place of
  usual time it took to generate page (shown when caching is not enabled).
  This means that change to gitweb/gitweb.css was not needed.

* cache_fetch() is run only when $caching_enabled.  Some of cache
  initializations are in gitweb.perl, and not at beginning of cache_fetch()

* Cache options are contained in %cache_options hash, instead of individual
  global variables (which were using non-Perlish camelCase notation).

* There is information about caching in gitweb in gitweb/README

* There are tests of gitweb caching in t9500, and caching API in t9503

 gitweb/README                          |   70 ++++++++++++++++++
 gitweb/cache.pm                        |   66 +++++++++++++++++
 gitweb/gitweb.perl                     |  122 +++++++++++++++++++++++++++-----
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 +++++
 t/t9503/test_cache_interface.pl        |   56 +++++++++++++++
 6 files changed, 318 insertions(+), 17 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..53759fc 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,11 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $caching_enabled
+   If true, gitweb would use caching to speed up generating response.
+   Currently supported is only output (response) caching.  See "Gitweb caching"
+   section below for details on how to configure and customize caching.
+   The default is false (caching is disabled).
 
 
 Projects list file format
@@ -305,6 +310,71 @@ You can use the following files in repository:
    descriptions.
 
 
+Gitweb caching
+~~~~~~~~~~~~~~
+
+Currently gitweb supports only output (HTTP response) caching, similar
+to the one used on git.kernel.org.  To turn it on, set $caching_enabled
+variable to true value in gitweb config file, i.e.:
+
+   our $caching_enabled = 1;
+
+You can choose what caching engine should gitweb use by setting $cache
+variable either to _initialized_ instance of cache interface, e.g.:
+
+   use CHI;
+   our $cache = CHI->new( driver => 'Memcached',
+   	servers => [ "10.0.0.15:11211", "10.0.0.15:11212" ],
+   	l1_cache => { driver => 'FastMmap', root_dir => '/var/cache/gitweb' }
+   );
+
+Alternatively you can set $cache variable to the name of cache class, in
+which case caching engine should support Cache::Cache or CHI names for cache
+config (see below), and ignore unrecognized options, e.g.:
+
+   use Cache::FileCache;
+   our $cache = 'Cache::FileCache';
+
+Such caching engine should implement (at least) ->get($key) and
+->set($key, $data) methods (Cache::Cache and CHI compatible interface).
+
+If $cache is left unset (if it is left undefined), then gitweb would use
+GitwebCache::SimpleFileCache from cache.pm as caching engine.  This engine
+is 'dumb' (but fast) file based caching layer, currently without any support
+for cache size limiting, or even removing expired / grossly expired entries.
+It has therefore the downside of requiring a huge amount of disk space if
+there are a number of repositories involved.  It is not uncommon for
+git.kernel.org to have on the order of 80G - 120G accumulate over the course
+of a few months.  It is therefore recommended that the cache directory be
+periodically completely deleted; this operation is safe to perform.
+Suggested mechanism (substitute $cachedir for actual path to gitweb cache):
+
+   # mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+
+For gitweb to use caching it must find 'cache.pm' file, which contains
+GitwebCache::SimpleFileCache and cache-related subroutines, from which
+cache_fetch and cache_stop are used in gitweb itself.  Location of
+'cache.pm' file is provided in $cache_pm variable; if it is relative path,
+it is relative to the directory gitweb is run from.  Default value of
+$cache_pm assumes that 'cache.pm' is copied to the same directory as
+'gitweb.cgi'.
+
+Currently 'cache.pm' is not a proper Perl module, because it is not
+encapsulated / it is not separated from details of gitweb.  That is why it
+is sourced using 'do "$cache_pm"', rather than with "use" or "require"
+operators.
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
 
diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 7f1bd5f..151e029 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -338,4 +338,70 @@ sub compute {
 1;
 } # end of package GitwebCache::SimpleFileCache;
 
+our $oldfh = select();
+our $data_fh;
+
+# Start capturing data (STDOUT)
+# (printed using 'print <sth>' or 'printf <sth>')
+sub cache_start {
+	my $data_ref = shift;
+
+	$$data_ref = '';
+	$data_fh = undef;
+
+	open $data_fh, '>', $data_ref
+		or die "Couldn't open in-memory file: $!";
+	$oldfh = select($data_fh);
+}
+
+# Stop capturing data (required for die_error)
+sub cache_stop {
+	# return if we didn't start capturing
+	return unless defined $data_fh;
+
+	select($oldfh);
+	close $data_fh
+		or die "Couldn't close in-memory file: $!";
+}
+
+# Wrap caching data; capture only STDOUT
+# (works only for 'print <sth>' and 'printf <sth>')
+sub cache_capture (&) {
+	my $code = shift;
+	my $data;
+
+	cache_start(\$data);
+	$code->();
+	cache_stop();
+
+	return $data;
+}
+
+# cache_fetch($cache, $key, $action_code);
+#
+# Attempts to get $key from $cache; if successful, prints the value.
+# Otherwise, calls $action_code, capture its output, use the captured output
+# as the new value for $key in $cache, then prints captured output.
+sub cache_fetch {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->get($key);
+
+	if (!defined $data) {
+		$data = cache_capture {
+			$code->();
+		};
+		$cache->set($key, $data) if defined $data;
+	}
+
+	if (defined $data) {
+		# print cached data
+		#binmode STDOUT, ':raw';
+		#print STDOUT $data;
+		# for t9503 test:
+		binmode select(), ':raw';
+		print $data;
+	}
+}
+
 1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 97ea3ec..7073e1b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -227,6 +227,44 @@ our %avatar_size = (
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
+# Locations of 'cache.pm' file; if it is relative path, it is relative to
+# the directory gitweb is run from
+our $cache_pm = 'cache.pm';
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
@@ -964,7 +1002,42 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
-$actions{$action}->();
+
+if ($caching_enabled) {
+	die_error(500, 'Caching enabled and "'.esc_path($cache_pm).'" not found')
+		unless -f $cache_pm;
+	# __DIR__ is taken from Dir::Self __DIR__ fragment
+	sub __DIR__ () {
+		File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+	}
+	use lib __DIR__;
+	require $cache_pm;
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
+	cache_fetch($cache, $output_key, $actions{$action});
+} else {
+	$actions{$action}->();
+}
+
 exit;
 
 ## ======================================================================
@@ -3169,7 +3242,9 @@ sub git_header_html {
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
@@ -3342,17 +3417,25 @@ sub git_footer_html {
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
 
@@ -3402,6 +3485,10 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+
+	# Do not cache error pages (die_error() uses 'exit')
+	cache_stop() if ($caching_enabled);
+
 	git_header_html($http_responses{$status});
 	print <<EOF;
 <div class="page_body">
@@ -5050,7 +5137,8 @@ sub git_blame_common {
 			or print "ERROR $!\n";
 
 		print 'END';
-		if (defined $t0 && gitweb_check_feature('timed')) {
+		if (!$caching_enabled &&
+		    defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
 			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
@@ -5309,9 +5397,9 @@ sub git_blob_plain {
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
 
@@ -5591,9 +5679,9 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
+	binmode select(), ':raw';
 	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode select(), ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 }
 
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..b7c2937 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -27,6 +27,8 @@ our \$export_ok = '';
 our \$strict_export = '';
 our \$maxload = undef;
 
+our \$cache_pm = '$TEST_DIRECTORY/../gitweb/cache.pm';
+
 EOF
 
 	cat >.git/description <<EOF
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 2fc7fdb..41c1119 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -639,4 +639,23 @@ test_expect_success \
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
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index ec92207..7c7f00c 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -7,9 +7,17 @@ use strict;
 use Test::More;
 use Data::Dumper;
 
+# Modules that could have been used to capture output for testing cache_fetch
+#use Capture::Tiny;
+#use Test::Output qw(:stdout);
+# Modules that could have been used in $cache_pm for cache_fetch
+#use IO::Capture
+
 # test source version; there is no installation target for gitweb
 my $cache_pm = "$ENV{TEST_DIRECTORY}/../gitweb/cache.pm";
 
+# ......................................................................
+
 unless (-f "$cache_pm") {
 	plan skip_all => "$cache_pm not found";
 }
@@ -22,6 +30,7 @@ ok(!$@,              "parse gitweb/cache.pm")
 ok(defined $return,  "do    gitweb/cache.pm");
 ok($return,          "run   gitweb/cache.pm");
 
+# ......................................................................
 
 # Test creating a cache
 #
@@ -89,6 +98,53 @@ $cache->set_expires_in(0);
 is($cache->get_expires_in(), 0,          '"expires in" is set to now (0)');
 $cache->set($key, $value);
 ok(!defined($cache->get($key)),          'cache is expired');
+$cache->set_expires_in(-1);
+
+# ......................................................................
+
+# Prepare for testing cache_fetch from $cache_pm
+my $action_output = <<'EOF';
+# This is data to be cached and shown
+EOF
+my $cached_output = <<"EOF";
+$action_output# (version recovered from cache)
+EOF
+
+sub action {
+	print $action_output;
+}
+
+
+# Catch output printed by cache_fetch
+# (only for 'print <sth>' and 'printf <sth>')
+sub capture_cache_fetch_output {
+	my $test_data = '';
+
+	open my $test_data_fh, '>', \$test_data;
+	my $oldfh = select($test_data_fh);
+
+	cache_fetch($cache, $key, \&action);
+
+	select($oldfh);
+	close $test_data_fh;
+
+	return $test_data;
+}
+
+# clean state
+$cache->set_expires_in(-1);
+$cache->remove($key);
+my $test_data;
+
+# first time (if there is no cache) generates cache entry
+$test_data = capture_cache_fetch_output();
+is($test_data, $action_output,        'action output is printed (generated)');
+is($cache->get($key), $action_output, 'action output is saved in cache (generated)');
+
+# second time (if cache is set/valid) reads from cache
+$cache->set($key, $cached_output);
+$test_data = capture_cache_fetch_output();
+is($test_data, $cached_output,        'action output is printed (from cache)');
 
 done_testing();
 
-- 
1.6.6.1
