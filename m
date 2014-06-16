From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 25/48] tag.c: use ref transactions when doing updates
Date: Mon, 16 Jun 2014 11:03:56 -0700
Message-ID: <1402941859-29354-26-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKR-0007V4-4F
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbaFPSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:10 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:50751 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so1153385ieb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JgLgguqdlNrh2v9bYNMIxPvtnCPgGUhzm118qxYRPfo=;
        b=N+JugcwV/DhlB33guDp+5wYFpQszwQi+AcebdQSY3JHkRu/Fl9G1yVcLPwX6wvgnt8
         XkxVbQXLlG6seBtVY4/GnIY61hXWJsVSxBhm7y3S7SHbfbxNfh/EO2XVigJNBBJsf0ze
         XWbtVDDe5jtiSOJjUhCVntmZeoiM1It1WCPZI0cPJoG/BR10nsdPQS156zxngNwARF2X
         HZ0tTMeBGL50oPG22I8rNaTS+YyQlFL/QuLVIPsBDlYeqB5X3agt6SkLsY1qRfqtoxuF
         FOQ+Ame/H4AZk6qXtm7Lih2b7S7BSqPLqUQp1Ov7L37aa5UvYDvlxZ+0quXEX4kNGQEP
         0iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JgLgguqdlNrh2v9bYNMIxPvtnCPgGUhzm118qxYRPfo=;
        b=QQE0Ql6BNEyJsh8gZm6X7v5NZ41gC/svMBI3SSTH2rVtuhu8kZoJjtCdnfBkijpPio
         yZ+9+QY+67JRHtXeINCT3OLC+f3CqxC00XMrJBKWx8WoLGvkOAb9wW+waVOe7hggMeSN
         MqlsJFWCR8XliypaTT6npZofJIRYtEQyumi98ZR4xjA21xU7anL7JeBecoV1RVgnHfVg
         g6H3938Q/92LuvVyFUdnZRqOZ1Dc5fv5VQ2JdyxBd7vBE+ENnmpxv1zq5IrxFaxPDZOk
         QlzNApDEiEM1Oeyx1Tpk4VIDFkZlycCT+9lQ5N3Ru+IS6M3+X9DKmdZ+J3VG4dVqizRs
         EmUQ==
X-Gm-Message-State: ALoCoQmESmNeBcA39IUVUuC/9lo/k77GhT53ljlf9KwsCnUSBpVaoPNc2dx/Y/ppdYWqp/cAVh8K
X-Received: by 10.182.66.33 with SMTP id c1mr1718306obt.39.1402941863399;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997325yhk.4.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3DC645A4911;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A3CEE0F37; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251779>

Change tag.c to use ref transactions for all ref updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..c9bfc9a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
-	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
@@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -701,11 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref.buf);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.0.282.g3799eda.dirty
