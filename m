From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 09/13] sequencer.c: use ref transactions for all ref updates
Date: Mon, 21 Apr 2014 15:53:27 -0700
Message-ID: <1398120811-20284-10-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6l-0008Rj-BY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbaDUWyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:33 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:58076 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbaDUWxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:43 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so1011105iec.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fdr3FVT73q950mSVve+OWSU7VRTaHtNp1CowCM28sI8=;
        b=Vqs14qHpobbHlC3GSDtHlwgu8x+5iHQewRfTy2gshsmnzOuyErFeOlV3JiiBrsnruT
         7nEVBnfVeL2DBsgeOP5kCHvahf9iLzbmLktY/4xe162FSvmXwLixNYL+w0dlWVgm4NPZ
         rm5vYO2GLv8GP+488kTSol0R6I0gOOyXV5e5NX3L5w8k4zM9r6QQbuwRWIoxXDXXDOwO
         2wj7lDOr0ZXBxn3g5DaVQ8ToX2kF+m9jz1pgG31FYlvDxzaoXLCVMJ8Zf8VqUGuOspPC
         3aHQGvarc5UrheJLFYRnWrTD68DAzA39YD43Se0yZLWTs9ZXLzoy8YbCkCXPTEtPuZ8D
         RmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fdr3FVT73q950mSVve+OWSU7VRTaHtNp1CowCM28sI8=;
        b=Go0UU0C26y+DwiQFuUu/J5SMBv/Mt7+eyygPVQBmF+MfFFsn1kKbqjhn7OYP6L9bzR
         MFnpSxMHN5QnwQi9BtltENNBwvNtaa81rQsYg6T1aZqxpptBlEW7JIMW7MxOl9gxcGaK
         Uhr4gFVANckMdOceKSfgOmORMVJTp+90C1RCwIDTU07w3bMGrYMJEtbbZ13dTBOk/P+5
         H9kRoSmkGGrz32KDMWyXSns8jK81Tebqx5t1/oned3TE4cdO+poXfrgtQlGn45pPUnh0
         NSDcKsnjOa9cRTryTESiyodl9yLu9PCvxo72vP3oaT0QIdCv2ROqU0MIQnPscWtlHBfZ
         kEgQ==
X-Gm-Message-State: ALoCoQmQOP6V+e27MDQllzth1+qN40ghTJ9EnxnoKDeyKtScZPpn4EiDGflbkjo6FbSzg9+dSu9duwpUS92G2Vi1dl9Cdr4BhVWtQ4kFay7HEaI/KMTWMBu3TyrGXnJROrPJdnV7BbPAj5o8VT46PrjddtgCx6rq8nl98QXpc00LcJaNUmmdHZjJ8JR1TrqMbznJ0FNmmjLn
X-Received: by 10.42.223.10 with SMTP id ii10mr16355949icb.21.1398120823496;
        Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id f65si5366081yhg.7.2014.04.21.15.53.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 559CC5A4207;
	Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A19AE06AA; Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246671>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..fa14ac0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,17 +272,26 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
+
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return 1;
+	if (ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) {
+		ref_transaction_rollback(transaction);
+		return 1;
+	}
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+	ret = ref_transaction_commit(transaction, sb.buf,
+				     UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&sb);
 	return ret;
 }
-- 
1.9.1.515.g3b87021
