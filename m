From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 25/48] replace.c: use the ref transaction functions for updates
Date: Fri, 20 Jun 2014 07:43:06 -0700
Message-ID: <1403275409-28173-26-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04u-0003ML-V8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbaFTOpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:47 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:35270 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so506254qcz.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UiBoXwaalisGbyyJt+kbCvMrsn0fyPUGMndWI0QL1P8=;
        b=WVTo27mnLPxkbbKTf/9wRK2CaZ8LetZGNfP5LqD4j2+OA1bJeCyX2VLxTdq2Go8rtW
         QhOY4DH8Nlv4ZXtN1AfpVSa/9G7bOnDGje1SturfO7sEtV/n7NO+wm5CwXH+cL0f39/F
         sSAbzLGoIfL0FGtT7JxobxQeaPkMjdAsrNJFYqO7XqwUp8HKIGMnuBVOoC6/B3q75TmC
         qrfdeF+CsKsYMBEl2mNYhxcB9WVMIxfDJVg4Yz24WCz8OPrOoZ2Piy2SeCbnb4O3C2RM
         GDwOjcGTXM5VfE59ibOyDb+Blzr/v2i+O20pbRimFab5JJKyHAr6aHgKb246pOx4mmDk
         5+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UiBoXwaalisGbyyJt+kbCvMrsn0fyPUGMndWI0QL1P8=;
        b=HCCMCC4l4nmCZL8+k5Do5EGwZAmzPX1SjRE74q7BtGhNoXhxO+NoPg1LYU3Wo6DXEr
         yS6F17vRpOSKrD/fXcQWNAqWzj0qEjbwe7kNcT3rBDSiHWHH5dwH1mHVknqdx81nFTa8
         lVeb/BUHxfA2YiOzK96U5+Et/Oa4O4LMkEtbUi3xX5TFoYk5RXM2xqByXgGlPuc2Tf+1
         ub2t93PvP+vaVNUhd+wPZlkeA2XdUUJc1it/SxJgHBbi1EpYvHfBtGlLbzwuAqt/2BXi
         SWr0LibaCsy4DRloxCU0JAp9s1zFutZldei+bavhR79Wb/r9N+7jT4USY2fsgqB2fOWC
         2FEQ==
X-Gm-Message-State: ALoCoQmXT1UFVRVt26fR6g18ysqW7BuF7HeOQ9iGfFiBP7VZ11TtKY7JA/rLOj1V17+cyvi2foEc
X-Received: by 10.58.151.238 with SMTP id ut14mr1478865veb.11.1403275413212;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si663239yhl.7.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0C7835A40F4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DAA13E08AF; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252253>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..7528f3d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -166,12 +167,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.420.g181e020.dirty
