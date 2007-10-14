From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/6] push, send-pack: use same rules as git-rev-parse to resolve refspecs
Date: Sun, 14 Oct 2007 10:54:45 +0200
Message-ID: <11923520862307-git-send-email-prohaska@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de>
 <1192352085653-git-send-email-prohaska@zib.de>
 <11923520852991-git-send-email-prohaska@zib.de>
 <11923520853189-git-send-email-prohaska@zib.de>
 <11923520851656-git-send-email-prohaska@zib.de>
 <11923520853014-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 10:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzFy-0006qF-IJ
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbXJNIy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbXJNIyz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:54:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:58233 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbXJNIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:54:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E8skBR025878
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 10:54:46 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E8sjYx021275;
	Sun, 14 Oct 2007 10:54:46 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11923520853014-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60813>

This commit changes the rules for resolving refspecs to match the
rules for resolving refs in rev-parse. git-rev-parse uses clear rules
to resolve a short ref to its full name, which are well documented.
The rules for resolving refspecs documented in git-send-pack were
less strict and harder to understand. This commit replaces them by
the rules of git-rev-parse.

The unified rules are easier to understand and better resolve ambiguous
cases. You can now push from a repository containing several branches
ending on the same short name.

Note, this breaks existing setups. For example "master" will no longer
resolve to "origin/master".

TODO: this patch does not yet include a modified documentation of
git-send-pack. I prefer to wait for some comments first.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 remote.c              |    5 +----
 t/t5516-fetch-push.sh |   12 +++++++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 58bc019..09cb611 100644
--- a/remote.c
+++ b/remote.c
@@ -383,10 +383,7 @@ static int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (namelen < patlen ||
-		    memcmp(name + namelen - patlen, pattern, patlen))
-			continue;
-		if (namelen != patlen && name[namelen - patlen - 1] != '/')
+		if (ref_cmp_full_short(name, pattern))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 97a032e..2664060 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -175,11 +175,21 @@ test_expect_success 'push with no ambiguity (1)' '
 test_expect_success 'push with no ambiguity (2)' '
 
 	mk_test remotes/origin/master &&
-	git push testrepo master:master &&
+	git push testrepo master:origin/master &&
 	check_push_result $the_commit remotes/origin/master
 
 '
 
+test_expect_success 'push with colon-less refspec, no ambiguity' '
+
+	mk_test heads/master heads/t/master &&
+	git branch -f t/master master &&
+	git push testrepo master &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_first_commit heads/t/master
+
+'
+
 test_expect_success 'push with weak ambiguity (1)' '
 
 	mk_test heads/master remotes/origin/master &&
-- 
1.5.3.4.224.gc6b84
