From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] builtin/log.c: fix minor memory leak
Date: Thu,  7 Aug 2014 19:13:37 +0200
Message-ID: <1407431617-4156-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 07 19:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFRGA-00057U-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 19:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533AbaHGRNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 13:13:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48964 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757335AbaHGRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 13:13:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s77HDbFI023435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 19:13:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77HDdO2004019;
	Thu, 7 Aug 2014 19:13:39 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XFRFz-0001CT-4p; Thu, 07 Aug 2014 19:13:39 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Aug 2014 19:13:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77HDbFI023435
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1408036417.98432@SICVEjATJ0ybSLQBy9G9+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254980>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Valgrind confirms, one less unreachable block ;-).

 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index 4389722..e4d8122 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -857,20 +857,21 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 {
 	struct strbuf desc = STRBUF_INIT;
 	if (!branch_name || !*branch_name)
 		return;
 	read_branch_desc(&desc, branch_name);
 	if (desc.len) {
 		strbuf_addch(buf, '\n');
 		strbuf_addbuf(buf, &desc);
 		strbuf_addch(buf, '\n');
 	}
+	strbuf_release(&desc);
 }
 
 static char *find_branch_name(struct rev_info *rev)
 {
 	int i, positive = -1;
 	unsigned char branch_sha1[20];
 	const unsigned char *tip_sha1;
 	const char *ref, *v;
 	char *full_ref, *branch = NULL;
 
-- 
2.0.2.737.gfb43bde
