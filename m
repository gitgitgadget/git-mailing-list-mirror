From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 00:14:14 +0100
Message-ID: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxBI-0006GU-Hu
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbYCMXtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYCMXtO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:49:14 -0400
Received: from rover.dkm.cz ([62.24.64.27]:41039 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYCMXtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 19:49:13 -0400
X-Greylist: delayed 2095 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 19:49:12 EDT
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 4A4A68B9C9;
	Fri, 14 Mar 2008 00:14:15 +0100 (CET)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77151>

On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
forks), the projects list (the default gitweb page) can take more than
a minute to generate. This naive patch adds simple support for caching
the projects list data structure so that all the projects do not need
to get rescanned at every page access.

$projlist_cache_lifetime gitweb configuration variable is introduced,
by default set to zero. If set to non-zero, it describes the number of
minutes for which the cache remains valid. Only single project root
per system can use the cache. Any script running with the same uid
as gitweb can change the cache trivially - this is for secure installations
only.

The cache itself is stored in /tmp/gitweb.index.cache as a Data::Dumper
dump of the perl data structure with the list of project details. When
reusing the cache, the file is simply eval'd back into @projects. For
clarity, projects scanning and @projects population is separated to
git_get_projects_details().

To prevent contention when multiple accesses coincide with cache
expiration, the timeout is postponed to time()+120 when we start
refreshing. When showing cached version, a disclaimer is shown at the
top of the projects list.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.css  |    6 +++++
 gitweb/gitweb.perl |   59 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8e2bf3d..673077a 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -85,6 +85,12 @@ div.title, a.title {
 	color: #000000;
 }
 
+div.stale_info {
+	display: block;
+	text-align: right;
+	font-style: italic;
+}
+
 div.readme {
 	padding: 8px;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bcb6193..0eee195 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -122,6 +122,15 @@ our $fallback_encoding = 'latin1';
 # - one might want to include '-B' option, e.g. '-B', '-M'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# projects list cache for busy sites with many projects;
+# if you set this to non-zero, it will be used as the cached
+# index lifetime in minutes
+# the cached list version is stored in /tmp and can be tweaked
+# by other scripts running with the same uid as gitweb - use this
+# only at secure installations; only single gitweb project root per
+# system is supported!
+our $projlist_cache_lifetime = 0;
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -3507,10 +3516,8 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
-
-	my ($check_forks) = gitweb_check_feature('forks');
+sub git_get_projects_details {
+	my ($projlist, $check_forks) = @_;
 
 	my @projects;
 	foreach my $pr (@$projlist) {
@@ -3540,11 +3547,53 @@ sub git_project_list_body {
 		}
 		push @projects, $pr;
 	}
+	return @projects;
+}
+
+sub git_project_list_body {
+	my ($projlist, $order, $from, $to, $extra, $no_header, $cache_lifetime) = @_;
+
+	my ($check_forks) = gitweb_check_feature('forks');
+
+	my $cache_file = '/tmp/gitweb.index.cache';
+	use File::stat;
+
+	my @projects;
+	my $stale = 0;
+	if ($cache_lifetime and -f $cache_file
+	    and stat($cache_file)->mtime + $cache_lifetime * 60 > time()
+	    and open (my $fd, $cache_file)) {
+		$stale = time() - stat($cache_file)->mtime;
+		my @dump = <$fd>;
+		close $fd;
+		# Hack zone start
+		my $VAR1;
+		eval join("\n", @dump);
+		@projects = @$VAR1;
+		# Hack zone end
+	} else {
+		if ($cache_lifetime and -f $cache_file) {
+			# Postpone timeout by two minutes so that we get
+			# enough time to do our job.
+			my $time = time() - $cache_lifetime + 120;
+			utime $time, $time, $cache_file;
+		}
+		@projects = git_get_projects_details($projlist, $check_forks);
+		if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {
+			use Data::Dumper;
+			print $fd Dumper(\@projects);
+			close $fd;
+		}
+	}
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	if ($cache_lifetime and $stale) {
+		print "<div class=\"stale_info\">Cached version (${stale}s old)</div>\n";
+	}
+
 	print "<table class=\"project_list\">\n";
 	unless ($no_header) {
 		print "<tr>\n";
@@ -3927,7 +3976,7 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	git_project_list_body(\@list, $order);
+	git_project_list_body(\@list, $order, undef, undef, undef, undef, $projlist_cache_lifetime);
 	git_footer_html();
 }
 
