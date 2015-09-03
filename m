From: David Turner <dturner@twopensource.com>
Subject: [PATCH 30/43] refs.c: add method for initial ref transaction commit
Date: Wed,  2 Sep 2015 21:55:00 -0400
Message-ID: <1441245313-11907-31-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlz-0006yC-Np
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbbICB5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:02 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33758 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbICB4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:14 -0400
Received: by qgev79 with SMTP id v79so18601147qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+MFotsRyqAXmQl6RqxNxGJuRSJzLN8CMaY/nyqJcADg=;
        b=GPYLlhYu/9mLy+9WMvI51+LyZW+I5FVbyte3KZyMm2WD5PUPKMCvak9MPVw8V1g2wZ
         d4qKoej6yOE+ognVGY0xZ8sMBg7+lxuzcBINeOsNXptD4ynIXHKC/8cbd2M3czcmuKPQ
         7SJva5F82q0FUw0dwuw7YwdJNvTqOEs9eSmKyfB/fRm6bmEU7oEfMch0PrPzhAqAx401
         nDapnyFizzZbLDPJQP4Ol9fWaXl84fSggV7kg6lF6YOlDTbKM2oNTLdR3INkxyK4F80u
         ilWxzadvd9nCvScTch5tSTVdUfVceGFdaGpJIpXpvDFg3mQt0nysEgnju/cWqYK0n/dg
         zspQ==
X-Gm-Message-State: ALoCoQm5oHtziyWkXi5UXCMtMje5q0Hy3r/33ZcR090FPyJa1/wqpo23IbnS/rbszGQYtzHoFocn
X-Received: by 10.140.106.99 with SMTP id d90mr2324875qgf.6.1441245373278;
        Wed, 02 Sep 2015 18:56:13 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:12 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277166>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource>
---
 refs-be-files.c | 5 +++--
 refs.h          | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 1180799..c49d44e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3501,8 +3501,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3732,6 +3732,7 @@ struct ref_be refs_be_files = {
 	files_transaction_delete,
 	files_transaction_verify,
 	files_transaction_commit,
+	files_initial_transaction_commit,
 	files_transaction_free,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs.h b/refs.h
index 09e7305..da97a14 100644
--- a/refs.h
+++ b/refs.h
@@ -659,6 +659,7 @@ struct ref_be {
 	ref_transaction_delete_fn transaction_delete;
 	ref_transaction_verify_fn transaction_verify;
 	ref_transaction_commit_fn transaction_commit;
+	ref_transaction_commit_fn initial_transaction_commit;
 	ref_transaction_free_fn transaction_free;
 	for_each_reflog_ent_fn for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
-- 
2.0.4.315.gad8727a-twtrsrc
