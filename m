From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 02/13] refs.c: use a single exit path from transaction commit and handle onerr
Date: Mon, 21 Apr 2014 15:53:20 -0700
Message-ID: <1398120811-20284-3-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6V-0008Bp-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbaDUWyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:18 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:45456 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbaDUWxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:39 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so1011906obb.3
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYGaBcEUXE3FdLFKM9KOYXJNmPR7Q2WjaCzveD55Mms=;
        b=ovRpD6qQWEfVq3lf+lbzMLXJ/M80HaN/gZWEQZgIvmj3qVNE8NA5HY163lpVa9+AGi
         A4H1012YQ/WiJsn7gH8+ZcXElpFBe9TkMn7/X7MlhZUHafdvyTJr7K98sn609TYieZtQ
         7++D9/8NC5qX7EkcBkFsziPe3f+LjRASOaSBr7hHypc9sgoLqJe3RxILRjGfG4fUTQW5
         mbe3PZcujbd155lqUYkDTJN4MV0KTS5jmVoTnCk/4YmRIcyLDP/d2WXdxsiLSQfIY/LK
         Gi2PzY2iyqIuvDExfYijSCWXwlON7Jc6iXIpHArRWmaAkbMxEFbkX3TEFyY77z37f7BZ
         okDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYGaBcEUXE3FdLFKM9KOYXJNmPR7Q2WjaCzveD55Mms=;
        b=JuP5p2f+OMyoLJuKZo0RV0elIwuDF881usVPogWNzRAinZcTGB7jrDLpUhcy2PpBLR
         W8hYXKPtHIwDY0xvL6NgKfdqlwWBetXlc/0s5rz9SMuT0d34eLLQPSBF/sK4tHtXUSmb
         J99yIlSg0Lejg9J9NjZU4INyCy6xu631ahzfrYUdYDVVME8/BF0jf1a73+PiXaf33v2E
         5Ifdjyt7+e58SqUj+QttenhtO+eK0d7Q+PDT6RpmPBI8LhnT9PbvQQA1Y1qj98tt2Nox
         I3zrEYtSSUSgFVNGhQ7VqJmdgFs3IsKAGPnavKI+YMM6U8CJZdWLH8H3bXCVTXMCpvU4
         ZbLw==
X-Gm-Message-State: ALoCoQmT62WAeDAuhupE7R7h0hwNcezmTwwrAJePRmZSzOPUgRmFHzCb5WdNiDTGtTsIyQonisgaT9h+bEOH/gO2IDjrivptqpdSmtIPh81szbm1TbbZd5j6wAfcVOKXYAEAUdEZeRyjotH9wrjqoK9RkN5IqK6kx1U4tg9m8DFXmxqT/L7NEcuilflA54VlgTdKcVPaW9EQ
X-Received: by 10.43.78.135 with SMTP id zm7mr17493562icb.27.1398120818563;
        Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id e40si5369739yhf.0.2014.04.21.15.53.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 65D8131C11A;
	Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 28B6FE06AA; Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246666>

Update ref_transaction_commit to have a single exit path and process onerr
if an error occured during hte commit. This does mean that in case of an error
occuring for UPDATE_REFS_MSG_ON_ERR during the calls to update_ref_lock or
update_ref_write we will log errors from both those functions as well as a
generic message from ref_transaction_commit.

I thought a while to make the MSG_ON_ERR message in ref_transaction_commit
conditional to only trigger if the error was not triggered by the two functions
we call that also take onerr, and which would already have logger an error
already for this case, but the code would just look too awful. I think it
is acceptable to log two error messages for those two cases than to badify
the commit code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 138ab70..9daf89e 100644
--- a/refs.c
+++ b/refs.c
@@ -3414,12 +3414,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
-	const char **delnames;
+	const char **delnames = NULL;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
 	if (!n)
-		return 0;
+		goto cleanup;
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3481,6 +3481,14 @@ cleanup:
 			unlock_ref(updates[i]->lock);
 	free(delnames);
 	ref_transaction_free(transaction);
+	if (ret) {
+		const char *str = "Cannot commit transaction.";
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR: error(str); break;
+		case UPDATE_REFS_DIE_ON_ERR: die(str); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+	}
 	return ret;
 }
 
-- 
1.9.1.515.g3b87021
