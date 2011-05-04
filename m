From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH V2 3/5] grep: Put calls to fixmatch() and regmatch() into patmatch()
Date: Thu,  5 May 2011 00:00:19 +0200
Message-ID: <1304546421-25439-4-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHk8M-0002aV-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab1EDWBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:01:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33565 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab1EDWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:01:18 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1707354wwa.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=kuDktDrvqB9rMKttNOXfswLdWFEM6okRcq70NbTYqo4=;
        b=qMex9a1mEAVjQfXSs37OyODAy9gJCO+SEibzEDZjKe6hFn5NE6kJrk1FOYMzIZZ1lB
         cAAytHazBI5Y1Tu+Q+ArY9Us9kSRuPcZtZBC/9xeludmRiCmzEwJE8gokUQO2rIM0cNs
         z4NsTtbi4w0p7+k1tcJhWgzWol1K9ufbBTahs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RuWCxBx5nAYT5GVVhQxqr8AaOrcipFqKI9ekcJilZ9cqE9oIR2GODXcdkQJa6cDpWX
         PzT5xyBiXlWlz6SNNaNg8aLe0z6WsTEaZrNYgKRYZ4n9effstZk3fB8/rGbQX30NAw5P
         8jaYjbZygW5DJBIHO62zaaFskFBuwVUGle6NY=
Received: by 10.227.200.3 with SMTP id eu3mr1693855wbb.94.1304546477362;
        Wed, 04 May 2011 15:01:17 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id ca12sm974772wbb.36.2011.05.04.15.01.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 15:01:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172775>

Both match_one_pattern() and look_ahead() use fixmatch() and regmatch()
in the same way. They really want to match a pattern againt a string,
but now they need to know if the pattern is fixed or regexp.

This change cleans this up by introducing patmatch() (from "pattern
match") and also simplifies inserting other ways of matching a string.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 grep.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 63c4280..d67baf9 100644
--- a/grep.c
+++ b/grep.c
@@ -412,6 +412,19 @@ static int regmatch(const regex_t *preg, char *lin=
e, char *eol,
 	return regexec(preg, line, 1, match, eflags);
 }
=20
+static int patmatch(struct grep_pat *p, char *line, char *eol,
+		    regmatch_t *match, int eflags)
+{
+	int hit;
+
+	if (p->fixed)
+		hit =3D !fixmatch(p, line, eol, match);
+	else
+		hit =3D !regmatch(&p->regexp, line, eol, match, eflags);
+
+	return hit;
+}
+
 static int strip_timestamp(char *bol, char **eol_p)
 {
 	char *eol =3D *eol_p;
@@ -461,10 +474,7 @@ static int match_one_pattern(struct grep_pat *p, c=
har *bol, char *eol,
 	}
=20
  again:
-	if (p->fixed)
-		hit =3D !fixmatch(p, bol, eol, pmatch);
-	else
-		hit =3D !regmatch(&p->regexp, bol, eol, pmatch, eflags);
+	hit =3D patmatch(p, bol, eol, pmatch, eflags);
=20
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -791,10 +801,7 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
=20
-		if (p->fixed)
-			hit =3D !fixmatch(p, bol, bol + *left_p, &m);
-		else
-			hit =3D !regmatch(&p->regexp, bol, bol + *left_p, &m, 0);
+		hit =3D patmatch(p, bol, bol + *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
--=20
1.7.3.4
