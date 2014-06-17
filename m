From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 25/48] tag.c: use ref transactions when doing updates
Date: Tue, 17 Jun 2014 08:53:39 -0700
Message-ID: <1403020442-31049-26-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviG-0003WZ-Fy
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbaFQPyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:17 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:50486 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-yk0-f202.google.com with SMTP id q200so355182ykb.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sx0I4/9qRhbYE/DWCSTTsmlf0L1osX6GUf6k0GZazHM=;
        b=cTwR+IpYl9zmQXBopNVxsTsYNuxnz9LW9D6B+wcKH3IGeq6F4D1WloadU2dSDLlvPf
         T4QeRbUcWDz0YcZH6E0uyJc39Jcvwy76HkUz1ThiGxDPGMVLWiXc6DPixn4l0d0e4lMY
         7narXmhTszwaZLEYweuq0p2NU7Ch5b8PXkFnGF1ThVHnpwShDh1F8NnznF6lp+RqgLYQ
         td5M3DLTmQnVGqVw8e64bG5G6f+vH86Yp2N5bIYltYAPrwkLIKtBvGR4M6J06IXOu+Q9
         /9PebljMLHQybCzt8sihucKzBkoltCvHjibwehxZKc4/PSqoqaDy/a3tvjmYQkKUHrsb
         YwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sx0I4/9qRhbYE/DWCSTTsmlf0L1osX6GUf6k0GZazHM=;
        b=SOATl7OgJYKk2UShfYssUNim06qJ0BhSEVEz8tAK1Tej+JY3aVTQaM705ly9EYt8hd
         25nqN+jEya4Zin1iVn0P01y/WPIjwbFaKsuBWDBq60Mb9bV2/JjvkhA2hUFbXy50mtAO
         UE9V1DwxBK7o+czJvXgpH53014AaNtd2VZ+oV+sfJ28u8apM88UcS0UEMWR5zHHwFpA3
         h8gBNUtuPkEY7JPgzrbMHJ3XjRPLvg4GYwi+tvCWD6/99vCVMVLw99QR6hR1h0+ZpIgx
         EZZRJxNBn0o/mA56oupOnTv7N8st3Fhfufv7L+9FdFXRzuZfFDoGBgKTGmcYKCspXKdW
         J5lQ==
X-Gm-Message-State: ALoCoQnCMy8NZfnaiwxV1ZfibPzuSiZC91X6U7/bbjy3wEZaUQE5uVfzXaI+2XaJi+UnJK83PLhT
X-Received: by 10.58.65.38 with SMTP id u6mr579690ves.16.1403020445313;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1209464yhg.2.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1BC5D5A45B3;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB9C2E036B; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251873>

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
2.0.0.438.gec92e5c
