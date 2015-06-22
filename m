From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 07/19] fsck: Make =?UTF-8?Q?fsck=5Fident=28=29=20warn-f?=
 =?UTF-8?Q?riendly?=
Date: Mon, 22 Jun 2015 17:26:03 +0200
Organization: gmx
Message-ID: <f3733d12589870e1fc9a8f3fad7cb85d9a901cd1.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73c5-0006sw-Do
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbbFVP0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:63986 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbbFVP0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MKprU-1Z73bn2jtA-0006tr; Mon, 22 Jun 2015 17:26:03
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:qMYiWqnc2g7D8LcV/6J2Jgilad9adF2yFqNtI9dI3lTfNzkp9NA
 ltGumvc7nFi7CbnjQRGfXHpz4/Zzfm+Awq3JgSa2m+LRgaTAAiBNC+eNaQQuPrqpcResgju
 lErmZI/Edghg+wBhDWZjSJLV92PYpOgdP3QXOZ2RNH6MuT6F6KW+6Y3kgcj0puaEq4hUl/i
 PyMq5RbLuiLi/XRYF3qJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eJQOGBkbvqM=:l1p2Xmen8HCA96ReOScBDR
 LakvQao3cvfpvj11WXWdobco02RgQOV5k6dLusIjsd+AyhRrRfB4yaPIbwyzth1XSGGDqaQlp
 gzxas+8M0EfrEJhwlnLWVOmUFptHmzMd6J3LS2k2GHNLGVU95tbEcPT/7fyZ2dpU0Pb1wnXgT
 /7DMuIkDXyRi0b0EZQ872hDd8b3D7uD61FM0mOMjJ0eOSjfLlVZ1dXdP1MAQETEQDwdozZu0k
 aZWl9UaqF1umPl7t9kd5CBGiZQ0N8dFxPKeW72h/ZKxHqWpsUz/Me1sDsr3BK2oBk2DRRJS1j
 bA0elhzIG9Fk8wrI9Gz6tSB8ASO7dZ519ZmYRWxA5YJoirLzajN4C1HUUtA6qcjPJIdW6qUHl
 jmYIjlPn0Woajr+K90C8eT0lbpTO/SNjeIsXZahEBToMYzlauc8xKnapURvG0nHYKRqfcsm5y
 j/P2SnmA/0PxaVkq43hl6iYn/tR2ayD3Ql7CJj+/mx2y1emyp2RQppE24kwk0HfcCAI+Jvna2
 aBjAkOFuANYIhZr2UN/2zJqHEF+yLLijFbHqS4AaoNaRA/K5Eia4yzcoMVXu2VQqQcEShU560
 hJF/g8jl376ap+7Is2I7c2bOtF25hqGLkwVCu07/aStfvOdMsr5WHafMoItTFrAnIE72GdYq2
 Pr9g8jvjvyWPV9IqX3rC9dvmOtqAjWgtv1rUqnd0yC2kJJ9mBjlCZ3f9bgLFhPXHEj98=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272377>

When fsck_ident() identifies a problem with the ident, it should still
advance the pointer to the next line so that fsck can continue in the
case of a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0ec02b2..d0a7282 100644
--- a/fsck.c
+++ b/fsck.c
@@ -481,40 +481,45 @@ static int require_end_of_header(const void *data, unsigned long size,
 
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
