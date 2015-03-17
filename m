From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/14] opt_arg(): report errors parsing option values
Date: Tue, 17 Mar 2015 17:00:13 +0100
Message-ID: <1426608016-2978-12-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvV-0001I3-NJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbbCQQA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:57 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43300 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932414AbbCQQAg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:36 -0400
X-AuditID: 12074414-f797f6d000004084-55-55084fa3d960
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D8.3C.16516.3AF48055; Tue, 17 Mar 2015 12:00:35 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSm023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:34 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLvYnyPUYP4OSYuuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZH/9fZSu4
	y16xbM43xgbGP6xdjJwcEgImEm/vL2aEsMUkLtxbz9bFyMUhJHCZUaLj3HUmkISQwEkmiYk7
	ZUBsNgFdiUU9zWBxEQE1iYlth1hAbGaBFInOP3fYuxg5OIQFXCWm/DQDMVkEVCWuT8sDqeAV
	cJG4M+ceM8QqOYnzx3+C2ZxA8Rd/XjNCbHKWWDttMtsERt4FjAyrGOUSc0pzdXMTM3OKU5N1
	i5MT8/JSi3Qt9HIzS/RSU0o3MUICR2QH45GTcocYBTgYlXh4G/LYQ4VYE8uKK3MPMUpyMCmJ
	8uZ5cIQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG94w6U401JrKxKLcqHSUlzsCiJ835brO4n
	JJCeWJKanZpakFoEk5Xh4FCS4NXxA2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	B0VFfDEwLkBSPEB7P4G08xYXJOYCRSFaTzHqctyZ8n8RkxBLXn5eqpQ47xtfoCIBkKKM0jy4
	FbA08YpRHOhjYV4RYNIQ4gGmGLhJr4CWMAEtaWlnA1lSkoiQkmpgLD23yO7s0aaVS3Z/sZl1
	62NGSuKLWw+LzuQ99vFas1dYcNr6/OTp+u8fhhved+c+skPzd/9mNvYp4n+qNm96o7TzSMes
	l6V/+Jqe8DZ+luRe8EH+UEc4U//dG/E2Xi83sAW9n3rt4eVjf89o5nGLMxxMN7ZY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265644>

If an argument is there, but it can't be parsed as a non-positive
number, then die() rather than returning 0.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 77c7acb..03cdabf 100644
--- a/diff.c
+++ b/diff.c
@@ -3368,7 +3368,7 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 		if (!c)
 			return 1; /* optional argument was missing */
 		if (convert_i(arg, 10, val))
-			return 0;
+			die("The value for -%c must be a non-negative integer", arg_short);
 		return 1;
 	}
 	if (c != '-')
@@ -3381,7 +3381,7 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	if (!*eq)
 		return 1; /* '=' and optional argument were missing */
 	if (convert_i(eq + 1, 10, val))
-		return 0;
+		die("The value for --%s must be a non-negative integer", arg_long);
 	return 1;
 }
 
-- 
2.1.4
