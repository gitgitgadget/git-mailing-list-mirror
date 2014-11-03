From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 09/15] refs.c: only write reflog update if msg is non-NULL
Date: Mon,  3 Nov 2014 08:55:51 -0800
Message-ID: <1415033757-9539-10-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKxu-0002zG-4N
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaKCQ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:58:41 -0500
Received: from mail-ie0-f202.google.com ([209.85.223.202]:59414 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbaKCQ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:05 -0500
Received: by mail-ie0-f202.google.com with SMTP id tr6so777002ieb.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFzkEh7WYp3kppMk9QJjxygACRubTxB1zZza6TU3os0=;
        b=F4KaUFP7lNcxZzv+dMmknTmVOj1vfR0C8PBMDmamydFmGF0nrCKUIrm5pGVIojTw3R
         G7/KMFy4Xvekv3LfVa/8ZK6b8e7PhmAWvhpou9u2tWI9xSjM5QfFxjtwwZXtzunyKdmd
         sy4fEQnLz/T3mNowhPPB7sEtbmB/HdCxHyR3aJuR0+w9v5UbU8WQ1Wcc9rOTGn5GceT6
         zlQRENH13dj1PbHYvOuduzFvSgI1qN17XCsn4QA+Zcj39Gb37aOYCslOyho/J4mARzWW
         CJhiV2Jf8CeEucNsESWVo4iv2PqpoSUEZNrcCePm4THJL0Ica1yLD3U6ZolpvvPnn2SR
         BvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFzkEh7WYp3kppMk9QJjxygACRubTxB1zZza6TU3os0=;
        b=NxLaHsQR+kGMUL4CBzsT9M19ef4248xh3+/b4y0RQAQqYSZY33dd0mqbIl1hUSdUcc
         8NvQtR+RDvNugvyxAwFWNzAuQczuVdEM70RipuLamaLd9ubqFp2AdJ7SMH2CGtqYhNaO
         Bvdeh9aozdtyy/SwkLFS4iv5BFK1wOMaBCn7rzY4JTIlJGxsdOuaveWJa6tfomExtEk6
         Bw9S/UtDMVvAIDlvmCCfJ4VZuiYTkePfONhTUrAi8RhRKIyBHxA1SJmfOdKEVLEz7FCs
         LNUtuqlaOzyjlqlSpm4x83ZVnW/Td3tKWnpFLRrS+f0AMeizJ4MsvFYofnnfYPI+OCev
         kzow==
X-Gm-Message-State: ALoCoQm1UFdLtlg2FuEOxizHoWbumsTMER+5IahrUs+o/aaAdtqBIwa+eV83LzOozLy6hhlVKd41
X-Received: by 10.42.197.134 with SMTP id ek6mr33465877icb.6.1415033763646;
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si958169yhb.4.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id fsY9xOy7.1; Mon, 03 Nov 2014 08:56:03 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 490E5E0FF5; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

This change only affects whether or not a reflog entry should be generated
and written. If msg==NULL then no such entry will be written.

Orthogonal to this we have a boolean flag REFLOG_TRUNCATE which is used to
tell the transaction system to "truncate the reflog and thus discard all
previous users".

At the current time the only place where we use msg==NULL is also the place
where we use REFLOG_TRUNCATE. Eveni though these two settings are currently
only ever used together it still makes sense to have them through two
separate knobs.

This allows future consumers of this API that may want to do things
differently. For example someone can do:
  msg="Reflog truncated by Bob because ..." + REFLOG_TRUNCATE
and have it truncate the log and have it start fresh with an initial message
that explains the log was truncated. This API allows that.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d54c3b9..f14b76e 100644
--- a/refs.c
+++ b/refs.c
@@ -3895,8 +3895,9 @@ int transaction_commit(struct transaction *transaction,
 				update->reflog_fd = -1;
 				continue;
 			}
-		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
-				     update->new_sha1,
+		if (update->msg &&
+		    log_ref_write_fd(update->reflog_fd,
+				     update->old_sha1, update->new_sha1,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
diff --git a/refs.h b/refs.h
index 5075073..bf96b36 100644
--- a/refs.h
+++ b/refs.h
@@ -337,6 +337,7 @@ int transaction_delete_ref(struct transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
-- 
2.1.0.rc2.206.gedb03e5
