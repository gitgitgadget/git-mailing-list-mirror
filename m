From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Fix incorrect diff of a link -> file change if core.filemode = false.
Date: Sat, 17 Feb 2007 00:09:02 +0100
Message-ID: <200702170009.02500.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 00:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HICCW-0000se-La
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946263AbXBPXJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 18:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbXBPXJI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 18:09:08 -0500
Received: from smtp4.noc.eunet-ag.at ([193.154.160.226]:38231 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbXBPXJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 18:09:07 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id D4D21974EB
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 00:09:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 27EC84CB68
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 00:09:03 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39957>

After this sequence:

$ ln -s foo A
$ git add A
$ git commit -m link
$ rm A && echo bar > A

the working copy contains a regular file A but HEAD contains A as a link.

Normally, at this point 'git diff HEAD' displays this change as a removal
of the link followed by an addition of a new file. But in a repository where
core.filemode is false this is displayed as a modification of the link.
The reason is that the check when the cached mode is allowed to override the
file's actual mode is not strict enough.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 diff-lib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 91cd877..5fc1910 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -171,7 +171,8 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = ce_match_stat(ce, &st, 0);
 		if (changed) {
 			mode = create_ce_mode(st.st_mode);
-			if (!trust_executable_bit && S_ISREG(st.st_mode))
+			if (!trust_executable_bit &&
+			    S_ISREG(st.st_mode) && S_ISREG(ntohl(ce->ce_mode)))
 				mode = ce->ce_mode;
 			sha1 = no_sha1;
 		}
-- 
1.5.0.19.gddff
