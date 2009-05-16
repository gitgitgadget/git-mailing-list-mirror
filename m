From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 07/11] http: create function end_url_with_slash
Date: Sat, 16 May 2009 11:51:49 +0800
Message-ID: <20090516115149.a369c14a.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0U-0005js-Ia
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZEPDzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbZEPDzi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:38 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61221 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbZEPDzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:36 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1344167pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=HVfMELKWljTtyA/hU1Ot1EobBPuDHHfmUn2jTT0WkwY=;
        b=gghZst0U5x16c+Qv8geDroErLL2KyxdjTDVwJ9VtwwvafksFTrkVvyp425BRBq7+Ej
         vbvJFWSta0XFOqJgOSTTMnWS3U+sdjHg138tyelVgAcBg26a5gMKzX7pJ335xd2VznuU
         dopkZ/MheiwZXpvX73NDmE1Nj2hjSIMaKzNDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Zrh/xsq/6xlBfdTtr7pTluGAwH881L5cihYZDmdn2Zff7+tW+Ag46pLkbGlbYh+h5P
         58SZVuXNA7A+ETb4CnDaURG2jBsUQL7erkDdnYF6qmn0m6+hczVgU2a3/Bh9NPKRSd1g
         O2LIlEKVLKXhmBeTkYCiwY4NtXcuFl+C+34N8=
Received: by 10.114.25.19 with SMTP id 19mr6277781way.89.1242446137350;
        Fri, 15 May 2009 20:55:37 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id m30sm2169601wag.53.2009.05.15.20.55.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:36 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119329>

The logic to append a slash to the url if necessary in quote_ref_url
(added in 113106e "http.c: use strbuf API in quote_ref_url") has been
moved to a new function, end_url_with_slash.

The method takes a strbuf, the URL, and the path to be appended to the
URL. It first adds the URL to the strbuf. It then appends a slash
if the URL does not end with a slash.

The check on ref in quote_ref_url for a slash at the beginning has been
removed as a result of using end_url_with_slash. This check is not
needed, because slashes will be quoted anyway.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 3ca60bb..75fce9e 100644
--- a/http.c
+++ b/http.c
@@ -620,6 +620,7 @@ void finish_all_active_slots(void)
 		}
 }
 
+/* Helpers for modifying and creating URLs */
 static inline int needs_quote(int ch)
 {
 	if (((ch >= 'A') && (ch <= 'Z'))
@@ -640,15 +641,20 @@ static inline int hex(int v)
 		return 'A' + v - 10;
 }
 
+static void end_url_with_slash(struct strbuf *buf, const char *url)
+{
+	strbuf_addstr(buf, url);
+	if (buf->len && buf->buf[buf->len - 1] != '/')
+		strbuf_addstr(buf, "/");
+}
+
 static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp;
 	int ch;
 
-	strbuf_addstr(&buf, base);
-	if (buf.len && buf.buf[buf.len - 1] != '/' && *ref != '/')
-		strbuf_addstr(&buf, "/");
+	end_url_with_slash(&buf, base);
 
 	for (cp = ref; (ch = *cp) != 0; cp++)
 		if (needs_quote(ch))
-- 
1.6.3.rc0
