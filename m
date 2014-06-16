From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 28/48] sequencer.c: use ref transactions for all ref updates
Date: Mon, 16 Jun 2014 11:03:59 -0700
Message-ID: <1402941859-29354-29-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbK8-0007AQ-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbaFPSHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:20 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:35406 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so613666pbc.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Di0jW09WKmCPBS+HS18W6LJaPeEDTCzpetQgFqSsug=;
        b=nd/F0TPvcqxMzSlhIVnoAlpw7r5zwGnPDSzUlzpfItIk9TljotCIOi6Qge+R2ietuB
         HnHvAfUT5wSOjVbtTtxlroirURLifN7hKrCQBu8hSaBBbjlC7n5mLfLgr20WftGbpCCv
         1e8v6o6VKIjKUt+A2LSV6/9V77fKEQ6ETLFy2CWjgOT/IQjyN73+mNIHVEjPOoav3/rG
         /vgVlWQJpUESY47D1mi7qd1rx1BV7gsJOxMFBZBf0CijENZSC68dZ08JkoJ9N/sNvB/C
         O9XtAFDoWuCrgtNb4819MQmoYaHJzINs9qA64ucgnhfKUXOaUTWsI9Dd7PvElpgw8ClI
         /SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Di0jW09WKmCPBS+HS18W6LJaPeEDTCzpetQgFqSsug=;
        b=mvvQBW0sDLh/3fVWWkUqYwkZSmoILjmXPTQf7HsJyTv5qx5frr9jCXbraN4G98GRIJ
         CPZxDp9VXJGdOfh1LXcvyorTz8Vack2LGwVhfY+E6lcomazlX7sOQ0yRfnBaYVDQJkO6
         qZaIu3yOQ2MgChyuBFU3MjMDee1ST3gNC/9fzlOhR5U+l1L6DA2prOtnX5nd0lh40yZH
         wE5H9ApzpZ1DF1kPzvdrDnaKuoOJuvQVg2FdoErqghLF1dlcWfJzuAzouW5AQSieB3jG
         dQRoLfC7Al7ZjvvQJdDGZqjJFpz/MdNGz8kVDQ/gXy6p6wNwhnmHX8anHwdtayIAcNs8
         yWyA==
X-Gm-Message-State: ALoCoQkzf4S7Lmkb5uOe2PO7XPkipcPL+k34Ga6RaBpn2LNHi1bPVk8kPAbV62XJz6oghjrpqG+p
X-Received: by 10.68.135.200 with SMTP id pu8mr909160pbb.9.1402941863268;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si998548yhm.0.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1A7185A4912;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F1408E0D03; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251772>

Change to use ref transactions for all updates to refs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..fd8acaf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.282.g3799eda.dirty
