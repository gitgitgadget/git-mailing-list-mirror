From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 1/3] grep: Put calls to fixmatch() and regmatch() into patmatch()
Date: Tue,  3 May 2011 23:35:55 +0200
Message-ID: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:36:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHNGO-0000hO-1N
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 23:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab1ECVgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 17:36:06 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42506 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab1ECVgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 17:36:05 -0400
Received: by wwk4 with SMTP id 4so3721134wwk.1
        for <git@vger.kernel.org>; Tue, 03 May 2011 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ja9xzzdAQ089uWhwJEkw5L1vZrSTn3/PW65TQiNl2Hc=;
        b=RvY5zJra1W6VUbZThTKZSl+JrTDBX/hdf46eAu7Bwwva9d8opFRwUk7MvCPQJyU6FV
         dahasEZSVlIi6rvdDaBBtXuj5bq8QwAoCKZX9G3XFnz++Z6kqwVzQ497s5I4kdOGpLUB
         yrwT2nmt/oGAyhmTMeKB0ZF0mlnJl+f8WPdiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hAfjhB1Y++vpKWHJrdXTZrTPnCACc0WVrKIoozIjNysMAPcWwGp19Q8aqgvMfpa/QU
         5zCJRLdZJY1dWQoSUSeiiHIhiYh69WZiMw5r2hzytyL8ii/nffpk5J0ql6YjB8tkxcqr
         AZoZmZ+DlrOAaa/EDMFBmH1xDsYm6SmGUUC94=
Received: by 10.227.175.134 with SMTP id ba6mr329295wbb.81.1304458563487;
        Tue, 03 May 2011 14:36:03 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id ed10sm305109wbb.49.2011.05.03.14.36.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 14:36:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172695>

---
 grep.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 63c4280..d67baf9 100644
--- a/grep.c
+++ b/grep.c
@@ -412,6 +412,19 @@ static int regmatch(const regex_t *preg, char *line, char *eol,
 	return regexec(preg, line, 1, match, eflags);
 }
 
+static int patmatch(struct grep_pat *p, char *line, char *eol,
+		    regmatch_t *match, int eflags)
+{
+	int hit;
+
+	if (p->fixed)
+		hit = !fixmatch(p, line, eol, match);
+	else
+		hit = !regmatch(&p->regexp, line, eol, match, eflags);
+
+	return hit;
+}
+
 static int strip_timestamp(char *bol, char **eol_p)
 {
 	char *eol = *eol_p;
@@ -461,10 +474,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	}
 
  again:
-	if (p->fixed)
-		hit = !fixmatch(p, bol, eol, pmatch);
-	else
-		hit = !regmatch(&p->regexp, bol, eol, pmatch, eflags);
+	hit = patmatch(p, bol, eol, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -791,10 +801,7 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		if (p->fixed)
-			hit = !fixmatch(p, bol, bol + *left_p, &m);
-		else
-			hit = !regmatch(&p->regexp, bol, bol + *left_p, &m, 0);
+		hit = patmatch(p, bol, bol + *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
-- 
1.7.3.4
