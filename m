From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 15/44] commit.c: use ref transactions for updates
Date: Thu, 15 May 2014 10:29:30 -0700
Message-ID: <1400174999-26786-16-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVg-000206-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbaEORbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:52 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:38449 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbaEORaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so241330qcy.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3cvXurnmKllgYkjDjs5PXgvjVyRH6ZEnSxfU3xWfcTA=;
        b=nYFPHPzAgvJBUFSoUeUwGuHxyl5ZBzHzBLV2/NmWw3zHtCNcqhVjBbPhxboc30QVhi
         4iJfQ2QoWvsyQLLO7WohkzFKVEZtiGYjiek2cG7BpkCGUU4FFVeMsIpsn9s4F8jIn/QZ
         uHjbZE0Bva5nTasL6YynQMGgc/w0etM7kG99RDNYw+5f8Ct5z0PShL4eu9fxMlmDre6Z
         PH4eVIc7IMsrn4nKTWMH/WCQMV2bSmqpTFC9GbOBnIn5c6QwXiPHOo8yqgzOgrJ+GfTD
         HizvZmGNAfMSixIHaufmuvVESqvdht9pxADlyQhkzY7S50Eg/aCHFfLYF7L/+ARVMUTe
         iwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3cvXurnmKllgYkjDjs5PXgvjVyRH6ZEnSxfU3xWfcTA=;
        b=QFtlNDCBEXTB0+bIsn3r5Tn0dG3r8SgshrHhaRpY5cJg02vIaEsEJXqoMhks6haDT2
         DpEEbapBnRWkcWcJGrjsuPejB47lcUoNIrrdY9wzNV3Eo53QqvYfvKcFdqlcmiAX3x36
         Vl/gS2o7cxd+64xN4dIuJTmgqNHynmWrcXR1dkbLO/VqTNQV1E8PcQit7Fn5EGcDX5zo
         D0j9Oxjn9bvmacWTxcKpM0J7H/BbA5ixeZsniw0bf7PzakhXgiIu/XM2j5sSBiwkqsw9
         sLIbERtSvUNK8CUvmhkqa+y5dOhROhPLCSyhzMMvaX0x0tIyhZjkxZV3yNoEgALu7u2S
         cYig==
X-Gm-Message-State: ALoCoQlVf+nxdJk3+mV5ja5/vjekgJHE2t3kKxavlnQPelC+ws28C8R/3FGBz2eX4QBKVGGPWGcw
X-Received: by 10.236.162.9 with SMTP id x9mr4850051yhk.17.1400175006340;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si273162yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 351FA5A428A;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 088ACE0B2F; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249153>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d28505a..592f019 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1581,11 +1581,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1707,16 +1708,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1725,9 +1716,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ?
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die("%s", err.buf);
 	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
2.0.0.rc3.477.g0f8edf7
