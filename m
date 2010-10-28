From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 3/3] gitweb: File based caching layer (from git.kernel.org)
Date: Wed, 27 Oct 2010 17:42:54 -0700
Message-ID: <1288226574-19068-4-git-send-email-warthog9@eaglescrag.net>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.2.3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 03:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHQ8-0003U1-CS
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab0J1Bgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 21:36:43 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48194 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461Ab0J1Bgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:36:42 -0400
X-Greylist: delayed 3133 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 21:35:15 EDT
Received: from voot-cruiser.middle.earth (173-27-0-103.client.mchsi.com [173.27.0.103])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9S0gucO008331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:43:05 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 27 Oct 2010 17:43:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160150>

This is a multi-part message in MIME format.
--------------1.7.2.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This is a relatively large patch that implements the file based
caching layer that is quite similar to the one used  on such large
sites as kernel.org and soon git.fedoraproject.org.  This provides
a simple, and straight forward caching mechanism that scales
dramatically better than Gitweb by itself.

The caching layer basically buffers the output that Gitweb would
normally return, and saves that output to a cache file on the local
disk.  When the file is requested it attempts to gain a shared lock
on the cache file and cat it out to the client.  Should an exclusive
lock be on a file (it's being updated) the code has a choice to either
update in the background and go ahead and show the stale page while
update is being performed, or stall the client(s) until the page
is generated.

There are two forms of stalling involved here, background building
and non-background building, both of which are discussed in the
configuration page.

There are still a few known "issues" with respect to this:
- Code needs to be added to be "browser" aware so
  that clients like wget that are trying to get a
  binary blob don't obtain a "Generating..." page

Caching is disabled by default with the $cache_enable variable,
setting this to 1 will enable file based caching.  It is expected
that this will be extended to include additional types of caching
(like memcached) in the future and should not be exclusively
considered a binary value.
---
 gitweb/cache.pm          |  365 ++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl       |   99 +++++++++++--
 gitweb/static/gitweb.css |    6 +
 3 files changed, 458 insertions(+), 12 deletions(-)
 create mode 100644 gitweb/cache.pm


--------------1.7.2.3
Content-Type: text/x-patch; name="0003-gitweb-File-based-caching-layer-from-git.kernel.org.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0003-gitweb-File-based-caching-layer-from-git.kernel.org.patch"

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
new file mode 100644
index 0000000..c86265c
--- /dev/null
+++ b/gitweb/cache.pm
@@ -0,0 +1,365 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+#
+# This program is licensed under the GPLv2
+
+#
+# Gitweb caching engine
+#
+
+#use File::Path qw(make_path remove_tree);
+use File::Path qw(mkpath rmtree); # Used for compatability reasons
+use Digest::MD5 qw(md5 md5_hex md5_base64);
+use Fcntl ':flock';
+use File::Copy;
+
+sub cache_fetch {
+	my ($action) = @_;
+	my $cacheTime = 0;
+
+	# Deal with cache being disabled
+	if( $cache_enable == 0 ){
+		undef $backgroundCache;
+		#$fullhashpath = \$nocachedata;
+		#$fullhashbinpath = \$nocachedatabin;
+		$fullhashpath = *STDOUT;
+		$fullhashbinpath = *STDOUT;
+		$actions{$action}->();
+		return;
+	}elsif( $cache_enable == 1 ){
+		#obviously we are using file based caching
+
+		if(! -d $cachedir){
+			print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";
+			mkdir ("cache", 0665) || die "Cannot create cache dir - you will need to manually create";
+			print "Cache directory created successfully\n";
+		}
+
+		our $full_url = "$my_url?". $ENV{'QUERY_STRING'};
+		our $urlhash = md5_hex($full_url);
+		our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";
+
+		eval { mkpath( $fullhashdir, 0, 0777 ) };
+		if ($@) {
+			die_error(500, "Internal Server Error", "Could not create cache directory: $@");
+		}
+		$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
+		$fullhashbinpath = "$fullhashpath.bin.wt";
+		$fullhashbinpathfinal = "$fullhashpath.bin";
+	} # done dealing with cache enabled / disabled
+
+	if(! -e "$fullhashpath" ){
+		if( ! $cache_enable || ! $cacheDoFork || ! defined(my $childPid = fork()) ){
+			cacheUpdate($action,0);
+			cacheDisplay($action);
+		} elsif ( $childPid == 0 ){
+			#run the updater
+			cacheUpdate($action,1);
+		}else{
+			cacheWaitForUpdate($action);
+		}
+	}else{
+		#if cache is out dated, update
+		#else displayCache();
+		open(cacheFile, '<', "$fullhashpath");
+		stat(cacheFile);
+		close(cacheFile);
+		my $stat_time = (stat(_))[9];
+		my $stat_size = (stat(_))[7];
+
+		$cacheTime = get_loadavg() * 60;
+		if( $cacheTime > $maxCacheTime ){
+			$cacheTime = $maxCacheTime;
+		}
+		if( $cacheTime < $minCacheTime ){
+			$cacheTime = $minCacheTime;
+		}
+		if( $stat_time < (time - $cacheTime) || $stat_size == 0 ){
+			if( ! $cacheDoFork || ! defined(my $childPid = fork()) ){
+				cacheUpdate($action,0);
+				cacheDisplay($action);
+			} elsif ( $childPid == 0 ){
+				#run the updater
+				#print "Running updater\n";
+				cacheUpdate($action,1);
+			}else{
+				#print "Waiting for update\n";
+				cacheWaitForUpdate($action);
+			}
+		} else {
+			cacheDisplay($action);
+		}
+
+
+	}
+
+	#
+	# If all of the caching failes - lets go ahead and press on without it and fall back to 'default'
+	# non-caching behavior.  This is the softest of the failure conditions.
+	#
+	#$actions{$action}->();
+}
+
+sub cacheUpdate {
+	my ($action,$areForked) = @_;
+	my $lockingStatus;
+	my $fileData = "";
+
+	if($backgroundCache){
+		open(cacheFileBG, '>:utf8', "$fullhashpath.bg");
+		my $lockStatBG = flock(cacheFileBG,LOCK_EX|LOCK_NB);
+
+		$lockStatus = $lockStatBG;
+	}else{
+		open(cacheFile, '>:utf8', "$fullhashpath") if ($cache_enable > 0);
+		open(cacheFile, '>:utf8', \$fullhashpath) if ($cache_enable == 0);
+		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
+
+		$lockStatus = $lockStat;
+	}
+	#print "lock status: $lockStat\n";
+
+
+	if ($cache_enable != 0 && ! $lockStatus ){
+		if ( $areForked ){
+			exit(0);
+		}else{
+			return;
+		}
+	}
+
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		my $openstat = open(cacheFileBinWT, '>>:utf8', "$fullhashbinpath");
+		my $lockStatBin = flock(cacheFileBinWT,LOCK_EX|LOCK_NB);
+	}
+
+	# Trap all output from the action
+	change_output();
+
+	$actions{$action}->();
+
+	# Reset the outputs as we should be fine now
+	reset_output();
+
+
+	if($backgroundCache){
+		open(cacheFile, '>:utf8', "$fullhashpath");
+		$lockStat = flock(cacheFile,LOCK_EX);
+
+		if (! $lockStat ){
+			if ( $areForked ){
+				exit(0);
+			}else{
+				return;
+			}
+		}
+	}
+
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		my $openstat = open(cacheFileBinFINAL, '>:utf8', "$fullhashbinpathfinal");
+		$lockStatBIN = flock(cacheFileBinFINAL,LOCK_EX);
+
+		if (! $lockStatBIN ){
+			if ( $areForked ){
+				exit(0);
+			}else{
+				return;
+			}
+		}
+	}
+
+	# Actually dump the output to the proper file handler
+	local $/ = undef;
+	$|++;
+	print cacheFile "$output";
+	$|--;
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		move("$fullhashbinpath", "$fullhashbinpathfinal") or die "Binary Cache file could not be updated: $!";
+
+		flock(cacheFileBinFINAL,LOCK_UN);
+		close(cacheFileBinFINAL);
+
+		flock(cacheFileBinWT,LOCK_UN);
+		close(cacheFileBinWT);
+	}
+
+	flock(cacheFile,LOCK_UN);
+	close(cacheFile);
+
+	if($backgroundCache){
+		flock(cacheFileBG,LOCK_UN);
+		close(cacheFileBG);
+	}
+
+	if ( $areForked ){
+		exit(0);
+	} else {
+		return;
+	}
+}
+
+
+sub cacheWaitForUpdate {
+	my ($action) = @_;
+	my $x = 0;
+	my $max = 10;
+	my $lockStat = 0;
+
+	if( $backgroundCache ){
+		if( -e "$fullhashpath" ){
+			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
+			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
+			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+			stat(cacheFile);
+			close(cacheFile);
+
+			if( $lockStat && ( (stat(_))[9] > (time - $maxCacheLife) ) ){
+				cacheDisplay($action);
+				return;
+			}
+		}
+	}
+
+	if(
+		$action eq "atom"
+		||
+		$action eq "rss"
+		||
+		$action eq "opml"
+	){
+		do {
+			sleep 2 if $x > 0;
+			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
+			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
+			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+			close(cacheFile);
+			$x++;
+			$combinedLockStat = $lockStat;
+		} while ((! $combinedLockStat) && ($x < $max));
+
+		if( $x != $max ){
+			cacheDisplay($action);
+		}
+		return;
+	}
+
+	$| = 1;
+
+	print $::cgi->header(
+				-type=>'text/html',
+				-charset => 'utf-8',
+				-status=> 200,
+				-expires => 'now',
+				# HTTP/1.0
+				-Pragma => 'no-cache',
+				# HTTP/1.1
+				-Cache_Control => join(
+							', ',
+							qw(
+								private
+								no-cache
+								no-store
+								must-revalidate
+								max-age=0
+								pre-check=0
+								post-check=0
+							)
+						)
+				);
+
+	print <<EOF;
+<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
+<!-- git web w/caching interface version $version, (C) 2006-2010, John 'Warthog9' Hawley <warthog9\@kernel.org> -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta name="generator" content="gitweb/$version git/$git_version"/>
+<meta name="robots" content="index, nofollow"/>
+<meta http-equiv="refresh" content="0"/>
+<title>$title</title>
+</head>
+<body>
+EOF
+
+	print "Generating..";
+	do {
+		print ".";
+		sleep 2 if $x > 0;
+		open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
+		open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
+		$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+		close(cacheFile);
+		$x++;
+		$combinedLockStat = $lockStat;
+	} while ((! $combinedLockStat) && ($x < $max));
+	print <<EOF;
+</body>
+</html>
+EOF
+	return;
+}
+
+sub cacheDisplay {
+	local $/ = undef;
+	$|++;
+
+	my ($action) = @_;
+	open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
+	open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
+	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+
+	if ($cache_enable != 0 && ! $lockStat ){
+		close(cacheFile);
+		cacheWaitForUpdate($action);
+	}
+
+	if(
+		(
+			$action eq "snapshot"
+			||
+			$action eq "blob_plain"
+		)
+		&&
+		$cache_enable > 0
+	){
+		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
+		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
+		if ($cache_enable != 0 && ! $lockStatBIN ){
+			system ("echo 'cacheDisplay - bailing due to binary lock failure' >> /tmp/gitweb.log");
+			close(cacheFile);
+			close(cacheFileBin);
+			cacheWaitForUpdate($action);
+		}
+
+		my $binfilesize = -s "$fullhashbinpathfinal";
+		print "Content-Length: $binfilesize";
+	}
+	while( <cacheFile> ){
+		print $_;
+	}
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		binmode STDOUT, ':raw';
+		print <cacheFileBin>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+		close(cacheFileBin);
+	}
+	close(cacheFile);
+	$|--;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 757ef46..eb53075 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -31,7 +31,7 @@ BEGIN {
 our $version = "++GIT_VERSION++";
 
 # Output buffer variable
-$output = "";
+our $output = "";
 
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
@@ -244,6 +244,57 @@ our $git_versions_must_match = 1;
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
+# This enables/disables the caching layer in gitweb.  This currently only supports the
+# 'dumb' file based caching layer, primarily used on git.kernel.org.  this is reasonably
+# effective but it has the downside of requiring a huge amount of disk space if there
+# are a number of repositories involved.  It is not uncommon for git.kernel.org to have
+# on the order of 80G - 120G accumulate over the course of a few months.  It is recommended
+# that the cache directory be periodically completely deleted, and this is safe to perform.
+# Suggested mechanism
+# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
+# Value is binary. 0 = disabled (default), 1 = enabled.
+#
+# Values of caching:
+# 	1 = 'dumb' file based caching used on git.kernel.org
+our $cache_enable = 0;
+
+# Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
+# if we calculate the cache to be under this number of seconds we set the cache timeout
+# to this minimum.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+our $minCacheTime = 20;
+
+# Used to set the maximum cache timeout for the dynamic caching algorithm.  Basically
+# if we calculate the cache to exceed this number of seconds we set the cache timeout
+# to this maximum.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+our $maxCacheTime = 1200;
+
+# If you need to change the location of the caching directory, override this
+# otherwise this will probably do fine for you
+our $cachedir = 'cache';
+
+# If this is set (to 1) cache will do it's best to always display something instead
+# of making someone wait for the cache to update.  This will launch the cacheUpdate
+# into the background and it will lock a <file>.bg file and will only lock the
+# actual cache file when it needs to write into it.  In theory this will make
+# gitweb seem more responsive at the price of possibly stale data.
+our $backgroundCache = 1;
+
+# Used to set the maximum cache file life.  If a cache files last modify time exceeds
+# this value, it will assume that the data is just too old, and HAS to be regenerated
+# instead of trying to display the existing cache data.
+# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
+# 18000 = 5 hours
+our $maxCacheLife = 18000;
+
+# Used to enable or disable background forking of the gitweb caching.  Mainly here for debugging purposes
+our $cacheDoFork = 1;
+
+our $fullhashpath = *STDOUT;
+our $fullhashbinpath = *STDOUT;
+our $fullhashbinpathfinal = *STDOUT;
+
 # configuration for 'highlight' (http://www.andre-simon.de/)
 # match by basename
 our %highlight_basename = (
@@ -500,6 +551,11 @@ our %feature = (
 		'default' => [0]},
 );
 
+#
+# Includes
+#
+do 'cache.pm';
+
 sub gitweb_get_feature {
 	my ($name) = @_;
 	return unless exists $feature{$name};
@@ -1089,7 +1145,8 @@ sub dispatch {
 	    !$project) {
 		die_error(400, "Project needed");
 	}
-	$actions{$action}->();
+	#$actions{$action}->();
+	cache_fetch($action);
 }
 
 sub reset_timer {
@@ -1159,6 +1216,7 @@ sub change_output {
 
 	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
 	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
+	print STDOUT_REAL "";
 
 	# Close STDOUT, so that it isn't being used anymore.
 	close STDOUT;
@@ -1185,10 +1243,7 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
-		change_output();
 		run_request();
-		reset_output();
-		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3465,7 +3520,9 @@ sub git_header_html {
 	# support xhtml+xml but choking when it gets what it asked for.
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
+	    $cgi->Accept('application/xhtml+xml') != 0
+	    &&
+	    $cache_enable == 0) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
@@ -3610,6 +3667,7 @@ sub git_footer_html {
 	my $feed_class = 'rss_logo';
 
 	print "<div class=\"page_footer\">\n";
+	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
@@ -3698,6 +3756,11 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+	# The output handlers for die_error need to be reset to STDOUT
+	# so that half the message isn't being output to random and
+	# half to STDOUT as expected.  This is mainly for the benefit
+	# of using git_header_html() and git_footer_html() since
+	#
 	# Reset the output so that we are actually going to STDOUT as opposed
 	# to buffering the output.
 	reset_output();
@@ -5610,9 +5673,15 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if( $cache_enable != 0){
+		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
+	}else{
+		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+	}
+	binmode BINOUT, ':raw';
+	print BINOUT <$fd>;
+	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close BINOUT;
 	close $fd;
 }
 
@@ -5897,9 +5966,15 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if( $cache_enable != 0){
+		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
+	}else{
+		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+	}
+	binmode BINOUT, ':raw';
+	print BINOUT <$fd>;
+	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close BINOUT;
 	close $fd;
 }
 
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 4132aab..972d32e 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -67,6 +67,12 @@ div.page_path {
 	border-width: 0px 0px 1px;
 }
 
+div.cachetime {
+	float: left;
+	margin-right: 10px;
+	color: #555555;
+}
+
 div.page_footer {
 	height: 17px;
 	padding: 4px 8px;

--------------1.7.2.3--
