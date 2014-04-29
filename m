From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 11/30] tag.c: use ref transactions when doing updates
Date: Tue, 29 Apr 2014 15:18:56 -0700
Message-ID: <1398809955-32008-12-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGOk-0003OZ-OO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbaD2WUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:35 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:48226 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273AbaD2WTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:22 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so205560oag.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g69JA6HcbZuX8JJje3EaWWjw4TMbnxmb/ET4laVDhck=;
        b=QXNr9hcjvAlckA1evSnh4JljPeQ6pPu2kJ/FTH9u3smsfndaZhpWPp1J9EKLGzL9bi
         tOcwpFZTZ8IRIEqcniSIPui0Z/WNCgdt9rmjWpUbCQ+MLLGCjm8cS1RccXjcfOPntzyR
         FbjinpmtRSUuXrqocOzQ6a8TpT3iMAsnX4WZ3lqwKTx3JRjyBwh2prwxirC4aY5zryXR
         BzIYg7D8H8yZQOBPsmwIA5EDKJcupJM+JzAPoeZO90wZ/8u6RE4Jvjv3ICjIUj4qvhIy
         km94+ff4xIHmOVd95Lgnsn4svhuSJSucxtKXNSZ3f1lCqPj+9v71m7+Zr6mmAJUx2eye
         AITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g69JA6HcbZuX8JJje3EaWWjw4TMbnxmb/ET4laVDhck=;
        b=TgjUgN90/sK23v8NLIjtx1QjxIgXoqCsMo+rVDnQsCUx5NmvCq8QCrU6SK0CySOid0
         mMNlc0N5MMv5yqRlF7TY/1PPAY2r4QsWIeL/F8NvhAR/8gdmnZeIXAcC+N6ZKN/2a2C8
         p2hbB9kWLjRGNovmZCwheNR8/Ygn+7N2vHpb02rfDpA3RsvbJNYXUHMZjRjVcxjEPR9d
         ACrrvKHWPnvee9Hw5ioK6hEcNmz2HiycQbP+0MhCeuDw38Fg2R/xyyC6ydQjM5WY3yZH
         hp5q3uch20/TbG10ZPTbk7y0BOg9Ru6j15M4fRjryS+MCPQElQGtOK2qDcFwkcGQdFaE
         C4EQ==
X-Gm-Message-State: ALoCoQmarvMLfR8GpSY/JAQ+qS5HKSnMPoAhmrI0bCrHbFRM1VAFDXZ1pEAOEQJqfHHPyA/cj2I6JSr16SSQIaJy0HDT04emJ6sKPV1EhK4lxbdOxybKh2HzW8fsxS2CInbc8ELIN9FVSb4rl3NauLMF1hXkBhQLh9qhTXOWdiiDCiM47qKuJmkJrqGe0XZ6F3bTpDbPyeac
X-Received: by 10.182.45.131 with SMTP id n3mr352139obm.20.1398809962246;
        Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si2306120yhj.2.2014.04.29.15.19.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1950831C1D2;
	Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D2013E0A5B; Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247645>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..31e32cb 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -488,7 +488,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
-	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
@@ -496,6 +495,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -641,11 +642,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
1.9.1.532.gf8485a6
