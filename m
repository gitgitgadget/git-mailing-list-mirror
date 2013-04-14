From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 31/33] pack_one_ref(): do some cheap tests before a more expensive one
Date: Sun, 14 Apr 2013 14:54:46 +0200
Message-ID: <1365944088-10588-32-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMav-0005Av-DX
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab3DNNDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:03:41 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:48981 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751597Ab3DNNDl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 09:03:41 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2013 09:03:41 EDT
X-AuditID: 12074412-b7f216d0000008d4-4d-516aa7656c98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B2.CD.02260.567AA615; Sun, 14 Apr 2013 08:56:05 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkS007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:56:04 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqJu6PCvQYOZmDYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M64fG8Ca8EMzoqHSzkbGLexdzFyckgImEjM/P4XyhaTuHBvPVsXIxeHkMBlRomT7Ueh
	nLNMEm8ff2cDqWIT0JVY1NPM1MXIwSEikC2xe608SJhZwEFi8+dGRhBbWCBMYt230ywgNouA
	qsT3fy/AbF4BV4lFP04xQSxTkDi+fRtYPSdQfPrzY2BHCAm4SMzaPJt1AiPvAkaGVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghASW0g3H9SblDjAIcjEo8vC8YswKFWBPL
	iitzDzFKcjApifIqLgMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF1bAXK8aYkVlalFuXDpKQ5
	WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8L5eCtQoWJSanlqRlplTgpBm4uAEEVwgG3iA
	NrwFKeQtLkjMLc5Mhyg6xagoJc77ESQhAJLIKM2DGwCL/VeM4kD/CPM+BaniAaYNuO5XQIOZ
	gAb77E0HGVySiJCSamA8+GPn8q9ff1utN21fmmUyM/zudTczz7uHj+3sz5891yZsqXZWaO7n
	1U9vnJ+rFrtGUaVcdu40Za1o1hZr857NzOs9NY4vSi1bVXhW5MFWe6uHmg8byrJjNOL1bs9Z
	6bZ+8idNln6Ds5OuRiav2zPpzD/vx3wsDhGsXo1vs1+9npT8+gajQPkmJZbijERD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221134>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 923d34f..361a28f 100644
--- a/refs.c
+++ b/refs.c
@@ -2005,16 +2005,15 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	enum peel_status peel_status;
-	int is_tag_ref;
+	int is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
-	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry, 0))
+	/* ALWAYS pack refs that were already packed or are tags */
+	if (!((cb->flags & PACK_REFS_ALL) || is_tag_ref ||
+	      (entry->flag & REF_ISPACKED)))
 		return 0;
-	is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
-	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref &&
-	    !(entry->flag & REF_ISPACKED))
+	/* Do not pack symbolic or broken refs: */
+	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry, 0))
 		return 0;
 
 	peel_status = peel_entry(entry, 1);
-- 
1.8.2.1
