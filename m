From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 28/48] sequencer.c: use ref transactions for all ref updates
Date: Tue, 17 Jun 2014 08:53:42 -0700
Message-ID: <1403020442-31049-29-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:57:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvlH-0007Xm-NX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbaFQP4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:20 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:61064 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so536845pbb.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TFhHvWE1M5aKbX8C0grBEfpLXtb3FLqQP0ChVl9JGcI=;
        b=iz7pxl5eErJEls4ky4lH4ujTMoJjyA3kHDnp4LVlLAVOFDHnVpNqmjNMhTrzecS4Ea
         MgVO/Eq2W1OqLVLERtwmtveSG61JgD7R27U1dPOgb8+TpnEUgyREIAPUS2VZLd8cdSOY
         fM7PH95ozYGCkg1HGSYTdHZCY8P1K5vESatm8tyrxRGrLAgzUV2NQIz9vC3VXKmtImIv
         R7fd20LyB3wHo84Pin3s9B0u/2+C2S90G8bOytbjrRTaiDPJqW/xgQKn9LsYNwT3REXR
         fHLqzmk6mXGBFMxSG7n71IZGlraT4K9oCAaM0joVx0nn9l38b9sc+LTf257hx+PFjOdm
         /RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TFhHvWE1M5aKbX8C0grBEfpLXtb3FLqQP0ChVl9JGcI=;
        b=QcvL9qJbMdi+YBtV+ha16jnMl5kYlpRAxJ5ac0z/OWHCYKTO0sBR3t71B2uVkusicX
         m5+r1YcXNPkr+VkKEEmOOK0zNduEQaKDTdPZgg5nzsWh9NMxnWdY/qcp08ZsDg75VdFe
         nsGwL+Hc6tkvaElLnlSV2I5na/8J/1Ql6LwuRSlv4hqHjr288A+vLVpy7lunhsXZ4g4E
         ejDqWBVQAbF7yveB3wxcChaT/840HAnlJeZHA00OqjH1QuROqkGxQ+zcSNpViTquzyI3
         1WCBAfE36NE5mnZTmjJbvQsGIAjWiJ8LHkRyIvQGSWG6qTak/iEZhigaKfLqRhDeN8/X
         npsg==
X-Gm-Message-State: ALoCoQl2iYuiBlshl/EkdzZt2q7mE5+xFPjFhKPVZ4dfGhVuLtfCuKuaPyuMVNTq/2XUGmKMbENn
X-Received: by 10.66.249.68 with SMTP id ys4mr453905pac.31.1403020445408;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1208002yhp.6.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3C9385A45BA;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0E56CE10DE; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251910>

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
2.0.0.438.gec92e5c
