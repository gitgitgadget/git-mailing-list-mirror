From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 32/48] fast-import.c: use a ref transaction when dumping tags
Date: Fri, 20 Jun 2014 07:43:13 -0700
Message-ID: <1403275409-28173-33-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04f-00037i-3x
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbaFTOps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:48 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:40098 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so978407iec.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrxGk1zlaYUeI86WKR9UxaIq4GM9SHyqrHoGmw/NJk8=;
        b=a4h08b46Jwv2eGL5iffj4tjl2AcPpjANlPrFCuX58/1Z9TVgxvCvdi82qW2ebI5Gj8
         L/dyX0YuWd6QsHcM5DlAo3IZUYh5rr0JViN4Tb2f/QqBqZuw6mAHEk/TbFveU+qJJt2l
         ktPblUZqbgDGygS1m7qX9oNLGlWlmIeb15Bz9JlzkAjDpteX/s8K+0uvSNI0m1951OqJ
         Vlh5slzh84ZH+hOxg+59YBgrmo3U1ZkAlJk37ZcsnColIxqbWlIPvldtdz5ptnJtlSur
         e91yxRdU5cFods30ceMMZpm3LV8uD2JFh6GQcaLm9myFsLHw/TrWoCvfODfpjgAq5KJc
         7pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrxGk1zlaYUeI86WKR9UxaIq4GM9SHyqrHoGmw/NJk8=;
        b=SJptN5YcObaqs1v/ZwK/opilLV9trZ1y7Y0L0yn/zwai/2OemWOQR32S0BGty1tOEs
         aVGJxcGHemZDNMoWPoHtGTb63qXQwYiFtAG0/GLZue80xgwmLpMXxHa+gT0gj6ICkKF5
         LIK4X80eDUIJH//H7pJjotsTiJ4FbC4WcnIXckuc38XEqV2LVAXWK41CCGZgLgUEFrtB
         sgAb8aj1xlvQpV3nwH7Tzfa10XEpVPZ4ZSk0y0HmRtF86VshVYbqCCv8O77pREJI+9WI
         NsmZeVTb4J5hYurecYQhLEKHA47AY2SQpQwsJPqkOl7w9NB5cMUyKndVwbMtr7BgfukB
         GBVg==
X-Gm-Message-State: ALoCoQlowLexk9aiFlzco4+Nvqzr0W7dnWR84PkU/cH11tvK3jcVf3K4UZmIT8SY3EpEiRJ2rWp+
X-Received: by 10.182.33.106 with SMTP id q10mr1524078obi.8.1403275413425;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si663241yhl.7.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 48B2A5A40F4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 26F47E12AA; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252249>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d5206ee..a95e1be 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1734,15 +1734,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.420.g181e020.dirty
