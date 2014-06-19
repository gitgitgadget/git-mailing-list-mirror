From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 19 Jun 2014 08:53:29 -0700
Message-ID: <1403193210-6028-48-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxefb-00074w-3c
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbaFSPyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:21 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:35439 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758082AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so332357qcv.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AFzhHPX05YpX5Dj78Oa7Pglb7cbNj3JeC4ffebJ0gx4=;
        b=Pc40Dt4Vfs6x7Ms14itdK39e1USDZPDL+E7aHRYeUmRWViPcgQvuivWf8CLyg/rsZp
         ysFpNvQKJGmDaSeDpLnqwJ1BGGe3dt+iRWc/AEUCkY2V9cqgbq9XjjRz4ovbzb9Ciqkn
         cw4UCeBSRMAv4i3gAPzKhSn7c8iU4wBWqt3jPNEVBd6f4JAaWeuiamdK5+x5JhcMdFPD
         3ZDUQcoWTAPjQx6jnz0pKgWyi0JgX7aSmO/LuqK/YpEk86biLh6Hcbz0mDgkt16XZrJZ
         08CGgPgp7H72BmEVVx+AEu7eSDUZhrfbgKSLdajW8Yr4gl9TId73XlF60+AUbOggk1G3
         tGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AFzhHPX05YpX5Dj78Oa7Pglb7cbNj3JeC4ffebJ0gx4=;
        b=ExaZFc1tEj1gq6DlFuReNuKTMGvlVWp0wKEiVZH1QT6h79tyDlle5HOdYT4liBN4y+
         HNf06K0jZNVPkV3rwpP9CNHiAoAalQdE5PfaDVLVXZDrjTtPpf+10IaIHHslffrPTYFs
         IsRuExJrbo+Txc8c1EmFfAp+pbNkT6aGOMISYd8wiQtWJakcllPgKtAFDh9cw53evlig
         MK2eQ1Gk77BZYBiU+lHSpr/0eO8Nqu+Tqa78NDbjBjfGkHMefx+jthrwZRDfyp5r9x6I
         Z3I84w9tjBVIDz/Tz3X0AJg4ISfM0EkLCEUwTuS6yyyvZnhnaZqnBBMt+VXqzN4ANTSg
         d7IQ==
X-Gm-Message-State: ALoCoQkPb4MGENKo0l7colCuY84MuHO4ST3AMHtLE7b94Ehybvv6FJ6QOUGPPylOhuQe0lGoR8Kw
X-Received: by 10.58.195.162 with SMTP id if2mr2647993vec.21.1403193214705;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si419906yhb.3.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8C10B5A4435;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6E93EE1106; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252131>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,36 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
-- 
2.0.0.438.g337c581
