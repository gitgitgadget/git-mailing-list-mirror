From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 07/19] fsck: Make =?UTF-8?Q?fsck=5Fident=28=29=20warn-f?=
 =?UTF-8?Q?riendly?=
Date: Fri, 19 Jun 2015 15:33:50 +0200
Organization: gmx
Message-ID: <3e2deca4addda073f9b80e47865d2a5c95cea6e2.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wQh-0008HN-HL
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbFSNdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:33:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:50290 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752405AbbFSNdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:33:54 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0McEkx-1ZNKzB3C0l-00JalJ; Fri, 19 Jun 2015 15:33:50
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:+PRnBaV2kWFV0yAucp10VHz2eM4mDAvoQYlYeu0z8W7N5nlHgel
 yxE7C27VJN2MdNnlJB/4YVimJhJpD2q9crNosAikH0oZKW7GA3zWuUvLrFoz6ayLkUzAONc
 V6hYluVgscjH3HBZSXNlpG1p92J+rtV3UULB2TdiNpQ4zls4YVPBoaVrB8AY64BtcYVblxn
 +qT34Hv6b+g0TFYtZWXhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kuMMOlfD41o=:sg8gF5ZWe3jse1PkVCM/YK
 Rnz8SPuTfatyR/0R/H7hpmyRmuAzQWcbN3op2eyKqj/sv0H6PnWIHIOJiKMTMul0friUB/9cH
 Sb6GKQl5sDCeK/10t0sdToNK6tD5gq7vn2JTV1GO/czyaSOdXATZf/FoDdSmeeNz37ajDDYAB
 400DeRqnO6B0nTmFsGuObWXGOhVM97Pj3sueUwntRPcDYFYOMEFtUK1KEJ06LGYaDjgx9gyL2
 +GoRr2v/sXBQCoBNIW7bMKra8QjIxpzAXlhPKhd/9yajJN5YeTvjwFtAmIhjAIE3+W5FVBEFZ
 46YPtemW4VpgSC1LxFRZ7Y42FKstNChzUe2f5Awdx+u9LRDX3tizWq7t1r9Fsr7NRYfVN4oBj
 aMIilBmRsXvZl0Eb5c/LJZ2IHZw9P/XTAWQXhHmgVGonRqfhjwYWqsjCgqgegRkXue8IWSz9k
 nOU1tlQZuWY+v/iDWSU6Nkp0g1zb3yPcHjOziN618KLmwH/diI9yZvrwdsnpOa8KSgv80YMpR
 lg1UKlQgk6SLWnQrm5Lp4gOfP8Aj51QjdJfwAvzdOzP3i5TU/wNK0Rz5ej3J2UHRTjkdRjMJO
 6++2ajAe9vPqaxleG1UBkyPrD+mllh3ksATvAsmRTroBrSk92ED5ScSpQGYXJAOub4MQ+gAkq
 5o4OBkqi2FMV7plEkBTYA7pKM6vW1AmZnaqn5UzWxycGalMjyu46CfPlXYSbCKXKY6zk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272143>

When fsck_ident() identifies a problem with the ident, it should still
advance the pointer to the next line so that fsck can continue in the
case of a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0b3e18f..9faaf53 100644
--- a/fsck.c
+++ b/fsck.c
@@ -479,40 +479,45 @@ static int require_end_of_header(const void *data, unsigned long size,
 
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
 		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
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
2.3.1.windows.1.9.g8c01ab4
