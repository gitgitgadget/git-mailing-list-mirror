From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 20/44] refs.c: free the transaction before returning when number of updates is 0
Date: Thu, 15 May 2014 16:15:17 -0700
Message-ID: <1400195741-22996-21-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tq-0007Dp-KL
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbaEOXRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:08 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:54605 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so720315yha.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nWGoyYP1BRRw94SCMiPaLRUVuLKy5Iwdyc4O3WrLP8k=;
        b=fmzb/HumlaeCdHV2Lw5aNc7AybidauOXe0+l4cWoAIDjb2yawqToeF5WO/Tch8a/L3
         Z0TGwXGhnLIBvuXWZIzNWa/EJQhMvGv+FACUTY6i7xnVlo55jfKo1CX/ilEm/Xc5GmZz
         LsG5w30w9iNtfjuxaFVS8vL7SYjtbEZGu5HM9CkNwa/WSxsdkElb4aBo9ryijThNpq85
         YWdHHV87a5XowW3SwnuNQDpM1GjZ5AJKrJxzZxMHWFBMfILhzIzitjtxThhYTeZOfYZW
         dWBpITv41QONT6WiyjU45NvVivJIjYUh+zppGg1du62TXDgJt4NBvUNpy3qSTqABoV+R
         fE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWGoyYP1BRRw94SCMiPaLRUVuLKy5Iwdyc4O3WrLP8k=;
        b=JE7GCO5jN8Uj98y9b7eoE3EJn3Gedqy/wEXKOGGDLvb6hQN90aVmqTk1N+xtDzq1nL
         hOfw1CUN7gDwHgev5Wlt/yIINSnOkzeDwpdY7GZM0B8tNY5SAid3kazvb6qvUIM6C27a
         dir/KB/XEWprBvztQTtIzSFMW10DYr7QRtT/pBP+GRmO6PMmIDePA/k4MqCeW9ilclqy
         Wtnvw6LMjnEGGCta1bphrHSnXlr5ACyxcol1AuKQ4nMvqvL5pRvfmALaHpevL9aYPQmU
         a4OklNc5OX5o4p5OODUymVsTsN5dD0YVbKJ+cKqzPWKkKeCRzGBoFJutezcEaIGLCvnO
         XRqw==
X-Gm-Message-State: ALoCoQnVt1EuZcSj5aBa9mXHu06WnRWzfIMlbJ4qKBllz13TrFLkP/hY7Zw4LBDvWg8boGDCHK9I
X-Received: by 10.236.140.42 with SMTP id d30mr6375448yhj.2.1400195745262;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318069yhb.6.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2260331C1CD;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F2D51E0764; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249249>

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
index 5e82695..b4c7d04 100644
--- a/refs.c
+++ b/refs.c
@@ -3502,8 +3502,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.gffe78a2
