From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 02/10] for-each-ref: clean up code
Date: Sat,  6 Jun 2015 12:39:33 +0530
Message-ID: <1433574581-23980-2-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18FB-0002oC-22
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbFFHJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:09:59 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33525 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbFFHJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:09:56 -0400
Received: by pdjn11 with SMTP id n11so29268081pdj.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yATg1oynw1k99jg2H+YOS5+jY+kXKDV+ySbTXFovrIo=;
        b=B6ihQWZ+j7iG466EMWTEfTBrEuyPOoUciowncYkQIwRqmhFIwKN8wjPiYuwIYmmCpU
         1QnZms+saGcNUKqara7DuKUy//acpl+YA06zvJ9JdO7MmfAywhPTrr+6Yx2IyJCSYWvH
         JiAEVq3EdEg5C/HJK9HIe4UWJoQbPl0+l/DDIx/L0bZYtzo8fPkqGVKlj1Kc6Elzm5RB
         SiEUOoQg28jHfr1jyuN2kvnhAysu2v5q6nbhHB2ntETLcGkLqlQCIMM9aVKHcd105Vmf
         NpXGBY7ryAuUvOZ7BmmjP4++Jk8Dr5Ck+vLImlh2EZVIrNHFhh6LLt+ADpCEune9nJDB
         BfBA==
X-Received: by 10.68.167.197 with SMTP id zq5mr12034667pbb.85.1433574595979;
        Sat, 06 Jun 2015 00:09:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.09.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:09:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270906>

In 'grab_single_ref()' remove the extra count variable 'cnt' and
use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
instead.

Change comment in 'struct ref_sort' to reflect changes in code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 48da5a4..0ca9836 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -27,7 +27,7 @@ struct atom_value {
 
 struct ref_sort {
 	struct ref_sort *next;
-	int atom; /* index into used_atom array */
+	int atom; /* index into 'struct atom_value *' array */
 	unsigned reverse : 1;
 };
 
@@ -881,7 +881,6 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -898,10 +897,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = new_refinfo(refname, sha1, flag);
 
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
+	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
+	cb->grab_array[cb->grab_cnt++] = ref;
 	return 0;
 }
 
-- 
2.4.2
