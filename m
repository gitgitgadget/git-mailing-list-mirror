From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv5 19/17] gitweb: Add beginnings of cache administration page
Date: Thu,  7 Oct 2010 00:02:04 +0200
Message-ID: <1286402526-13143-20-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5s-0002Gb-97
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab0JFWDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933240Ab0JFWDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hhL9L9KqFr2UMybaz7Ngaw2lTvPRmRAHiMTT1gdlfKE=;
        b=KESNZrTIuHOQVqJNKcW7IaQLU4AcflecP6fE060QkLinZfK3jjtHdsUl/UQIolIxtm
         yonjUEXQ6R2sD1Rnf57jvB7ThwCDZOKXXTxghh5CCcFg/fsiXoq6LgBEkSKe+xINI20g
         XC1EuWtge3rz2p59RGzHr/JmCxbWOWjB0oFUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vWmtL9Q85+cE78uJJjapJ+EUp8157+3nUkli+QSZjndIhzF69ZnTdAS4f+ElD6KfqH
         yhXHwMSaDOdq+jC/M6EzcTknKqOL8/fMzSDGikipRTfLlYcXsTuM20tEP0uIl4fnW7Pm
         oOpYHyr+RKWNfi4wr11u7cFsdK+s5L+HLFuZY=
Received: by 10.204.68.136 with SMTP id v8mr10204454bki.88.1286402589067;
        Wed, 06 Oct 2010 15:03:09 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158318>

Currently it shows estimated size of cache, and provides link to
clearing cache.

Cache administration page is visible only on local computer; the same
is true with respect to ability to clear cache.  Those are bare
beginnings of autorization framework.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v4:
* action_is_cacheable() (is_cacheable() in previous version) now uses
  %actions_info hash.

* Adding actions related to gitweb cache administration is now done in
  configure_caching() subroutine.

* cache_admin_auth_ok() now returns true also for running gitweb as
  script, when REMOTE_ADDR environment variable is not define.  It
  also covers situation where non-standard (not in RFC 3875)
  SERVER_ADDR is not defined.


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

 gitweb/gitweb.perl |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fee8739..c413797 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -24,6 +24,8 @@ use Encode;
 use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
+use POSIX;
+
 binmode STDOUT, ':utf8';
 
 our $t0;
@@ -851,6 +853,10 @@ sub evaluate_actions_info {
 	map { $actions_info{$_}{'output_format'} = undef }
 		qw(blob_plain object);
 	$actions_info{'snapshot'}{'output_format'} = 'binary';
+
+	# specify uncacheable actions
+	map { $actions_info{$_}{'uncacheable'} = 1 }
+		qw(cache clear_cache);
 }
 
 sub action_outputs_html {
@@ -858,6 +864,11 @@ sub action_outputs_html {
 	return $actions_info{$action}{'output_format'} eq 'html';
 }
 
+sub action_is_cacheable {
+	my $action = shift;
+	return !$actions_info{$action}{'uncacheable'};
+}
+
 # fill %input_params with the CGI parameters. All values except for 'opt'
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
@@ -1178,12 +1189,13 @@ sub dispatch {
 	if (!defined($actions{$action})) {
 		die_error(400, "Unknown action");
 	}
-	if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+	if ($action !~ m/^(?:opml|project_list|project_index|cache|clear_cache)$/ &&
 	    !$project) {
 		die_error(400, "Project needed");
 	}
 
-	if ($caching_enabled) {
+	if ($caching_enabled &&
+	    action_is_cacheable($action)) {
 		# human readable key identifying gitweb output
 		my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
 
@@ -1204,11 +1216,11 @@ sub run_request {
 
 	evaluate_uri();
 	evaluate_gitweb_config();
-	evaluate_actions_info();
 	evaluate_git_version();
 	check_loadavg();
 	configure_caching()
 		if ($caching_enabled);
+	evaluate_actions_info();
 
 	# $projectroot and $projects_list might be set in gitweb config file
 	$projects_list ||= $projectroot;
@@ -1311,6 +1323,10 @@ sub configure_caching {
 			'depth' => $cache_options{'cache_depth'},
 		});
 	}
+
+	# some actions are available only if cache is turned on
+	$actions{'cache'} = \&git_cache_admin;
+	$actions{'clear_cache'} = \&git_cache_clear;
 }
 
 run();
@@ -3673,7 +3689,7 @@ sub git_header_html {
 	my $expires = shift;
 	my %opts = @_;
 
-	my $title = get_page_title();
+	my $title = $opts{'-title'} || get_page_title();
 	my $content_type;
 	# require explicit support from the UA if we are to send the page as
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
@@ -7325,3 +7341,98 @@ XML
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
+	if (defined $ENV{'REMOTE_ADDR'}) {
+		if (defined $ENV{'SERVER_ADDR'}) {
+			# SERVER_ADDR is not in RFC 3875
+			return $ENV{'SERVER_ADDR'} eq $ENV{'REMOTE_ADDR'};
+		} elsif ($ENV{'REMOTE_ADDR'} =~ m!^(?:127\.0\.0\.1|::1/128)$!) {
+			# localhost in IPv4 or IPv6
+			return 1;
+		}
+	} else {
+		# REMOTE_ADDR not defined, probably calling gitweb as script
+		return 1;
+	}
+
+	# restrict all but specified cases
+	return 0;
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
-- 
1.7.3
