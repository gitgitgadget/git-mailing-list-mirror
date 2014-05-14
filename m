From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 11/42] tag.c: use ref transactions when doing updates
Date: Wed, 14 May 2014 14:16:45 -0700
Message-ID: <1400102236-30082-12-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgbr-0000qe-2l
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaENVU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:20:56 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:57106 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbaENVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:24 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so34050veb.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zx0H7/IAxIiDn7yX23JQyj3f07iADuzECWEKVyMnwRI=;
        b=ok3Rm5DTqxlIB00ovxTAaEXVA1/UNeiSll5Y3SH3CG8fgUH525mPih0yE7FKMBr8BE
         9FqXkSVl2XsMZE0cZhSV4YU3ar+Ed0GOdPgz0CDMbwMJmTb3ld83vj7h1DTl0Wz74l4p
         7I1Uxot3lv82xg44vbCcdBA8N4c6Di243Y4ObFT87CY/tWlVfOwXSIYsPBJci1ZrRFGh
         na2dPef9HjJTL6MfMmrPtBe2gPgDzXTHh5oE+gY41wrj9SwVxf87I2v8yPtyy7foAZHO
         EWSvVWtZuFvGFo7I3YbRJTlbo+jYuJ4kkKox/K6lN4aklhFGN7aOVQy+M2HnGXjwKCfA
         i/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zx0H7/IAxIiDn7yX23JQyj3f07iADuzECWEKVyMnwRI=;
        b=WEKP1BCFZxfSvWMOrwkLjG/MYPM/BeY3ZewkcpXlC/j6ehiBiCdhfzLyZRuWfLKGFQ
         FU+sirukoBZ5SUSlW2mDu63taK8x1pvgqFyMDSnjDWMAfwN1507rT/CSSG9Deb02jTpx
         8OShFzRyNUEITnu+Uu2Ebbm1ToqgdQvR6FkxU5ry+iQhX0dO37XZX0TgYmt9Aea5MzkU
         Ft3RnPp0h7oyz9jEMWlqN2vs+YTvZc24UOU4A99xcO4k5ND7so4m3NhQFog66URFrUZK
         0OeqLVU7DYdlpPwaH5F47DYJFdqm0AfpZYflzDaDjvecJAHjkJspyyR2ZMX6ve/YGnTl
         M19Q==
X-Gm-Message-State: ALoCoQkz77YOO8NPxhmmDsehKgkonl46bbCpaYK1h07xoR5NFBugrJFGAcOCgEwKBcpUCxVd80cw
X-Received: by 10.58.94.163 with SMTP id dd3mr2959252veb.29.1400102243617;
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si144157yhl.7.2014.05.14.14.17.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 77D915A4292;
	Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3DBEAE0973; Wed, 14 May 2014 14:17:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248987>

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
2.0.0.rc3.471.g2055d11.dirty
