From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 07/19] fsck: Make =?UTF-8?Q?fsck=5Fident=28=29=20warn-f?=
 =?UTF-8?Q?riendly?=
Date: Thu, 18 Jun 2015 22:08:33 +0200
Organization: gmx
Message-ID: <07d15d7aace24adf61afe9041d07905e9c141ff8.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:08:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g76-0002kH-RC
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbbFRUIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:08:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:65360 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621AbbFRUIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:08:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LguAU-1YkLfY0mjG-00oGgW; Thu, 18 Jun 2015 22:08:34
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:4of0SitzljmqDCgHxhHGkH8ITBSjVRCT2b/KbHrFH68UEtUhlpe
 m/+9i9kXk58lwIqRyOUIY9UwulAaKSRkHlQIJm5mJIUPVcpMU/rj3HUs25IjuphFGW+88K4
 KNYjunF3ErsEwvFFl5Fw/o9aEinMO+FnPlgzlbhXtMiHDG4ss1enN2Mq1QY1U8+gP9jMeam
 z4uXVt2mcs4IvaYBwiFRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rb+/AgRuem8=:k47xyTiodIWssOqwDT4J7a
 OADvKOVwGzHrlK+kcuaqDBE1WI020PsSjupTwc31i+0a6oaJAiDEAXhnmPKZuN+eJt/nv5uZM
 YE/dt0rqL8eIWY+qVOuCD+2k66LgZQTPibXNMuF0mkaTuoLNqZzwi0YFT5tN6Q5LN0j/mzgeK
 zDlcThCWq1c+iaOopUlrN8FJz+ZHAZC8CG1jez+A+OhgIkF12FVfsDY0yFrm9QBHI9a9ckLv1
 QdJNsylaoSs6MMtxYXgnSmdizJT9y0Vj0G2twXZFWmak2tzw5acRiJJOVV5FVffI1IDleuDhz
 hpWmf5O2yn8NNjidR29FYamIrBdWXo9gr8Tyv0gyHsjFeQrEd89H7fUZi0Fqn1D/N+5ze94hS
 HPu9JIoasX8FRhvgm90/5wxIIcqW9EaPmxm9OXzW7i2HYtHqeslBM7KC8/ifcVSmOYD/fjqxG
 xqKhrZG3wl8H1V3LqnmnBu6g/9hQnZi0ri5/b1RgSIrKM4H/9jx+boh2cjls23A1P8ose3K+g
 7MNZGaeJ2CJyhJMgC8rbns5N1F6DnumVRfEfV8gkQ6UblgELKEaq5xFbvnSkrdqrATWPzYldl
 5zlpzGZGuuNJrbHs6yyWWLqnbcDO8ZeO/MzdlSZwpKQuArAC0NVUKIYwZhOlbPxBWPo4DUqed
 wGxqfNjzmzIqFuAn3jRuOXCqeHfhgmc4jgzcywGXg5Zgwj3M+XAe7ZEjMVY+rl1rxGs8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272049>

When fsck_ident() identifies a problem with the ident, it should still
advance the pointer to the next line so that fsck can continue in the
case of a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 47cb686..8a1eea3 100644
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
2.3.1.windows.1.9.g8c01ab4
