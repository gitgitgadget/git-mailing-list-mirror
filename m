From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/25] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 14 Oct 2014 17:51:04 -0700
Message-ID: <20141015005104.GP32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:51:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCo5-0002E0-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840AbaJOAvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:51:09 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42935 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbaJOAvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:51:08 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so223588pad.33
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GipeYvr8s124rH5mN6QLaaWxoRCJSF4lpcVVG+1ARqE=;
        b=g+jmvCFRAdUXrB6vO99MzeBg3U+GoJBM3tOkEmHuNRgoeoUkNcI8YYAb943h7e93uX
         skSrSqWmfmOY/YOalSPREOb43q1EnhuatBj7zUwaQ+4pNqsQis+8FaLicRzkdisjEgHE
         lTeHVSSauK1mx5Ct4gyAr5AmRuDPpnEvTBCeKFTv4UgBBY8orUxo13ZU5eW6utmb7JSh
         BqPcWxOQuwMt23lz+jkc2UWOuUuTpto5q1nCBcYsvns93whI4bTzEskJp/Y5OVXun+Oz
         bXYFrBp3RL2ir1FkW/jiIfCdeLpbONmTKYzyquWoAyZCkHavAXggdz2HkSa+xrRlwXVO
         wVTQ==
X-Received: by 10.66.102.9 with SMTP id fk9mr7576427pab.114.1413334268240;
        Tue, 14 Oct 2014 17:51:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id hm1sm15311458pdb.84.2014.10.14.17.51.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:51:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 13:49:07 -0700

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fetch.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 159fb7e..6ffd023 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -404,23 +404,37 @@ static int s_update_ref(const char *action,
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
+	if (ret) {
+		df_conflict = (ret == TRANSACTION_NAME_CONFLICT);
+		goto fail;
+	}
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
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
2.1.0.rc2.206.gedb03e5
