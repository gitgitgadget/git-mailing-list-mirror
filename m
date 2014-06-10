From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 28/48] sequencer.c: use ref transactions for all ref updates
Date: Tue, 10 Jun 2014 15:29:16 -0700
Message-ID: <1402439376-25839-29-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZ9-0005Ui-OB
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbaFJW3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:52 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:57077 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so176332yha.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdQPVnGMfxo5FVWMDO+YURcuDQxNUgWceZAcZ8Rhzi0=;
        b=W8Lu9qClTXHw+8/kdItrBlSHSAPsPltIUvQtr0jKPOJqS9Wxx8yT0AmmQeqIpmwJTI
         5uRDA5c01tHn63CeVWK4B5PpVpmCoH9m4/xIfraW7kDjroskBV44nTTrv4413SGJ0b+1
         QTcetjASwBwMlvxyOuW9KrmLS9vVk31KVA2PZkRTUh3HbyExXudiDJwzYKnJcIZ4VdF0
         3jajTVNCfJdcIyA9p/s//XoSLp6G07C6HeBL+n10TiddEcs4UL+ktOGk/Y+wVNkp8QEj
         0JX7tB1sx0DFbDb2b+r9wZ9dINr4i43coF29ULX8zPf15eqcA2/Rv1qf812/TO8oA4ws
         FYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdQPVnGMfxo5FVWMDO+YURcuDQxNUgWceZAcZ8Rhzi0=;
        b=byM2+39G4AdbeinziKzF7HCDrEYAbN2qYUkN46VwYaMAeykEt99KAQyd8p//kVbp88
         XkRL7g1/lNA8r9uP+CzrDGE6xD62V5sCdj4ycS5VwNjxk2HiISCYd56TFx/UBc7+EQFQ
         TpiZhn3OUZ0Sl1KIutahWPKP8Y6bN7p2h7+QT/yP46xeps0FiBYCTUuAE2refZcKW3rP
         aTqZN3SlO32qyhvgcsuYZvGa9P/DgO9qqudereSqb/+KUM6Rh8nac9fvsxRKeIuSQrm6
         95hF0/t1NLgWKNItzdLvTcxLvs3EwLyKqdF34C6qTB7TioYKT0XusBzK6F1pVDVwdZW2
         5PzQ==
X-Gm-Message-State: ALoCoQmSFZNzLTCR4vYDRP9IOPfbjBySk2FQuiaVapuyJBkVQrWuoYMTEiTWhDX56xXu2CzcDxTA
X-Received: by 10.58.100.235 with SMTP id fb11mr6987893veb.33.1402439381061;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1395393yhk.4.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E49F35A473D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C750CE0A0A; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251300>

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
2.0.0.574.g30c2c5e
