From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Add option to cvs update before export
Date: Thu, 24 May 2007 17:06:55 +0200
Message-ID: <20070524150655.15030.13626.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu May 24 17:08:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrEv0-00071q-HJ
	for gcvg-git@gmane.org; Thu, 24 May 2007 17:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbXEXPHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXEXPHO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 11:07:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9172 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbXEXPHK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 11:07:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 260C4802815;
	Thu, 24 May 2007 17:00:49 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10253-06; Thu, 24 May 2007 17:00:48 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C62BB8027FA;
	Thu, 24 May 2007 17:00:48 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 4E25D29132;
	Thu, 24 May 2007 17:07:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id qft144DQq+Wn; Thu, 24 May 2007 17:06:59 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 31C6F28CA4;
	Thu, 24 May 2007 17:06:56 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48269>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 Documentation/git-cvsexportcommit.txt |    5 ++++-
 git-cvsexportcommit.perl              |    8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index fd7f540..da5c242 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
 DESCRIPTION
@@ -58,6 +58,9 @@ OPTIONS
 	Prepend the commit message with the provided prefix. 
 	Useful for patch series and the like.
 
+-u::
+	Update affected files from cvs repository before attempting export.
+
 -v::
 	Verbose.
 
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d6ae99b..42060ef 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -15,9 +15,9 @@ unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
     die "GIT_DIR is not defined or is unreadable";
 }
 
-our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d);
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u);
 
-getopts('hPpvcfam:d:');
+getopts('uhPpvcfam:d:');
 
 $opt_h && usage();
 
@@ -178,6 +178,10 @@ foreach my $f (@files) {
 
 my %cvsstat;
 if (@canstatusfiles) {
+    if ($opt_u) {
+      my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
+      print @updated;
+    }
     my @cvsoutput;
     @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
     my $matchcount = 0;
