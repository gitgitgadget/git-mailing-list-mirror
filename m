From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] utf8: NO_ICONV: silence uninitialized variable warning
Date: Fri,  5 Jun 2015 02:42:16 -0400
Message-ID: <1433486536-23447-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 08:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0lLg-0006KN-JI
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 08:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbbFEGnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 02:43:20 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37761 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbbFEGnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 02:43:19 -0400
Received: by igbsb11 with SMTP id sb11so8323913igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MCkVsPats/cJp1PN63Yfm82x5hQMo9FHp5sU+STsdo8=;
        b=LUtmdu8bw/D8JJh5SQQZKlHS9Z4pvhtFa3s8DcIy99vwI5nhWoyCuhpQFN0u43U935
         O+M3YWZi5lWBLUw+IcSxL4Oonx0ghp/1XXGaQFA1XBoidSppbEaeWDMF1q+Y1Y3uNdEH
         qh1tD9zxtE9GzQa9Rq/5cxM1otgJc0S8LJynNA002k7RKBUKYvR3CHJGceACzA6QsRFQ
         Yte5o39XddxN1EpxPHDLRbyZkCy6WdSK2bv4hz77ItysGxfdXV1ySkbl01LnW4lGIiiJ
         hLdjKznlg7ZwDaUwptCBQErnfxNxunrwEi59UUu6XzTJo06eq5plk486xM92dHHJK1PG
         wGmA==
X-Received: by 10.107.136.197 with SMTP id s66mr2371661ioi.65.1433486598496;
        Thu, 04 Jun 2015 23:43:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id 69sm2708248ioz.10.2015.06.04.23.43.15
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jun 2015 23:43:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.613.g328fd50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270814>

The last argument of reencode_string_len() is an 'int *' which is
assigned the length of the converted string. When NO_ICONV is defined,
however, reencode_string_len() is stubbed out by the macro:

    #define reencode_string_len(a,b,c,d,e) NULL

which never assigns a value to the final argument. When called like
this:

    int n;
    char *s = reencode_string_len(..., &n);
    if (s)
        do_something(s, n);

some compilers complain that 'n' is used uninitialized within the
conditional.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 utf8.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utf8.h b/utf8.h
index e7b2aa4..5a9e94b 100644
--- a/utf8.h
+++ b/utf8.h
@@ -31,7 +31,9 @@ char *reencode_string_len(const char *in, int insz,
 			  const char *in_encoding,
 			  int *outsz);
 #else
-#define reencode_string_len(a,b,c,d,e) NULL
+static inline char *reencode_string_len(const char *a, int b,
+					const char *c, const char *d, int *e)
+{ if (e) *e = 0; return NULL; }
 #endif
 
 static inline char *reencode_string(const char *in,
-- 
2.4.2.613.g328fd50
