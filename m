From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 21/33] refs: on symref reflog expire, lock symref not referrent
Date: Mon, 29 Feb 2016 19:52:54 -0500
Message-ID: <1456793586-22082-22-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZc-00078C-JG
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbcCAAxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:55 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34588 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcCAAxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:51 -0500
Received: by mail-qg0-f43.google.com with SMTP id b67so130619582qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+Pyvz3IXCFlPWH8tIqzSY3yR/Z/8dkyZt9iUtTLMwY=;
        b=oj57s3Z05iWzfXlBhv40zGbNFXr19bLEGcRP4tHr8EiGK2CtQJdbpTmaEL9ZFnlMvh
         809dGuttAfkcp+RZaDyDBCPxZZ0k5uZ2QJvqRhut6G5oetUmNRP5n9nGrUBgTE1bySFh
         ucZz/JBseXSsXRnt1CAMU53Dz2crxQ27X4lL/sdA369NBQfmUzu6OX6QWNkDSvuoDbfF
         eJx0Yw4SSPcUQfxxYq0IklhgkUQN7CfX4gqfg/uvpmI9/sqfBQjuTCtC8mdpY7cFhE/S
         V2tEgm9/Lcee8KxRS5XWkyErRaXEjcLP55J2F3MCXLfPmouqRYT9mTCnVmA79S9B5dzQ
         HxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+Pyvz3IXCFlPWH8tIqzSY3yR/Z/8dkyZt9iUtTLMwY=;
        b=jucVhfyvXijh2fYjLPpNX/RoDls4DeLaiP7YPqgbF9F5urEI9mHAc+x5qPvhnGSKMS
         F14MEwsd6caDAosKk0vpSJ7xUpQ9NMBok45iRLCL+JGObQu/viI4Em+RdPaKxFGW6Oej
         UXHlimY/ZAvaN7nV5mm3jHKUi/ftVK354TEHKF19Nx2hfh8RUxrMOLMOB7V205NVEkSR
         NqdVJwwTiuUOLakzCELVEY6Nt61nJXD/nGxiuE3pF0Xc5oBNUG4HQbsiAtAdqxyoJ4Y0
         QLp9CceXeJFEAvDDTb3Lt9/pCORKVnc7FR+ds7fxAQkdlLDAUvqdJ9lQNK6pm0XIZZ26
         VPDQ==
X-Gm-Message-State: AD7BkJI/d14fMLiKFC5Y9VZJVMPfVLdc+X28gs5cO5euOB5ueSzQ4s//EESwxWzywuDaLQ==
X-Received: by 10.140.163.5 with SMTP id j5mr24998196qhj.68.1456793630773;
        Mon, 29 Feb 2016 16:53:50 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287957>

When locking a symbolic ref to expire a reflog, lock the symbolic
ref (using REF_NODEREF) instead of its referent.

Add a test for this.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c |  3 ++-
 t/t1410-reflog.sh    | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7c557b2..1f36dde 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3300,7 +3300,8 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index c623824..9cf91dc 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -338,4 +338,14 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'reflog expire operates on symref not referrent' '
+	git branch -l the_symref &&
+	git branch -l referrent &&
+	git update-ref referrent HEAD &&
+	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
+	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
+	touch .git/refs/heads/referrent.lock &&
+	git reflog expire --expire=all the_symref
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
