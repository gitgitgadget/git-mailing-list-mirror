From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 11/11] ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
Date: Sun, 14 Jun 2015 01:07:29 +0530
Message-ID: <1434224249-21476-11-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:39:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGi-0002U2-0d
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbbFMTi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36421 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbbFMTix (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:53 -0400
Received: by pabqy3 with SMTP id qy3so40681821pab.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xGbzLuhcvISFxR7NAC4Km1NmmTeI8sevd7ozjPmVKL0=;
        b=KaaZUfLM/BuAfS1e9CV67VIiTEUap6DxlQd7t87RX3TpRsYGrBMJbhpu9ACdK6JJu/
         lGrFb7vVn+0isQQmeopyFsoHr4a8FUrpo4GsVtVJaye0ywa0I8IEefi09G3xDJtsKyuD
         jjcv9pOe0DkPVx3W1sfk9/Mfy3Oy2KaCueWv94PmXjLwx+imu3OtL+PQEaBDzvw35xdu
         vX0o58eHo6FaLHLGOuZWd+OOh5dM9sp4aArtwKQm3ni6+8aY+Z4z3wO3lCbjTebtdpJa
         haY3f2YpLJygvEkwedEVm06XNLgZwYITm2Y6P4ZWpMmAqEJHgRAnRFR4wGhC9Smf4sgB
         Gq5w==
X-Received: by 10.68.139.136 with SMTP id qy8mr34174484pbb.89.1434224332699;
        Sat, 13 Jun 2015 12:38:52 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271574>

This would remove the need of using a pointer to store refname.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 7 ++++---
 ref-filter.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a1151e0..43502a4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -847,8 +847,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
 						 int flag)
 {
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
-	ref->refname = xstrdup(refname);
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
 
@@ -889,7 +891,6 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
-	free(item->refname);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 697b609..6997984 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -32,7 +32,7 @@ struct ref_array_item {
 	int flag;
 	const char *symref;
 	struct atom_value *value;
-	char *refname;
+	char refname[FLEX_ARRAY];
 };
 
 struct ref_array {
-- 
2.4.3.435.g2403634.dirty
