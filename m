From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 18/42] refs.c: free the transaction before returning when number of updates is 0
Date: Thu,  1 May 2014 13:37:18 -0700
Message-ID: <1398976662-6962-19-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxlt-0002wG-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbaEAUjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:39:44 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:38541 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbaEAUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:52 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so799441iec.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e3GgTI4MPRdBZDMhoWD4qTO9hGCYmyQUNXhpQhA/geE=;
        b=jsYnUdgQGcXoGcmefQwvRRCe082gdACAewBGUsrllS13aXGI9b3wWR+TazJ9cKfRaG
         DHLjuHI27fmq5vn4J8NAqAJvDGj5ToSbjul9ed14/sdVydaOu0KbLOM1ru+yd20GX2Uy
         ki2wifBnSB6/nT2uSwsWllBClAyv2fYCnFLZJ6gx7ZZI9HNSxfSgwzjf334Pd/F8gxVf
         3wwovBzid+rNvEw/NVIAvLJpkYFKcD+kVRSCGXMVgriQ9e/eH0XWDXwalXAdOR63ZLYN
         A8HTnOO513UDEFvvOOHovDQct6SA6nNnSwhLQXJ3rBWoPigMOE550SaLb4XVDqMolh1K
         VW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e3GgTI4MPRdBZDMhoWD4qTO9hGCYmyQUNXhpQhA/geE=;
        b=Irw3pyrjAm8GOqTGr6biZ3UqZkhlsYhUpPr+CxISBi6W6JdnxyGE/1IB8KatQWzlN7
         A5VF/0HhPqEXNl7670tDaVZGR0kFpxLQyMwSlKH7E7KAhFNUO35MgLSshuZ+Mwtt0WsV
         7obMdFGIIAJRHScAC8XWuStE8sH5KCmJVKgo0y/gHhk9dQu0n9BkU4gtTm0Pt3TcdpS/
         +TiICEbso8s6UmhH0kbJRcqbspXH8yEWlZ9NBXCm5T9NQRI5Rnzhk3vY6q+4/H63Z/ep
         hgtVmQVwR3PtzRbNq76icAQFPjPBM50Zubv1R7pWn5jzCfFl/T04Y4qhLxs738vSjpDs
         ia2g==
X-Gm-Message-State: ALoCoQm8oe9+ZeKUfVqduTwL81Y9oa99xEXhYtv84BkbALYWR/+zVIcaP4q/s/87LhVGtU44ySPd
X-Received: by 10.182.226.163 with SMTP id rt3mr6999913obc.13.1398976672532;
        Thu, 01 May 2014 13:37:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538056yhe.3.2014.05.01.13.37.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 57EB731C1CC;
	Thu,  1 May 2014 13:37:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1C8EDE097F; Thu,  1 May 2014 13:37:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247864>

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
2.0.0.rc1.351.g4d2c8e4
