From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v4] http: fix charset detection of extract_content_type()
Date: Wed, 18 Jun 2014 07:11:53 +0900
Message-ID: <1403043113-12579-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:12:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx1c6-0004ZO-VA
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 00:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbaFQWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 18:12:12 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48401 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965329AbaFQWMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 18:12:09 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so3167302pbc.6
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vqQZth3ZPa9s8TzKhMD8FT2jr/tgl7lk2UR2AcsY1fo=;
        b=bnAA1gdnKpoGCSgTEWB+NhMpi719GiLOLyaXPH5oN2vdbo67ghIF5+t8J2+ShYslDa
         3JGTZ+AhV+tGiYYFvkinKmRvE4IYTr5yGlL5L4NW71A5PR69DzQV39EIAlDZ4vmp3J9a
         8rElzsM8KtugAEY+JjjuhOMM6BV9i8fNDaHNfCCGrii2UPLqilqv4pBixU7NqYOIzUPt
         88/FIz+/28HlpMRVEslVdWVPGTFV4KyqsYf6EisltzpmDJVEeLcL1DoSU59TO6PhaTnZ
         CA5yO1R0wIacidgN7Ev6Rmyz4ynTJdG3RlRskkKYSFfIhuMwBGCvdQEkziCkcKu6h5Vn
         Tiag==
X-Received: by 10.66.254.136 with SMTP id ai8mr35494417pad.37.1403043129039;
        Tue, 17 Jun 2014 15:12:09 -0700 (PDT)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id zn9sm90906391pac.31.2014.06.17.15.12.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 15:12:08 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.0.0.422.gb6302de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251961>

From: Yi EungJun <eungjun.yi@navercorp.com>

extract_content_type() could not extract a charset parameter if the
parameter is not the first one and there is a whitespace and a following
semicolon just before the parameter. For example:

    text/plain; format=fixed ;charset=utf-8

And it also could not handle correctly some other cases, such as:

    text/plain; charset=utf-8; format=fixed
    text/plain; some-param="a long value with ;semicolons;"; charset=utf-8

Thanks-to: Jeff King <peff@peff.net>
Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 http.c                     | 4 ++--
 t/lib-httpd/error.sh       | 4 ++++
 t/t5550-http-fetch-dumb.sh | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 2b4f6a3..3a28b21 100644
--- a/http.c
+++ b/http.c
@@ -927,7 +927,7 @@ static int extract_param(const char *raw, const char *name,
 		return -1;
 	raw++;
 
-	while (*raw && !isspace(*raw))
+	while (*raw && !isspace(*raw) && *raw != ';')
 		strbuf_addch(out, *raw++);
 	return 0;
 }
@@ -971,7 +971,7 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 
 	strbuf_reset(charset);
 	while (*p) {
-		while (isspace(*p))
+		while (isspace(*p) || *p == ';')
 			p++;
 		if (!extract_param(p, "charset", charset))
 			return;
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index eafc9d2..a77b8e5 100755
--- a/t/lib-httpd/error.sh
+++ b/t/lib-httpd/error.sh
@@ -19,6 +19,10 @@ case "$PATH_INFO" in
 	printf "text/plain; charset=utf-16"
 	charset=utf-16
 	;;
+*odd-spacing*)
+	printf "text/plain; foo=bar ;charset=utf-16; other=nonsense"
+	charset=utf-16
+	;;
 esac
 printf "\n"
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 01b8aae..ac71418 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -191,5 +191,10 @@ test_expect_success 'http error messages are reencoded' '
 	grep "this is the error message" stderr
 '
 
+test_expect_success 'reencoding is robust to whitespace oddities' '
+	test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
+	grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.0.422.gb6302de

Oops, I fixed the whitespace error.
