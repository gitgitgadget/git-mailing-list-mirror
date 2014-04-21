From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 07/13] replace.c: use the ref transaction functions for updates
Date: Mon, 21 Apr 2014 15:53:25 -0700
Message-ID: <1398120811-20284-8-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6a-0008HG-FA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbaDUWyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:22 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:59333 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbaDUWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:42 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so1012033obb.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GChSeV9nDgUW70O6l+yP991nW3o8/F1pJ1USBREruhw=;
        b=H2A2OaRC8O2Bpod/hW2QHzbGMRgks1h1KiS+s2q8avxDb0Op7fZ01Etz6ycnntMcHb
         9OAcqcVD2RgG9XLfw+rbTlXjV+/nsabMJbG3i24VPXK62Wuz7QKnm5QYFWdtAQYLTl6I
         bGDsM/79dAJrEVo6juKOa75HWiM529lY8D5YFVLmZkbfwLyvJhrjYLWJcvb+CEy+AAq1
         79h7KCos96521CtHdIc70pLnW15cyP0QeONiZtY+4h8sfp4ZJtRIPDHPveUS5Ev8ijBW
         DjzF2Dey3niu/zX0WC3SiO6bQ9tvA6vWd9N2YVVQX6izhfePcZ4lNJ36S2ep/XSxVH49
         61yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GChSeV9nDgUW70O6l+yP991nW3o8/F1pJ1USBREruhw=;
        b=FMCj+bRNU+xQG+n33IuiAoTc4F5rMULkNytSF39aKvjcMPL1t/S9m0ECsb8NlEZpG6
         KSvRwj8q40U42OL11VUV8BKDBoqjC/sWDyGuFFMNYXjs2iUxXtRBkrezXPM5i9Cf5Pgd
         PX3M1jxxYKgHFsStUkLYkMcx6nZE4NfoH6pw17sKJUOMBZS1Ks4e+2R7YPe673z46VHS
         cUKBJJT7Z7nZ7wpXZS2Wce8Kfy+7LH3BPw3IcIvI2HJkCx3KqjkHwJ0CKySBum6Vgrb7
         x3GJ678CXwB/4spNc+7AS7Xuh2FbMVxZ7LPNfAb0FL4eYNCjBLxR3MI7DyiptPD31tUu
         UQdg==
X-Gm-Message-State: ALoCoQmWM739AKsLwbvzimk5MVyJDM6N/pI0BhVfFE6BXI9/llxIGgjYeyCqVH/jg29ByjFth9+oR4DdZzBGtY0c2GcAViCFigIK0J5+W4/qMXk+J+o0v9rVlDeYQJBLf9t4xPtvtwlB5THlr4ZxW7Hwvu5jplf1IQ7ASm3lxoX0CHhCWx9rD/FRIA0KKgNIUmW0bIEAscAW
X-Received: by 10.182.104.70 with SMTP id gc6mr10026878obb.35.1398120822154;
        Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si5366650yhb.6.2014.04.21.15.53.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0380C31C11A;
	Mon, 21 Apr 2014 15:53:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BC7B9E06AA; Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246668>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..b91e550 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,11 +157,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
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
+	    ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
+		die(_("%s: failed to replace ref"), ref);
 
 	return 0;
 }
-- 
1.9.1.515.g3b87021
