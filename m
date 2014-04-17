From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/11] tag.c: use ref transactions when doing updates
Date: Thu, 17 Apr 2014 12:46:21 -0700
Message-ID: <1397763987-4453-6-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:47:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasH5-0003nA-2r
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbaDQTq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:57 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:63838 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaDQTqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:38 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so125031veb.4
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q09KFIcmhG7UEuVBQ3UbWQXv+YySygJOwkNykJ+TGm8=;
        b=ZT4IHC/eM+L06rvWsx6NzlTuDerlJatlx0ygDSMS0INNNLMI3wdShWjS4bAlpl65/9
         Goe6tY3PCU4tAGePjGsHfcQeTFHLLmaZRsRTnmuTBOcNJt3BFWVMleivDoBeodXeTCKX
         qXW8gXkjqQDHyFoON/1ldOTSPpAFkw7MpRptYA/88fQPhnlos9sHQjoydTo3yPXgW4XH
         A2J9XCEfStCsqE7a6+AER5ErMHj0LcSAqaEhby74ixGcvy3GrevKYZeebmD2Y9dBTkv3
         aMn5VR1sue10s1p6aVr4NvhgJDIIgmuN+FLpGt1kjOWHUkfa6+/DYnOno0fVsiZimGXf
         HOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q09KFIcmhG7UEuVBQ3UbWQXv+YySygJOwkNykJ+TGm8=;
        b=D/IaoYtE5w4HhDY5wHumaNDGkBNw4vjk2b9/l21vsYKj6myi77q3ZZW11uBaZpmZ4q
         colzbYcNrVL69w1+ZJ/I6qicaWNhYGj6UcJMwR2AqyMh6dSfQQb/Pqn9yV5TthAk9JIi
         1tX3hsda0oE3ossBFKkORchKqE+whGER1Nq3qRDpSvpdqbjrHm+UfPV2Axkn3KuHC3y7
         DoGHILZDCUExKOmK9NtMIN7gumogJGWVmK/JgGwiAqGaztsNWPVJsAQ4nADPv7e1uovk
         nRZIklq4ibT2DnehqhwY+wc6xwTiZ9K0awNuiBTbacTjWiIGBGbw4ak1l52MS1UBuSCX
         Bnow==
X-Gm-Message-State: ALoCoQmhOymfZhWgrG6WlaiSOhkeQb7Iv6js731bO+aLrhxZlZQZXQvt6Zb+/oZI+QcCdD4JGMbZ9JGb2hOkwkd60r06XgVtWXdUzjCfEkpP6geGsgDhaq66aRtjN4gK9LFJyGN8UJRlxwZzGLNh/GGSRMWpM04e9e3PP9cClxK0vBj+CwkWsyWTUfafeoYAcxS7U3p7lJ2v
X-Received: by 10.224.6.198 with SMTP id a6mr6482146qaa.6.1397763996903;
        Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id s65si3654759yhc.2.2014.04.17.12.46.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B9C2A31C20C;
	Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7DE1AE0967; Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246442>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..dbeacc5 100644
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
@@ -496,6 +495,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -641,11 +641,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref.buf);
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		die(_("%s: cannot start transaction"), ref.buf);
+	if (ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, !is_null_sha1(prev)))
+		die(_("%s: cannot update transaction"), ref.buf);
+	if (ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
+		die(_("%s: cannot commit transaction"), ref.buf);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
1.9.1.513.gd486896
