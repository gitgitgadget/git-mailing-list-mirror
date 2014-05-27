From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 20/41] sequencer.c: use ref transactions for all ref updates
Date: Tue, 27 May 2014 13:25:39 -0700
Message-ID: <1401222360-21175-21-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyE-00045u-8C
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbaE0U1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:32 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:48766 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1645975yhl.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5EdMga6KHEO/ww7ax3WnSUc/hF2WOhQoZerMxCr99O8=;
        b=UcsqbQ9AF1G1Oe07c9jGjkYb4VOVHt/oOVeRjQJudHiUQAbasEnmoVCxL/xzeitRIx
         KpcCyvSea0aj2sHlMJmJ+hooYWi26EhQkOCtr107MWPOECs27MirCrFiPH9R5Z74wpGq
         oGfHQ8At7nc2uPk99KGy7FPoqPzg0cXnRXGqNZYjRAhFDNKkKHZgPPwfbxDGkN+hvrsc
         N5BkCTLDnXDApPol8VEYKMz3w5SyYN3OkQFkUIFrjdYkoq1ZlCWt60y0ESWdMyqIusRK
         W9UZvbdDe/m6Uc5t2qxOxCKeZXPgYDd/rCbEAXsiSxRM3SCyFs7iXMCggDKKNP/Zhtsy
         SpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5EdMga6KHEO/ww7ax3WnSUc/hF2WOhQoZerMxCr99O8=;
        b=T+9DcSBjmE8JqHHwxJfbqYOE2zSz3VW/pgb643TFd1HshVoKPE+7WeMy1Vo7+vK0MN
         QGBdcwt8WCTs91955EFq4aju1mHSDPDlfC3d5aFlMCH+VdPDeeMeyLN56VYC3zqVZfhW
         X4zXDwtQbf5SHt7XfBKZbMZ3Nf8iI9i8gjbjg+rYBC2fJCGleAbpiiORjhi/ufeXbugs
         ugmXYNKsjcRliz4UPW7cSmBKSXF4QWnLh4ZEitYet+7Z73RC8QR1duklg9H6y678GNqp
         iJI1A07bh6zwGRvuBGwxgt2IK58487gi6egc/cm3SIR3NxMeeYUB4RBhnhbU8NMv57iV
         wBgA==
X-Gm-Message-State: ALoCoQmWNbPG7YP7Vogfmcq9i/fS9Jzwq/B0WtCI49NJ2IQ3PqeNh6M7y2gZcroIKVhY6gIGOU8+
X-Received: by 10.236.54.103 with SMTP id h67mr965745yhc.27.1401222364649;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1574645yhj.5.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7F670370568;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B204E1081; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250221>

Change to use ref transactions for all updates to refs.

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
2.0.0.rc3.474.g0203784
