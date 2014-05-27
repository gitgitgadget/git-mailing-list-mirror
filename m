From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 25/41] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 27 May 2014 13:25:44 -0700
Message-ID: <1401222360-21175-26-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxV-0002p8-KU
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbaE0U0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:38 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:53170 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so1646267veb.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8im+sdzXMw3xAQ+3LRGnPI+Y6g4CANUNF4elrkLLmcM=;
        b=l72hz6GsMqiZcQpqw/TWENfPuQK7YJb+2+4cuFZNT/1LyROAgeSa1Pt0Ja15AZXy46
         zskA4asv0MXaVpeIRDlqOfk6xvdRIVb+CefH/XB2RB2LU76DXvCpMfQZYbowGAG54IDD
         STyJ+syYjEEDkecymxzXnxQfCe5vJG8NACjQkyeiesV3r1jsuuYbbNqxn2N5cKjNnwv5
         XYcjaPEhVTMvGfY/l68AfzcqKjo2Ob8RPpO3BYFhuu9eeNd6rg6PfTsAxrZ5L+B0QDik
         JTS/qJQRJ09JPcvZlpYoDbipXj3STETMN7gsFj75/5frljPdiVoHsI0gPjKjxqntr2D9
         d/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8im+sdzXMw3xAQ+3LRGnPI+Y6g4CANUNF4elrkLLmcM=;
        b=Ht3kv3Bf7IsisywDjigezA7gQNEJYggx+0FZhAoqJIoaVz1JPwiW+YU/mumM6KGqqu
         Yve2FZsb1ELL32aUouXSRR2JhF5JMZARQJmU0ISyU4YlX8/KKgdS6f/an5XvJCxqJeih
         64rgruqaiqGPTcxhIKmGtG0bTrtlruRPS1sg/jObcy1xHAB9u+/psdoB/++igBero6pJ
         paEyynjfEJKQ8Eqo+Wr6UTG91jnyzZBPXYfZMPsaYzlAx7ByTS7m8LK7GEtSaT4LsD5V
         tqnxKoQ/XWZ6BQfgmYBR6qxIz1HZxnMyJVjZCT/XIWjX1IZLbL20Kz1blng6t0Ln2jy7
         q27A==
X-Gm-Message-State: ALoCoQkUZ9wnNgZm08YCVzbF/qaar65uCjOAqqd2u63F07dG4ENtKAxpHr56YecFWbIWflpAviJB
X-Received: by 10.58.165.33 with SMTP id yv1mr14009654veb.30.1401222365013;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1574647yhj.5.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D88AC2F4AD1;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A9E50E1958; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250209>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4a7b196..3db5b3d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,22 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
 	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name, t->sha1,
+					   NULL, 0, 0, &err))
+			break;
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.rc3.474.g0203784
