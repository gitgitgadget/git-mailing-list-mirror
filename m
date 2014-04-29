From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 18/30] refs.c: free the transaction before returning when number of updates is 0
Date: Tue, 29 Apr 2014 15:19:03 -0700
Message-ID: <1398809955-32008-19-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNd-00029w-Js
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbaD2WTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:30 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36741 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965280AbaD2WTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:25 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so206143obc.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W7BRdk2XhcTkRXTq9HM4yPQSgSL6l1zojN1Zv2UofH4=;
        b=WsJRPOnUVzvN4KfbgDCzdNrsgCl04qw6IRyGwOQ4BwRLcWKGXZ1vCOzX/vrsorXIlY
         sTuC/QpyWyVi7UI1Vj9ZhDz8eLadfiCcBsyOcbylbAEJuRx/5rN5s9wJ3Q8rUXgLylsy
         XQ4gYx5cT3oCMdDrybZ0HPcO0NduSm2Da6kJJXRMoKSFTHQw2zYokZkZy4fpNoWkbdAa
         NOn+83eQBESlOC6DlVIbI9SQOwxdxcBH1prFNw9cRpVZieR7fvua7RO2Ia6oNWF0OKWq
         WpddHODJSVaesTxwiHupFDmPTHJsiacyuWfDhO8gaQiqrQouAtKPF13Lq4mCljyZKpgg
         0vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7BRdk2XhcTkRXTq9HM4yPQSgSL6l1zojN1Zv2UofH4=;
        b=dQl347/83PlLcHNH7DznGEDOUPY2cyy6nw2rCqRfGEiUDyAUkgmQoC3SoCrANwIKxD
         L0vohmScDpJW4WieYJl5iqB+3HEplCpz6cg0CrWNbvP1I356uh37Y+lM8+1K4Cu9XcDv
         ef5PqtbmP4vvkU49GUxjtyUtEpPH3zASEM+nY66KX09EKbw2+/qvSHiEiW7fLGvMr2SK
         yE6y+FbGl5k3IQSpSfJ5y+c8RA3HzeJJxvJlmRokEYAjdQzVBoNl6ymrFJcDsPmORh7j
         bH8WIMpXeNvXPPOovCbbdSWg2fvV3CcbIHzO0eS5UO69VqCs6BxLzak4fqAwIVZm1ugt
         0j2w==
X-Gm-Message-State: ALoCoQne1nMPxjP9sqfO3XR6/bQRzLOAIjAxUeuGEHVFp++IKtL0PyHo4YtCvz/ODQmYxq/HnJzHcot6rBPBDx9nzDroDcsup4WDZlcwEwvPDN4/neg7MatHVwOXpFuoAsy/McOXGQ5kyA36rDVOY6NLxre/CLWBhNa9TvW4u262gRAgZd9RpxQ1v1edLwQtzOv9tJNxYdxw
X-Received: by 10.43.18.133 with SMTP id qg5mr267674icb.13.1398809965005;
        Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si2738497yhb.6.2014.04.29.15.19.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D430E5A4121;
	Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98D82E0A5B; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247633>

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
1.9.1.532.gf8485a6
