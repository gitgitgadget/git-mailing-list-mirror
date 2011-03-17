From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH v2 2/3] gitweb: introduce localtime feature
Date: Thu, 17 Mar 2011 12:38:30 -0700
Message-ID: <e160457138c1166ffa6faf1c58ea170e@localhost>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JAW-0004Bj-5y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab1CQTrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:47:20 -0400
Received: from [69.28.251.93] ([69.28.251.93]:42670 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab1CQTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:47:17 -0400
Received: (qmail 13433 invoked from network); 17 Mar 2011 19:47:16 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 Mar 2011 19:47:16 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 17 Mar 2011 12:47:15 -0700
In-Reply-To: <c8621826e0576e3e31240b0205e7e3d0@localhost>
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169265>

With this feature enabled, all timestamps are shown in the local
timezone instead of GMT.  The timezone is taken from the appropriate
timezone string stored in the commit object.

Affected views include:

summary page, last change field (commit time from latest change)
commit page, author/committer
commitdiff page, author/committer
log page, author time

No change to:

relative timestamps
patch page

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a3caf..bf341cb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -504,6 +504,19 @@ our %feature = (
 		'sub' => sub { feature_bool('remote_heads', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Use the author/commit localtime rather than GMT for all timestamps.
+	# Disabled by default.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'localtime'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'localtime'}{'override'} = 1;
+	# and in project config gitweb.localtime = 0|1;
+	'localtime' => {
+		'sub' => sub { feature_bool('localtime', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -2928,6 +2941,12 @@ sub parse_date {
 	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
 	                          1900+$year, $mon+1, $mday,
 	                          $hour, $min, $sec, $tz);
+
+	if (gitweb_check_feature('localtime')) {
+		$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d $tz",
+				     $days[$wday], $mday, $months[$mon],
+				     1900+$year, $hour ,$min, $sec;
+	}
 	return %date;
 }
 
@@ -3990,7 +4009,7 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd);
+		print_local_time(%wd) if !gitweb_check_feature('localtime');
 		print "</td>" .
 		      "</tr>\n";
 	}
-- 
1.7.4.1
