From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] refs.c: Have a write_in_full_to_lock_file wrapping write_in_full
Date: Wed, 21 Jan 2015 15:23:43 -0800
Message-ID: <1421882625-916-5-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:24:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4d2-0000SX-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbAUXX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:23:58 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:64240 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbAUXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:52 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so22548092igb.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Eso2cBWJ9P1Zp7F9lf4kS/a0tU8Ake2007X8aoO3Vk=;
        b=UcuARngmEvXrD8Sdd5lVVlQUO1cav8AN1oj1KJP2iaDt52RnZw1ttm7vL3S9FxDueY
         9VrHePU032BV6j804FHm6FIj2KsD3dhvx+71s8c2zpmqO1Lcoc2tijew5oZ6hbH6i6Ub
         MaL83KPvfEBsko7OIZs8R48FKhFwvCxaAsoXuBvuygvXfHXuMDrMDj+nwtSOK/FW6A+Y
         RxNGALyjnS9AMHBgh6zutm2vfaS8D83k3AYR13gvzX2ro+MIK7ppypRXs/UOkVQPj/7W
         IjJDKJ1fC7MDFrBN9oIa4Yhkzrtwi/RFF0MgG6mDVOhQvJg/T2F4squDgHChU7KZ2RDd
         Qk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Eso2cBWJ9P1Zp7F9lf4kS/a0tU8Ake2007X8aoO3Vk=;
        b=m8NponG338HXXp9kT/RwFIbGeKbdD2lBA7DWNoA5klW1SqurijnAgk/GPpRK+w6Wqo
         rfmNdfBSHpAirb2XQlhy+9HHyigm1Sv5J6oAyxpXUDoOSdEBlz8RkRFRR8lPgBRM1Mbe
         03sLMQFUcCwba6FaQM4yluadmET235pw9fGmNQd9kVoQ4yyx6zT+/flwsC1HXP178d9x
         0GdQhjIp/1s2XqJutt/PdXhu3whDofJrKMCTZXNjtXtFbHTZaUKjzCIrtCCYJ5a9GD07
         YvY/QCXr1vgatSA5gfRrr4b0P2OgGJNq4SaH+JsTRiCp6fPIvU0poNYIqyQJsGgVGJUt
         n4PQ==
X-Gm-Message-State: ALoCoQn0SFpT6cyMM7/zIomcb/D+HNEawhyyYQlQgequAjMJ1fY6D/PsxZSuBloWs//gveTU9afQ
X-Received: by 10.50.78.131 with SMTP id b3mr114760igx.0.1421882631823;
        Wed, 21 Jan 2015 15:23:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id c4sm680280igt.19.2015.01.21.15.23.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:51 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262780>

Now we only have one place where we need to touch the internals of
the lock_file struct.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8281bed..311599b 100644
--- a/refs.c
+++ b/refs.c
@@ -3064,6 +3064,13 @@ int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+static ssize_t write_in_full_to_lockfile(struct lock_file *lock,
+					 const void *buf,
+					 size_t count)
+{
+	return write_in_full(lock->fd, buf, count);
+}
+
 /*
  * Write sha1 into the ref specified by the lock. Make sure that errno
  * is sane on error.
@@ -3097,8 +3104,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
+	if (write_in_full_to_lockfile(lock->lk, sha1_to_hex(sha1), 40) != 40 ||
+	    write_in_full_to_lockfile(lock->lk, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
@@ -4078,9 +4085,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lk->fd,
+			(write_in_full_to_lockfile(lock->lk,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_in_full(lock->lk->fd, "\n", 1) != 1 ||
+			 write_in_full_to_lockfile(lock->lk, "\n", 1) != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-- 
2.2.1.62.g3f15098
