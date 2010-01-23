From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 05/10] gitweb: Use Cache::Cache compatibile (get, set) output caching (WIP)
Date: Sat, 23 Jan 2010 01:27:28 +0100
Message-ID: <553a364cdfdbb1d5c6dfc75f0545e46143a1be8a.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTtg-000356-50
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0AWA2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508Ab0AWA2p
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:28:45 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:44838 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437Ab0AWA1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:48 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so1932419fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=w0KOfo9/iJIbvhpNKDT+TvFsrV6XYedVLvqlmbwPjGI=;
        b=DqVapNDGlM7xtf8LEqkjd74z4pvadZaJI7dXi8H7YEiVlSa8kI4E4iKyS0NsjZ3R1a
         KqP49DFNFrh1olVgbAegEv064VpwVPTsClqsY0ZdJcjEP+MU3SKYj6pLVoKh2uWHjiKx
         woNMvopwAgHidiGen1qBxpMBbN/p+UyK3eZIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LF6bj6ftsy++lV/A9IgDAUbn2xcItnnBbZnk/Iz+nhtA04t9siux78La5bp+UOSRjE
         Po2LmCtP2B2yGgZPUzw6RNbmxUgrzqSUZKLSTSSZXxx0X2yPZ5rhqKgGBwrKV8VwuDj4
         lPiEfT9NBS+eaBZ/LtJc/bZ7389QovABalzS0=
Received: by 10.102.210.16 with SMTP id i16mr1878092mug.103.1264206467248;
        Fri, 22 Jan 2010 16:27:47 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:46 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137806>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

As you can see cache_fetch() subroutine is much, much simpler that the
one in original patch by J.H.:
  [PATCH 9/9] gitweb: File based caching layer (from git.kernel.org)
  Message-ID: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/136917

As you can see I have introduced $cache_pm variable, to be able to
test caching in t/t9500-gitweb-standalone-no-errors.sh, but also to be
able to install cache.pm in some other place than along gitweb.cgi.
There would be no such problems if we used 'require GitwebCache' or
somesuch, in place of 'do "cache.pm"' like in original patch by J.H.
But at leats for now I have decided to follow J.H. in this issue.

Instead of using binary (sic!) valued $cache_enable as in J.H. patch,
I use set of two variables: $cache (to be able to select what caching
engine to use, and what features should be enabled), and
$caching_enabled to actually enable/disable cache.

When caching is enabled gitweb do not output timing info (time to
generate page), as it would contain incorrect information if the page
was retrieved from cache; in this place we could put cachetime info
from the original patch by J.H., which means writing

  Cache Last Updated: ". gmtime( time )

I have forgot about adding this feature...


ATTENTION !!!: I have run both tests (t9500 to check for errors in
gitweb.perl, and t9503 to test the API), but I haven't actually tested
that *gitweb itself* behaves correctly.

 gitweb/cache.pm                        |   36 ++++++++++++++++++++++++++++
 gitweb/gitweb.perl                     |   40 +++++++++++++++++++++++++++++--
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   13 ++++++++++
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 12a7a78..3a33158 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -359,4 +359,41 @@ sub compute {
 1;
 } # end of package GitwebCache::SimpleFileCache;
 
+# human readable key identifying gitweb output
+sub gitweb_output_key {
+	return href(-replay => 1, -full => 1, -path_info => 0);
+}
+
+sub cache_fetch {
+	my ($cache, $action) = @_;
+
+	my $key = gitweb_output_key();
+	my $data = $cache->get($key);
+
+	if (defined $data) {
+		# print cached data
+		binmode STDOUT, ':raw';
+		print STDOUT $data;
+
+	} else {
+		# calculate data and regenerate data
+		open my $data_fh, '>', \$data
+			or die "Can't open memory file: $!";
+		# matches "binmode STDOUT, ':uft8'" at beginning
+		binmode $data_fh, ':utf8';
+
+		$out = $data_fh || \*STDOUT;
+		$actions{$action}->();
+
+		if (defined $data) {
+			$cache->set($key, $data);
+			binmode STDOUT, ':raw';
+			local $/ = undef;
+			print STDOUT $data;
+		}
+
+		close $data_fh;
+	}
+}
+
 1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cd5073c..0394dc8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -234,6 +234,22 @@ our $gitlinkurl_base = ("++GITWEB_BASE_URL++" =~ m!^(git://.*)$!) ? $1 : '';
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
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -998,7 +1014,21 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
-$actions{$action}->();
+
+if ($caching_enabled) {
+	do $cache_pm;
+	die $@ if $@;
+
+	$cache ||= GitwebCache::SimpleFileCache->new({
+		'cache_root'  => '/tmp/cache',
+		'cache_depth' => 2,
+		'expires_in'  => 20, # in seconds
+	});
+	cache_fetch($cache, $action);
+} else {
+	$actions{$action}->();
+}
+
 exit;
 
 ## ======================================================================
@@ -3207,7 +3237,9 @@ sub git_header_html {
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
@@ -3380,7 +3412,9 @@ sub git_footer_html {
 	}
 	print {$out} "</div>\n"; # class="page_footer"
 
-	if (defined $t0 && gitweb_check_feature('timed')) {
+	# timing info doesn't make much sense with output (response) caching
+	if (!$caching_enabled &&
+	    defined $t0 && gitweb_check_feature('timed')) {
 		print {$out} "<div id=\"generating_info\">\n";
 		print {$out} 'This page took '.
 		             '<span id="generating_time" class="time_span">'.
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index d9ffc90..d041083 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -27,6 +27,8 @@ our \$export_ok = '';
 our \$strict_export = '';
 our \$git_versions_must_match = 0;
 
+our \$cache_pm = '$TEST_DIRECTORY/../gitweb/cache.pm';
+
 EOF
 
 	cat >.git/description <<EOF
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 2fc7fdb..0f93962 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -639,4 +639,17 @@ test_expect_success \
 	 gitweb_run "p=.git;a=summary"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+cat >>gitweb_config.perl <<\EOF
+
+$caching_enabled = 1;
+EOF
+test_expect_success \
+	'caching enabled' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+
 test_done
-- 
1.6.6.1
