From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 12/33] refs: add method for initial ref transaction commit
Date: Mon, 29 Feb 2016 19:52:45 -0500
Message-ID: <1456793586-22082-13-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZS-00073r-1O
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcCAAxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:42 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33198 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcCAAxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:40 -0500
Received: by mail-qk0-f176.google.com with SMTP id s5so63748835qkd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6Akj7B2gSFNXIjqNB5sd4iNX89BcHvsBb/YVPJ+SGs=;
        b=oCcmi9a1ijVPzxJy6T9AsH4zNJu4CludqW7J06jSJ2FOEIRU7Rv9eJSNLS1GKtHvUK
         rxTgry8MtgCzEYLL5GI1eK3L4pkAXPsLHssyWe087Z2Ga0R+4PRqNjTIiae3aUCX2e49
         gV7XRn28BfKh/bb2e1Ec0t5qLjIWqGeMdmZbSxHA3w+0YFZukhQNcY92MO1Yr39gXDGZ
         +mJMZyO1QXFnBYNMhJCZFVV/DkTJBDE28LeWpbL2LIlAfR+fWEubL+iadp21yMOYZwJg
         rCOrfn5SQ6DgyCE9bO5SvGene4K8wTIE8zrM8LJn0+Ih3fGBZYA+/6rwXG92GA4R+62k
         wLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6Akj7B2gSFNXIjqNB5sd4iNX89BcHvsBb/YVPJ+SGs=;
        b=D7dretEdxrn5LjmljYuqjWEyBVN9yVVX7THRp4IWah1Dds5CSigw6N/bBYlilJhZuE
         sqtN8SKZauEp/+3/cGcp3Ri84lmzsUfeYBPobmSvdbvnN2KITWg7pcYE46n8i+KVpXFO
         f7x3tgr1qdZgCwy770KNw8McchxT/DkGkUk1V8pF254bwADG9TyBaq8O0eq7vuTDXbDj
         jm6nIHFnUrBlFuGR3LWbBFa3W65ss/oFmsWqc3ultfpc0Ir4So2GSBryjTNURPwKfeqr
         kpeenW7lZP265UnzUwDxRxX4gsNpCSis0FmoHGMGffD3uY6/BrrojSnHG+Qbx9GiUTFF
         GDWQ==
X-Gm-Message-State: AD7BkJIevUfEFpsTUOLgUO6bSxX4jTLSsOk1sVbIqb8sjjwUtCiE0UyPZonL5WgdeaHQyQ==
X-Received: by 10.55.73.74 with SMTP id w71mr23329667qka.60.1456793619506;
        Mon, 29 Feb 2016 16:53:39 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:38 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287954>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 637df71..b5ef4fc 100644
--- a/refs.c
+++ b/refs.c
@@ -1399,3 +1399,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a25fda4..1906875 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3194,8 +3194,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3419,6 +3419,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c92e0c3..5aa3fa0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -255,6 +255,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.767.g62658d5-twtrsrc
