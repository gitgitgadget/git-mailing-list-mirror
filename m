From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/19] fetch.c: change s_update_ref to use a ref transaction
Date: Wed, 10 Sep 2014 20:08:43 -0700
Message-ID: <20140911030843.GO18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:08:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRukd-00022Y-2p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaIKDIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:08:47 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:58636 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaIKDIq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:08:46 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so7536199pde.41
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BgmwAFTS2iiNbxsp9V9AhOld6LEKYWZLPztPWqxrZho=;
        b=TW7MJ35UrRqNjwEo2amTIkNQfHlNcLLVTg/vufjcUA+ubGh5AoIH3aYuIBwT+DR1v8
         w70bavjFyPm25dX/LYauWYuY5o8Cc73Y4egwpoL9iQzg9lE4Mxtm9yIcmBzchjc6Rry6
         +YR737tNP1lKvehp49N6h/nAdR9xoAeTOvZFfAv0VI/vXNAleh7jDXZBH0Bmtg6TQju5
         ltrRJt/jsCBdJumK0HFxmO6A7nRDJk4InDP6+GQ8DP/kOos5DoWW8pu4U+teOBfK25Fg
         RnSxBM0xMYFAf8g7xp3Any1Qww62AzZNNs6nxDRwA0aRTovTpP7mQc5cAkQtCwDzcR9K
         2kBg==
X-Received: by 10.69.12.33 with SMTP id en1mr43760876pbd.66.1410404926518;
        Wed, 10 Sep 2014 20:08:46 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bn4sm15752158pbc.40.2014.09.10.20.08.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:08:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256823>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 13:49:07 -0700

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fetch.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..2e3bc73 100644
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
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
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
