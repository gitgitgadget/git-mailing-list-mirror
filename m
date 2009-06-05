From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 14/23] http: create function end_url_with_slash
Date: Sat, 6 Jun 2009 00:04:56 +0800
Message-ID: <20090606000456.70a24b3c.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzI-00053w-86
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZFEQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbZFEQJA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbZFEQI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:59 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=aRDsInRzA4aSqpU2Eb6KwriKBXgz9NymwxPt4DotNa8=;
        b=ZrcwF+snYFSQvqtMS4+cBDvYxFh9r1LG63FGq+2mnsBxX67NzoyxXuBwXJPSrInJS3
         bKEbtuOo0Qfn2ymjh6S3dQgQR+zQqUEu7nlGdz30Ww1hPEUcyMoHR86HebQcgh1QhH2E
         oBgX/kGLmKM00Xpbo49obqrqQt5xIZwlUCoic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HmSLswR6eCHVoI+JzQ1DSOrhfEX46AIge4kwWPmnEHqwJCikSeBOYHiqPnq5egsAjc
         Y5jPlL83wW2/GzmCJtX4mSNp5jOPhiHkliy0NoWbhhQo4n4461vApMPx3iII8QPAqz9G
         hjGZJ9/aOUOKQBqAS2qQQSB/dq2uLWZiTf2hI=
Received: by 10.142.222.19 with SMTP id u19mr1324451wfg.23.1244218142375;
        Fri, 05 Jun 2009 09:09:02 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm436007wfd.23.2009.06.05.09.09.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:02 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120797>

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
