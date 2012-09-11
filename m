From: David Gould <david@optimisefitness.com>
Subject: [PATCHv2] fix broken list iteration in clear_child_for_cleanup
Date: Tue, 11 Sep 2012 21:22:45 +0100
Message-ID: <1347394965-29906-1-git-send-email-david@optimisefitness.com>
References: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Cc: David Gould <david@optimisefitness.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 11 22:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBX01-0005pr-4k
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 22:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab2IKUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 16:23:47 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:51268
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544Ab2IKUXl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 16:23:41 -0400
X-Trace: 613329455/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ON_NET_AUTH_ACCEPTED/pipex-temporary-group/88.108.247.46/None/david@optimisefitness.com
X-SBRS: None
X-RemoteIP: 88.108.247.46
X-IP-MAIL-FROM: david@optimisefitness.com
X-SMTP-AUTH: 
X-Originating-Country: GB/UNITED KINGDOM
X-MUA: git-send-email 1.7.12.290.g62cd8d4
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIKdT1BYbPcu/2dsb2JhbABFu1aBCIIhAQUnLyMQCEk5HgcSiBS8JJE2A5srg2eGaoJn
X-IronPort-AV: E=Sophos;i="4.80,407,1344207600"; 
   d="scan'208";a="613329455"
X-IP-Direction: IN
Received: from 88-108-247-46.dynamic.dsl.as9105.com (HELO ephebe) ([88.108.247.46])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Sep 2012 21:23:12 +0100
Received: from pseudopolis.thedysk (pseudopolis [192.168.100.9])
	by ephebe (Postfix) with ESMTP id 23B5680314;
	Tue, 11 Sep 2012 21:22:57 +0100 (BST)
X-Mailer: git-send-email 1.7.12.290.g62cd8d4
In-Reply-To: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205264>

We iterate through the list of children to cleanup, but do not keep
our "last" pointer up to date. As a result, we may end up cutting off
part of the list instead of removing a single element.

Iterate through children_to_clean using 'next' fields but with an
extra level of indirection. This allows us to update the chain when
we remove a child and saves us managing several variables around
the loop mechanism.

Signed-off-by: David Gould <david@optimisefitness.com>
Acked-by: Jeff King <peff@peff.net>
---
PATCHv2 updates PATCH only in the commit message: Peff suggested
both a helpful subject and a more-informative introduction.

 run-command.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index f9922b9..c42d63b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -53,13 +53,13 @@ static void mark_child_for_cleanup(pid_t pid)
 
 static void clear_child_for_cleanup(pid_t pid)
 {
-	struct child_to_clean **last, *p;
+	struct child_to_clean **pp;
 
-	last = &children_to_clean;
-	for (p = children_to_clean; p; p = p->next) {
-		if (p->pid == pid) {
-			*last = p->next;
-			free(p);
+	for (pp = &children_to_clean; *pp; pp = &(*pp)->next) {
+		if ((*pp)->pid == pid) {
+			struct child_to_clean *clean_me = *pp;
+			*pp = clean_me->next;
+			free(clean_me);
 			return;
 		}
 	}
-- 
1.7.9.5
