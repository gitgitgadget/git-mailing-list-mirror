From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 20/41] sequencer.c: use ref transactions for all ref updates
Date: Tue,  3 Jun 2014 14:37:38 -0700
Message-ID: <1401831479-3388-21-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPg-0005YP-27
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934354AbaFCVi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:26 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:63551 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934239AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so807706qaq.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RKNMLkgaIOLCZdBf/H5mkr4WmMRCdZPFMW6uLD2RHrM=;
        b=fmgD9x/eixNNFqGTHQvvJ39XiqKgtJ6EvakjAdQIl7yak0z0T+kcKCziuc+0h7/zOp
         UOlG2qFUtLyC8dVU+UDUx8SsRTbeeAwB6iwxeXF4efnkoriKc8Z/i6mm01295h4R5ql9
         3nF9aq/uf7cxJ4776oQtRUBILp7pZnElNrIxpQcaiA0t5k7SO4NnjK+8lwXFuagB1cKq
         rrPhZrIvKg45vW3YoD08jYCq0K3bJTRjgBL7j4IItbDulAKwJbh4j42Afy3XDjzpFpEM
         jSspEu+LA+crDGV7PjSekji0BqJKTwa6kxAQpq6LhMmYjqOmoMJysbN5qOUF6ZnsmuXC
         AOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RKNMLkgaIOLCZdBf/H5mkr4WmMRCdZPFMW6uLD2RHrM=;
        b=TGTI3cXdNXbuGCyPjw7gRxQ5sONR0jrJal5sn2pulTJP9OYFsQkA9xNI7uBMINueIn
         Qlky/PiegeqQHIWr4+niPizHovZPlXyAmW+gC7Nnr7bbBPHLOZXnB3l3+tomOeqBsT8+
         fa0mXpzW72IT4pT7YmA6NKffPTYM39e7EQZYVcuwzCWY4tnwZmSmGPbgv1V3vBCfxKbJ
         c7iTfKk8WydofgGbOHUJ/Qqi+/YpL2K9Z31gIqi/9jIZpDvFaxjBZzjOQIT17aoi2Khe
         igIm96rrnr9dP4KLnTnZqJ2bmu3tVz8OPRTBcOmEq7h2AtxJ1HS1FSAOlTf3E5xzXoA2
         qkHw==
X-Gm-Message-State: ALoCoQleuRrLBa5Kqb1JokH/s/4ladMuu9TY9WLTTkOzPGGeq2s6sMV1WrMZ+7A+HTq5kpYd8RXd
X-Received: by 10.52.4.164 with SMTP id l4mr15046746vdl.3.1401831487732;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si30644yhe.1.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 852E431C462;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5F5C9E00FA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250653>

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
2.0.0.567.g64a7adf
