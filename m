From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 21/40] fast-import.c: change update_branch to use ref transactions
Date: Fri,  6 Jun 2014 15:28:59 -0700
Message-ID: <1402093758-3162-22-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2ev-0002x2-SM
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbaFFWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:47 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:45051 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-vc0-f201.google.com with SMTP id hq11so681188vcb.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=th7tWKSLSvSQyhdHxGcUAhX4ELdfT2P7lhU9bkHZUkI=;
        b=kHQeQsVYxXqkkrfUprtJe8j2b1wXeyuJY9FZwpC4vJw2c/A4aGASM/KpvPaDnW+toQ
         +FKJCovd6dzLSng3F/gVoKwt/lf9WUXWuTUZ41SggqbTt4N9FepvUMQAfXNHK1woBgZD
         wuBIWeObuynbOMASI97TfvW2/z0fMbMXV7HP5g/AVRg8kLOxXj1qTMxXLIQSheSBHYNj
         n/JRSpXlfvwZ+dCHs41T/QLhCOt2t5XNYukTqpCsI7xlMWMS4aCcA2jHOq2Aow/fsLvq
         wV6Gn5zIROAUdSUyoK9b0NlDWPV/iUJfUscbBxK5fqok7xGgDEvA7wQJN/mrdVn0h7Nl
         vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=th7tWKSLSvSQyhdHxGcUAhX4ELdfT2P7lhU9bkHZUkI=;
        b=hCAlrmqp+xHox5alwkx5ZNH7zzIkYxPlWDQN8YOTEZeFkMK/OngUFz5dU0LJak7pIw
         EMr20zUy+56EdfWmOvYMBrVDF6KS4Y/DnJyqOlZicbHzUU1cIXDL+NHmv1YorZpLW23w
         C4DfmTcmT8aSkLa4Z4xg1wkNtc3xTz4bCxsoqTtRpCBTn8BstZ+KjUfrktEh5BlIbaR6
         QYHqeC7UfPJAPHBilx0xS2dH6vkKnoxP7cqDRKNsqDh9R/qTWRAqaClj/gchswooVFzX
         CVyj7wZ7orNpMI9QUXrWGCSPYL2YqqFULEtHO70wuxvdUemGErT1L2VSej4ZJMxNI/sn
         hFoA==
X-Gm-Message-State: ALoCoQliHW7TWrLkvbJe6+2hyfTJ6ktDLkGr1/cKO95RCPNrTJdnKkdfXO2dDfxEbYaYHry+h/GP
X-Received: by 10.58.106.75 with SMTP id gs11mr5382382veb.18.1402093762607;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750956vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5F9FF5A450E;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3DC49E0D74; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250995>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..4a7b196 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,39 +1679,44 @@ found_entry:
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
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
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
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.582.ge25c160
