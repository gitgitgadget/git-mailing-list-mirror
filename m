From: Robert Quattlebaum <darco@deepdarc.com>
Subject: [PATCH] Enable tilde expansion for svn.authorsprog parameter
Date: Thu, 5 May 2011 09:47:28 -0700
Message-ID: <BD234792-3C9E-413A-84BC-24ADD1028B5D@deepdarc.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 19:02:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1wT-0002GD-9G
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab1EERCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:02:16 -0400
Received: from spider.nocdirect.com ([69.73.181.158]:57322 "EHLO
	spider.nocdirect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1EERCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:02:15 -0400
Received: from c-67-174-221-32.hsd1.ca.comcast.net ([67.174.221.32] helo=[172.30.96.30])
	by spider.nocdirect.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <darco@deepdarc.com>)
	id 1QI1i8-0004lc-04; Thu, 05 May 2011 12:47:32 -0400
X-Mailer: Apple Mail (2.1084)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - spider.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - deepdarc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172852>

While tilde (~) expansion often happens automatically at the command
line, it does not occur automatically for paths specified in the
git configuration file. This is unfortunate because it is often
useful to specify path names relative to the current user's (or
some other user's) home directory.  This patch adds support for
tilde expansion for the svn.authorsprog configuraiton option using
perl's glob() function.

As a side effect of this change, if you pass an 'authors-prog' via
the command line that it will be subjected to tilde expansion
*twice*. This is only a problem for usernames that have real tildes
or wildcards in them, which should be extraordinarily rare.

Also, since tilde expansion is performed using glob(), there is a
chance that if the authors-prog contains a wild card that it will
match multiple executables. In such a case the behavior will almost
certainly be undesirable.

I'm submitting this patch more for discussion than for consideration
at this point. I feel that there might be a better way to go about
this, but I'm not familiar enough with the codebase to know what
that might be.

Signed-off-by: Robert Quattlebaum <darco@deepdarc.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0fd2fd2..ff2591e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -307,7 +307,7 @@ version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
 if (defined $_authors_prog) {
-	$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
+	$_authors_prog = "'" . File::Spec->rel2abs(glob($_authors_prog)) . "'";
 }
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
-- 
1.7.4.1


__________________
Robert Quattlebaum
Jabber: darco@deepdarc.com
eMail:  darco@deepdarc.com
www:    http://www.deepdarc.com/
