From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 32/48] fast-import.c: use a ref transaction when dumping tags
Date: Thu, 19 Jun 2014 08:53:14 -0700
Message-ID: <1403193210-6028-33-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxegZ-0008Kw-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbaFSPyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:54 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:45841 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758061AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so330258yha.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dn7f6WauTyJlazijQs3L7KMGVTSE6YmY1Vb/pPA5QuU=;
        b=lWri/DfSy7qoSEUitlAwCMPKPnP4IpGP7R33eEiCILi18gCsScRo9BXHcQKtS+j3Ca
         fATMydwg4CCY70B/OGpSjdIvsnV0gEchtYQjk6itf7MK1IOSxl0DK49gcG/1P3Q49yBx
         ohMes7l7rMYfnDkwzS/rQh0jfqQ2SyWWNuKjenHY3a6j2UKemIL71x/ZZxnyvni/4sRh
         NSUT8ueDGpTAUNcWg/fCdI5AkVchms+azlSdTFYJg8tzLKf1iVHMpWko+d6wtDwz3jJX
         ONAKiAls/K0AFZqgNO1aS2Z0djQv3EzCeqPzxDsTzSFO+Py51+VC6xhafwcsiB3Po6dn
         8KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dn7f6WauTyJlazijQs3L7KMGVTSE6YmY1Vb/pPA5QuU=;
        b=OvOnlHVztSL0+ce6wgboBew8QsbkoveWVQLLOfieyJv6xiUv2/nJB1UnWbZQl58xwW
         G4A9qOxb3FTOLxFokRr8EuUV6Xl5rbI6B0H3Egl9jfdAsnFS0eP2kqp1KemSVMo/1qJg
         Y27S8IKkaMZtslGazEFXSVuhN49K0DcTCQL66ccKsN0tsXKWcFVT2hr4+RpsCJZ/8YU0
         xy/XY4m7jo6NB5MkLix8hgI2CeH3KCawwkcTj+bBtLED21SObFwtyjJmKmMM2PV6veF5
         UgInzJfu+iYaLdOEPXlsWuuymiTicSSNCXwRPesNt3+Z3QOR9BSC23WEBB5AuCTRn+p3
         axxg==
X-Gm-Message-State: ALoCoQkXYznPpvCYFvdlQZxcqwRBIZ5UlGxf1wQZxHUn5sao7UYoTTS87HWg17CbgjTw2WUdN5kv
X-Received: by 10.236.9.41 with SMTP id 29mr2215692yhs.23.1403193214038;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419903yhb.3.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E0E7F31C2E6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AEC4BE0734; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252142>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cd929dc..191fc47 100644
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
2.0.0.438.g337c581
