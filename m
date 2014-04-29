From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 17/30] refs.c: change update_ref to use a transaction
Date: Tue, 29 Apr 2014 15:19:02 -0700
Message-ID: <1398809955-32008-18-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNc-00029w-2K
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbaD2WTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:31 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:47253 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965279AbaD2WTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:24 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so204522oag.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oADmgO79gQKXkv+Eoo4EIrHtoyqMIJ0NQ4Y4grdSwnA=;
        b=hOX3SqYBaJpC8PuTQTx4aJIcSbmFU+icHiyCznEt5WIlHZpnmitKKtkFjAZ1NaL0py
         SczLyvkIExiXaJnnEK1EgzdJNgo3EQlcI/tjYbDXj8Rk8GuCr53BQ3Y5c48N7f1ALPI4
         Q2h5S2qly5oV7/RiuRiL4X6XMUuaERoP4s9x85+DtxbdpegSEUnAuUbVy/uHna4Fyh3t
         y74EsaNdz8AeIfSVZJ+aByf0+ix3pBn+FcYbRA9PYC2HLyZfhMYLowwgqADFpdT7yXRt
         Dte45ruXNn7oZLI0bSJ7fZKqlJrRK9+XppW/6Ubdo8Sv5gdWSx/2aHP7l9XGSTZbwwoY
         Auyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oADmgO79gQKXkv+Eoo4EIrHtoyqMIJ0NQ4Y4grdSwnA=;
        b=kQZiSopgTJn9crvqOOF9rLXAm0PxBqDbZdz6rMwrAtdF3Ud3uKCCP3l8wN8Fp5YPCp
         ruKiwe/fbQ4LGQH/zOEDIP9gzYeS5mp27uE1Hy800hnFrDgMWfQ+kw1WKcqdqpo0lBAu
         9Vy0gUChSTJ//+ZKKk0aK5fOL1doshp5x798VVsd2S/Mwa4vX8XBNgHeieL9LW9YnZrE
         QwxftiawiOdXaQU65/l+EXdG9aGy6ERYUPZTKAsN6HITWdDxEdEe1KuFXCrdwBDcu50Y
         QBULqDyJebgNXcmPSPMno3zqBV46mkUIFY0D/6oHEfRgVhqlNucDduJQKph7HG11Mb2/
         mBLA==
X-Gm-Message-State: ALoCoQnVKA5808USB2v3i7LC4nh1QY+7VicwKTGn6b5HLpiU9ljz/7hOlNqzaK3gbqvX4aLafEIgY3bD2iimqSIwSsNEdHsnyF3IcrNq/rq9ILiHCvalnnnimf/A74MLkMFalLou1Wr3U53jmAZosMeiVX4vYmImyL5iPVQ/xOz1kChbf/367SSvaZZIbOT9CIXPV3EjjbkV
X-Received: by 10.182.104.70 with SMTP id gc6mr260344obb.35.1398809964626;
        Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2738495yhb.6.2014.04.29.15.19.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7889F31C1D2;
	Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3D14AE0A5B; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247632>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4e28e..563f336 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,11 +3396,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
1.9.1.532.gf8485a6
