From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] git-svn fix to avoid using strftime %z
Date: Tue, 24 Feb 2009 14:44:49 -0500
Message-ID: <1235504689-17420-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Feb 24 20:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc3Ee-0000Ol-3v
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897AbZBXToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 14:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbZBXTox
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:44:53 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:57264 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310AbZBXTox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:44:53 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lc3Cz-0001O9-Nr; Tue, 24 Feb 2009 14:44:49 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lc3Cz-0004XO-LL; Tue, 24 Feb 2009 14:44:49 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1OJinCN017442;
	Tue, 24 Feb 2009 14:44:49 -0500
X-Mailer: git-send-email 1.5.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111333>

%z isn't available on all platforms in the date formatting
routines.  Provide a workalike capability that should be
more portable.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
This is the reworked version that was requested.  It drops %z completely
from the strftime call in favour of the hand rolled version.  All tests
still pass on Linux and Solaris.

 git-svn.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cbc5211..24180eb 100755
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
@@ -4721,7 +4722,12 @@ sub run_pager {
 }
 
 sub format_svn_date {
-	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
+	# some systmes don't handle or mishandle %z, so be creative.
+	my $t = shift;
+	my $gm = timelocal(gmtime($t));
+	my $sign = qw( + + - )[ $t <=> $gm ];
+	my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
+	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
 }
 
 sub parse_git_date {
-- 
1.6.0.4
