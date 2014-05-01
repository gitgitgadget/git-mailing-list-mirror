From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 15/42] fast-import.c: change update_branch to use ref transactions
Date: Thu,  1 May 2014 13:37:15 -0700
Message-ID: <1398976662-6962-16-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxmN-0003YM-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbaEAUkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:00 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:50010 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbaEAUhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:51 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so546816qcz.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJZXhksfNdEiC6HBw+4eMe+Xkw18RuwokQli7T8iOdU=;
        b=h7P4An/GHtGPnEyPutFzyOINesd0tcgIc5qilU6U1SKUtE21+L3qmFthJoQi2rs9nP
         46ZU9tHhBw+wzKyqhnPttv6gJOske8cM4mHxskX2pV8HYrvQtc2uAkP0ssm8C2tvPapx
         EX0P2F8keFEf6/u/jOyx9xCtm97OxnU7KH3DBRwfiyroNwgrpgLlCSuvT3Z1lk2P4j0g
         ZZMsHTSzZwRZTvChJR4eAOUQWzkM7GN+VsD9aWDDgobhOgPpaz9e20lGjt810PvVkLZx
         f0IGsZmcRIAry+q7VQuMOVMOGMV5CUrCfHv7eFG30cQIJiuH5Oanqyq/op/BL2nhwo1l
         wzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJZXhksfNdEiC6HBw+4eMe+Xkw18RuwokQli7T8iOdU=;
        b=NEzRBApa8CyqwLB0tlMBNhy5/hIo0OW56BXiCCmHCl0EONnR5g0bZBu/UAHiL3+EyA
         dtSiPS/HltA6pzKZyOKrUDVhbTqwa5vZrAEJYD0Ol1cDZdG/9GaYu2ZfrAbkvSF4z1mS
         SpOyjpJGhu6PJriMs3iBL9D+MPJ3zn9fU3u6NLkhL6y0k+X0/dUrtCSPzwjDYHbOswdY
         Bm+rZTii/JZB2oyhgQQIqBtrd5xiDhS4KcC1EdUhAXw6hR1FDLEVnzpNgIs62HM6cHdm
         dG/HjqXkqr5/xwWsXKKGdKDnvTAnWKL5XTY01/rMmRSAP+DzYsXu+MWS+TemYBwgmbO0
         Jovg==
X-Gm-Message-State: ALoCoQmACZLvznt2gAyuS37z8jPhPh3fhHzSwK6sjhwOBS5FtktvRMRa7uuz+IBYgaStEM8/YvSr
X-Received: by 10.58.59.104 with SMTP id y8mr6476920veq.18.1398976671245;
        Thu, 01 May 2014 13:37:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537664yhk.4.2014.05.01.13.37.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:51 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1D8E531C1CC;
	Thu,  1 May 2014 13:37:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D51E9E097F; Thu,  1 May 2014 13:37:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247871>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..79d219b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,39 +1679,45 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
+
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) ||
+	    (ref_transaction_commit(transaction, msg, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error("Unable to update branch %s: %s", b->name, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.0.0.rc1.351.g4d2c8e4
