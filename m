From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 11/42] tag.c: use ref transactions when doing updates
Date: Thu,  1 May 2014 13:37:11 -0700
Message-ID: <1398976662-6962-12-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxm9-0003FZ-MN
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbaEAUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:06 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:57646 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaEAUhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:50 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so674136pab.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pcsyWyXsK7C5NNq+ZtOQPSv98OXxL4O+y+Z6qisv8I=;
        b=pgXrp0yrQW2QChxAL6OECsSsTNCdQ2lDnR0Erx5Qh9aQ9XN38/n1HxaL0wGn66iI0W
         /j+/CFspu2XfAImy0j+bk0DvqGKPTi4sE7eyimMVhfW3lYMGtPT5xpc/LFuas9e/wJHD
         5l8oII7hNoJeMrJVlopu9QHxf50rja38yAy0rYTQQFVs6RJY1ujtH7ugla3afAkVqfNN
         rp+hAX5QNrCiX4iv/ZrCev36RfN/aXpwi7OB4sQ/0cjqmabRDHTQqaQuwxvVOuy8BiHq
         jA3Po8ZBz61GeAuNB8EHmxZnVehJpHwYU3xL5VBUEbmIFg/GH8P+CEZaaDQYJhjrhPyN
         d0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pcsyWyXsK7C5NNq+ZtOQPSv98OXxL4O+y+Z6qisv8I=;
        b=PubOXGRQZSPYe+SMyBEAnhwhEGXf8ooBrEO4Oz82mbZqLGFg6Nudoeu0HpeXU1EH5c
         rc7tGwbmvCSqKXtlQMTyA9V/aQdbLV68O9/rBItMskxjr76dIh4ZTAcDoy0dFgAxlu25
         3GAywQ5e6+Z/8zJWtkkTQ8egRiH/hHvdJ/qYzv2cCxbz7KwhjCYyqHAq/RahOp1IdrCR
         KWEVDl6lPngBKsTYfBTXmtilQPTBcKGsJlTkckEUGNuzvsPigRINTSM0rD5M/IYBTkwv
         KPjJq9tLQaOIa1FqMB+AhREVK8qkyBgWAiN7okNZ4FDSE/pfbS+ht73T154Ah54Fu/yK
         pgQg==
X-Gm-Message-State: ALoCoQlrTmzNg4whSbG+M7Oncrd1FEGlxUks6SzCzboGbbiQADwY/7+pykaD3diyU/i1tj0gdpnn
X-Received: by 10.66.232.38 with SMTP id tl6mr7127556pac.33.1398976669564;
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si2126349yho.1.2014.05.01.13.37.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6247831C1CC;
	Thu,  1 May 2014 13:37:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 254C8E097F; Thu,  1 May 2014 13:37:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247868>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index f344002..1cf5650 100644
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
@@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref.buf);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.0.rc1.351.g4d2c8e4
