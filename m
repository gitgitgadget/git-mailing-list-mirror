From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 13/44] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 16:15:10 -0700
Message-ID: <1400195741-22996-14-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uH-0008LA-J0
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbaEOXRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:40 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:40465 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so389717obc.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gPMAD2WPK1Ffo1dl+2jGzrBHYsqfXIRq/pdRf9xizl4=;
        b=K+RAl4AnJRYdCxBgVsHkQv9CAa+3qJbsWzGUSwDNlep6pN7E9zYdjPzJuNNhBKiil4
         EK1kM6SFL7nethXEdaEUDsog+zlkCZw+HO0ygpAIeoOLGJRYB2eE8yvaBZ6hcJb7itPN
         Aew7ygRenre3LVZeS1zBkQyd192gAy12I/IdBZHikSbL47bUQiLoNVmW+8N/cJsiWCf8
         i1+lsnmL35yc0QMyqCQP6r07+Qj/JNyyUjujhCJQ9veE6ninnVYyGJyrAeZ/a4lgvjYs
         rZ5pfj11WMaxCDcUO38n2yD89L3WV8MSLGYhNSMa75cDcnb9tPB6hxcOODquukxfnUfG
         6QQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gPMAD2WPK1Ffo1dl+2jGzrBHYsqfXIRq/pdRf9xizl4=;
        b=KZATSFRlE0+8mr2TImnG3nvC/UlC817FRXbyMt1VQ9+QKeXJTozQIu1n25XxNY2MUA
         v/Z1XHx1Naqhd13TzTXBtylUV7EAwkx6PLpebAhPG+3Mq6rR0qHvw4aNSso+w85czE2g
         riNzxR3H8BEJNOwVvXbyehoqJgLxsaMbzjGvFUisozxgGg/IulYvhn22X3W/0rgUEBMH
         G2dZBTlqam1UZzWiRWZr+2UBgoq7dZyoBEsnHf7EuDavmolZySE8qUEn5qQYLFgibKBO
         XbG6BtUu68W17OIV67j09d/7vb7Th3yILcVg8J1Cg0hqedoANcc6q9vH9XaClL/r4eVq
         ywAA==
X-Gm-Message-State: ALoCoQl1p2+8mLC8zdDu5kLKjFC9U5Gg2QlzyEEIKn52TCv+mOQESxgwc4dGFLhe9Cvnzd0eBwBQ
X-Received: by 10.182.153.68 with SMTP id ve4mr6609423obb.39.1400195745129;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si317564yhl.7.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F2F3931C1ED;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CD29CE0528; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249256>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..b05f9a5 100644
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
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.0.rc3.477.gffe78a2
