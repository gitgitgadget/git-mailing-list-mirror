From: nori <semtlenori@gmail.com>
Subject: [PATCH] http: fix charset detection of extract_content_type()
Date: Sun, 15 Jun 2014 03:49:34 +0900
Message-ID: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Jun 14 22:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvuXF-0006Yc-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 22:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbaFNU0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2014 16:26:32 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63144 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaFNU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 16:26:31 -0400
Received: by mail-pb0-f53.google.com with SMTP id uo5so2913403pbc.40
        for <git@vger.kernel.org>; Sat, 14 Jun 2014 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=zRBLQJrWtdT07RM7mz+M8ll5SHdbNNDatgGZd6sjW+w=;
        b=dq6L+ptHSDWYZkJ6FqxMUl9Ir85WA5103xDJTXG1SSGn/OO4M+0yyG65Uv6HsJTT0l
         AFECGaOq3f9Ed7II3UCRsHifbz0WJJxt5FHFrsL5nfc/YtMgWOHwnumizOaIeBJrUhSC
         u4IXi6PJydSnWBpx/v91kaEMroOc2Eqy+2X+FTpDhq3z9Fg+iVYR7vCqrImr1hwVXjg9
         JeHPoloejCeaqmiDfIrwLoYT1sajcgtZUdF4qEve0KfxXE17OWoE+kN/ZlutBHYNu3s2
         rNZAl7tQe3weUO+KO+oN3r7+KqmsHC0KRpy1ivraLAwJriDCp3rKiUZ57wN72vHpmq7s
         opyA==
X-Received: by 10.68.254.70 with SMTP id ag6mr12798872pbd.33.1402777591330;
        Sat, 14 Jun 2014 13:26:31 -0700 (PDT)
Received: from nori-ThinkPad-X1-Carbon ([222.234.94.10])
        by mx.google.com with ESMTPSA id gd7sm41978994pac.34.2014.06.14.13.26.29
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Jun 2014 13:26:31 -0700 (PDT)
X-Google-Original-From: "nori" <nori@nori-ThinkPad-X1-Carbon>
Received: by nori-ThinkPad-X1-Carbon (sSMTP sendmail emulation); Sun, 15 Jun 2014 05:26:26 +0900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251662>

extract_content_type() could not extract a charset parameter if the
parameter is not the first one and there is a whitespace and a following
semicolon just before the parameter. For example:

    text/plain; format=fixed ;charset=utf-8

Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 2b4f6a3..05e8b91 100644
--- a/http.c
+++ b/http.c
@@ -971,7 +971,7 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 
 	strbuf_reset(charset);
 	while (*p) {
-		while (isspace(*p))
+		while (isspace(*p) || *p == ';')
 			p++;
 		if (!extract_param(p, "charset", charset))
 			return;
-- 
2.0.0.422.gb6302de
