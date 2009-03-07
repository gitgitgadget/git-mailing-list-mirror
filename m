From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http: use strbuf API in quote_ref_url
Date: Sat, 07 Mar 2009 23:40:04 +0800
Message-ID: <49B29554.30805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 16:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfyen-0005NB-5B
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 16:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbZCGPkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbZCGPkP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:40:15 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:31662 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZCGPkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:40:13 -0500
Received: by ti-out-0910.google.com with SMTP id d10so569043tib.23
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Sgk1QhNtNVU7WcjtbsIuNNwLf225/PpusEifC0WhHL0=;
        b=wXtPAlVl7PjnugKDM+/WHMQJlc3P1Qh938EtGgzo1huQoflk0K0wV3o36wYYAygjbc
         KV3mdrATQ58i+/wDRehhZ94i/dE67F2dR5PFncOHpE/eVRwlQpGEEcbD9foVTrYVMqOQ
         jMq8m81eYiwzBFWdX3u1D1ACRL3mY+RpOT38I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=OXAbQ4yhNM69j0fOv5LEW6IN3gIuFUWlfhcHAdBuOcDUmUcK5nJFJxmOp0113fYrIl
         aT7LJDrJxTn6GLnsnVSm+BTbwNolMX6VV4d3ipaiszCg9fVG4QcujTz4NBaQMby2QkAi
         gUe72SvMZfBaOrsZzWducZnsUjDYR4wIPEdJQ=
Received: by 10.110.86.3 with SMTP id j3mr5605604tib.51.1236440410202;
        Sat, 07 Mar 2009 07:40:10 -0800 (PST)
Received: from ?116.87.148.213? ([116.87.148.213])
        by mx.google.com with ESMTPS id u8sm700445tia.30.2009.03.07.07.40.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 07:40:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112542>

In addition, ''quote_ref_url'' inserts a slash between the base URL and
remote ref path only if needed. Previously, this insertion wasn't
contingent on the lack of a separating slash.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/http.c b/http.c
index cdedeb6..9de4130 100644
--- a/http.c
+++ b/http.c
@@ -577,31 +577,22 @@ static inline int hex(int v)

 static char *quote_ref_url(const char *base, const char *ref)
 {
+	struct strbuf buf = STRBUF_INIT;
 	const char *cp;
-	char *dp, *qref;
-	int len, baselen, ch;
+	int ch;
+
+	strbuf_addstr(&buf, base);
+	if (strcmp(base+strlen(base)-1, "/") && strcmp(ref, "/"))
+		strbuf_addstr(&buf, "/");

-	baselen = strlen(base);
-	len = baselen + 2; /* '/' after base and terminating NUL */
-	for (cp = ref; (ch = *cp) != 0; cp++, len++)
-		if (needs_quote(ch))
-			len += 2; /* extra two hex plus replacement % */
-	qref = xmalloc(len);
-	memcpy(qref, base, baselen);
-	dp = qref + baselen;
-	*(dp++) = '/';
 	for (cp = ref; (ch = *cp) != 0; cp++) {
-		if (needs_quote(ch)) {
-			*dp++ = '%';
-			*dp++ = hex((ch >> 4) & 0xF);
-			*dp++ = hex(ch & 0xF);
-		}
+		if (needs_quote(ch))
+			strbuf_addf(&buf, "%%%02x", ch);
 		else
-			*dp++ = ch;
+			strbuf_addch(&buf, *cp);
 	}
-	*dp = 0;

-	return qref;
+	return strbuf_detach(&buf, NULL);
 }

 int http_fetch_ref(const char *base, struct ref *ref)
-- 
1.6.2.rc1
