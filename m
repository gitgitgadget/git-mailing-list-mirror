From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 9/9] gitweb: File based caching layer (from git.kernel.org)
Date: Wed, 13 Jan 2010 17:23:05 -0800
Message-ID: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERK-0002pa-Jm
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab0ANBX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970Ab0ANBXY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:24 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56023 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab0ANBXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:14 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lv009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:13 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136917>

This is a very large patch that implements the file based
caching layer that is used on such large sites as kernel.org and
soon git.fedoraproject.org.  This provides a simple, and straight
forward caching mechanism that scales dramatically better than
Gitweb by itself.

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
- There is an intermittent flushing issue that has yet
  to be tracked down

Caching is disabled by default with the $cache_enable variable,
setting this to 1 will enable file based caching.  It is expected
that this will be extended to include additional types of caching
(like memcached) in the future and should not be exclusively
considered a binary value.
---
 gitweb/cache.pm    |  283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |    6 +
 gitweb/gitweb.perl |   58 ++++++++++-
 3 files changed, 344 insertions(+), 3 deletions(-)
 create mode 100644 gitweb/cache.pm

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
new file mode 100644
index 0000000..d08bcec
--- /dev/null
+++ b/gitweb/cache.pm
@@ -0,0 +1,283 @@
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
+use File::Path qw(make_path remove_tree);
+use Digest::MD5 qw(md5 md5_hex md5_base64);
+use Fcntl ':flock';
+
+sub cache_fetch {
+	my ($action) = @_;
+	my $cacheTime = 0;
+
+	# Deal with cache being disabled
+	if( $cache_enable == 0 ){
+		$output_handler = *STDOUT;
+		$output_handler_bin = *STDOUT;
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
+		my $numdirs = make_path( $fullhashdir, { mode => 0777, error => \my $mkdirerr, } );
+		if( @$mkdirerr ){
+			my $mkdirerrmsg = "";
+			for my $diag (@$mkdirerr) {
+				my ($file, $message) = %$diag;
+				if($file eq '' ){
+					$mkdirerrmsg .= "general error: $message\n";
+				}else{
+					$mkdirerrmsg .= "problem unlinking $file: $message\n";
+				}
+			}
+			die_error(500, "Could not create cache directory | $mkdirerrmsg");
+		}
+		$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
+		$fullhashbinpath = "$fullhashpath.bin";
+	} # done dealing with cache enabled / disabled
+
+	if(! -e "$fullhashpath" ){
+		if(! defined(my $childPid = fork()) ){
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
+		$cacheTime = get_loadavg() * 60;
+		if( $cacheTime > $maxCacheTime ){
+			$cacheTime = $maxCacheTime;
+		}
+		if( $cacheTime < $minCacheTime ){
+			$cacheTime = $minCacheTime;
+		}
+		if( (stat(_))[9] < (time - $cacheTime) ){
+			if( ! defined(my $childPid = fork()) ){
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
+		open(cacheFile, '>:utf8', "$fullhashpath");
+		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
+
+		$lockStatus = $lockStat;
+	}
+	#print "lock status: $lockStat\n";
+
+
+	if (! $lockStatus ){
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
+		open cacheFileBin, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
+		$output_handler_bin = *cacheFileBin;
+	}
+
+	$output_handler = *cacheFile;
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
+	$actions{$action}->();
+
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		close(cacheFileBin);
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
+			open(cacheFile, '<:utf8', "$fullhashpath");
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
+			open(cacheFile, '<:utf8', "$fullhashpath");
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
+	print $::cgi->header(-type=>'text/html', -charset => 'utf-8',
+	                   -status=> 200, -expires => 'never');
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
+		open(cacheFile, '<:utf8', "$fullhashpath");
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
+	my ($action) = @_;
+	open(cacheFile, '<:utf8', "$fullhashpath");
+	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+	if (! $lockStat ){
+		close(cacheFile);
+		cacheWaitForUpdate($action);
+	}
+
+	while( <cacheFile> ){
+		print $_;
+	}
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		open(cacheFileBin, '<', "$fullhashbinpath");
+		binmode STDOUT, ':raw';
+		print <cacheFileBin>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+		close(cacheFileBin);
+	}
+	close(cacheFile);
+}
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 50067f2..f809f16 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
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
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8bb323c..ec95bb9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -230,6 +230,50 @@ our $git_versions_must_match = 1;
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
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -593,6 +637,11 @@ if (defined $maxload && get_loadavg() > $maxload) {
 	die_error(503, "The load average on the server is too high");
 }
 
+#
+# Includes
+#
+do 'cache.pm';
+
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
@@ -994,7 +1043,7 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
-$actions{$action}->();
+cache_fetch($action);
 exit;
 
 ## ======================================================================
@@ -3200,7 +3249,9 @@ sub git_header_html {
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
@@ -3344,6 +3395,7 @@ sub git_footer_html {
 	my $feed_class = 'rss_logo';
 
 	print {$output_handler} "<div class=\"page_footer\">\n";
+	print {$output_handler} "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
@@ -3424,7 +3476,7 @@ sub die_error {
 	my $extra = shift;
 
 	# The output handlers for die_error need to be reset to STDOUT
-	# so that half the message isn't being output to random and 
+	# so that half the message isn't being output to random and
 	# half to STDOUT as expected.  This is mainly for the benefit
 	# of using git_header_html() and git_footer_html() since those
 	# internaly use the indirect print handler.
-- 
1.6.5.2
