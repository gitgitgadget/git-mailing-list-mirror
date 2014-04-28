From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 24/27] fast-import.c: use a ref transaction when dumping tags
Date: Mon, 28 Apr 2014 15:54:39 -0700
Message-ID: <1398725682-30782-25-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSA-0005v8-LV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbaD1WzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:05 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:44953 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbaD1Wy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:56 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so1609047iec.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRCief9sEVIXD0JjcyyunOxjt4hcXvLxE6JL95NP0m0=;
        b=AfN2j8E38CMXzUfiShR4L0DDVQlX0XR6XhfPpuxcw6cslJ+1ccFw9bJajiWIXotG+X
         sGZg5BJkJBkjjAQ8Ezc8elaMAUD5qJI7MNy1CE9aMO3sS1flsBN8RWhG5RaXOJZBMcXT
         Ut5/OSRK4Gh9KXezI8RW91UNd8h+xkbDiDBaZw95I9t4fw8D5CAVU8mTOwGfYjVl0DJ+
         mdcZOookOTz2JweM474MRTzzysksU51aUFtO22DryHzHN6JHOMacZ1osSs2u2maCTUsy
         8GF5M+S68zOk6HMLPkNcVKzQXJ3tdb4nfPpdLlwhCD5O8g8hY3MPmmdXCvI48TkH2woR
         larA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRCief9sEVIXD0JjcyyunOxjt4hcXvLxE6JL95NP0m0=;
        b=Re1kR6MH++jrvwotjU/gEGA4Re9U0IkWuYTCaFq2YBuzL0l8yWrJ9AXGuQQFxPhrNo
         1leBNGXFoD2P7d1nyBPM47lNBDEKnxETdhVkHjx8qVMTgSjqy5/3a0emQjIvCySNXLtm
         y5yDM1m/qCXrFCgv+at4WhXGyF+nRcCe+W20b5r0YUUgeP84Sg1t/4cl2akC2HSRLx1K
         tjvpFCYjsGdUkoxmRbrBxyP06z2C156u7m4vp1tvCQwMiu+IEL8upfAUwHKMvNiCtCf4
         +ZJNgyFB489vBPJbqvLxN26HklcGzOu30GJ/KL7vwky99eagPdv84o/B7qSchhTjghnw
         82XQ==
X-Gm-Message-State: ALoCoQmkoZ1B3IcFIoLARpbSqayPO3N8t7oAqVeW/hGnQDTb56mD1N0LxbeKj5Az21blwgL9C3qU+KzYv/VvTKIwvlFtflooHnRa7vKKYg6QVxvKYUgC56k0oOG2dFjTi1A/Y7vnGKjcaKvWTI7lwFUAt8zjziC1YZVrzzcl3hiLUSADPa07Dow33GFgAJ2Xyx4Dt/ywKlXv
X-Received: by 10.42.235.206 with SMTP id kh14mr11893062icb.30.1398725696079;
        Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1424591yhl.7.2014.04.28.15.54.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D7C3531C20B;
	Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 94596E08C1; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247469>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ab36de5..b105f17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1730,15 +1730,22 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
 	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin();
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		sprintf(ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name, t->sha1,
+					   NULL, 0, 0))
+			failure |= error("Unable to update %s", err.buf);
 	}
+	if (failure || ref_transaction_commit(transaction, msg, &err))
+		failure |= error("Unable to update %s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_reset(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
1.9.1.528.g98b8868.dirty
