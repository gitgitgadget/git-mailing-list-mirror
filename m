From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 25/48] tag.c: use ref transactions when doing updates
Date: Tue, 10 Jun 2014 15:29:13 -0700
Message-ID: <1402439376-25839-26-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYt-0005Hk-M9
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbaFJWaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:01 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:44110 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so450475obb.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l5XjkWidyJvNGhuxmwGMGIs6tCICyNwb2AG3S8ZI6Xs=;
        b=Pn2+Oa7m/ZcpgrUQPqc0D2dQ3mqOAuncHCmKZfnP30o+mVH7JZ3/MW98EHsVkod6HT
         oDSrDidpLnA6JoiMBbQYCSgyOCfXJ9Qa9uZq0dZIeMUYwTZOgk5jif/EC3TJYi2784ox
         6cRH8CP0CNf0yoRKe9vB+jwDwUXLXVFtsjNmf+kRCiCi3/ANwtR5MjmPC1JKO3XzaFre
         rI/BrLkRK+H/nRwNXl5YIYB1e+8A4r/3Q3u/ZFfd95hd38mvcjBd9FbRigNY0G0MRwqF
         JYd4ym1GZ/ENtNzLeeRqmAcWEWbZtNl4uHc9pAyPWDEFpXRKjFK8WrcpngCHVR1y7b9v
         yO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l5XjkWidyJvNGhuxmwGMGIs6tCICyNwb2AG3S8ZI6Xs=;
        b=KB8ptwf9N6cFhpLvRhJLGA3lhQovsjqZo5aTFHmvplcrgG1fmO16rPU7+1VwzdvFvB
         DXIVnJPyS4kgFui3ZtAWJu8/OJ7jyzbO8mhTPgz4qJxp6LlCQptO/H2W9JupIA6eoOUl
         w28ABBY87jHtBa41EZAX+ZcfpFjgctQHqQH3q+6V/WaHHmtWse9RjJvLuVK7IHIxr3CZ
         EvNIVpIbVpmn8Kadw9Cg0EjaGqdnpDZbNrjMwgMMQBxjYS4lHyPgV2Mvcj1Eb+VvmjKc
         HM6Vpx1+eIvIfM5xwc6pXR2eSaMy2QQSz6XfdOco7n8VIs9ktvna+yWQRxXIbvrpgFMQ
         KXhg==
X-Gm-Message-State: ALoCoQnEZO8xRAl8VT52LD5vJ708AQ5Id1kUgAnSiQs5wDhGZ1FCiz/kdLYBasCfzT969xCad6wz
X-Received: by 10.182.58.71 with SMTP id o7mr3458525obq.3.1402439381096;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396562yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EC9A431C746;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CDA91E0BF1; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251291>

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
2.0.0.574.g30c2c5e
