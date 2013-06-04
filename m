From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/15] quote: remove sq_quote_print()
Date: Tue,  4 Jun 2013 18:05:26 +0530
Message-ID: <1370349337-20938-5-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRF-0006cZ-NR
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab3FDMeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:05 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:63312 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab3FDMeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:01 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so174009pbb.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qUo9cC0nXuoPQsJp/xmsdllFtLvax60pJ1KACh3kPCc=;
        b=lKZc3NrCb3iIe8pAs0SzC42RwDwJmhbFIzXJDd4SyfK4UWh2MxjLESw6K3w1gD3BJZ
         7y5C5KLIeIxytYLE82zN/Tesc8DYOw6p9FO1oaE33oTtKJP5nhaa+piXVzmLjbVoSdaf
         dmBtx2LD2456gRiQfgPX9hSEtPQk5StTzq61nEhF7sgglQEl1fVc8tpmDCoAGWq1xZ0v
         1FPT4ymiUuypXnMzShq3ns3/sa3rE4WILIbJOXqgtCxg/8JvhETXqhdV/oIgJBIlOQ9G
         zJYypMehBPgL3wTrV9nplxGbiOfGVxY2PDOmtox+Y/jgxkJ7gzeLzYsuOtlSEhj1Y/Vs
         i+rQ==
X-Received: by 10.66.192.226 with SMTP id hj2mr28774812pac.37.1370349241037;
        Tue, 04 Jun 2013 05:34:01 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.33.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226347>

Remove sq_quote_print() since it has no callers.  A nicer alternative
sq_quote_buf() exists: its callers aren't forced to print immediately.

For historical context, sq_quote_print() was first introduced in
575ba9d6 (GIT_TRACE: show which built-in/external commands are executed,
2006-06-25) for the purpose of printing argv for $GIT_TRACE.  Today, we
achieve this using trace_argv_printf() -> sq_quote_argv() ->
sq_quote_buf(), which ultimately fills in a strbuf.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 quote.c | 17 -----------------
 quote.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/quote.c b/quote.c
index 8c294df..778b39a 100644
--- a/quote.c
+++ b/quote.c
@@ -42,23 +42,6 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
-void sq_quote_print(FILE *stream, const char *src)
-{
-	char c;
-
-	fputc('\'', stream);
-	while ((c = *src++)) {
-		if (need_bs_quote(c)) {
-			fputs("'\\", stream);
-			fputc(c, stream);
-			fputc('\'', stream);
-		} else {
-			fputc(c, stream);
-		}
-	}
-	fputc('\'', stream);
-}
-
 void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 {
 	int i;
diff --git a/quote.h b/quote.h
index ed06df5..251f3cc 100644
--- a/quote.h
+++ b/quote.h
@@ -27,8 +27,6 @@ struct strbuf;
  * excluding the final null regardless of the buffer size.
  */
 
-extern void sq_quote_print(FILE *stream, const char *src);
-
 extern void sq_quote_buf(struct strbuf *, const char *src);
 extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
 
-- 
1.8.3.GIT
