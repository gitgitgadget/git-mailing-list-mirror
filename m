From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 12/27] replace.c: use the ref transaction functions for updates
Date: Mon, 28 Apr 2014 15:54:27 -0700
Message-ID: <1398725682-30782-13-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTO-0007Si-CE
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbaD1W4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:16 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:53067 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbaD1Wyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:51 -0400
Received: by mail-qg0-f73.google.com with SMTP id q108so375970qgd.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmwH0zKATF9z3scNJf6ZKt8sAxXHdox9j36w/pisDAQ=;
        b=XhSLn6zsBAUsbJ5D9lfj0iuqpTfSGf8u65S9rtCH1Sh+HhPfTFX91O0SSYUakRwI9o
         zKA32HCnJP+XRr+pJ+JJij6kb/kGHzlat8SaAhk/RxhPlxdA0uL52s7JcyeMWvl+G12h
         dW1w8TclS88R5zzhv5zr6VmwWb4AlncakS2a/JYj1fsEV8bvisBT3VX5Sy7LPD8WcKMu
         7fAEyp+bv/wfDnKSST0TkJ4f1N5/CIzQSUJMgjlch/SkhDwyJvwj7UreWmcFOSujuHCj
         f0p6IKFQGJueViMLMqpsNDpTHOOxGlGtuwwfVBY19ZY6XWftAhlcOewgJtoh8PTFk5mw
         VyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmwH0zKATF9z3scNJf6ZKt8sAxXHdox9j36w/pisDAQ=;
        b=d7fBDdMB0gAfdvUr06/PcrS5DMgVQEf0iM05VJ8mLNC+3AR6LwveaE8M0roYCV/XmP
         fS7sxuruFbyOmHfGyaUO3g1gc68SewErmE1ZA7pQs48lFRW3gWbt4di/4gR884h9waSZ
         F2IEa+16zjTN189luc6xHsDhHCa1DUjE9Xv9HHGz9zUqYtKckw+ZxBPVp5mn7b+iePxj
         TrhTcZxxEyWUgtRyNN86Dd9aRKkPHnUlX4iqr5vz/SmCMD5owyvaRajN0qeL9aYNalmZ
         bAc2hzO49+TjyazqoRP393XWhGd1dBnklpB4sC0wexP2onZ5/b/RvriZu0HX20VJM+nJ
         8LyA==
X-Gm-Message-State: ALoCoQl7nC7Hc45w++fKvy7tcC3VKoihBIwVoVAKWexLsVGxwu3Cnhg6TvCdkO9G00DZV8hQAwlNml6B8BidPglNMGPIMKCo5nYBkR9RkAqNqnCLYfWoCq5jvntxaPgYlAjJBaS3HUieuxNma65qeO3JB1nnQjf3hmiuy0bWoNlrrHt4x6cw39huP0bZL+hG6JhWpK2syZb2
X-Received: by 10.58.202.10 with SMTP id ke10mr13785897vec.8.1398725690691;
        Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si2350131yhd.5.2014.04.28.15.54.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8333531C20B;
	Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 39038E080D; Mon, 28 Apr 2014 15:54:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247483>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..b037b29 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
 	return 0;
 }
-- 
1.9.1.528.g98b8868.dirty
