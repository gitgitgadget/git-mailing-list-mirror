From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 24/48] tag.c: use ref transactions when doing updates
Date: Thu, 19 Jun 2014 08:53:06 -0700
Message-ID: <1403193210-6028-25-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxegK-00081s-Is
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbaFSPzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:01 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:45073 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-yk0-f202.google.com with SMTP id 19so110394ykq.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJjbZ/hKrgedfm/GhofdoNSLy8TX2j/v6WyG7PQUdSM=;
        b=jBIIgcU4FAO9ULSB3FZ09CGjZ/ee6qloe98xvCYSA2KRZ9eObKB/Rdt3s33hn156uB
         yqgF/QHEi/yzUzpZOcurAqjsalY5p8ZZFscXJnmBLvydeVizoplXO61/7XB/xOwimBBN
         Zl3Q0HHMZVTcR44NX3pNiy8aqCyA4FeaNUkROF8WxqBrgIfVaU1NwzuTi+fMRQ6m4vFD
         8IBghtoNXLaQuazfn07i6p+Ie8YJI+Z55ZwO5HROQAwDALcaDsFF+xnoAk20tksbqQ34
         qaU5bIT8S2CiK/Qn6GbkGARhfrSN0BpjPuwAQ6l+lVr8+QiXEycY3CzdXjRAKos9Tp5U
         tDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJjbZ/hKrgedfm/GhofdoNSLy8TX2j/v6WyG7PQUdSM=;
        b=OCzFwjVO+ywZ6vWzF61qBTRuuPMwcnDSZUQiJQuzPD2XMVHVrsIqs1o2CXLKvTikDt
         GaNDJFbNm6jnPkQY4l5LZwcAOst/mLwGy5m/WciHEP3lHf7Z4Wechf6hUkZlP1pNVqPl
         Sxsc1aL9sBTgLKdvOqtYKCFtfwxoKgjaK4pMaztw40OyTFvqgDM9cMo+voxpWDwJyYOq
         M3vdtBVck8mz8PJ+WUwBKSy8HKAMvblEfNlH6/0Q9XtzB1Y4PgdT9edYO5kUvMfUYQ1N
         oEOIznDpUEnWH/9Q+p+Isf9JdBCfl+l+FWNwFDC7aIueiGd2MgOXPybeVrdF4ELRKD50
         201g==
X-Gm-Message-State: ALoCoQnVKYzoPFzIbr7zie/EAsXm5IOHh2mX2QLWYvtJGtFcGm1aVwIeccNr7blNhCM1njdQ3mOz
X-Received: by 10.236.128.112 with SMTP id e76mr2274162yhi.38.1403193213621;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419900yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7A23831C416;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5579EE094D; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252138>

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
2.0.0.438.g337c581
