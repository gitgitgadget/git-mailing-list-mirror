From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 28/48] sequencer.c: use ref transactions for all ref updates
Date: Thu, 12 Jun 2014 10:21:19 -0700
Message-ID: <1402593699-13983-29-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ib-00087X-DS
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623AbaFLRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:07 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:39655 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so244460veb.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/4u9jqHCSVNkfLITGrzcf57L57aLAQz8ZJi0CG0OtU=;
        b=RKXg+mEGYppMkfSAQKz0RHD0JAC3BE5oIJ+feR8sflveAG5ev/llCUUmjGthOEKdlg
         Ct6s0leVzwuo57ahigmzAznMC0gOBTkanwcfBx6y6xEbhDx+BgcwihEelDtcgnnHPpje
         rPc8V4aBYfB9ExoUcM1Eb10E+FCLsjvF3JAVt0W+fMvh5RDBIbhhAH+F/MNl3YSompEP
         Y42XzzkzF3YdC33k2RWDhNoV726ySPxRiQioFBbzEbflAl7Zu1lZuWnj10c93inrEzDL
         SWACNXyvXiToMES+YK8alKOIiP8e4ZIrVNkk/EgVGlliEdKOFgL8uEk8E2aTsZ6G/59L
         WF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/4u9jqHCSVNkfLITGrzcf57L57aLAQz8ZJi0CG0OtU=;
        b=mHQQ010h+h3Gt3ZpGICQHEGcq0uozTnjZa54MaK1j9ETH8JM/AXC+cSIryaFmZ6LZX
         K/M9avGrgZYOQczp06+9ICanxh3UMXmyhLGueW41mkpHo7rrnCXXZCMETKOq8/OTpZEi
         BMiKg0U+jc6yubK4OXlVyJ6fLHJnB8pQDbt9SneSTldskS3sTG7ef9gVfeEf/R0rvhwo
         DG9t+h5qgMGt/QDerEeW4JTuMeGue7xtQnpMRxg9nUt31vJPhvRwEV8tvECGAesGwT1Y
         c8jHLP1eKRJyuoXi2NaM+R3uHeo9A7/QMbjF9xHvZN6BVmgusERHJiKuXYKtftpp8qE7
         Uisg==
X-Gm-Message-State: ALoCoQkqbU/GI43aXt7MB/0Pual2NmbsjylyCebeZ6R9Y+HYaMFL2aThTE6HckaBQquQPif4Yv/c
X-Received: by 10.236.223.9 with SMTP id u9mr657851yhp.2.1402593703917;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si113773yhm.0.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C30A35A4813;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9FBC5E0D39; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251441>

Change to use ref transactions for all updates to refs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..fd8acaf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.599.g83ced0e
