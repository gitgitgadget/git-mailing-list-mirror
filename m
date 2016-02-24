From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 20/32] refs: on symref reflog expire, lock symref not referrent
Date: Wed, 24 Feb 2016 17:58:52 -0500
Message-ID: <1456354744-8022-21-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQN-0004YF-Vs
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190AbcBXW7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:40 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35041 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070AbcBXW7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:37 -0500
Received: by mail-qg0-f50.google.com with SMTP id y89so26983229qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=viuXcLnQAilArKwjSny5VFCOrxhNu0fSmEOnjf7VRsg=;
        b=DmUnOoRJbSI9bsi6jF+sh42XAOvxkJrbvOkuyLN+07HM3G0Lr1tkn0pRsQgXiVQ7h8
         5kmSh35F7EzblgQOBRbwLUGFlkaleTUPMbn+V2p4F43JGnUWHDgrc13hkrXqFSM9NcOB
         F1Zf15pDeR5KAPFLI0u1Ldw93hEM0l7qx5lE4ejTOzG+LE0O4GKfqOlKVH7IMEZlD4I9
         EmMld+UbgA0PjRJpZQH07ezObkWs7/8/uL7MuWwK4m8fSUkQDXv4t9HucV3TCQJahn6i
         Ish/JTOv5v+SVCPu0m8ewRNR4fZ5f1TopYItxCAd9xnzPWR3FCZTGvShRfnsEsUzr0Pz
         ZwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=viuXcLnQAilArKwjSny5VFCOrxhNu0fSmEOnjf7VRsg=;
        b=MyxNR06oRKX+w0OZoDf6W+olAL1qeGHqNJaaxORflAE3YxH/u/uRvdnPS/hpf9AaD5
         pcFN1vsBVFNASJUPPD6hKXVXySqlc0MgZTCyi5c46m+7jSha7oCw2VMEkj0DLlueXxCD
         idlNBsgcdDiWSdxaepS4yMJ1kCist5WObj7FJ80zKwj0O6lXIycfbw8UDYYdx477xJAW
         djtFJI2LK6foGci2JejCEgyxC/wGKLEHXQurZ8XcFO7G0JM/BFLqKZqtFXJmTKEbKGpV
         7Ve3SDbLTJCTWg99CE8h39fiJTq935wJLsiUtzNWRQoPqr0FTmjBdZdWgBeqwTmXl4L7
         bA/A==
X-Gm-Message-State: AG10YOTVtN1910sKelcIBUny1U+ijzEok7TgycKjz/dE3hM/6RzXuxFXPUFq4YSLdWi+Tg==
X-Received: by 10.140.44.38 with SMTP id f35mr52390325qga.49.1456354776341;
        Wed, 24 Feb 2016 14:59:36 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287266>

When locking a symbolic ref to expire a reflog, lock the symbolic
ref (using REF_NODEREF) instead of its referent.

Add a test for this.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c |  3 ++-
 t/t1410-reflog.sh    | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7a3c9df..f1045b4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3309,7 +3309,8 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
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
