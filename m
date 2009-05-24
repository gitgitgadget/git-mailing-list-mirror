From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 09/18] http: create function end_url_with_slash
Date: Sun, 24 May 2009 22:19:52 +0800
Message-ID: <20090524221952.2f733074.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eao-0005ol-R8
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZEXOWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbZEXOWC
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:02 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZEXOWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:01 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=aRDsInRzA4aSqpU2Eb6KwriKBXgz9NymwxPt4DotNa8=;
        b=II/hGrND7OXKnS3UY8RZpMBfaPV9UrRIhFYfE0VWPc9Ns0WE9Jk1wc7gPjWQSyTWLQ
         djIQ/7ziluimEp3DVm63Iej4x1eX13SsFIc40LcmJVpe32pZhF9pLMUSeZUpREoCxqTK
         q1WZiuMtB1jpR1AD3tdIVs6Oip2Rgk4W0MKZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=I7j739EsqpECMvI32qyPIdk9bNvbtb1eXGVgXZHQrGZAc4ES/UjdATlaCw2dm83bps
         JL0eIs1zrC5iyhx1hI/rln8SkXMU4NnG/O0SZm8w69S1/zJ4cB9LBjoVr2PuH3Hx5deS
         JKRoNN8UUbSGnUnsrkrmUWukUEddodJ7Q6wVU=
Received: by 10.114.159.17 with SMTP id h17mr12498347wae.124.1243174923754;
        Sun, 24 May 2009 07:22:03 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id m31sm6835252wag.66.2009.05.24.07.22.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:03 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119822>

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
1.6.3.1
