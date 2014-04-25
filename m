From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 11/19] tag.c: use ref transactions when doing updates
Date: Fri, 25 Apr 2014 09:14:46 -0700
Message-ID: <1398442494-23438-12-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdimt-00076U-GV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbaDYQPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:10 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:50181 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaDYQPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:06 -0400
Received: by mail-pb0-f73.google.com with SMTP id rr13so209295pbb.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1qpRlLhUhSIk8+nojh78jUD2DoKTnxZ7rTmTScIO2A=;
        b=kRxZnD3L+SJRHHoeDUdhuufVscY/d4sTpCBykeMzGNiEYa8OkMiiessJYQlBtxLIxO
         d7apM6omx+D6cOuiQ+ReibfLwr7pt3RakO7uhWxddMwyuQBKHE7nU0aSQWAoSEHw0KHl
         +4tCvhDz+M/20fCly04UxYdePSdzdEX7JzTopQomcF2rvBV72op9F3gqjV7bpmed4sji
         bt5fI6U2utdxjXKUMLuOzsFm9obR4Pvw21TS2gKUbittUjhzxVlSErZ9iR9/avuXpKTQ
         KSwKVb+693JieDWezE+75ejNbtd50MpfpmkL1JayWH45IaXrfrx8d15IlNGxpLO/Q0mu
         ZHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h1qpRlLhUhSIk8+nojh78jUD2DoKTnxZ7rTmTScIO2A=;
        b=XfDyNanMBDVuqDGtPIxrFUjFsstNzkEyye5O1LFzoKacYSOr8KCx5+TL/blWyMBFFW
         Fe/l+qpzs31XfeVP0biE0bAmR9KfxjsKDVmWFQqEgQAMwHWjknIjzzGaB2+jJipuvdYB
         wBSY26YEDCJR6Ke8JInrNCyN5QRHlIJD59Tu6ADj4Qf0KBXYU5f70x6KvJCDIVVKfEPd
         fKnOh6OKOi54shv+S5/GSoinC3aRTamR/bf7DCrPGBJ4yORKAN9sfqxfSMSJkU68Oysf
         aLhDEEVeFdYEKv3CZ7QOvqGTYcMBlIsNeEuMvf2cX3rXGHSdWcaKVOMUh1b9ox9O9qS5
         kCOg==
X-Gm-Message-State: ALoCoQkkqZ7QaADsHwP85+XBnHxucuwhfwGfuHmGnu0Z327G+sG/yCqVcd6kaRVcSNfiWaIrS+PK+UKNRENvyaIlHvXL4NA0ylsKiIHex+mne4in2GYPqB9lGOoma99qUhkEfMtOaE3J7BfASgYeSiGTJUZRJaQJza7SCIay1WjKRz9N8TazsupG3YAQlWNCmHf5chaAltkP
X-Received: by 10.66.102.36 with SMTP id fl4mr3580837pab.20.1398442504889;
        Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1050715yhk.4.2014.04.25.09.15.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ACC3431C028;
	Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69A74E0855; Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247052>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..dd53fb4 100644
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
+	char *err = NULL;
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
+	  die(_("%s: cannot update the ref: %s"), ref.buf, err);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
1.9.1.521.g5dc89fa
