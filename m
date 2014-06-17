From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: [PATCH v3] http: fix charset detection of extract_content_type()
Date: Wed, 18 Jun 2014 00:29:59 +0900
Message-ID: <CAFT+Tg-d6hBact67bjnc2NFghtmBtr7tyuBvA4_QWgz71eJv_g@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvKo-0005Q2-W5
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933051AbaFQPaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:30:00 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:65455 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbaFQP37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:29:59 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so4289431igb.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:cc
         :content-type;
        bh=oqTP5bjDWVQo8jigUx3+a2h3sjRskxs4BDubQ6QMXCc=;
        b=1BQNf62XZD2MUbDAoLIdpoYDWEF7UJcHjKQ6EYfKe2Jv0EHdo64l65kByvn/YULKf+
         tmpgkWQRMwlKsDxwLZRCWV2BV92cIYl8Ow/xFmNGNSMAzydYyyS45im06D2O4VvYPV9r
         czGTJR+PeSJaFUb4gTCQS+uQ6xFVT2sKJaDCXXK1hRhiztSVtVnZSHrt9F7p66gnjW0R
         u8RcNx86gcypzDaohWnLRMs6DKhKSyRQZlbPqid4IdEIhvTyoxi3zLIpG3bhbeywBgZl
         n/oIBJ71HXipQydcvX069dKCKe9hnrHMqBYfcOs5ikEyeZ+Gca492vHOXk3IQlYThpub
         7A0A==
X-Received: by 10.50.178.196 with SMTP id da4mr21323490igc.6.1403018999166;
 Tue, 17 Jun 2014 08:29:59 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Tue, 17 Jun 2014 08:29:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251864>

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

- while (*raw && !isspace(*raw))
+ while (*raw && !isspace(*raw) && *raw != ';')
  strbuf_addch(out, *raw++);
  return 0;
 }
@@ -971,7 +971,7 @@ static void extract_content_type(struct strbuf
*raw, struct strbuf *type,

  strbuf_reset(charset);
  while (*p) {
- while (isspace(*p))
+ while (isspace(*p) || *p == ';')
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
+ printf "text/plain; foo=bar ;charset=utf-16; other=nonsense"
+ charset=utf-16
+ ;;
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
+ test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
+ grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.0.422.gb6302de

I have squashed Jeff King's patch. How can I credit him in this commit message?
