From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 16/44] sequencer.c: use ref transactions for all ref updates
Date: Thu, 15 May 2014 10:29:31 -0700
Message-ID: <1400174999-26786-17-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUf-00086L-LV
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbaEORa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:28 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:56809 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so637188vcb.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ss9fgXk1KdmTo1fQkak3a6/fbiHQzza8jf2mLs1/L2g=;
        b=PxWKfplMsWZ87YNBL897TfAeCIPyJ5KuDTKNw4C9FqoQz7TGStKBVfctpJ1DHJD7QF
         WjHimLNXq+yEedjT4NvwaSM34aGdclRHotHB1z6ZJbmZryjT7zZQrWrP48cHQGcYHB8k
         sKC3mS/603l6yJw8bMS3M77keFFep9njQPN9V8AdVN8iKrjcDjAjP9Cyu1I+OVitrsHx
         tHyycLYJNnmrnH8jqOKvmmplgQHM5K7i0jVa7bo+kAxDpD9WIEsMm2OVdtk5zX0Kyuhy
         gtjTpNyc/q23r5CWe2Tc9f8ndK3ClgWqDJCv9hcz9NwkyvOkZESdz8BcnXqtIL1mY0x8
         nLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ss9fgXk1KdmTo1fQkak3a6/fbiHQzza8jf2mLs1/L2g=;
        b=KqMzR7yNXsfHps19F19eVynRJ5LP68nInpW39yAuyQTs1ypwEUE3qoQrOswH23svqS
         zdmg5vpiF1jJ5EP1DTtb4lSEL9D2GifAM9SysTUiKF/Ak+IPTSqWi72Y22yk9UZziROb
         nUSOTXxGD/OY6wPSQIIArZMwzOij1CObhzmX1xfiT95/5mvdkBy3LJe2T3orqGRMJW8w
         n3DIWKxYtDL8CyZsQY/EJi3AwZIoV5dayMK3GvzLOkvGQ3e1dcskQfocxAZmCnMtspjI
         ByES7xh+dHV1BN166l5BCYiIYkkPw8c311oGDTUrtC8gcSaVYMx3Ig9uYBc/f0VoI+Ft
         Imig==
X-Gm-Message-State: ALoCoQlRukUl+fY5TWXkhMiD/GUayRVIoikbUbMw2jvr0I01Um2BFn9LshRRXxHRqRC6K6yQNvkI
X-Received: by 10.58.236.5 with SMTP id uq5mr5485643vec.35.1400175006455;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274176yhj.0.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4F8965A42E3;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2BEA1E1207; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249131>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..9282a12 100644
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
+	if ((!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
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
2.0.0.rc3.477.g0f8edf7
