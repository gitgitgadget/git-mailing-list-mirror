From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 3/4 (amend)] gitweb: File based caching layer (from git.kernel.org)
Date: Sun, 28 Nov 2010 12:22:58 +0100
Message-ID: <201011281223.03141.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011130035.50229.jnareb@gmail.com> <201011130056.24222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 12:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMfMC-0003jJ-SE
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 12:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab0K1LXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 06:23:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52399 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab0K1LXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 06:23:21 -0500
Received: by bwz15 with SMTP id 15so3070990bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=s+aZd31WerH8naKNOxNTF80gy/pKCS9RZag5YDxFhr8=;
        b=m9q66LjW3w7yLvUs1xyAmLWxATR8BJEYYEsfzyWXU8c+X2wthCBTMdhoIJW2PX8hYF
         kFWnzB0HO8LfIYEjcqcesmlqbmpYUibmOGq7R/H4wJxvhbHzC4CrSqcxgUyn62L8eraP
         y/G9E/edtLcGCxUoN8KZh3cO2Bb9Z3yMlN3VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mLgCo1AO8zTOc7i4eZJoxASUm+WTK2fNgO5VBMGLcnYOkbgYjkUyGjSYTrSqZSFsEb
         Raw1O2T6v5sASRYlfyxoBfH7C3LfyOWPgH4Yo6qxp67ndNCA5C5YmZZb+LV3l9nbvVPP
         OGzWCDzFTMLDROJnT9s5Zv0PMNzM/m46UWXZo=
Received: by 10.204.60.212 with SMTP id q20mr3682184bkh.104.1290943399621;
        Sun, 28 Nov 2010 03:23:19 -0800 (PST)
Received: from [192.168.1.13] (abwq157.neoplus.adsl.tpnet.pl [83.8.240.157])
        by mx.google.com with ESMTPS id 11sm1421334bkj.12.2010.11.28.03.23.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 03:23:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011130056.24222.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162339>

=46rom: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

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
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

On Sat, 13 Nov 2010, Jakub Narebski wrote:

> +sub cacheUpdate {
> +=A0=A0=A0=A0=A0=A0=A0my ($action,$areForked) =3D @_;
> +=A0=A0=A0=A0=A0=A0=A0my $lockingStatus;
> +=A0=A0=A0=A0=A0=A0=A0my $fileData =3D "";
> +
> +=A0=A0=A0=A0=A0=A0=A0if($backgroundCache){
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0open(cacheFileBG, '>:ut=
f8', "$fullhashpath.bg");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $lockStatBG =3D floc=
k(cacheFileBG,LOCK_EX|LOCK_NB);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$lockStatus =3D $lockSt=
atBG;
> +=A0=A0=A0=A0=A0=A0=A0}else{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0open(cacheFile, '>:utf8=
', \$fullhashpath);
                                            ^^^^^^^^^^^^^^

I have made mistake with this line when moving $caching_enabled check
out of cache_fetch to its caller.

Reusing $fullhashpath variable as a *capture buffer* (it has nothing
to do with path; it is not a filename no longer) wouldn't help there.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $lockStat =3D flock(=
cacheFile,LOCK_EX|LOCK_NB);

A note about original code: you can't flock in-memory files.

> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$lockStatus =3D $lockSt=
at;
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0#print "lock status: $lockStat\n";
[...]

 gitweb/Makefile          |    3 +
 gitweb/gitweb.perl       |  105 ++++++++++++--
 gitweb/lib/cache.pl      |  348 ++++++++++++++++++++++++++++++++++++++=
++++++++
 gitweb/static/gitweb.css |    6 +
 4 files changed, 450 insertions(+), 12 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

diff --git a/gitweb/Makefile b/gitweb/Makefile
index f9e32eb..6ddd4f1 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -113,6 +113,9 @@ endif
=20
 GITWEB_FILES +=3D static/git-logo.png static/git-favicon.png
=20
+# Gitweb caching
+GITWEB_MODULES +=3D cache.pl
+
 GITWEB_REPLACE =3D \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cae0e34..3c3ff08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -250,6 +250,53 @@ our %avatar_size =3D (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload =3D 300;
=20
+# This enables/disables the caching layer in gitweb.  This currently o=
nly supports the
+# 'dumb' file based caching layer, primarily used on git.kernel.org.  =
this is reasonably
+# effective but it has the downside of requiring a huge amount of disk=
 space if there
+# are a number of repositories involved.  It is not uncommon for git.k=
ernel.org to have
+# on the order of 80G - 120G accumulate over the course of a few month=
s.  It is recommended
+# that the cache directory be periodically completely deleted, and thi=
s is safe to perform.
+# Suggested mechanism
+# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
+our $caching_enabled =3D 0;
+
+# Used to set the minimum cache timeout for the dynamic caching algori=
thm.  Basically
+# if we calculate the cache to be under this number of seconds we set =
the cache timeout
+# to this minimum.
+# Value is in seconds.  1 =3D 1 seconds, 60 =3D 1 minute, 600 =3D 10 m=
inutes, 3600 =3D 1 hour
+our $minCacheTime =3D 20;
+
+# Used to set the maximum cache timeout for the dynamic caching algori=
thm.  Basically
+# if we calculate the cache to exceed this number of seconds we set th=
e cache timeout
+# to this maximum.
+# Value is in seconds.  1 =3D 1 seconds, 60 =3D 1 minute, 600 =3D 10 m=
inutes, 3600 =3D 1 hour
+our $maxCacheTime =3D 1200;
+
+# If you need to change the location of the caching directory, overrid=
e this
+# otherwise this will probably do fine for you
+our $cachedir =3D 'cache';
+
+# If this is set (to 1) cache will do it's best to always display some=
thing instead
+# of making someone wait for the cache to update.  This will launch th=
e cacheUpdate
+# into the background and it will lock a <file>.bg file and will only =
lock the
+# actual cache file when it needs to write into it.  In theory this wi=
ll make
+# gitweb seem more responsive at the price of possibly stale data.
+our $backgroundCache =3D 1;
+
+# Used to set the maximum cache file life.  If a cache files last modi=
fy time exceeds
+# this value, it will assume that the data is just too old, and HAS to=
 be regenerated
+# instead of trying to display the existing cache data.
+# Value is in seconds.  1 =3D 1 seconds, 60 =3D 1 minute, 600 =3D 10 m=
inutes, 3600 =3D 1 hour
+# 18000 =3D 5 hours
+our $maxCacheLife =3D 18000;
+
+# Used to enable or disable background forking of the gitweb caching. =
 Mainly here for debugging purposes
+our $cacheDoFork =3D 1;
+
+our $fullhashpath =3D *STDOUT;
+our $fullhashbinpath =3D *STDOUT;
+our $fullhashbinpathfinal =3D *STDOUT;
+
 # configuration for 'highlight' (http://www.andre-simon.de/)
 # match by basename
 our %highlight_basename =3D (
@@ -506,6 +553,15 @@ our %feature =3D (
 		'default' =3D> [0]},
 );
=20
+#
+# Includes
+#
+if (!exists $INC{'cache.pl'}) {
+	my $return =3D do 'cache.pl';
+	die $@ if $@;
+	die "Couldn't read 'cache.pl': $!" if (!defined $return);
+}
+
 sub gitweb_get_feature {
 	my ($name) =3D @_;
 	return unless exists $feature{$name};
@@ -734,6 +790,10 @@ our %actions =3D (
 	"project_list" =3D> \&git_project_list,
 	"project_index" =3D> \&git_project_index,
 );
+sub is_cacheable {
+	my $action =3D shift;
+	return !($action eq 'blame_data' || $action eq 'blame_incremental');
+}
=20
 # finally, we have the hash of allowed extra_options for the commands =
that
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
=20
 sub reset_timer {
@@ -1142,6 +1206,7 @@ sub change_output {
=20
 	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messa=
ges and such
 	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
+	print STDOUT_REAL "";
=20
 	# Close STDOUT, so that it isn't being used anymore.
 	close STDOUT;
@@ -1167,10 +1232,7 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
=20
-		change_output();
 		run_request();
-		reset_output();
-		print $output;
=20
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3447,7 +3509,8 @@ sub git_header_html {
 	# support xhtml+xml but choking when it gets what it asked for.
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =3D~ m/(,|;|\s|^)application\/xhtml\+xm=
l(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') !=3D 0) {
+	    $cgi->Accept('application/xhtml+xml') !=3D 0 &&
+	    !$caching_enabled) {
 		$content_type =3D 'application/xhtml+xml';
 	} else {
 		$content_type =3D 'text/html';
@@ -3592,6 +3655,7 @@ sub git_footer_html {
 	my $feed_class =3D 'rss_logo';
=20
 	print "<div class=3D\"page_footer\">\n";
+	print "<div class=3D\"cachetime\">Cache Last Updated: ". gmtime( time=
 ) ." GMT</div>\n";
 	if (defined $project) {
 		my $descr =3D git_get_project_description($project);
 		if (defined $descr) {
@@ -3680,9 +3744,14 @@ sub die_error {
 		500 =3D> '500 Internal Server Error',
 		503 =3D> '503 Service Unavailable',
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
=20
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
@@ -5592,9 +5661,15 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename=3D"' . $save_as . '"');
 	local $/ =3D undef;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if ($caching_enabled) {
+		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open=
 bin dump file");
+	}else{
+		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not ope=
n bin dump file");
+	}
+	binmode BINOUT, ':raw';
+	print BINOUT <$fd>;
+	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close BINOUT;
 	close $fd;
 }
=20
@@ -5879,9 +5954,15 @@ sub git_snapshot {
=20
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	if ($caching_enabled) {
+		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open=
 bin dump file");
+	}else{
+		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not ope=
n bin dump file");
+	}
+	binmode BINOUT, ':raw';
+	print BINOUT <$fd>;
+	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close BINOUT;
 	close $fd;
 }
=20
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
new file mode 100644
index 0000000..dd14bfb
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
+	my ($action) =3D @_;
+	my $cacheTime =3D 0;
+
+	if(! -d $cachedir){
+		print "*** Warning ***: Caching enabled but cache directory does not=
 exsist.  ($cachedir)\n";
+		mkdir ("cache", 0755) || die "Cannot create cache dir - you will nee=
d to manually create";
+		print "Cache directory created successfully\n";
+	}
+
+	our $full_url =3D "$my_url?". $ENV{'QUERY_STRING'};
+	our $urlhash =3D md5_hex($full_url);
+	our $fullhashdir =3D "$cachedir/". substr( $urlhash, 0, 2) ."/";
+
+	eval { mkpath( $fullhashdir, 0, 0777 ) };
+	if ($@) {
+		die_error(500, "Internal Server Error", "Could not create cache dire=
ctory: $@");
+	}
+	$fullhashpath =3D "$fullhashdir/". substr( $urlhash, 2 );
+	$fullhashbinpath =3D "$fullhashpath.bin.wt";
+	$fullhashbinpathfinal =3D "$fullhashpath.bin";
+
+	if(! -e "$fullhashpath" ){
+		if(! $cacheDoFork || ! defined(my $childPid =3D fork()) ){
+			cacheUpdate($action,0);
+			cacheDisplay($action);
+		} elsif ( $childPid =3D=3D 0 ){
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
+		my $stat_time =3D (stat(_))[9];
+		my $stat_size =3D (stat(_))[7];
+
+		$cacheTime =3D get_loadavg() * 60;
+		if( $cacheTime > $maxCacheTime ){
+			$cacheTime =3D $maxCacheTime;
+		}
+		if( $cacheTime < $minCacheTime ){
+			$cacheTime =3D $minCacheTime;
+		}
+		if( $stat_time < (time - $cacheTime) || $stat_size =3D=3D 0 ){
+			if( ! $cacheDoFork || ! defined(my $childPid =3D fork()) ){
+				cacheUpdate($action,0);
+				cacheDisplay($action);
+			} elsif ( $childPid =3D=3D 0 ){
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
+	# If all of the caching failes - lets go ahead and press on without i=
t and fall back to 'default'
+	# non-caching behavior.  This is the softest of the failure condition=
s.
+	#
+	#$actions{$action}->();
+}
+
+sub cacheUpdate {
+	my ($action,$areForked) =3D @_;
+	my $lockingStatus;
+	my $fileData =3D "";
+
+	if($backgroundCache){
+		open(cacheFileBG, '>:utf8', "$fullhashpath.bg");
+		my $lockStatBG =3D flock(cacheFileBG,LOCK_EX|LOCK_NB);
+
+		$lockStatus =3D $lockStatBG;
+	}else{
+		open(cacheFile, '>:utf8', \$fullhashpath);
+		my $lockStat =3D flock(cacheFile,LOCK_EX|LOCK_NB);
+
+		$lockStatus =3D $lockStat;
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
+		my $openstat =3D open(cacheFileBinWT, '>>:utf8', "$fullhashbinpath")=
;
+		my $lockStatBin =3D flock(cacheFileBinWT,LOCK_EX|LOCK_NB);
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
+		$lockStat =3D flock(cacheFile,LOCK_EX);
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
+		my $openstat =3D open(cacheFileBinFINAL, '>:utf8', "$fullhashbinpath=
final");
+		$lockStatBIN =3D flock(cacheFileBinFINAL,LOCK_EX);
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
+	local $/ =3D undef;
+	$|++;
+	print cacheFile "$output";
+	$|--;
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		move("$fullhashbinpath", "$fullhashbinpathfinal") or die "Binary Cac=
he file could not be updated: $!";
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
+	my ($action) =3D @_;
+	my $x =3D 0;
+	my $max =3D 10;
+	my $lockStat =3D 0;
+
+	if( $backgroundCache ){
+		if( -e "$fullhashpath" ){
+			open(cacheFile, '<:utf8', "$fullhashpath");
+			$lockStat =3D flock(cacheFile,LOCK_SH|LOCK_NB);
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
+			$lockStat =3D flock(cacheFile,LOCK_SH|LOCK_NB);
+			close(cacheFile);
+			$x++;
+			$combinedLockStat =3D $lockStat;
+		} while ((! $combinedLockStat) && ($x < $max));
+
+		if( $x !=3D $max ){
+			cacheDisplay($action);
+		}
+		return;
+	}
+
+	$| =3D 1;
+
+	print $::cgi->header(
+				-type=3D>'text/html',
+				-charset =3D> 'utf-8',
+				-status=3D> 200,
+				-expires =3D> 'now',
+				# HTTP/1.0
+				-Pragma =3D> 'no-cache',
+				# HTTP/1.1
+				-Cache_Control =3D> join(
+							', ',
+							qw(
+								private
+								no-cache
+								no-store
+								must-revalidate
+								max-age=3D0
+								pre-check=3D0
+								post-check=3D0
+							)
+						)
+				);
+
+	print <<EOF;
+<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/=
TR/html4/strict.dtd">
+<!-- git web w/caching interface version $version, (C) 2006-2010, John=
 'Warthog9' Hawley <warthog9\@kernel.org> -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv=3D"content-type" content=3D"$content_type; charset=3D=
utf-8"/>
+<meta name=3D"generator" content=3D"gitweb/$version git/$git_version"/=
>
+<meta name=3D"robots" content=3D"index, nofollow"/>
+<meta http-equiv=3D"refresh" content=3D"0"/>
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
+		$lockStat =3D flock(cacheFile,LOCK_SH|LOCK_NB);
+		close(cacheFile);
+		$x++;
+		$combinedLockStat =3D $lockStat;
+	} while ((! $combinedLockStat) && ($x < $max));
+	print <<EOF;
+</body>
+</html>
+EOF
+	return;
+}
+
+sub cacheDisplay {
+	local $/ =3D undef;
+	$|++;
+
+	my ($action) =3D @_;
+	open(cacheFile, '<:utf8', "$fullhashpath");
+	$lockStat =3D flock(cacheFile,LOCK_SH|LOCK_NB);
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
+		my $openstat =3D open(cacheFileBin, '<', "$fullhashbinpathfinal");
+		$lockStatBIN =3D flock(cacheFileBin,LOCK_SH|LOCK_NB);
+		if (! $lockStatBIN ){
+			system ("echo 'cacheDisplay - bailing due to binary lock failure' >=
> /tmp/gitweb.log");
+			close(cacheFile);
+			close(cacheFileBin);
+			cacheWaitForUpdate($action);
+		}
+
+		my $binfilesize =3D -s "$fullhashbinpathfinal";
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
=20
+div.cachetime {
+	float: left;
+	margin-right: 10px;
+	color: #555555;
+}
+
 div.page_footer {
 	height: 17px;
 	padding: 4px 8px;
--=20
1.7.3
