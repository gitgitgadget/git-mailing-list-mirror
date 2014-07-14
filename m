From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 14/19] refs.c: log_ref_write should try to return meaningful errno
Date: Mon, 14 Jul 2014 13:58:56 -0700
Message-ID: <1405371541-32121-15-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 23:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLv-0003E7-UV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbaGNU76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 16:59:58 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:52755 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756963AbaGNU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:08 -0400
Received: by mail-qc0-f201.google.com with SMTP id m20so438437qcx.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HA/6bBVdb9MDcPY68vqW+acP5xCFZVG0aLuc/1o932U=;
        b=Z9zG6Jt+D9QQsx5zvqEvA/7n/fk+aIXpjvxiYectf4+yH3aTyBtN+u06up0gclDzR9
         8blyuup191lwomSyhGsSMG7xeEeVIXfyNjJrd/fWpFD0opU7VNEz+8Y+vpiwJf8o6Rhr
         9+z514WomRrHjbzfIWz7yloSTSESgspnWF7aAEdiFwwKj77lyYRfqrBEcbfPXYYv9E1m
         lzfUCmmkAGimSmgRQxczuvRN1644lLfHctluLryDtLowD4zuwLi3Z7NemVAqczjfOX+U
         +5dKiE4/ykqfJk64u32E6luHEyMAP+pTsenV3Qfiuc6pUFagj8jIMjO5xMwnO1jZeKy+
         0sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HA/6bBVdb9MDcPY68vqW+acP5xCFZVG0aLuc/1o932U=;
        b=PKhx00G2Wuk4xwFmV1oXoPiygz9AsvGE2E3hzWy/8/am0m0u8cFEMy2/ESpd8avQO2
         pzdL34InEy/PGLNitHyEBHATwp46BuEFg2C6CCrhidWkleFV+RNWrV3G1Jcg0V8tuJeG
         EN/ThYfulQuSGSxaJtbAo6qkK1o2oVgC6vrQaqR2YOjzKO3aQ5GlrkO6+XXrDysk0Qq+
         au9jzXYGx8LeMopfM/2nAMcB5Doxo0KfnI0T6Bp0TiuRYJXyxX/iBjs+OKBt/rX8vA0x
         ymLIttKcD7SWmxALCY1H31Se/sp7SQPTp1xYriNk8VpviSrjQ+3fm0vTuPqZR6yhDCZV
         Nkdg==
X-Gm-Message-State: ALoCoQm1zQ6T1p5bS+3CgolBOMI8jcKitM9gtr+GS2tVImEZcxRrCqycy1D5Dn8PqAk6WyssZT0w
X-Received: by 10.236.78.70 with SMTP id f46mr7851212yhe.24.1405371546157;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si821466yhk.4.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0726731C481;
	Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D5D56E0952; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253531>

Making errno from write_ref_sha1() meaningful, which should fix

* a bug in "git checkout -b" where it prints strerror(errno)
 =C2=A0despite errno possibly being zero or clobbered

* a bug in "git fetch"'s s_update_ref, which trusts the result of an
 =C2=A0errno =3D=3D ENOTDIR check to detect D/F conflicts

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 211429d..61570c9 100644
--- a/refs.c
+++ b/refs.c
@@ -2859,8 +2859,19 @@ static int log_ref_write(const char *refname, co=
nst unsigned char *old_sha1,
 		len +=3D copy_msg(logrec + len - 1, msg) - 1;
 	written =3D len <=3D maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
-	if (close(logfd) !=3D 0 || written !=3D len)
-		return error("Unable to append to %s", log_file);
+	if (written !=3D len) {
+		int save_errno =3D errno;
+		close(logfd);
+		error("Unable to append to %s", log_file);
+		errno =3D save_errno;
+		return -1;
+	}
+	if (close(logfd)) {
+		int save_errno =3D errno;
+		error("Unable to append to %s", log_file);
+		errno =3D save_errno;
+		return -1;
+	}
 	return 0;
 }
=20
@@ -2869,14 +2880,17 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/"=
);
 }
=20
+/* This function must return a meaningful errno */
 int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term =3D '\n';
 	struct object *o;
=20
-	if (!lock)
+	if (!lock) {
+		errno =3D EINVAL;
 		return -1;
+	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
@@ -2886,19 +2900,23 @@ int write_ref_sha1(struct ref_lock *lock,
 		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
+		errno =3D EINVAL;
 		return -1;
 	}
 	if (o->type !=3D OBJ_COMMIT && is_branch(lock->ref_name)) {
 		error("Trying to write non-commit object %s to branch %s",
 			sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
+		errno =3D EINVAL;
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) !=3D 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) !=3D 1
-		|| close_ref(lock) < 0) {
+	    write_in_full(lock->lock_fd, &term, 1) !=3D 1 ||
+	    close_ref(lock) < 0) {
+		int save_errno =3D errno;
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
+		errno =3D save_errno;
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
--=20
2.0.1.546.gf603308
