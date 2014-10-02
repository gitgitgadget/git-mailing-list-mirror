From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/24] fetch.c: change s_update_ref to use a ref transaction
Date: Wed, 1 Oct 2014 19:07:22 -0700
Message-ID: <20141002020722.GD1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVnm-0000ak-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbaJBCH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:07:26 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43858 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbaJBCH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:07:26 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so1176708pdj.12
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4mvS+4Wyfh5aTq7/H8JAYwGP/Hfz4tTsc0F3I2nb5IY=;
        b=hN99Z58N7TurZumAS/RexdqKqk5Q6TOCCxKqcEEHyUge3u2JHyhaWtT2I4MDMfPmdR
         9Ertp7qNZVwbert0AUYBQXZYvzPjOf31DkHNm8e1dywbln1k8AiV2iYN3uHRzp7/qXXe
         4AvZy8PsCCWrMwqHz39OzSxF4X+GlnA64YqzOr8obGyQknIdNouadOr7LmPrddx4O3mR
         ZHWKzkVbJpoG9FwA0dW66JIzXXnodHscLOl3iaY4CJrU98zmhFPSLdTge9Mj/VOfzjZM
         VfcTQZJebhB6Rq2pTP7t0M1StnoyQbnaxedwyqvn9Ugbu+KIOhAAsJsplPrW/bX8YD3w
         vzfw==
X-Received: by 10.66.132.81 with SMTP id os17mr71858469pab.9.1412215645701;
        Wed, 01 Oct 2014 19:07:25 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id td4sm2118847pbc.36.2014.10.01.19.07.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:07:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257782>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 13:49:07 -0700

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- tweaked handling of ref_transaction_commit result (no functional
  change)

 builtin/fetch.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..30b40f6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,37 @@ static int s_update_ref(const char *action,
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
