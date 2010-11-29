From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 3/4 (amend v2)] gitweb: File based caching layer (from git.kernel.org)
Date: Tue, 30 Nov 2010 00:09:03 +0100
Message-ID: <201011300009.05437.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <7vvd3fzskv.fsf@alter.siamese.dyndns.org> <7vr5e3zs9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:09:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCqZ-0005bP-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab0K2XJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 18:09:18 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab0K2XJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 18:09:16 -0500
Received: by fxm8 with SMTP id 8so633728fxm.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3slt2uYibIBl1gX/DBTZarx8AbSHrjpq+t6w9QpFtqY=;
        b=sgNTv+XbQfSpos7+COSykDdj5BfeVam76rpTXOpn0dYdYqZ9pMrYTqtiu66cf/yWDe
         /P1obfRVSRvdysocWC8FUMuTo7Q+HSnSH8jjKB3pyONN6i5hu+AIgayBvBdKL6UVQBTZ
         4nJA4ZmFkWg7kIFMsTqlKFEG8Dc3bW/AubG0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dnHkL/0ilkKFNdg+MvN7F57cEApx7A7aYGzVsmREJg0a7eO4tjULItRqHAExjgHOEf
         /Q6NNLwKjkd5m1tGm2GzXi4+wSoWGkAUJ4nw1TO/8BgVXTfEFt1Q5Jj1LZ6wZFNoEjVP
         eYGQAZL/OSJwfatqapZ4Z/ww5qvq2VCNQXYNo=
Received: by 10.223.102.79 with SMTP id f15mr5999804fao.134.1291072154855;
        Mon, 29 Nov 2010 15:09:14 -0800 (PST)
Received: from [192.168.1.13] (abvn170.neoplus.adsl.tpnet.pl [83.8.211.170])
        by mx.google.com with ESMTPS id e17sm1429521fak.10.2010.11.29.15.09.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 15:09:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr5e3zs9u.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162449>

On Mon, 29 Nov 2010, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>> I have made mistake with this line when moving $caching_enabled check
>>>> out of cache_fetch to its caller.
>>>> 
>>>> Reusing $fullhashpath variable as a *capture buffer* (it has nothing
>>>> to do with path; it is not a filename no longer) wouldn't help there.
>>>
>>> Errr... I meant that this abuse didn't help avoiding my mistake.
>>
>> Thanks.
> 
> Wait a bit.
> 
> This seems to match what I have already queued on 'pu', no?  Am I
> hallucinating?
 
Damn, it looks like my mailer included wrong (older) version of a file.
I'm sorry.  Below there is interdiff:

  diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
  index dd14bfb..4360b3d 100644
  --- a/gitweb/lib/cache.pl
  +++ b/gitweb/lib/cache.pl
  @@ -99,7 +99,7 @@ sub cacheUpdate {
   
   		$lockStatus = $lockStatBG;
   	}else{
  -		open(cacheFile, '>:utf8', \$fullhashpath);
  +		open(cacheFile, '>:utf8', $fullhashpath);
   		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
   
   		$lockStatus = $lockStat;

-- >8 --
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

[jn: added error checking to loading 'cache.pl'; moved check
 for $caching_enabled outside out of cache_fetch, which required
 update to die_error()]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/Makefile          |    3 +
 gitweb/gitweb.perl       |  105 ++++++++++++--
 gitweb/lib/cache.pl      |  348 ++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/static/gitweb.css |    6 +
 4 files changed, 450 insertions(+), 12 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

diff --git a/gitweb/Makefile b/gitweb/Makefile
index f9e32eb..6ddd4f1 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -113,6 +113,9 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# Gitweb caching
+GITWEB_MODULES += cache.pl
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cae0e34..3c3ff08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -250,6 +250,53 @@ our %avatar_size = (
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
@@ -506,6 +553,15 @@ our %feature = (
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
@@ -734,6 +790,10 @@ our %actions = (
 	"project_list" => \&git_project_list,
 	"project_index" => \&git_project_index,
 );
+sub is_cacheable {
+	my $action = shift;
+	return !($action eq 'blame_data' || $action eq 'blame_incremental');
+}
 
 # finally, we have the hash of allowed extra_options for the commands that
 # allow them
@@ -1072,7 +1132,11 @@ sub dispatch {
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
@@ -1142,6 +1206,7 @@ sub change_output {
 
 	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
 	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
+	print STDOUT_REAL "";
 
 	# Close STDOUT, so that it isn't being used anymore.
 	close STDOUT;
@@ -1167,10 +1232,7 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
-		change_output();
 		run_request();
-		reset_output();
-		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3447,7 +3509,8 @@ sub git_header_html {
 	# support xhtml+xml but choking when it gets what it asked for.
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
+	    $cgi->Accept('application/xhtml+xml') != 0 &&
+	    !$caching_enabled) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
@@ -3592,6 +3655,7 @@ sub git_footer_html {
 	my $feed_class = 'rss_logo';
 
 	print "<div class=\"page_footer\">\n";
+	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
@@ -3680,9 +3744,14 @@ sub die_error {
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
@@ -5592,9 +5661,15 @@ sub git_blob_plain {
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
 
@@ -5879,9 +5954,15 @@ sub git_snapshot {
 
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
index 0000000..4360b3d
--- /dev/null
+++ b/gitweb/lib/cache.pl
@@ -0,0 +1,348 @@
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
+		open(cacheFile, '>:utf8', $fullhashpath);
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
+__END__
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
