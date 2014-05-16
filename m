From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 13/44] tag.c: use ref transactions when doing updates
Date: Fri, 16 May 2014 10:37:01 -0700
Message-ID: <1400261852-31303-14-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM4y-0006gW-KS
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112AbaEPRhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:51 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:38814 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so587636obc.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0TcY+3uyqNANaosB1yAy5/8BKzfnsk70yzSSeN0jkmc=;
        b=IzGYD3W/pWRy1kW0roRnxPLZS0uWk0vOcsLMamATcsLb6AG9F95WIJd+ocV8BkUbbl
         A9vBPCBZoJ2x3gGd5oDLDvBwhbYfxGRJrXB7aRlTCLUZdRYhHsHbxH0DMXsNDXindlbn
         SVevigNkOv/Ec1ohBsHm4jebRi4fFGMvVW9r+Xu0MN8d3YZkX8uzyjr1+Oy6JeBUZHZQ
         TUHRTPWTGJOKi3FOO4iVYSU9pypHtKu9IkNCBscIXKOjGlprkqeErcIM4DyGjR6QEFwu
         ftiBY/goI5jMeQSu1MQgb4y8KakNUd0IilwwC/qw88ClkfNKV2QOv9yo2xfFn3Mxi7lH
         0i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0TcY+3uyqNANaosB1yAy5/8BKzfnsk70yzSSeN0jkmc=;
        b=NUa/0xRmBvlja126psdE1SSwAcAgz4mNxoKjLBFe+Lwut4gDhemyU20BxUeeU9ayht
         4j3aLWVf+qfSAEkX1+fc6ZLLrgJVnVeCT527XwGWpmYbVdggFflg1ApoQXybV0qlPK7z
         NLElX1t4L8qu2bo6+YXrfL0JmfjPPLviQAtBP4mMEMs5N1/Mkp6KtW2m8jEreFXkrW8U
         b3A/YzYZTGJ/sQ3cguV72NA8+lva24yA4FhQVzO9viMJPSawZUhqteNjPDldnKPR/luE
         uvVTDXq/8Kcdi22TWQcz2l+2EQi1ymr6/D+txwoy9527AM0EmiwxJR+SKf8O7E4hCUUt
         HcOQ==
X-Gm-Message-State: ALoCoQkO++6FOYi07GX4yMIOfbMnZBTDViuz4TSRQYmaoiiUlGPMG0/xFhJnB2NwewQZ2EHj+42+
X-Received: by 10.42.209.18 with SMTP id ge18mr7784326icb.7.1400261857367;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si443259yhj.0.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 37F6731C273;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E0586E1797; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249359>

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
2.0.0.rc3.510.g20c254b
