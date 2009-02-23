From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] git-svn fix for systems without strftime %z
Date: Mon, 23 Feb 2009 09:33:03 -0500
Message-ID: <1235399583-6043-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1235399583-6043-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:45:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbczV-0001vH-5R
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbZBWPng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbZBWPne
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:43:34 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:54243 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbZBWPnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:43:32 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lbbrk-0005d8-I1; Mon, 23 Feb 2009 09:33:04 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lbbrk-0001bz-FW; Mon, 23 Feb 2009 09:33:04 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1NEX4eq006194;
	Mon, 23 Feb 2009 09:33:04 -0500
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1235399583-6043-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111142>

%z isn't available on all platforms in the date formatting
routines.  Detect when %z is ignored and insert the
the proper value if necessary.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-svn.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cbc5211..66f49b4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4615,6 +4615,7 @@ package Git::SVN::Log;
 use strict;
 use warnings;
 use POSIX qw/strftime/;
+use Time::Local;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
             %rusers $show_commit $incremental/;
@@ -4721,7 +4722,18 @@ sub run_pager {
 }
 
 sub format_svn_date {
-	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
+	my $timestr = strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
+
+	# for systems without %z (solaris 8, 9, etc)
+	if ($timestr =~ /%z/) {
+		my $lt = time;
+		my $gm = timelocal(gmtime($lt));
+		my $sign = qw( + + - )[ $lt <=> $gm ];
+		my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($lt - $gm)))[2,1]);
+		$timestr =~ s/%z/$gmoff/;
+	}
+
+	return $timestr;
 }
 
 sub parse_git_date {
-- 
1.6.0.4
