From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 11/27] tag.c: use ref transactions when doing updates
Date: Mon, 28 Apr 2014 15:54:26 -0700
Message-ID: <1398725682-30782-12-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTG-0007I9-QL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbaD1W4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:17 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:33468 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbaD1Wyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:50 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so1133199veb.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l7m+/VyJa8IUz2ubpEL0aFjiw4iR92oOxI0w2M4v6xM=;
        b=MgdkSU8WY1G4Qv1KqExkCgLXx40sapjbu6/rR+E9LriqBSidxbrAjFEOEZ93Xlzl4g
         yMCXcO4xIUC6b+SkVbEj1ym+eWYJDZk38EKDOavjBhk5ukftN03cK7OH1dedbJqQv63f
         rlfSAMUK+u7jzzr4lo+Q4Ls+kgeitfAnqKvqcetW9SIMacfSgR5pTbHeU26sSTlKn8YW
         f1IdaPIXX5w2gri1q3+rQqIbZJAoQgL3sxl+N+KJ2HaH4wqEcGvWMMv2RDmFv4VqxtNm
         AIuKdMMOKG4uaLUSCUQKrQzBebqgqEmSAICFDm783zLhPntyDBR642QRg+GZhr/ScVr4
         V/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l7m+/VyJa8IUz2ubpEL0aFjiw4iR92oOxI0w2M4v6xM=;
        b=ULXKCKGuK5GCbvZD7xJDnlwpUZjaFp+BW9OhqnRwNruVYOZp+aRUyTQoLLW/VRt3p9
         GPY1AZvMLa04g2vDOq+q9H5SZo53gpeAb3EtNEBDUiD7g7Q1vKzF9JdNFGuEncV9vbNT
         Pj6bJxXnNt6kgGEbXtMEvAoY7sXGaRyIA9bukiJMGIW3A4m8bijcJ0eMwrzH9XnX0/Ju
         LkxKqGzdF9OPNwbLrtP3YGLu/zBmp3f+XSdJqERGnnybO3RX6LhcqzRg6K5/i5wRYNE0
         YyqTYUik7W0IMcifmEtMDr/iAO/LSncEQKeUqGVOBHPvuBMhxNMRVSdA28bDhFdqX0s7
         rOjw==
X-Gm-Message-State: ALoCoQkI20oqGxf5ph+3vS4ew0aw9yVuLfRTQcIZcU8+Zssxqrc6z8KJ4C+9PeZuXSaFUObFktUe+klxTJWiipT/sDwWSmJNLnUQQNHK81CJnwsqkkPPLxtaX6KLGKfZCn+7PhtCKFESX9Cx9He5QLsDaBhb9+lnRbzlioOyI1Af914t2Snv/c30xdwB9S6NA4/Ix0YI3tx3
X-Received: by 10.58.77.204 with SMTP id u12mr13487288vew.24.1398725690364;
        Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si2350124yhd.5.2014.04.28.15.54.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2DED631C20B;
	Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B17AAE08C1; Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247481>

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
1.9.1.528.g98b8868.dirty
