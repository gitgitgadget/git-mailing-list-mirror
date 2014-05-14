From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/31] refs.c: lock the ref during _update instead of during _commit
Date: Wed, 14 May 2014 15:13:14 -0700
Message-ID: <1400105610-21194-16-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQr-0006EC-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaENWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:42 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:34913 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbaENWNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:38 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so47985qcy.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7yFY4ngdxiLmGCyPpjQFqLXmB+poFMcQMEuTC0Xjxmw=;
        b=aHlEw/FEZAugYEGoNg94cGWTdkH4T/HrDBv46/hdZS5lWNjhW0mxNK2BbOpCBh1+qM
         gTKD76CCTgE2eVZu1FNV7KnZo6jG8npC/8XGr0X6qETgcB+jbdO17FkXgNYjnvRbbTuD
         GG7j3vCi7Nc5xV/ev0LJTIIsRh/JBsZ0DXc/nonqczH4d5yLNLlil1VYAGiC+lR7rPcn
         htjA3JaPZqNZX5df7hEhmPzXF3vyahoDRv6jUsugupEMuKzhNrXrdILak/bmEpsLbSJU
         vns8/7OB5KHjV5Bbk5/csWokSQ2b9w2S6BQg4jH1/ksanmf3Os4MQmVZXeYFOW2wbcK7
         o0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7yFY4ngdxiLmGCyPpjQFqLXmB+poFMcQMEuTC0Xjxmw=;
        b=Ciq+MYxKE7sHN/Tz/NrjGGfFMhbp5ZlEz52pjbeWsoe+SmDBKuBYWIVOG985aMEd9+
         IcZ+dw3hQ2liPXoFLMRw2YFFNrdOsHWI/rM5Rw4uzHMPkdyuyvyt5u9zqRzMsXpTHGxI
         TXaA8KsKYyVM9+V+zU+wg2ShWnU/2ot5mtVetJsJDj3faW1eC5ZL8dENizF0mtaddruX
         Ymt0S7+3z808RoMoxEWiJeYY9/7GcbmkM1ioENOGYcW0Telqsfk06RL3AkR28TfP/4RW
         krLtgf/fvQp08PBvwWcTw70Ckl3+4kOPw/ldz4Lkra4babnQzByMEJdYrByPjnMCk9pJ
         L6LQ==
X-Gm-Message-State: ALoCoQnOY6V/BzcY2W8lJDind3WlLfto8z79aG41UDAkzicK+ZYeaICCe5xAbDfPCIZPTSjce7ft
X-Received: by 10.236.93.38 with SMTP id k26mr2774448yhf.20.1400105617574;
        Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si151868yhk.4.2014.05.14.15.13.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6999A31C1F8;
	Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2C18BE038E; Wed, 14 May 2014 15:13:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249011>

Try to lock the ref during the transaction update instead of later during the
commit phase. This allows us to do things such as :

t = transaction_begin()
transaction_update_sha1(t, ref, ...)   /* locking ref */
...
do stuff while we know that ref is locked
...
transaction_commit(t)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 8212d77..b006238 100644
--- a/refs.c
+++ b/refs.c
@@ -3438,6 +3438,16 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	 */
 	if (update->flags & REF_ISPACKONLY)
 		add_delname(transaction, update->refname);
+	else {
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type,
+						   transaction->delnames,
+						   transaction->delnum);
+	}
 	return 0;
 }
 
@@ -3566,14 +3576,6 @@ int transaction_commit(struct ref_transaction *transaction,
 		if (update->flags & REF_ISPACKONLY)
 			continue;
 
-		update->lock = lock_ref_sha1_basic(update->refname,
-						   (update->have_old ?
-						    update->old_sha1 :
-						    NULL),
-						   update->flags,
-						   &update->type,
-						   transaction->delnames,
-						   transaction->delnum);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.rc3.506.g3739a35
