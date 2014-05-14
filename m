From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 22/31] refs.c: release all remaining locks during transaction_free
Date: Wed, 14 May 2014 15:13:21 -0700
Message-ID: <1400105610-21194-23-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRE-0006v8-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbaENWOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:07 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:55038 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbaENWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:40 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so441290yha.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ukJNOl0iLKmTVeYioCpKthaIZfyMSa1LIgSd3dh9daE=;
        b=F/Ds4Za2fLD9mmi7XnAsEVKWiaZYCvRBPOVvUafCVhhwNvJ0/c1dPZkyWFIKldNU4N
         P0r/07okHfi334x6+lzQscZiCBRR/VJZhIGoVFjKJNopQf0J5TnMWMAUSbOnpe3vda32
         1ZGIGN4xrF/9wVCaIA6r2nbr4H5lcx+3KpTt1nVrlOCECCrwI5mju2djCdqU8CB2Igtz
         Nxwa+WI/WozTK6R579Py4pqN5zDFvdNdiEL8ldgYY3OJ2l+RZsOcOhwwCj+4/NRn1fp2
         gvG3NdZbwZHTnJhcXHFoh0BRQk311A3xyrGrVB0vn8Sr3ScVUHXPRg6GgETRIDzmd8bM
         2M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ukJNOl0iLKmTVeYioCpKthaIZfyMSa1LIgSd3dh9daE=;
        b=dvykmolwO32zLZ0rdN8fJ9ZH/KIrft5b7aYWvTW+zqhS6Orw9mwppZASob3wW+n5QQ
         e025tHUv+Gg/3Z9rDEqypZDcA/h5t6BU4S/CKiXVJgDVJ0H/eaB/Z861fRvhyBT9AtxV
         N0dXFYz2HP9spKohcZCD0xgLZ/cJU1bVGZ+5HO0ywagKlK5bub3eLZ6vBBAmfmC355M4
         GjUyW1lFsxjKW34f774C6AN1Qx2k2CRdka3QPyvqmbbPPEG2oS+WRQNBsOduGmVZHhi0
         WQk72RJqbE4yqj4DIHCO13ESHO7ak+9Kipe7mAVw6KN7uncGyq5nXzFgqZiSS7ZPweXS
         i7SQ==
X-Gm-Message-State: ALoCoQkdR6rO3KUO4SGu8KcFIGFd/RE5C0QhVVrtZDLwmMPVWzb+6xg+RChlBf7hlMRqNAXgE5Zn
X-Received: by 10.236.92.204 with SMTP id j52mr2756719yhf.26.1400105619939;
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si151873yhk.4.2014.05.14.15.13.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C8A915A41E5;
	Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8B5FFE038E; Wed, 14 May 2014 15:13:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249018>

If there are remaining locks held when we free a transaction, make sure that
we release them instead of relying on the atexit magic to release them for
us. Otherwise, if we perform two transactions on the same ref and the first
transaction is aborted then the second transaction will fail to lock the ref.
This can currently not trigger since there are no commands that use multiple
transactions.

This sequence illustrates the bug:

t = transaction_begin()  /* first transaction */
transaction_update_sha1(t, ref, ...)  /* ref is locked */
transaction_free(t)

t = transaction_begin() /* second transaction */
transaction_update_sha1(t, ref, ...) /* will fail since ref was locked above */

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 87cdd91..17feec5 100644
--- a/refs.c
+++ b/refs.c
@@ -3325,6 +3325,8 @@ void transaction_free(struct ref_transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
+		if (transaction->updates[i]->lock)
+			unlock_ref(transaction->updates[i]->lock);
 		free((char *)transaction->updates[i]->committer);
 		free((char *)transaction->updates[i]->msg);
 		free(transaction->updates[i]);
@@ -3729,8 +3731,10 @@ cleanup:
 	  : REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
-		if (updates[i]->lock)
+		if (updates[i]->lock) {
 			unlock_ref(updates[i]->lock);
+			updates[i]->lock = NULL;
+		}
 	return ret;
 }
 
-- 
2.0.0.rc3.506.g3739a35
