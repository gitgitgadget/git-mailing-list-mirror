From: David Turner <dturner@twopensource.com>
Subject: [PATCH 06/16] refs: add method for initial ref transaction commit
Date: Wed,  2 Dec 2015 19:35:11 -0500
Message-ID: <1449102921-7707-7-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Hsg-0006rU-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890AbbLCAgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:14 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:35896 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251AbbLCAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:45 -0500
Received: by iofh3 with SMTP id h3so64842507iof.3
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLKQexiKzUngfMHJHERP0RxmxBLnb+yYIVr6qUg/kgI=;
        b=1QLILh0a/I+Wrpp9uCmYLo254XJs2DFK/GJSBpT/+nIciA1L0lFiwcxmLVlA9ARRNg
         N27/Ju1XINeK4fqkCfDV1K4EI2D7NY6mmgZPfrLyHaksuM0G6bxRORlJYx8xuaAJ5Xwc
         /ZXqOJIMHb0/Sa/X1X1zSagwPgalMTGb3oBlIjML4mNqXn50wIvcmasWnjRayXQnBzI/
         rCXLVH9eCRFrqNt10EmK/4OSrm9syhv5heEO2zC6UblqiSz52lIw1bnOPwQVufxNVNrd
         JKap/Y0gthNwxhB4v8C1eplj0hYgeMAT030dD/7Jig+iwO/LcTDCN6Spl1+GynagjXe8
         bWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLKQexiKzUngfMHJHERP0RxmxBLnb+yYIVr6qUg/kgI=;
        b=ccxkuc6Y2iILe74EaNcc3f2dO2PR07fUsaTUHR0frpYUy8PsMadFt+e0BtiTJIT1uG
         Ls3O0/tN68tOmQZXijH1PjtTFkzYg6H0PMZZj2omOQb4N9beB2697+PltGhYgKZ0WQv0
         wU5kz9Rwel8eNTI8Y5LmSnEfsNa/R2QoYJMxa4C1kjzhziDY1o9Va+g8pffzjR8Qyy0M
         Zeu7R668vGfxk2Q5Tw/uvd/OdPLGG4V5v+vJL77BeEMKkMxmJZgOS4c/gi5MXqAdVYVi
         Kld0FA8XuZLGatP1VlAgz4s2aoWA3sVhOh6pkPtggsAI4zeV038ZfFn8Ixn7wF6fw2Ul
         J20A==
X-Gm-Message-State: ALoCoQkOgiVXSIzHQhL/PPTouM0RIwP5sVB4dW1j1BzE9Y/8jH+fvWxZRG8cZgdujto25L/DeKUI
X-Received: by 10.107.41.146 with SMTP id p140mr6189686iop.80.1449102945257;
        Wed, 02 Dec 2015 16:35:45 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:44 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281927>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index a8ed77d..e50516c 100644
--- a/refs.c
+++ b/refs.c
@@ -1250,3 +1250,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 1f76e34..44ad632 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3313,8 +3313,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3538,6 +3538,7 @@ struct ref_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 798dee9..74bd44b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -267,6 +267,7 @@ struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.749.g0ed01d8-twtrsrc
