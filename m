From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 14/27] sequencer.c: use ref transactions for all ref updates
Date: Mon, 28 Apr 2014 15:54:29 -0700
Message-ID: <1398725682-30782-15-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTA-0007EB-7i
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbaD1W4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:03 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:47268 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbaD1Wyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:52 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so1612342obb.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ds08Rm8jI9Ssjpn3SIN1rxYldL7OU2y8H8CFErOHSgQ=;
        b=isaseTv5xCygiUzszFH/Gg7Ij/Xx90kZWW8xcraCxAnHgtyjGfaEDIf4hPbxiRk5Am
         /1tuwhP3VsAo0juiFiOCNZG3z+xFYJSGi4Ejo4dQjIi8b0SO1z7yAeO5e95s//6Gftkh
         Yidbv3PlSuHZcM67gJ0pJiwgOen4z6RI+PT+GhUEFbGqkY0SFGun71pRFLaA7sLD0Sr4
         BzLYrARQddK9COPmYpKmnX/93Ppck6CjkluDiCVSwC41RYiDR2iNO2p+nJrm4C5n8PrN
         +01yWEUTGHUD4/fIoiaibOXOxOybsiTwrPlgURHBpFVmHCNtMOXflqU0/Qhivxs9mZlJ
         A2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ds08Rm8jI9Ssjpn3SIN1rxYldL7OU2y8H8CFErOHSgQ=;
        b=lW3NqB9nPmHp3Rq7orepovzs3gQREtBcgByFIwJl1efW70s/IN8wXqbKIFckm1ZLLz
         f1zzYFtjDCQqKsBg+AZSRXIBOxFdJnouCUF6m94IgVPJmb2/oSRfpXCQ3LaFiNn4GqiY
         SQDai/1DyFulzBKSQcyHhnJpg8tY/oyCbvwmgsnBFuVNB9LxCL7Ofuji3THi3npPbxjQ
         z7O25WQ1VhOxH31RtinDhw6pykUhcV5lOTfiS3qHioLy2Lmgt9MyT8Z2lWQXbs3St6Yy
         8OeXbS5rhHFTtv0RiIatDr9echdyiZf2SOCwn9CCuIE7yosyHen8wgUYxL3pHFAHnD4u
         7dVA==
X-Gm-Message-State: ALoCoQnNkHZNmYhl3LN6rxCv33OGesTePxEKG3665to0hGHF+W3g29ibDt/PKjFhF9So41aHg/B6GbmjcSnrCacSLbAvK4Yamx5skkkUwmBoFj7u8M1WjN3oQNIw8Kflhofxp5Xa1jsqvdvDCdIbkxnNivBqpA/Tp3ppWVzUCzgB4caeSmmwRGTw+4+VB6YGL+T4ECfdLGkM
X-Received: by 10.182.196.8 with SMTP id ii8mr14512306obc.5.1398725691781;
        Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2350766yhk.4.2014.04.28.15.54.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 981EB31C20B;
	Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2A048E08C1; Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247479>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..449e093 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,19 +272,30 @@ static int error_dirty_index(struct replay_opts *opts)
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
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		strbuf_release(&sb);
+		return error(_("HEAD: Could not fast-forward: %s\n"),
+			     strbuf_detach(&err, NULL));
+	}
+
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
1.9.1.528.g98b8868.dirty
