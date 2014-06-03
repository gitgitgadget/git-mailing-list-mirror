From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 17/41] tag.c: use ref transactions when doing updates
Date: Tue,  3 Jun 2014 14:37:35 -0700
Message-ID: <1401831479-3388-18-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSc-0007Xw-67
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbaFCVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:20 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:57360 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934199AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so1408504veb.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3D/rWgwSXzyt3O5lif+VvSqDh/6LiEQWuCduIZXLRM=;
        b=A+Eo7AfXdv9VF7l76OjYNbXVX71DMGc/0Zq/sk5phuViA4Wv+5JwBdlGuVBvULlq9x
         Il98nghHxDPQfczN2hXIQ2fZsYQvdhe5ND9kke4nABbP1kZf+OxHIs72k+VGL2YvaX3H
         q5QwPqfswBuDvw5uq48yA8DxvMKoTN9/T9VPJS1lP/ooEYLY5JbXNc6EnU9bx12GDwqE
         ahV7ey9dgYfoFLaqlEFb7xaeGwo58NcgVYMXGq0ZLr8Sf910QRawl/zARnExQcA8Gyk7
         Z0Ik5kz6Upp2eO+YxAnmHNizGJBaOd6QoL1i2V3Nez41oAqT933NjGraah6Xc+HcXJ0n
         foog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3D/rWgwSXzyt3O5lif+VvSqDh/6LiEQWuCduIZXLRM=;
        b=QX6z9BglzSG4t4yhi9S6F267jzddL0GxZMjywlZBKhXLn1q0uja3Fbr79w2OMl4Mpn
         T2Dh3lQGlsRqR0RlA+cf/SHeRGZTusbdMVI/CfT69qlZNXzrBOMf+OzKc3XeKEzASjFt
         p2tuSDaaDhfq0AAmwEBtUKbWe/0IDqONGS2zjNW04rjQ+q3KTK0/12voNcDMWQTlOsYk
         /U4INBcJREJC0Dhv1JUGalb52Dc+ffacX8bK1M5jPvg/sMcFcu+OmHqVAKxiGaOW8WkC
         S2hIFTqe1Vh+ZBCUGy9Ryx+5bYXsyJbU50r+tjGKL7PF29W6c2AlCOPKnUUuA+Nfi91w
         3v1Q==
X-Gm-Message-State: ALoCoQm72VyykfPJEF/BVuR5l73IDON87FlQfjkSIyQZG1UDwhrl7cZ+CE7UGyfXIYa0I/ha6aRu
X-Received: by 10.236.87.73 with SMTP id x49mr16735063yhe.30.1401831487584;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si30039yhb.3.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6A23431C435;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4823AE0887; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250673>

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
2.0.0.567.g64a7adf
