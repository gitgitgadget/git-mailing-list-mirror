From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 19/17] gitweb: Add beginnings of cache administration page (WIP)
Date: Thu, 24 Jun 2010 09:56:53 +0200
Message-ID: <1277366213-28381-2-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 09:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORhJS-0006fQ-BG
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 09:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0FXH5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 03:57:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58674 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab0FXH5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 03:57:13 -0400
Received: by mail-fx0-f46.google.com with SMTP id 3so123089fxm.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o6bAA4DHy8shHnSSWjufOf2/Bp4/Szqn7McZIWidls0=;
        b=w7GqVsXqWR36Og85yy4236qjwKe+vTIiMSobZk0zxE4UVArkL1kseVclsE58e8ZsJk
         0y9uZf/7bdv/j2RLpi/I0umikftuwUCYoAK63jkxm3BgUYZAkQ3uVl9VROgw5SMXgWPy
         ZuclFg+LBgtlFyJHTNRcbO2SNuauDQYAKZsWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rElEcWyMzyRbMLm4uyxb4m9eEKX+TxTsVcammM/X0Bm00td+LspHjV4M+sWhDs5tP9
         qflF0Qnh3ahvVCMXASkJGF5U3NovBUxamt1EWkbeHV4TZ9Z9Ww81sdr5KW39FSud59zX
         VkvVaZE8fP8qy+lkCbEROkXG6aga+I2CktsAk=
Received: by 10.223.30.10 with SMTP id s10mr8902808fac.4.1277366232502;
        Thu, 24 Jun 2010 00:57:12 -0700 (PDT)
Received: from localhost.localdomain (abvz51.neoplus.adsl.tpnet.pl [83.8.223.51])
        by mx.google.com with ESMTPS id r9sm712449faq.1.2010.06.24.00.57.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 00:57:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149565>

Currently it shows estimated size of cache, and provides link to
clearing cache.

Cache administration page is visible only on local computer; the same
is true with respect to ability to clear cache.  Those are bare
beginnings of autorization framework.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is "frontend" (interface) patch for gitweb cache management.

This is very much work in progress, sent to git mailing list as a
proof of concept.  Would something like that (perhaps with more
advanced authorization for admin) be useful?

The 'cache' page looks like this:

  Cache location      Size	 
  ------------------+---------+--------------
  cache/gitweb        14 KiB	[Clear cache]
  ------------------+---------+--------------

where '[Clear cache]' is a submit button.

 gitweb/gitweb.perl |  131 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 313114c..deb0553 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -24,8 +24,13 @@ use Encode;
 use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
+use POSIX;
 
 binmode STDOUT, ':utf8';
 
 our $t0;
@@ -781,6 +786,19 @@ our %actions = (
 	"project_index" => \&git_project_index,
 );
 
+our %uncacheable_actions = ();
+# some actions are available only conditionally
+if ($caching_enabled) {
+	$actions{'cache'} = \&git_cache_admin;
+	$actions{'clear_cache'} = \&git_cache_clear;
+
+	map { $uncacheable_actions{$_} = 1 } qw(cache clear_cache);
+}
+sub is_cacheable {
+	my $action = shift;
+	return !$uncacheable_actions{$action};
+}
+
 # finally, we have the hash of allowed extra_options for the commands that
 # allow them
 our %allowed_options = (
@@ -1093,7 +1111,7 @@ if (!defined $action) {
 if (!defined($actions{$action})) {
 	die_error(400, "Unknown action");
 }
-if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+if ($action !~ m/^(?:opml|project_list|project_index|cache|clear_cache)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
@@ -1102,12 +1120,20 @@ if ($caching_enabled) {
 	# $cache might be initialized (instantiated) cache, i.e. cache object,
 	# or it might be name of class, or it might be undefined
 	unless (defined $cache && ref($cache)) {
-		$cache ||= 'GitwebCache::FileCacheWithLocking';
+		if (eval { require GitwebCache::FileCacheWithLocking; 1; }) {
+			$cache ||= 'GitwebCache::FileCacheWithLocking';
+		} else {
+			# GitwebCache::CacheOutput loads GitwebCache::SimpleFileCache
+			$cache ||= 'GitwebCache::SimpleFileCache';
+		}
 		$cache = $cache->new({
 			%cache_options,
 			#'cache_root' => '/tmp/cache',
@@ -1120,7 +1146,9 @@ if ($caching_enabled) {
 			'depth' => $cache_options{'cache_depth'},
 		});
 	}
-
+}
+if ($caching_enabled &&
+    is_cacheable($action)) {
 	# human readable key identifying gitweb output
 	my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
 
@@ -3472,7 +3500,7 @@ sub git_header_html {
 	my $expires = shift;
 	my %opts = @_;
 
-	my $title = get_page_title();
+	my $title = $opts{'-title'} || get_page_title();
 	my $content_type;
 	# require explicit support from the UA if we are to send the page as
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
@@ -7118,3 +7146,92 @@ XML
 </opml>
 XML
 }
+
+# see Number::Bytes::Human
+sub human_readable_size {
+	my $bytes = shift || return;
+
+	my @units = ('', 'KiB', 'MiB', 'GiB', 'TiB');
+	my $block = 1024;
+
+	my $x = $bytes;
+	my $unit;
+	foreach (@units) {
+		$unit = $_, last if POSIX::ceil($x) < $block;
+		$x /= $block;
+	}
+
+	my $num;
+	if ($x < 10.0) {
+		$num = sprintf("%.1f", POSIX::ceil($x*10)/10); 
+	} else {
+		$num = sprintf("%d", POSIX::ceil($x));
+	}
+
+	return "$num $unit";
+}
+
+sub cache_admin_auth_ok {
+	return $ENV{'SERVER_ADDR'} eq $ENV{'REMOTE_ADDR'};
+}
+
+sub git_cache_admin {
+	$caching_enabled
+		or die_error(403, "Caching disabled");
+	cache_admin_auth_ok()
+		or die_error(403, "Cache administration not allowed");
+	$cache && ref($cache)
+		or die_error(500, "Cache is not present");
+
+	git_header_html(undef, undef,
+		-title => to_utf8($site_name) . " - Gitweb cache");
+
+	print <<'EOF_HTML';
+<table class="cache_admin">
+<tr><th>Cache location</th><th>Size</th><th>&nbsp;</th></tr>
+EOF_HTML
+	print '<tr class="light">' .
+	      '<td class="path">' . esc_path($cache->path_to_namespace()) . '</td>' .
+	      '<td>';
+	my $size;
+	$size = $cache->size()     if (!defined $size && $cache->can('size'));
+	$size = $cache->get_size() if (!defined $size && $cache->can('get_size'));
+	if (defined $size) {
+		print human_readable_size($size);
+	}
+	print '</td><td>';
+	if ($cache->can('clear')) {
+		print $cgi->start_form({-method => "POST",
+		                        -action => $my_uri,
+		                        -enctype => CGI::URL_ENCODED}) .
+		      $cgi->input({-name=>"a", -value=>"clear_cache", -type=>"hidden"}) .
+		      $cgi->submit({-label => 'Clear cache'}) .
+		      $cgi->end_form();
+#		print <<'EOF_FORM';
+#
+#<form method="post" action="?a=clear_cache" enctype="application/x-www-form-urlencoded">
+#<input type="submit" value="Clear cache" />
+#</form>
+#EOF_FORM
+	}
+	print <<'EOF_HTML';
+</td></tr>
+</table>
+EOF_HTML
+
+	git_footer_html();
+}
+
+sub git_cache_clear {
+	if (cache_admin_auth_ok() && $cache &&
+	    $cgi->request_method() eq 'POST') {
+
+		$cache->clear();
+	}
+
+	#print "cleared";
+	print $cgi->redirect(-uri => href(action=>'cache', -full=>1),
+	                     -status => '303 See Other');
+}
