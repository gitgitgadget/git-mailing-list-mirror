From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 16/44] sequencer.c: use ref transactions for all ref updates
Date: Fri, 16 May 2014 10:37:04 -0700
Message-ID: <1400261852-31303-17-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM55-0006xE-T4
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbaEPRht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:49 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:51769 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757745AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so884876yhl.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+L7mEEfJhaLdt0qP266u0kxFBLK1ByTNGH+eb6gYzu0=;
        b=TTsaI5sgZeSlGoBSTYgcjS4SuD20zqudeN0uquXXsavZNqdjwDWZbBOvnIAuPpWwAt
         Np2WKp5SqHELpCVhytdESBBsjlXRbuOcZ1IsQgipz9Pl9lV51EY4zm3cti1+TzXunWAO
         KGk34vIoHRfNBkq2g7u7tJaXuj6vEyRRbroRl2gcvo16i58rh2Db78w/owcTDQ4Dyw17
         uKQ3NKaQTwK8rD897iPpvpaOGujZqaE/fKdbXW/rFX/fZ+0SC0xGyr98J+XBG8XkC8Nm
         j4LgYxd3k8LYZUsQdCIrUBP9QDzdmv4y3KS+xlkc9cPNTPc8oldp2rdWQOUY8QDVCv4h
         wbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+L7mEEfJhaLdt0qP266u0kxFBLK1ByTNGH+eb6gYzu0=;
        b=E0gIIQCHv37KAShcikXb+c6uuybmd0LniA7/AFLUqasp8kV4zhVKl2/uVGSCEjQ0c6
         hA+8WVZyniv41MEBeJjddwo47cunJKQy8YkWoGfNit9nUre4kOliUwmUwIdeRZMssOzm
         7tf9j3z6+NiYWNJASqddC0Bb6vyIGEO3W4EVPLGf1DhRNvOU3BcUjWdeoxUK3pmRvJ63
         I0bnTO5+lMJroFe2W0LROe/C0V8OZEsHbd/S9iAVXrjTN/zPzIn+6haUYfA/Fy+5VEpO
         NyH81TQSO4J2F9MxLno3HW5uR7lUMP2rHtUecEpyxFBf6YHEu+133rq158VP2071Bsfu
         Q4ag==
X-Gm-Message-State: ALoCoQnYv3bPs5aQqOcaGNkGWNnTnOfoD8rlDzwBqgqCXekKUdLpm+BKyRWeJAgml9LCrzm37/N5
X-Received: by 10.58.141.200 with SMTP id rq8mr1137045veb.31.1400261857454;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si442304yhk.4.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4E5A131C2BB;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2A42AE0B9F; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249360>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..b047fb8 100644
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
+		ref_transaction_free(transaction);
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
2.0.0.rc3.510.g20c254b
