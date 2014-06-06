From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 15/40] refs.c: make ref_transaction_begin take an err argument
Date: Fri,  6 Jun 2014 15:28:53 -0700
Message-ID: <1402093758-3162-16-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2dv-0002LL-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbaFFW3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:36 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:54816 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-vc0-f201.google.com with SMTP id hq11so681130vcb.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YmlaKcZlnN+GL9Ho/TnkvQTks/G395Nk2oWD1A5c7cc=;
        b=Fj0HaTWrHwZk4AjxO0D5SPrBsHpx7aWd0FTtvzD9QotR+WsvegJNWLoVjdNNmzceEH
         hNTEQq61whQ8Jv3DfEC0XjMJ6+Xqm0dMcsPaM4T/o7eTBfwbW4AF8Cg/7AZ7hBFB8IYR
         GG64U6icEzqSXleO9LTRyU7KQaf/Pj/ULepXe78Dp8O5pCdvidyx1oXTdvyiDixLLMnK
         TMEadzFwHO45YVMdRRxSdqMu8uu/31+IPjQ8BeXMHtwuYRu6I4tnwFTdk9AtiL+DlqkH
         eZlpeFZqS6817AOAF15Xd/DrtOS7P1cwHj5kIyBHmkbeGjAq1SpH1zoiLCnWiLtiF/ud
         3X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YmlaKcZlnN+GL9Ho/TnkvQTks/G395Nk2oWD1A5c7cc=;
        b=DoaC68c/51L8GFL+oRxjpP0NrDwQYw1PibRes2gQuGypI4e7EvUWghwQGbwnuS3/oc
         huH7xtVsq5a4+yYyoOjQ6/ESAt1ETxTvyrrQzwn+7iahpSJPYr+MczfPOw8NQi7nYCpu
         6qHMCIBAmH1CaYOkjZr8aIz9NVrd1jjnL1amumYQDSzyxZCgIvavLj6YFyJVVSX83HCA
         eshhHqBbVcBf2Rd6fbw2bKOq93jaz3kzmDd89qcg8U4JGIEHqE7p8PLYpC8zwB92pQ/M
         rLk5yJoof261QEffxwwCht8KPQeSnrqDme4K/2Uo3Mhc01f4GswgCLIZzc6W/s5fybVD
         OknQ==
X-Gm-Message-State: ALoCoQmsmPbo6h93rubgG+jrJTzjBNyfwQSflls8osPRMXHviDWyL8HSctK7nM4emudJoVbA7Z4A
X-Received: by 10.224.12.14 with SMTP id v14mr4774867qav.8.1402093762176;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id pr8si750951vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E82AD31C62C;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B5DF1E110B; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250978>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index d9b99c7..ee87eda 100644
--- a/refs.c
+++ b/refs.c
@@ -3387,7 +3387,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 58ba365..743358f 100644
--- a/refs.h
+++ b/refs.h
@@ -257,7 +257,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.582.ge25c160
