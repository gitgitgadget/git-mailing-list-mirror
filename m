From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 16/44] sequencer.c: use ref transactions for all ref updates
Date: Thu, 15 May 2014 16:15:13 -0700
Message-ID: <1400195741-22996-17-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sv-0004pQ-3J
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbaEOXPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:51 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:62048 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so324743veb.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kk5jfQ3Racq48Fkn0im0VJ7FWxpLse+Zr+mnpE2eprs=;
        b=HkMuJsMeNDPmUkV3SZF6g0Ua8on4Eku734kKcxRQVA3OAOaoSs+qoZtZlZR+MQI3ch
         ytO15MWxAEWogOnt8Gyfig7XiE2HMJ2ysSDxsx4pK2/ICNHw7Gt76+BCWj2xJC+MxO36
         fLEsF1c6gVYKJ/vcxcrTmkpQUHwjyDWADpEuER8zWF/E22HcIN92cC3Y/ByMrxdlSaR0
         5sIb9N3tmTciPkDEbSkS84iE2TuAPsJO7CK+oDaK24d2Mt2PEus3vHRHBgJ42KffLUD8
         f+BEqHq0YorU9JdkWTjh7s4QCpPRklhtpiIEeb87N2jHq7I4qX/iHLYmT67TtfhB7gVi
         bfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kk5jfQ3Racq48Fkn0im0VJ7FWxpLse+Zr+mnpE2eprs=;
        b=YCp+3nJwkWAoa5c5vLBKcUBsbB2EAtCJOHzbldH1Itia2u34RQm2rwgr9lLs5ioT0u
         kHFQ9E9RQjHpf6T6hwDVPSKrSC9QTBnSpQV8oya3i6lNXRPx0bk2OAyKSpiHWrF83tpt
         RfKXHtM2qEbPNdXpzHIj+JThRn0KH7exnA64AxXVcOjZ0rvYan/2epjMhPp5R1j2bHjf
         AXwI5lz52Ti9cfsgUBCKb1EOPSOMR9jCmPPvR1rkuhNrVTfdFIpUHIS4Wx+mT+ii6jRs
         6jISVxpznJGGYQq7p2R6gsLuFVBFYkmMghBkh71YwDf4h/F+cexPTf/sXmDFfM+HEaZs
         rpMA==
X-Gm-Message-State: ALoCoQnrbl/39BvHxvcu6UFMfIzDrePV6ER/Ru6vvHWeJrZblwFtCvt9bnCK44Nj8mEEHeZcUfVR
X-Received: by 10.224.36.137 with SMTP id t9mr5668565qad.4.1400195744957;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244835yhj.5.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CB74731C2BF;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A9C85E115F; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249228>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..e6b3bbc 100644
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
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn, &err) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.rc3.477.gffe78a2
