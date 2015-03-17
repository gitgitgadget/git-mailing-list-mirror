From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/14] opt_arg(): simplify pointer handling
Date: Tue, 17 Mar 2015 17:00:14 +0100
Message-ID: <1426608016-2978-13-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvV-0001I3-3b
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbbCQQA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58121 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932501AbbCQQAg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:36 -0400
X-AuditID: 1207440c-f79376d00000680a-29-55084fa4c6b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E4.2F.26634.4AF48055; Tue, 17 Mar 2015 12:00:36 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSn023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:35 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqLvEnyPUoG+xlEXXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6Mlvnv2Atm
	clRsX32XtYFxFlsXIyeHhICJxMLlL9ghbDGJC/fWA8W5OIQELjNKPP4wmQXCOckkcfXDXyaQ
	KjYBXYlFPc1gtoiAmsTEtkMsIDazQIpE5587YJOEBawlps6eDbaBRUBV4v6Zt4wgNq+Ai0T7
	phPMENvkJM4f/wlmcwLFX/x5DVYjJOAssXbaZLYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn
	5uWlFuka6uVmluilppRuYoSED88Oxm/rZA4xCnAwKvHw3ihgDxViTSwrrsw9xCjJwaQkypvn
	wREqxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3jjtQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9
	sSQ1OzW1ILUIJivDwaEkwbvcD6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb
	8cXA6ABJ8QDtrQBp5y0uSMwFikK0nmJUlBLnnQ+SEABJZJTmwY2FJYVXjOJAXwrzKoNU8QAT
	Clz3K6DBTECDW9rZQAaXJCKkpBoYOyMPKUstfG78UZgpWk7+lfy0QOv2c4/freRtKtyy79k6
	3+W3956zuLlJYHVuz8bbKyu2f99Y+Irxbcn5/hVfubuNi2UNPseofjlmdeJXjVqX5AvNs1OT
	5sQvk55aLb1rzkq70PRdJtsKa+XTxewvfk7fWS1ktKJ/tbuKP/eh/poPX/PdiiqT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265639>

Increment "arg" when a character is consumed, not just before consuming
the next character.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 03cdabf..bc1e3c3 100644
--- a/diff.c
+++ b/diff.c
@@ -3358,14 +3358,13 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	char c, *eq;
 	int len;
 
-	if (*arg != '-')
+	if (*arg++ != '-')
 		return 0;
-	c = *++arg;
+	c = *arg++;
 	if (!c)
 		return 0;
 	if (c == arg_short) {
-		c = *++arg;
-		if (!c)
+		if (!*arg)
 			return 1; /* optional argument was missing */
 		if (convert_i(arg, 10, val))
 			die("The value for -%c must be a non-negative integer", arg_short);
@@ -3373,7 +3372,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	}
 	if (c != '-')
 		return 0;
-	arg++;
 	eq = strchrnul(arg, '=');
 	len = eq - arg;
 	if (!len || strncmp(arg, arg_long, len))
-- 
2.1.4
