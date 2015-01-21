From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 07/19] fsck: Make =?UTF-8?Q?fsck=5Fident=28=29=20warn-f?=
 =?UTF-8?Q?riendly?=
Date: Wed, 21 Jan 2015 20:25:09 +0100
Organization: gmx
Message-ID: <68cb5436187978ad41df09bfae325893ff0ff84d.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:25:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0u1-0002ON-Og
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbbAUTZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:25:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:58550 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbbAUTZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:25:16 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MdaiW-1YNoXx2wxw-00PJsK; Wed, 21 Jan 2015 20:25:09
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:xOk/IKTd2HYeWyk6QKd+6p/zCBGbt9olp9EEnJxpZxWE/p/VaF7
 Rbc1HTYjrqA2KFanUQIeS1OMcRMHpfy19cqQYlR9y3kK5/vc2GP52Qkd2LLQIhrHa7xdeNd
 aDeEtWQ4LGnStjV6JfMp15yy232dBIKRX/27zXf5xRTNbpW3rK9bK2xOuv+jsWgpMiJYdZi
 w8lvrOeqxxLvnCA9/r4XQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262752>

When fsck_ident() identifies a problem with the ident, it should still
advance the pointer to the next line so that fsck can continue in the
case of a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 09f69fe..16500e3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -453,40 +453,45 @@ static int require_end_of_header(const void *data, unsigned long size,
 
 static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
 {
+	const char *p = *ident;
 	char *end;
 
-	if (**ident == '<')
+	*ident = strchrnul(*ident, '\n');
+	if (**ident == '\n')
+		(*ident)++;
+
+	if (*p == '<')
 		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	*ident += strcspn(*ident, "<>\n");
-	if (**ident == '>')
+	p += strcspn(p, "<>\n");
+	if (*p == '>')
 		return report(options, obj, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
-	if (**ident != '<')
+	if (*p != '<')
 		return report(options, obj, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
-	if ((*ident)[-1] != ' ')
+	if (p[-1] != ' ')
 		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	(*ident)++;
-	*ident += strcspn(*ident, "<>\n");
-	if (**ident != '>')
+	p++;
+	p += strcspn(p, "<>\n");
+	if (*p != '>')
 		return report(options, obj, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
-	(*ident)++;
-	if (**ident != ' ')
+	p++;
+	if (*p != ' ')
 		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
-	(*ident)++;
-	if (**ident == '0' && (*ident)[1] != ' ')
+	p++;
+	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(strtoul(*ident, &end, 10)))
+	if (date_overflows(strtoul(p, &end, 10)))
 		return report(options, obj, FSCK_MSG_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
-	if (end == *ident || *end != ' ')
+	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
-	*ident = end + 1;
-	if ((**ident != '+' && **ident != '-') ||
-	    !isdigit((*ident)[1]) ||
-	    !isdigit((*ident)[2]) ||
-	    !isdigit((*ident)[3]) ||
-	    !isdigit((*ident)[4]) ||
-	    ((*ident)[5] != '\n'))
+	p = end + 1;
+	if ((*p != '+' && *p != '-') ||
+	    !isdigit(p[1]) ||
+	    !isdigit(p[2]) ||
+	    !isdigit(p[3]) ||
+	    !isdigit(p[4]) ||
+	    (p[5] != '\n'))
 		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
-	(*ident) += 6;
+	p += 6;
 	return 0;
 }
 
-- 
2.2.0.33.gc18b867
