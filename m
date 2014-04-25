From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 18/19] refs.c: free the transaction before returning when number of updates is 0
Date: Fri, 25 Apr 2014 09:14:53 -0700
Message-ID: <1398442494-23438-19-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdins-0000OR-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbaDYQQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:20 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:58433 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaDYQPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:09 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so629225yha.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mUd2a6FNZkI/2IZvWdxL52WxkyTt9My/6Ui5w4fpIHk=;
        b=mJ6RtDZA0Tx6GxqiRdQMX42TOFsf7/EE1GBaETN062KuAY9etU9IAql2XLn8Y9Ivob
         Sc0eDn2OMeFb+KFcgwhf38JsI4osVnHKFLcyg65znacgqOpX9ZIt4J24dF7+tp+xjCRS
         G2z2thabUuHneS+s9gi/YpQjnqCTTjOAswpt6+vgcTPc+25tBuHWls4K5XGiz3QFHwt4
         5ZtqyS5KNXe2ghAYmp9Qg8f9fWenVJjnZ8ztzPBkBYHSXBty3V/8xX9Dtk36BA8w/UYH
         tvdg5fO1nODMNHkJmoGy41a0ZlM5t1Ug8Xt623LAiwb3URJh4DLbgag2qSiOqSPGC+30
         Lfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mUd2a6FNZkI/2IZvWdxL52WxkyTt9My/6Ui5w4fpIHk=;
        b=SFh+AmzLndJmKH+HRm7yK44of7UgVKab2sCdtROeHke68PA7pC85Ma2Q4bFZie9dSD
         4rdG/8iXzVpvQVfMPsxeBouOoJdz0Rm8VpwhElpR4r5PkVBK21aXRoc8qPRG8GHbeubK
         z0jNYn4Osa+FvfewdD7+6kYXMNQ46LFpCBYv/k+szqf5XJS34UIz0W5L3pAE29Lu7skR
         MkmFfs6GqefW+qavJ6rjANDEfzsMO7+Orx7mna00d+iKD/68chRnSLVWwcDue5ytRTOs
         4qMtUJeQCvZqrjQRekISdvKY2FAhGs02teAH4pRxBi4KceITPxf7oXtw7bV+UFfgltzv
         7LFA==
X-Gm-Message-State: ALoCoQlbKPFoUqXiisj8AhliO5VRCdaLIgrtS6Dd82WB36YaeBCcKaFIsQQp4DMEuxdMj27Cs1jlUunDq0LwW+Pb2d9Vso2FdHEF26k/RClhlDU8ppaJtgfMq/XnbGHXhzVWQiivvZ48NCwP5yeElejFBDx0aFDYGElvB/Y0jIJLNR7bO/3+PjthpH71DsC5XWOfy1Fn5AN4
X-Received: by 10.58.30.78 with SMTP id q14mr4819231veh.10.1398442508844;
        Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si617578yhj.2.2014.04.25.09.15.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AD76231C25D;
	Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 61E65E0855; Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247060>

We have to free the transaction before returning in the early check for
'return early if number of updates == 0' or else the following code would
create a memory leak with the transaction never being freed :
   t = ref_transaction_begin()
   ref_transaction_commit(t)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 95df4a9..ffa9c83 100644
--- a/refs.c
+++ b/refs.c
@@ -3452,8 +3452,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (!n) {
+		ref_transaction_free(transaction);
 		return 0;
+	}
 
 	if (err)
 		*err = NULL;
-- 
1.9.1.521.g5dc89fa
