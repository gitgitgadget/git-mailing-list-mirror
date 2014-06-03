From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2] string-list: Add a value to string_list initializer lists
Date: Tue,  3 Jun 2014 02:13:18 -0700
Message-ID: <1401786798-3729-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 11:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrknj-0002pL-CD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 11:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaFCJOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 05:14:31 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39345 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbaFCJOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 05:14:31 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so4421236pde.18
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mDbMzUi22KiTMKTz49rDYcCUsfP0gkT9eM+CWNW1S+E=;
        b=KNQV9dKDbV3jZ3WynXoRujTYGdDkdVETaaTEtywpAXFvMd0gxC3CNKGMBAPJrcc0KN
         rdWDtTV6Bd36E3srOobPfK20CLcBZRJh9/KNuL1PgzmYFi5XW2jE9QPbWV9eUsdHlKUF
         21+KLjVQUyNPczHpca3xmLoUHwjMxVvoezFPOHgzAe83MSCxSATPGkXWOnQM6elo+tFI
         zxcLfHRboLwBio84CR2NDobl9+1nMXkh2A2jhbg3bFi9yPLwkLwZgnhKlWbmN4TjaP1s
         0zryPd1YBZkAEz8tdzjSjMRYNOep34um8XPL2JNiGXkE6zdVSKn54csYwB7371Nxm2wC
         Y3hg==
X-Received: by 10.68.133.163 with SMTP id pd3mr12076193pbb.166.1401786870598;
        Tue, 03 Jun 2014 02:14:30 -0700 (PDT)
Received: from localhost.localdomain ([117.254.217.85])
        by mx.google.com with ESMTPSA id ih6sm25462615pbc.22.2014.06.03.02.14.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 02:14:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250622>

STRING_LIST_INIT_{NODUP,DUP} initializers list values only
for earlier structure members, relying on the usual
convention in C that the omitted members are initailized to
0, i.e. the former is expanded to the latter:

	struct string_list l = STRING_LIST_INIT_DUP;
	struct string_list l = { NULL, 0, 0, 1 };

and the last member that is not mentioned (i.e. 'cmp') is
initialized to NULL.

While there is nothing wrong in this construct, spelling out
all the values where the macros are defined will serve also
as a documentation, so let's do so.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---

V1: http://thread.gmane.org/gmane.comp.version-control.git/250560

 Documentation/technical/api-string-list.txt | 2 ++
 string-list.h                               | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 20be348..f1add51 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -200,3 +200,5 @@ Represents the list itself.
   You should not tamper with it.
 . Setting the `strdup_strings` member to 1 will strdup() the strings
   before adding them, see above.
+. The `compare_strings_fn` member is used to specify a custom compare
+  function, otherwise `strcmp()` is used as the default function.
diff --git a/string-list.h b/string-list.h
index de6769c..dd5e294 100644
--- a/string-list.h
+++ b/string-list.h
@@ -15,8 +15,8 @@ struct string_list {
 	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
 
-#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
-#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
+#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
+#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
-- 
1.9.0.GIT
