From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] http: use strbuf API in quote_ref_url
Date: Sun, 08 Mar 2009 00:47:21 +0800
Message-ID: <49B2A519.8050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 17:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfzic-0002BD-30
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 17:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbZCGQra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 11:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZCGQra
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 11:47:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:36374 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbZCGQr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 11:47:29 -0500
Received: by ti-out-0910.google.com with SMTP id d10so583392tib.23
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 08:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=PCMANpWO9J6kFyonhpXu0ERQjctnIgN8aCtDH6De2w4=;
        b=XiBjjOrzEXbvTn61aq/wfLrIErEVHzloOVb1EXr0TZabtU/AOfSNS79kkfeYq6UIPW
         K3hEiFRWQsS0FOrxavNMt2UlYgjSKgWzRhlaifeYmg3NLSfm4YBCZCyYeohQ/kLJ/eVm
         4XPJ2feO7FVc11NXhmY1LnhY/8hNzeKCUsziM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=kINnoUJI96IkP67UhenV97ZlrdlQO4+OUO8oT2oHxKEW3JW1POGdNqpKq3Awd8p4bM
         XxivHOpgRGPPBzIneTQ+002rk1YmQ2U97IN7RyAdBh0O0LgzDYJuV/y4bFl92lPKnXLI
         iMpOAgLX8CWTOxJhP7PdBN5/47EHnPjkwE8Kc=
Received: by 10.110.7.18 with SMTP id 18mr5714366tig.46.1236444446125;
        Sat, 07 Mar 2009 08:47:26 -0800 (PST)
Received: from ?116.87.148.213? ([116.87.148.213])
        by mx.google.com with ESMTPS id b7sm1458761tic.15.2009.03.07.08.47.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 08:47:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112549>

In addition, ''quote_ref_url'' inserts a slash between the base URL and
remote ref path only if needed. Previously, this insertion wasn't
contingent on the lack of a separating slash.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Differences from v1:
 *use buf when checking for '/'
 *remove for's braces

 http.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/http.c b/http.c
index cdedeb6..1691498 100644
--- a/http.c
+++ b/http.c
@@ -577,31 +577,21 @@ static inline int hex(int v)

 static char *quote_ref_url(const char *base, const char *ref)
 {
+	struct strbuf buf = STRBUF_INIT;
 	const char *cp;
-	char *dp, *qref;
-	int len, baselen, ch;
+	int ch;

-	baselen = strlen(base);
-	len = baselen + 2; /* '/' after base and terminating NUL */
-	for (cp = ref; (ch = *cp) != 0; cp++, len++)
+	strbuf_addstr(&buf, base);
+	if (buf.len && buf.buf[buf.len - 1] != '/' && *ref != '/')
+		strbuf_addstr(&buf, "/");
+
+	for (cp = ref; (ch = *cp) != 0; cp++)
 		if (needs_quote(ch))
-			len += 2; /* extra two hex plus replacement % */
-	qref = xmalloc(len);
-	memcpy(qref, base, baselen);
-	dp = qref + baselen;
-	*(dp++) = '/';
-	for (cp = ref; (ch = *cp) != 0; cp++) {
-		if (needs_quote(ch)) {
-			*dp++ = '%';
-			*dp++ = hex((ch >> 4) & 0xF);
-			*dp++ = hex(ch & 0xF);
-		}
+			strbuf_addf(&buf, "%%%02x", ch);
 		else
-			*dp++ = ch;
-	}
-	*dp = 0;
+			strbuf_addch(&buf, *cp);

-	return qref;
+	return strbuf_detach(&buf, NULL);
 }

 int http_fetch_ref(const char *base, struct ref *ref)
-- 
1.6.2.rc1
