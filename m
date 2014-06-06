From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 20/40] sequencer.c: use ref transactions for all ref updates
Date: Fri,  6 Jun 2014 15:28:58 -0700
Message-ID: <1402093758-3162-21-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2dw-0002LL-1q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbaFFW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:37 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:32935 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so741074iec.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AaMyHQJ1p4rKWp5nHWr8mginnUN2ilwCAB8zqJX9RFs=;
        b=PebUHeic9jg97lWsS3Nc8Q1h9td5+EzDVvQ2nt4LB2oxHpbxbTFqqdw9SSW0A/T/6o
         L5Ka5ioGTX6awJbPdR3QLDA1tqc2PwNu6DxLd41MrGJqlK6lfaNh5fkT8BH4XHsAsdvX
         BtBSXDDJQuYMadCqA6s1KGz6Y64GLsTEIvJlEQje/nonqfLAlPM+xiAa+O4gJn1asiHI
         NGq0QOYsV0L2VLglD+VJNnIN4QMq2DwjXYDax/7dpZLWIff/4DfxsP7fqZm6hkDZkrMv
         PIYP11lbLxx43cQcPEl3F+mjjKuSHYKnrfXRkAg7ducxVPbkSUNclLuTZzvcKJw7woc2
         EiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AaMyHQJ1p4rKWp5nHWr8mginnUN2ilwCAB8zqJX9RFs=;
        b=U2OH+s1GZSjeya/RkoFRgOjQZ56l33tZcAamyE1qN4BSLIV1Qtcwx7qsVtN1MeFPom
         myiijFQf28If2LFxD7vMDX+sdpU9/0AOdS9z0z7036OzOxG73c9hhnAW7lH+2ttVidMZ
         K028TDlpnc0iTfZ9U2kjlegIH9PkaqForSv+kDQJ8V0D4EROfktcl80HnFM1GkIBF65s
         kS2ixmOLwFs4lRKUqTuPiyqfPo5ooDoN2K2KECZaaCBk1Ij1FQ+dACBz6SoCJ5WoHXrF
         SKl6rGiMx0YPyfgNOUjcOUzX/woNbFG74KBsSHY6RZ2S5+c7eWyVtdHF6Xibg/fbC5JF
         aiZA==
X-Gm-Message-State: ALoCoQkbL6XkQMVgThXqimn1Ga7uhQkVBOYKmfItm5n4EIW6PdQrU1L+wTuVfXnmoy0z7SIHjd1x
X-Received: by 10.42.233.133 with SMTP id jy5mr4543112icb.32.1402093762462;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id ds6si750433vdb.0.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 388995A44F9;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1497BE081F; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250980>

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
2.0.0.582.ge25c160
