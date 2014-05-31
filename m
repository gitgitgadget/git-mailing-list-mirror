From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 39/41] refs.c: propagate any errno==ENOTDIR from
 _commit back to the callers
Date: Fri, 30 May 2014 17:22:30 -0700
Message-ID: <20140531002230.GL12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-40-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat May 31 02:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqX4H-0000w1-Q4
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 02:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934889AbaEaAWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 20:22:34 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47176 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934624AbaEaAWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 20:22:33 -0400
Received: by mail-ie0-f175.google.com with SMTP id y20so2367097ier.6
        for <git@vger.kernel.org>; Fri, 30 May 2014 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wFeXm8pqfV2u4SVFwcLqmfhOXPPS9cQw0UUZU9WQPzA=;
        b=mrmrP1FFVP2yneXHt8XIqqFeNH7gDzsmVKgKeqiuvTwgDXRIVXDCmgatcIbfNPGGjJ
         wiwbE1IJDeHG28QHS91Mfx398KcV3RUadGvN0gjx03YNn44burplFj38AauW+dUm2+jX
         oPSgMj5ovhk8Jp90iFrbC2Hsjx8cmN1Lmp+0FA12pC9ThhTsc3rGY31wjmmXHrmMdBs/
         Ehb7/hdGU2VIblBHNOqzG8hDlFGvBArG/pOfrdcGODFvCHjaKr1tT9SIqSMTWvyRsxaU
         TIhH+Jju5W4J8Iwe7fNvT61ep5ul1D1JCV+4Sx43KhjlKYT2BwIPqUFCJzavBWbL9Qle
         gKww==
X-Received: by 10.50.50.231 with SMTP id f7mr1030963igo.42.1401495752863;
        Fri, 30 May 2014 17:22:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y7sm9211221igl.13.2014.05.30.17.22.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 17:22:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-40-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250495>

Hi,

Ronnie Sahlberg wrote:

> For these cases, save the errno value and abort and make sure that the caller
> can see errno==ENOTDIR.
>
> Also start defining specific return codes for _commit, assign -1 as a generic
> error and -2 as the error that refers to a name conflict. Callers can (and
> should) use that return value inspecting errno directly.

Heh.  Here's a patch on top to hopefully finish that part of the job.

Unfortunately, the value of errno after calling lock_ref_sha1_basic is
not reliable.
http://thread.gmane.org/gmane.comp.version-control.git/249159/focus=249407
lists the error paths that are broken (marked with "[!]" in that
message).

diff --git i/builtin/fetch.c w/builtin/fetch.c
index b13e8f9..0a01cda 100644
--- i/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -377,6 +377,7 @@ static int s_update_ref(const char *action,
 	char *rla = getenv("GIT_REFLOG_ACTION");
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
@@ -387,16 +388,22 @@ static int s_update_ref(const char *action,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
-		error("%s", err.buf);
-		strbuf_release(&err);
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	}
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
 	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
diff --git i/refs.c w/refs.c
index dbaabba..b22b99b 100644
--- i/refs.c
+++ w/refs.c
@@ -3499,7 +3499,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i, save_errno = 0;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3535,7 +3535,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   delnames, delnum);
 		if (!update->lock) {
 			if (errno == ENOTDIR)
-				save_errno = errno;
+				df_conflict = 1;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
@@ -3590,8 +3590,7 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	errno = save_errno;
-	if (save_errno == ENOTDIR)
+	if (df_conflict)
 		ret = -2;
 	return ret;
 }
diff --git i/refs.h w/refs.h
index 88732a1..1583097 100644
--- i/refs.h
+++ w/refs.h
@@ -325,9 +325,11 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem.
  * If the transaction is already in failed state this function will return
  * an error.
- * Function returns 0 on success, -1 for generic failures and -2 if the
- * failure was due to a name collision (ENOTDIR).
+ * Function returns 0 on success, -1 for generic failures and
+ * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a name
+ * collision (ENOTDIR).
  */
+#define UPDATE_REFS_NAME_CONFLICT -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
