From: David Gould <david@optimisefitness.com>
Subject: [PATCH] clear_child_for_cleanup must correctly manage children_to_clean
Date: Tue, 11 Sep 2012 15:32:47 +0100
Message-ID: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
References: <62cd8d4a1853cb6fe8fda9f534cc269c8b2e0f6c>
Cc: David Gould <david@optimisefitness.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 11 16:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBRWP-0004C7-2g
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 16:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab2IKOcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 10:32:52 -0400
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:15570
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891Ab2IKOcv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 10:32:51 -0400
X-Trace: 649803601/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$ON_NET_AUTH_ACCEPTED/pipex-temporary-group/88.108.247.46/None/david@optimisefitness.com
X-SBRS: None
X-RemoteIP: 88.108.247.46
X-IP-MAIL-FROM: david@optimisefitness.com
X-SMTP-AUTH: 
X-Originating-Country: GB/UNITED KINGDOM
X-MUA: git-send-email 1.7.12.290.g62cd8d4
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAMRKT1BYbPcu/2dsb2JhbABFu0+BCIIhAQUnLyMQCEk5HgeIJrtzkTYDmymDZ4Zqgmc
X-IronPort-AV: E=Sophos;i="4.80,405,1344207600"; 
   d="scan'208";a="649803601"
X-IP-Direction: IN
Received: from 88-108-247-46.dynamic.dsl.as9105.com (HELO ephebe) ([88.108.247.46])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Sep 2012 15:32:49 +0100
Received: from pseudopolis.thedysk (pseudopolis [192.168.100.9])
	by ephebe (Postfix) with ESMTP id 30976800EC;
	Tue, 11 Sep 2012 15:32:49 +0100 (BST)
X-Mailer: git-send-email 1.7.12.290.g62cd8d4
In-Reply-To: <62cd8d4a1853cb6fe8fda9f534cc269c8b2e0f6c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205232>

Iterate through children_to_clean using 'next' fields but with an
extra level of indirection. This allows us to update the chain when
we remove a child and saves us managing several variables around
the loop mechanism.
---
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
