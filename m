From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 09/14] refs.c: only write reflog update if msg is non-NULL
Date: Mon, 16 Jun 2014 09:51:40 -0700
Message-ID: <1402937505-6091-10-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8w-0002pd-1x
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbaFPQwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:07 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:57745 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so837966yha.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2AaZq8IOSgZU9joMFD+j156ciLTsw/lKIA6Qi/s9p8=;
        b=Fc7NrCPgCzJFLgO/Pg7o0kmaQa9p/tcacwsB2ml3AWuT1aw8HpI50Xw2SspKIuvTtL
         zWLmwny62Ew8Wu7cfDejcIK+Y+BL0IUgZSz2wClKwyHvX1YRb429fOnCyM6DOQDIi2Ct
         WJhDJGZSNKGZQAlbg5YoDQ+JABWpAfqlsZy/GgMHCwu33QtEs93ahUZeHah3txXzEVPd
         7wFTef+5u1xEjDhdZynfR3DKoMs8vDF2Czd9Y5+D19vx2434bwhKPGmQPPpvrZZXnFnW
         NLf16h0eKhfRd/BR44yfYZaHKKk7Rdl8es0xbeZS3RUnp/fchNXoXA7aTNEfFUeJuAHK
         CAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G2AaZq8IOSgZU9joMFD+j156ciLTsw/lKIA6Qi/s9p8=;
        b=HbbmUinjMTphHwjIum+/jC/t7k4PzwzODJGgDM71lLox0BDm5qujaHZsCkNQ+uo1Ff
         uGpyc3WPnKlS1VaNLt78RgSIqW25BYQRciOCl0/x76wmqYrOE1Lp5YMY4BUl1MRLXyiP
         u5o7P3TygsO7QwWBAxBVxY70glZsPNBS2aHlQVlg4KP0BcU7/x1kfa0JZFY0H0K2M4MC
         cSyC/7pgrJABotekfGzXnGUM8Tx2EaGnHzDT2yRfq+kvFmgp7WhMvi3FW4UbeCQuAfua
         huIlxaerLvWNcmmrBWfpt0sWDGaDRUNOcdzJJuGKjK7t1LUtbMBG7b3ArP5qBzUZ6XD1
         GmwA==
X-Gm-Message-State: ALoCoQnpBIBHFjSJJdxyHtHFpyqyyfoGz02Z09vYPA6E7oM9BZBYgicDAc6ysya5jTFWWtxUaC2R
X-Received: by 10.236.1.198 with SMTP id 46mr697524yhd.16.1402937509869;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si984292yhe.1.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B7F605A47B3;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 502BFE1718; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251725>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 379b50e..2163c90 100644
--- a/refs.c
+++ b/refs.c
@@ -3785,8 +3785,9 @@ int transaction_commit(struct ref_transaction *transaction,
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
index 7c3a9ca..b0e339b 100644
--- a/refs.h
+++ b/refs.h
@@ -336,6 +336,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.770.gd892650.dirty
