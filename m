From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 14/19] sequencer.c: use ref transactions for all ref updates
Date: Fri, 25 Apr 2014 09:14:49 -0700
Message-ID: <1398442494-23438-15-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdioP-0001Jk-IS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbaDYQQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:36 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:65040 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaDYQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:07 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so629218yha.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUnigzD0wsy4k6R5iXZ0KXV68vT/kSwSUyjQfa3A3pc=;
        b=To/b7cymxRlfHKq8jxDSoBlJ+SoaSDcMK1zH8S/u478A+SsjznOZg1yl6InMtBopsJ
         LoqMm+zq7MIpi84YsdftcgzgjZe4Q5On9J8Vxq7FOrYPw3pMcXKGzT8kEk56wa6El32d
         nB45kNJwz4zC0NbSIBzfeIjtPcthfEbHz/V170Ui8/Q9W7uNJVSYxAe3KlVwEcCgS/7Z
         A3+srizoMm4OFENDluj01znMKpOdcMHfP5zagmBNTDsxvRTP9FMRg1J07TnU6OstRH1Q
         +WGaFZ0VrulCB2nUkYbUY67QeCaG7wmtZCQYphwLdN2b2nTYs7oYMDMDVB/9RpEmDkC9
         +raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gUnigzD0wsy4k6R5iXZ0KXV68vT/kSwSUyjQfa3A3pc=;
        b=TrBT6GS4OgpiHExnJggio+mqbECR8Rsmf43ev0eDbzhl0uUZ6UEsXaZTAcbZewnyVx
         /ixEtusUUEUN0PukQ8S9jGv7U1ODePSy4LOg90h0tjVGWehVVL3H6p3rZrqlhI153l7y
         pc4nwYoSbkQVP+akJJi4EDQ9AiuGE0BSibvXxwmdtCfrx7RjHVFn8nOJfqTwJpm97dWq
         w9+zUM2+WnX/yuQfG5oVeyijMmJ7Y2LNO1zoescyc2V2u3/J6XlqcEb7k2q824drHT8a
         4q5Dj7pAnlZHqwDvA5vUuMjFlgTRNbOyOa1zfqgm42aKRx77Gc323aNu5jc6jPh/Tmiy
         uXLQ==
X-Gm-Message-State: ALoCoQlyMM2q45fO0hVcv1+NSK+4DXn/dYqtim4w1GsG5mGKsyX5dSdGIzRzjeif4v9ygbkXTPoZ6bXj7iQfx6E/JGMk68tS3382E4E8kD/9XMk076lsLSCZAUtKjatMP/J4vJJJT0pk9hLLwOacNyFmCoilASynohdd2st4+ZMcR/3hIPWrNpCTEdhliPCrN5lwdKNeWwCe
X-Received: by 10.224.95.9 with SMTP id b9mr4809624qan.2.1398442506543;
        Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si1050182yhd.5.2014.04.25.09.15.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 658DF31C028;
	Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1FBAFE0855; Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247066>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..7d59f58 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,19 +272,29 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	char *err = NULL;
 
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
+		return error(_("HEAD: Could not fast-forward: %s\n"), err);
+	}
+
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
1.9.1.521.g5dc89fa
