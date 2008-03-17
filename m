From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/3] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 16:09:29 +0100
Message-ID: <1205766570-13550-3-git-send-email-jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGzI-0007Cc-Bz
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbYCQPJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYCQPJu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:09:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:16344 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYCQPJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:09:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2046570nfb.21
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4zKNyx4TapqqSsKkPmSkv6eVwkWZtotsiXHYT/JV0YE=;
        b=soBQhl4W0//rYH0nhCNSfy0dUpFqIBf3Pu4qy4db+InjoAdB3A8ODCGK8YiTdm8mytmPZZ6eJBs8q8O+f33qU6X3FPL/Vr0fgR5SMVp8kJxUcqxExM5Vw+q5aOPkV2S30ETFTsX9fIOw+G8J3k5d+haID/V9XhN2JXyJ9ze7cJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hCpLk8ps3nNm6gzFe2h/UdKwVirxVuX1TIJduV/dfsVjW889TkV5YdxNZML6SYR7Hztr0ygSzep9zVeH3gGL/S7GlO5MdR8O87JeEobRvDRhMkdiD7CKfa3a1z67Ifpph6loDtbECgFjDN1a3YDfW7gV55MZidhOjdN0qPTKwTM=
Received: by 10.78.107.8 with SMTP id f8mr42571768huc.40.1205766583021;
        Mon, 17 Mar 2008 08:09:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.138])
        by mx.google.com with ESMTPS id 28sm13131826fkx.11.2008.03.17.08.09.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 08:09:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HF9dDV013578;
	Mon, 17 Mar 2008 16:09:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HF9cl4013577;
	Mon, 17 Mar 2008 16:09:38 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77438>

From: Petr Baudis <pasky@suse.cz>

On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
forks), the projects list (the default gitweb page) can take more than
a minute to generate. This naive patch adds simple support for caching
the projects list data structure so that all the projects do not need
to get rescanned at every page access.

$projlist_cache_lifetime gitweb configuration variable is introduced,
by default set to zero. If set to non-zero, it describes the number of
minutes for which the cache remains valid. Only single project root
per system can use the cache. Any script running with the same uid as
gitweb can change the cache trivially - this is for secure
installations only.

The cache itself is stored in /tmp/gitweb.index.cache as a
Data::Dumper dump of the perl data structure with the list of project
details.  When reusing the cache, the file is simply eval'd back into
@projects.

To prevent contention when multiple accesses coincide with cache
expiration, the timeout is postponed to time()+120 when we start
refreshing.  When showing cached version, a disclaimer is shown
at the top of the projects list.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is (slightly changed) second part of Petr Baudis patch; the
difference (intediff) between this version and the original can be
found in cover letter for this series.

The differences, besides a bit of style changes like using '&&'
instead of 'and', are:
 * Current version reads cache file in full, in 'slurp' mode, instead
   of reading it line by line and then concatenating lines.
 * Current version dumps @projects in the 'terse' mode, so it can be
   eval'ed directly into @projects, without need of extra variable.
 * Current version does atomic writing to cache file by writing first
   to temporary file (there in exclusive mode to *.lock file, but
   File::Temp::tempfile() temporary file could be used instead), and
   then renaming file.  This way we avoid possibility of reading
   partially created file.  Opening file in O_EXCL mode should prevent
   writers trampling one over another, and make only one instance of
   gitweb fill cache; on the other hand if somehow *.lock file is not
   deleted it would prevent regenerating cache.

Note: instead of using Data::Dumper to serialize data we could use
Storable module (distributed with Perl like Data::Dumper).  From what
I've checked it has larger initial cost, but might be better for
larger number of projects, exactly the situation when projects list
caching is needed.

I can send version using Storable; could you compare then Data::Dumper
on repo.or.cz set of repositories then, Pasky?

 gitweb/gitweb.css  |    6 ++++++
 gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 446a1c3..1e83896 100644
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
index 90ab894..5527378 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -118,6 +118,15 @@ our $fallback_encoding = 'latin1';
 # - one might want to include '-B' option, e.g. '-B', '-M'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# projects list cache for busy sites with many projects;
+# if you set this to non-zero, it will be used as the cached
+# index lifetime in minutes
+# the cached list version is stored in /tmp and can be tweaked
+# by other scripts running with the same uid as gitweb - use this
+# ONLY at secure installations; only single gitweb project root per
+# system is supported!
+our $projlist_cache_lifetime = 0;
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -3510,16 +3519,52 @@ sub git_get_projects_details {
 }
 
 sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+	my ($projlist, $order, $from, $to, $extra, $no_header, $cache_lifetime) = @_;
 
 	my ($check_forks) = gitweb_check_feature('forks');
 
-	my @projects = git_get_projects_details($projlist, $check_forks);
+	use File::stat;
+	use POSIX qw(:fcntl_h);
+
+	my $cache_file =  '/tmp/gitweb.index.cache';
+
+	my @projects;
+	my $stale = 0;
+	my $now = time();
+	if ($cache_lifetime && -f $cache_file &&
+	    stat($cache_file)->mtime + $cache_lifetime * 60 > $now &&
+	    open(my $fd, '<', $cache_file)) {
+		$stale = $now - stat($cache_file)->mtime;
+		local $/ = undef;
+		my $dump = <$fd>;
+		close $fd;
+		@projects = @{ eval $dump };
+	} else {
+		if ($cache_lifetime && -f $cache_file) {
+			# Postpone timeout by two minutes so that we get
+			# enough time to do our job.
+			my $time = time() - $cache_lifetime + 120;
+			utime $time, $time, $cache_file;
+		}
+		@projects = git_get_projects_details($projlist, $check_forks);
+		if ($cache_lifetime &&
+		    sysopen(my $fd, "$cache_file.lock", O_WRONLY|O_CREAT|O_EXCL, 0600)) {
+			use Data::Dumper;
+			$Data::Dumper::Terse = 1;
+			print $fd Dumper(\@projects);
+			close $fd;
+			rename "$cache_file.lock", $cache_file;
+		}
+	}
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	if ($cache_lifetime && $stale) {
+		print "<div class=\"stale_info\">Cached version (${stale}s old)</div>\n";
+	}
+
 	print "<table class=\"project_list\">\n";
 	unless ($no_header) {
 		print "<tr>\n";
@@ -3902,7 +3947,7 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	git_project_list_body(\@list, $order);
+	git_project_list_body(\@list, $order, undef, undef, undef, undef, $projlist_cache_lifetime);
 	git_footer_html();
 }
 
-- 
1.5.4.3.453.gc1ad83
