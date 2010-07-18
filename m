From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-svn: write memoized data explicitly to avoid Storable bug
Date: Sun, 18 Jul 2010 16:17:49 +0400
Message-ID: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
Cc: Eric Wong <normalperson@yhbt.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sergey Vlasov <vsu@altlinux.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 18 14:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaSvr-00065q-RH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 14:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0GRMY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 08:24:59 -0400
Received: from vint.altlinux.org ([194.107.17.35]:46428 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab0GRMY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 08:24:59 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2010 08:24:58 EDT
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vint.altlinux.org (Postfix) with ESMTP id C2E603F80015;
	Sun, 18 Jul 2010 12:17:50 +0000 (UTC)
Received: by imap.altlinux.org (Postfix, from userid 617)
	id 5B1A73E48D6F; Sun, 18 Jul 2010 16:17:48 +0400 (MSD)
X-Mailer: git-send-email 1.6.0.2.321.g8406
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151207>

Apparently using the Storable module during global destruction is
unsafe - there is a bug which can cause segmentation faults:

  http://rt.cpan.org/Public/Bug/Display.html?id=36087
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=482355

The persistent memoization support introduced in commit 8bff7c538
relied on global destruction to write cached data, which was leading
to segfaults in some Perl configurations.  Calling Memoize::unmemoize
in the END block forces the cache writeout to be performed earlier,
thus avoiding the bug.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 git-svn.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

 In my case segfaults happen only when the perl-IO-Compress module is
 installed - apparently the attempt to load Compress::Zlib (now
 provided by IO::Compress) changes something.

 This unaswered report is also suspicious:

   http://thread.gmane.org/gmane.comp.version-control.git/142161

 (when running ./t9151-svn-mergeinfo.sh -v, the segfault should be
 visible: "error: git-svn died of signal 11").

diff --git a/git-svn.perl b/git-svn.perl
index 19d6848..c416358 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3169,6 +3169,22 @@ sub has_no_changes {
 			LIST_CACHE => 'FAULT',
 		;
 	}
+
+	sub unmemoize_svn_mergeinfo_functions {
+		return if not $memoized;
+		$memoized = 0;
+
+		Memoize::unmemoize 'lookup_svn_merge';
+		Memoize::unmemoize 'check_cherry_pick';
+		Memoize::unmemoize 'has_no_changes';
+	}
+}
+
+END {
+	# Force cache writeout explicitly instead of waiting for
+	# global destruction to avoid segfault in Storable:
+	# http://rt.cpan.org/Public/Bug/Display.html?id=36087
+	unmemoize_svn_mergeinfo_functions();
 }
 
 sub parents_exclude {
-- 
1.6.0.2.321.g8406
