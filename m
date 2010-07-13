From: Raja R Harinath <harinath@hurrynot.org>
Subject: [PATCH] Use dev_t for device id (st_dev) from stat in setup_git_directory_gently()
Date: Tue, 13 Jul 2010 14:32:00 +0530
Message-ID: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
Cc: Raja R Harinath <harinath@hurrynot.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 11:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYbTZ-0002nz-Ps
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 11:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab0GMJIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 05:08:24 -0400
Received: from [117.192.136.207] ([117.192.136.207]:60094 "EHLO
	hariville.hurrynot.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751426Ab0GMJIX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 05:08:23 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2010 05:08:22 EDT
Received: by hariville.hurrynot.org (Postfix, from userid 1000)
	id 2EB831E80FBA; Tue, 13 Jul 2010 14:32:32 +0530 (IST)
X-Mailer: git-send-email 1.7.2.rc2.11.g03e33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150891>

The original declaration was int, which seems to cause trouble on my
machine.  It causes spurious "filesystem boundary" errors when running
the testsuite.  The cause seems to be

  $ stat -c%d .
  2147549952

which is too large for a 32-bit int type.

Using the correct type, dev_t, solves the issue.  (Because I'm
paranoid and forgetful, I checked -- yes, Unix v7 had dev_t.)

Other uses of st_dev seem to be reasonably safe.   fill_stat_cache_info
truncates it to an 'unsigned int', but that value seems to be used only
to validate the cache, and only if USE_STDEV is defined.
---
 setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 7e04602..87c21f0 100644
--- a/setup.c
+++ b/setup.c
@@ -323,7 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset, root_len;
-	int current_device = 0, one_filesystem = 1;
+	dev_t current_device = 0;
+	int one_filesystem = 1;
 	struct stat buf;
 
 	/*
-- 
1.7.2.rc2.11.g03e33
