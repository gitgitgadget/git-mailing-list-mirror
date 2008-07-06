From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] branch -v: Prevent garbage output on remote refs
Date: Sun,  6 Jul 2008 05:24:39 -0400
Message-ID: <1215336279-99480-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 11:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFQW7-00060f-LH
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 11:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYGFJYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbYGFJYq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 05:24:46 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54594 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbYGFJYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 05:24:45 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id C287C1FFC021;
	Sun,  6 Jul 2008 09:24:41 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.337.gf6537
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87508>

The stat string was only initialized if the ref was local, but was
always used in a printf.  This meant that whatever data was on the
stack got printed.  In the case of "branch -av", this was probably the
tracking information of the last local branch.  If the case of "branch
-rv", this was "@???" in my case.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 After looking through the second get of changes I pulled, I tried this:

 $ git branch -av
 * master                 3195299 [ahead 1] Make rebase save ORIG_HEAD if changing current branch
   origin/HEAD            08b51f5 [ahead 1] Merge branch 'qq/maint'
   origin/gitk-for-paulus 7d8856d [ahead 1] gitk: Update German translation.

 Huh. That doesn't look right...  Let's try just showing the remotes:

 $ git branch -rv
   origin/HEAD            08b51f5 @???Merge branch 'qq/maint'
   origin/gitk-for-paulus 7d8856d @???gitk: Update German translation.

 That's definately not good.

 I guess that other people either have a compiler that is more careful about
 clearing stack variables, or don't use "branch -v".

 builtin-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index e9423d1..470c59f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -327,7 +327,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	if (verbose) {
 		struct strbuf subject;
 		const char *sub = " **** invalid ref ****";
-		char stat[128];
+		char stat[128] = "";
 
 		strbuf_init(&subject, 0);
 
-- 
1.5.6.2.336.g3195
