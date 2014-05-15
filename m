From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 13/44] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 10:29:28 -0700
Message-ID: <1400174999-26786-14-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWI-00030c-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbaEORca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:30 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:38847 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-ie0-f202.google.com with SMTP id ar20so289255iec.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SML5U3MLjTS8rsr9rcG0D/cFzIHJFXYpxHjrZNjwEjo=;
        b=LhSS6nH8tHAbuAROXiwcrTgs1B1D1JfOSTSa89iLjJQvrTdtPqQseRwtiTbGVLVXb2
         KNHtTx9qxhWhLxG2kZ+GrUZVb/sB6sKckVmJS01kcCw4bUIcIRQMmOr/ubtX22O7AQvR
         BoR3dnlgt0PQ3lyZ4edNnTCxpmJ9rw4AnAK+xALYp7hQy6q3aykOpQk4UtoZmUEJhx1Q
         hB5qnimQteoec3DZc8PSVatVlUPSSQqT2zx1V4kTiBI2f1FpgmBobtmaX56Jk2haRznh
         Wb1MOX87NwbrHUGChN8LtLfJWn4iJR6SEtkzT0lq13q3UCqfpXIEQ4iW0L05mnxLdQ/S
         MA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SML5U3MLjTS8rsr9rcG0D/cFzIHJFXYpxHjrZNjwEjo=;
        b=aChGCWV8dzg5iJTbwmSBNs4bhUb4K4gWQ4wqYy68huqVUAgcZDmFsA8+ZjN1XcuNoW
         uFM6lKgWVIJVfqR/cmhYW5aTfbrrZjlQXzvpOsBZhA1BhmlDfU9Ya80EVATGmsqVk73m
         T934T62aLjQYYxTfyOq8nzqMkfsnoPZQ1RKS6ibpyhN3D4lQ9RbyPiObIKKUggpXlvzt
         fPXojb2SQAu49uz05Quc+JuAM4hNiH5ZarXCDwk4EbBg4x2bXUco8LTmt3L6XHcHF8pv
         DijoPIXcIsp7TG1/kaVXUEkd4jG2bgDxDx3OUUb1C3FDouX0JG8JjC6vOZrxxfgC4tpl
         1mMA==
X-Gm-Message-State: ALoCoQkYhqsbJUuhm1DweaxJ8IcPH5d7ltezht98RhwRoFFj5MHmQxeLpfXCo5qWZm9JH328U3GD
X-Received: by 10.43.141.196 with SMTP id jf4mr5117976icc.9.1400175006346;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si272579yhb.6.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 330A55A4263;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EE6A7E038E; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249161>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..bf2a5c3 100644
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
2.0.0.rc3.477.g0f8edf7
