From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 18/27] refs.c: free the transaction before returning when number of updates is 0
Date: Mon, 28 Apr 2014 15:54:33 -0700
Message-ID: <1398725682-30782-19-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSp-0006nO-BD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbaD1WzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:21 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:58191 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbaD1Wyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:54 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so1612352obb.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CL+iFr0LRCxu5xVWe7NEqrlAXOc7ozHAMYoY/eVcyaA=;
        b=n1wPG4sZWmqiWfumiwtJtmXXTW0lMfEpcwwMdxsQsfY53aEUsGVpzQySmX4Za0YDq7
         fKm1fSB5rIWvbdLSzcLZJz+03FQ1Q7BsboW/3WZa9TFcRUhHjDpM1dwyKZSULe0iTUbe
         yMHS51eRdV9g411spzmSX/N6Xa+eI9U5qVe/KeL9GnhMDNNe+2ZiYOU7zC2I9cCK/uni
         RQwUK3Fw4FEQqL4INLDwM8RzN8DrunsfI41Wel7Z7maVJ/P2TBgugm7j8EhSTr+kLvey
         M0lUrHaF/tDlcwaWKMukRIb25sYU1lDZB0PztKGg/v4tp8r/mPFY0XsWuAOhrl5ZtCPR
         fwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CL+iFr0LRCxu5xVWe7NEqrlAXOc7ozHAMYoY/eVcyaA=;
        b=b4Ona4cEI7PKzrFT6TLaGn/v/FIpRxVFBlmw0Fq4f0bgislTBPGn/8TApiKndrztta
         LHSbOVrw9MOdoNNwrSnynD25mM5oFcQ7jX48iUWD7nriGyp79MQ+1TZ8cjgnmjJhevrv
         H8ub7utEueZ/8Jrd0dXYlq/s38fHHvNjuJOjyFIIJtHmZZsAnbtq9O1s1M8TnOn5ERR3
         /eIUbwnLUTevDXf3Xi+xth1VQon9+oFyiFNw9F32ZF3phCfYilaN0IHpNnD510ID2D8Q
         rBiSejAo0jgn5GxGlGuURvfQcF3xAqGv6I0AOJWE4Ebwd6Ty0s599BOYYycVKjGcQEP5
         l1gQ==
X-Gm-Message-State: ALoCoQkI+neF0bcs39UAyHj2kt0f+PghGa/fjDN26DUfU9tdvP4OymXFbcgTkGvg6xBo0DA6DG3k7zkge3xc8Txlerk7VnJ03uthElEG9haQFLViarsfLmXy6aIAcE9rWqzostGs2+sVBUcdvVhpfbsLhDu/sEto0xlRCgyhhwznTBMMsup+w+JWWOoePgEH9Qu8fy/d3PxG
X-Received: by 10.182.75.193 with SMTP id e1mr14242351obw.1.1398725693683;
        Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2349974yhb.6.2014.04.28.15.54.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7B53B31C20B;
	Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0F0C4E080D; Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247474>

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
index 563f336..c6ee43c 100644
--- a/refs.c
+++ b/refs.c
@@ -3451,8 +3451,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (!n) {
+		ref_transaction_free(transaction);
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
-- 
1.9.1.528.g98b8868.dirty
