From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 25/40] fast-import.c: use a ref transaction when dumping tags
Date: Fri,  6 Jun 2014 15:29:03 -0700
Message-ID: <1402093758-3162-26-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eI-0002Zm-J7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaFFWaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:01 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:57825 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so681042veb.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yvv+ERaP3Aqb2i/VELnzv6A/iVp/cVNh2D/eVF4vTZM=;
        b=YtoMVa2zZHcN9TVP82daxwjNyv1xN57gNZh0Vqe2/IbveocPjFXm2Lf7Bmhna1bKVc
         Won3dSdTt62k6eS2PXAAEFL+ScURTZMrjxHmAoQRalJkvEVPZtU4Pg+fPt7cqewv1qVK
         X9BmCGe0SbCqvCuT+F1KSSWP9jzz84Qamyuc4aQ2iHQt2PmuD5/IGvHqqhZoFohI5XnV
         tyqVML89pjmJ1IMVN8jDNBlAiZ4frzQziwpW7G/Y3NMuD6dY/R6mBEM2Mj6qL2AfJ3a9
         pTQLknmuWHVc1wUSzXGTZWXM3MAeW84/Yu0dIyNTV+YRPMP00PYhPVOGumu6M5fEhypd
         iMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yvv+ERaP3Aqb2i/VELnzv6A/iVp/cVNh2D/eVF4vTZM=;
        b=TieEcXfqxYOsM0kKq92fTtKeIyvxHm1LTNn4+n76dJ1j5s5PcEC+LkUKV/33D+UM6w
         ScMxnQPo51y7vWGATfGr4x6a1VOna0P1P0FtY30t+1Xg0xWue8m0ekXMx++AoNKku3/S
         hyN+sS5jKsFJQilnQ5F5lI9SlamEt7ZQDkd8LrhbBxnGE4cTfHUL4Pwv8MHVaHE5d+r+
         DtMWGLB/nS7zT1Z7f64KfZXsmDifGND4zHyaDKm3enNlFahhvm7SPZNze3IC+HLuaoJj
         ZgEAOAtQ8GeJtZ8dKiDf9eKW4o42P1WwyPfk997IbfdKrVmbGFKvDg2s0YCdxMwVWe0d
         4q5A==
X-Gm-Message-State: ALoCoQl7PD1XCLsBc7jm2b1ZHABBn7oPgEIIJya7ECKlbocczBq35aOzJICpy/D/pRwmrM5vkKh5
X-Received: by 10.58.48.233 with SMTP id p9mr5190436ven.31.1402093762929;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750436vdb.0.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ADEDE31C62A;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8A9C7E081F; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250988>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4a7b196..587ef4a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,32 @@ static void dump_tags(void)
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
2.0.0.582.ge25c160
