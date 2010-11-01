From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
Date: Mon,  1 Nov 2010 11:24:51 +0100
Message-ID: <1288607092-31458-4-git-send-email-jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 11:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCrZy-0005lL-FA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 11:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab0KAKZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 06:25:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44181 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141Ab0KAKZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 06:25:21 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so3125206ewy.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o5QK6WC6cQ38Pu6ZuRI0nluI3xBjRaWdhnvXOKcK0Ew=;
        b=Hutaou4qmGIeHMBHxFnA+rs2unzFqbxd5KgOngZSF0Zkwu+AXvJNYl1fZ8cvvFKS99
         dM7EklQVgSWdbP2UOnnRx1LfRh08x6coJm2wUgxrERKdNFxzHHPSjdo9dSsIeOjmB0IF
         zXRVmxxUrzw/4Yd9kX58gWK/iKQlvE9F25a0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LBvddCszAna+ULVpExes3Qis83VNR2qiRjACg3NWFrIjTPO4vTPMpwRtvToRMMO+1B
         4C2hTkm5gTnQ1MMHsRAOD1se+udkqpsFuNpWq/Ju6sVmY1ktAtZDd8yaUpdMxslPxGCW
         jRWAjqdgoILjww0il3ko5yUCtlGYgxGPuGM2c=
Received: by 10.213.32.7 with SMTP id a7mr3019318ebd.50.1288607120183;
        Mon, 01 Nov 2010 03:25:20 -0700 (PDT)
Received: from roke.localdomain (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id x54sm4069255eeh.11.2010.11.01.03.25.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 03:25:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <201010311021.55917.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160476>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

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

Caching is disabled by default.  You can turn it on by setting
$caching_enabled variable to true to enable file based caching.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is *minimal* fixup of J.H. patch, addressing only major concerns
of Junio C Hamano (JH) and me (JN).

JH> Jakub, can we have an absolute minimum fix-up, so that we can give
JH> this wider exposure?  I think there are only
JH> four issues:
JH>
JH>  (1) exclude Ajax-y stuff from caching

Done, via "if ($caching_enabled && is_cacheable($action) { ... }".

Alternate solution would be to degrade Ajax-y actions to their
non-Ajax-y versions (i.e. 'blame_incremental' to just 'blame') when
caching is enabled.

JH>  (2) install cache.pm the same way gitweb.perl is installed via
JH>      the Makefile

It is now 'gitweb/lib/cache.pl' (*.pl and not *.pm because it is not a
proper Perl module: it lacks 'package Foo' for one), and is installed
via 'install-modules' target in gitweb/Makefile, which is prereq to
'install' therein.  So 'make install-gitweb' would install cache.pl
alongside gitweb.

JH>  (3) running tests with appropriate -I so that cache.pm is found;

Thanks to "use lib __DIR__.'/lib';" it is not necessary.  The 
'use lib' solution has the advantage that it would work for mod_perl
too.

JH>  (4) die if 'cache.pm' cannot be "done".

  #
  # Includes
  #
  if (!exists $INC{'cache.pl'}) {
  	my $return = do 'cache.pl';
  	die $@ if $@;
  	die "Couldn't read 'cache.pl': $!" if (!defined $return);
  }

Gitweb now includes 'cache.pl' only once (which is important in
persistent environments that wrap gitweb, like mod_perl's
ModPerl::Registry, or Plack's Plack::App::WrapCGI which is used for
--httpd=plackup in git-instaweb), checks if there were any errors
parsing it, and checks if there were any errors finding it
(e.g. locating it).

JN>  (5) naming and semantic of gitweb config variables configuring caching;
JN>      at least change $cache_enabled enum to $caching_enabled boolean

Done.  $cache_enable is not more.

JN>  (6) do not change anything in gitweb behavior if caching is disabled;
JN>      move 'if ($caching_enabled)' test to gitweb.perl, and remove code
JN>      from cache_fetch

This simplified 'cache.pl' by removing all conditionals depending on
state of $cache_enable from it (see interdiff below).  This required
adding check if caching is enabled before running reset_output() in
die_error() subroutine.


For tests to not hang I had to change permissions of cache directory
from 0665 ('rw-rw-r-x') to 0755 ('rwxr-xr-x').  I think that was a
bug.

Interdiff (with '--ignore-all-space'):

  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
  index 8f748a3..abaeec6 100755
  --- a/gitweb/gitweb.perl
  +++ b/gitweb/gitweb.perl
  @@ -250,11 +251,7 @@ our $maxload = 300;
   # that the cache directory be periodically completely deleted, and this is safe to perform.
   # Suggested mechanism
   # mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
  -# Value is binary. 0 = disabled (default), 1 = enabled.
  -#
  -# Values of caching:
  -# 	1 = 'dumb' file based caching used on git.kernel.org
  -our $cache_enable = 0;
  +our $caching_enabled = 0;
   
   # Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
   # if we calculate the cache to be under this number of seconds we set the cache timeout
  @@ -552,7 +549,11 @@ our %feature = (
   #
   # Includes
   #
  -do 'cache.pm';
  +if (!exists $INC{'cache.pl'}) {
  +	my $return = do 'cache.pl';
  +	die $@ if $@;
  +	die "Couldn't read 'cache.pl': $!" if (!defined $return);
  +}
   
   sub gitweb_get_feature {
   	my ($name) = @_;
  @@ -782,6 +783,10 @@ our %actions = (
   	"project_list" => \&git_project_list,
   	"project_index" => \&git_project_index,
   );
  +sub is_cacheable {
  +	my $action = shift;
  +	return !($action eq 'blame_data' || $action eq 'blame_incremental');
  +}
   
   # finally, we have the hash of allowed extra_options for the commands that
   # allow them
  @@ -1120,8 +1118,11 @@ sub dispatch {
   	    !$project) {
   		die_error(400, "Project needed");
   	}
  -	#$actions{$action}->();
  +	if ($caching_enabled && is_cacheable($action)) {
   	cache_fetch($action);
  +	} else {
  +		$actions{$action}->();
  +	}
   }
   
   sub reset_timer {
  @@ -3494,9 +3494,8 @@ sub git_header_html {
   	# support xhtml+xml but choking when it gets what it asked for.
   	if (defined $cgi->http('HTTP_ACCEPT') &&
   	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
  -	    $cgi->Accept('application/xhtml+xml') != 0
  -	    &&
  -	    $cache_enable == 0) {
  +	    $cgi->Accept('application/xhtml+xml') != 0 &&
  +	    !$caching_enabled) {
   		$content_type = 'application/xhtml+xml';
   	} else {
   		$content_type = 'text/html';
  @@ -3737,7 +3736,7 @@ sub die_error {
   	#
   	# Reset the output so that we are actually going to STDOUT as opposed
   	# to buffering the output.
  -	reset_output();
  +	reset_output() if ($caching_enabled);
   
   	git_header_html($http_responses{$status}, undef, %opts);
   	print <<EOF;
  @@ -5647,7 +5646,7 @@ sub git_blob_plain {
   			($sandbox ? 'attachment' : 'inline')
   			. '; filename="' . $save_as . '"');
   	local $/ = undef;
  -	if( $cache_enable != 0){
  +	if ($caching_enabled) {
   		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
   	}else{
   		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
  @@ -5940,7 +5939,7 @@ sub git_snapshot {
   
   	open my $fd, "-|", $cmd
   		or die_error(500, "Execute git-archive failed");
  -	if( $cache_enable != 0){
  +	if ($caching_enabled) {
   		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
   	}else{
   		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
  diff --git a/gitweb/cache.pm b/gitweb/lib/cache.pl
  similarity index 75%
  rename from gitweb/cache.pm
  rename to gitweb/lib/cache.pl
  index c86265c..dd14bfb 100644
  --- a/gitweb/cache.pm
  +++ b/gitweb/lib/cache.pl
  @@ -18,21 +18,9 @@ sub cache_fetch {
   	my ($action) = @_;
   	my $cacheTime = 0;
   
  -	# Deal with cache being disabled
  -	if( $cache_enable == 0 ){
  -		undef $backgroundCache;
  -		#$fullhashpath = \$nocachedata;
  -		#$fullhashbinpath = \$nocachedatabin;
  -		$fullhashpath = *STDOUT;
  -		$fullhashbinpath = *STDOUT;
  -		$actions{$action}->();
  -		return;
  -	}elsif( $cache_enable == 1 ){
  -		#obviously we are using file based caching
  -
   		if(! -d $cachedir){
   			print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";
  -			mkdir ("cache", 0665) || die "Cannot create cache dir - you will need to manually create";
  +		mkdir ("cache", 0755) || die "Cannot create cache dir - you will need to manually create";
   			print "Cache directory created successfully\n";
   		}
   
  @@ -47,10 +35,9 @@ sub cache_fetch {
   		$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
   		$fullhashbinpath = "$fullhashpath.bin.wt";
   		$fullhashbinpathfinal = "$fullhashpath.bin";
  -	} # done dealing with cache enabled / disabled
   
   	if(! -e "$fullhashpath" ){
  -		if( ! $cache_enable || ! $cacheDoFork || ! defined(my $childPid = fork()) ){
  +		if(! $cacheDoFork || ! defined(my $childPid = fork()) ){
   			cacheUpdate($action,0);
   			cacheDisplay($action);
   		} elsif ( $childPid == 0 ){
  @@ -112,8 +99,7 @@ sub cacheUpdate {
   
   		$lockStatus = $lockStatBG;
   	}else{
  -		open(cacheFile, '>:utf8', "$fullhashpath") if ($cache_enable > 0);
  -		open(cacheFile, '>:utf8', \$fullhashpath) if ($cache_enable == 0);
  +		open(cacheFile, '>:utf8', \$fullhashpath);
   		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
   
   		$lockStatus = $lockStat;
  @@ -121,7 +107,7 @@ sub cacheUpdate {
   	#print "lock status: $lockStat\n";
   
   
  -	if ($cache_enable != 0 && ! $lockStatus ){
  +	if (! $lockStatus ){
   		if ( $areForked ){
   			exit(0);
   		}else{
  @@ -220,8 +206,7 @@ sub cacheWaitForUpdate {
   
   	if( $backgroundCache ){
   		if( -e "$fullhashpath" ){
  -			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
  -			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
  +			open(cacheFile, '<:utf8', "$fullhashpath");
   			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
   			stat(cacheFile);
   			close(cacheFile);
  @@ -242,8 +227,7 @@ sub cacheWaitForUpdate {
   	){
   		do {
   			sleep 2 if $x > 0;
  -			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
  -			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
  +			open(cacheFile, '<:utf8', "$fullhashpath");
   			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
   			close(cacheFile);
   			$x++;
  @@ -298,8 +282,7 @@ EOF
   	do {
   		print ".";
   		sleep 2 if $x > 0;
  -		open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
  -		open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
  +		open(cacheFile, '<:utf8', "$fullhashpath");
   		$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
   		close(cacheFile);
   		$x++;
  @@ -317,11 +300,10 @@ sub cacheDisplay {
   	$|++;
   
   	my ($action) = @_;
  -	open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
  -	open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
  +	open(cacheFile, '<:utf8', "$fullhashpath");
   	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
   
  -	if ($cache_enable != 0 && ! $lockStat ){
  +	if (! $lockStat ){
   		close(cacheFile);
   		cacheWaitForUpdate($action);
   	}
  @@ -332,12 +314,10 @@ sub cacheDisplay {
   			||
   			$action eq "blob_plain"
   		)
  -		&&
  -		$cache_enable > 0
   	){
   		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
   		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
  -		if ($cache_enable != 0 && ! $lockStatBIN ){
  +		if (! $lockStatBIN ){
   			system ("echo 'cacheDisplay - bailing due to binary lock failure' >> /tmp/gitweb.log");
   			close(cacheFile);
   			close(cacheFileBin);
  @@ -363,3 +343,6 @@ sub cacheDisplay {
   	close(cacheFile);
   	$|--;
   }
  +
  +1;

 gitweb/Makefile          |    3 +
 gitweb/gitweb.perl       |  105 ++++++++++++--
 gitweb/lib/cache.pl      |  348 ++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/static/gitweb.css |    6 +
 4 files changed, 450 insertions(+), 12 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 6fa7625..315753e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -111,6 +111,9 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# Gitweb caching
+GITWEB_MODULES += cache.pl
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 91e274f..abaeec6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -243,6 +243,53 @@ our %avatar_size = (
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
+our $caching_enabled = 0;
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
@@ -499,6 +546,15 @@ our %feature = (
 		'default' => [0]},
 );
 
+#
+# Includes
+#
+if (!exists $INC{'cache.pl'}) {
+	my $return = do 'cache.pl';
+	die $@ if $@;
+	die "Couldn't read 'cache.pl': $!" if (!defined $return);
+}
+
 sub gitweb_get_feature {
 	my ($name) = @_;
 	return unless exists $feature{$name};
@@ -727,6 +783,10 @@ our %actions = (
 	"project_list" => \&git_project_list,
 	"project_index" => \&git_project_index,
 );
+sub is_cacheable {
+	my $action = shift;
+	return !($action eq 'blame_data' || $action eq 'blame_incremental');
+}
 
 # finally, we have the hash of allowed extra_options for the commands that
 # allow them
@@ -1058,7 +1118,11 @@ sub dispatch {
 	    !$project) {
 		die_error(400, "Project needed");
 	}
-	$actions{$action}->();
+	if ($caching_enabled && is_cacheable($action)) {
+		cache_fetch($action);
+	} else {
+		$actions{$action}->();
+	}
 }
 
 sub reset_timer {
@@ -1128,6 +1192,7 @@ sub change_output {
 
 	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
 	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
+	print STDOUT_REAL "";
 
 	# Close STDOUT, so that it isn't being used anymore.
 	close STDOUT;
@@ -1153,10 +1218,7 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
-		change_output();
 		run_request();
-		reset_output();
-		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3432,7 +3494,8 @@ sub git_header_html {
 	# support xhtml+xml but choking when it gets what it asked for.
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
+	    $cgi->Accept('application/xhtml+xml') != 0 &&
+	    !$caching_enabled) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
@@ -3577,6 +3640,7 @@ sub git_footer_html {
 	my $feed_class = 'rss_logo';
 
 	print "<div class=\"page_footer\">\n";
+	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
@@ -3665,9 +3729,14 @@ sub die_error {
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
-	reset_output();
+	reset_output() if ($caching_enabled);
 
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
@@ -5577,9 +5646,15 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if ($caching_enabled) {
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
 
@@ -5864,9 +5939,15 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if ($caching_enabled) {
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
 
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
new file mode 100644
index 0000000..dd14bfb
--- /dev/null
+++ b/gitweb/lib/cache.pl
@@ -0,0 +1,347 @@
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
+	if(! -d $cachedir){
+		print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";
+		mkdir ("cache", 0755) || die "Cannot create cache dir - you will need to manually create";
+		print "Cache directory created successfully\n";
+	}
+
+	our $full_url = "$my_url?". $ENV{'QUERY_STRING'};
+	our $urlhash = md5_hex($full_url);
+	our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";
+
+	eval { mkpath( $fullhashdir, 0, 0777 ) };
+	if ($@) {
+		die_error(500, "Internal Server Error", "Could not create cache directory: $@");
+	}
+	$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
+	$fullhashbinpath = "$fullhashpath.bin.wt";
+	$fullhashbinpathfinal = "$fullhashpath.bin";
+
+	if(! -e "$fullhashpath" ){
+		if(! $cacheDoFork || ! defined(my $childPid = fork()) ){
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
+		open(cacheFile, '>:utf8', \$fullhashpath);
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
+	local $/ = undef;
+	$|++;
+
+	my ($action) = @_;
+	open(cacheFile, '<:utf8', "$fullhashpath");
+	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+
+	if (! $lockStat ){
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
+	){
+		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
+		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
+		if (! $lockStatBIN ){
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
+
+1;
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
-- 
1.7.3
