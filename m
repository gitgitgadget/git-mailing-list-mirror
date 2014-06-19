From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Thu, 19 Jun 2014 08:52:56 -0700
Message-ID: <1403193210-6028-15-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeh4-0000VH-MM
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933596AbaFSPzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2014 11:55:47 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:51538 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so331542vcb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=loyVo6DMtdarBuVyN+zCvo0t6PDNKEJ/C23eRjrH41I=;
        b=RH3smPZ336jXkrCrXDXI6jRTdKQbx1EHy4ZEk7O508u3s2pbEpkS/aB7ozxyOSBV5+
         exuE7up42nLjq6yHGZMCiS6ubddj2HcNWBZIf2DAzVadKFrF7HOcDvnpRmyFUebxPOMT
         0RKYPVDU2DdgUl9GYnUCL5fkkuLu9EizQQ6z6Kt6xS9BU6FVuuKGi1GBqcFXMaf8u942
         JHdmsHNZ44WXC8sDKbJcmDt63hcN/CaoEgQfCTm/PBT5atPb0lva8CwYxrJneV+rlfYM
         1J3JsU4OjcYqvgehcJS8NQnZNb1IL3NO6SC8zArEqA9KbQMjqzHbnt2+vYEXrzKlKU8t
         AkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=loyVo6DMtdarBuVyN+zCvo0t6PDNKEJ/C23eRjrH41I=;
        b=ZQYLffxkVpzvYB9EybHJ2Ln64NXdIvWy1gyf09wZRn7SlWoiK8Qo6e+SS/SUhwKSVC
         WJ9gstPCFOFm2DrVTkf2CZIrTD+wYZnmI6ycOJw5+ad9CuphsA3QE+xnDQ5YWNpUxUao
         DnTegNaVj+EJvY2Rd/vSwI6FwgZq1DabKA3lac3uu/W9ddL3GHCIWQnhnKKBW0bLzEvT
         ueW6AhZcCJurhLpxyhuPKZ6gdJqFv6bTuwwJcxT5YXJbHh2T96uvKd7DxkQrngaPtd/q
         Y4DWdcyaNKZyLqXJMS4j8MDU2LtI347H3v4lPBCo1OkHKdVsj5RaxH225rJKhfTm1e3i
         T3vg==
X-Gm-Message-State: ALoCoQlo906/slIWO3Drttve5wkhC8N0kAnXY7YUNAdCtlGA+CdQjf6AG3/kVAIPVZUgHRkZbFVw
X-Received: by 10.236.81.99 with SMTP id l63mr2306073yhe.3.1403193213326;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419897yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 31CAB31C485;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E7EA2E24DD; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252150>

Making errno from write_ref_sha1() meaningful, which should fix

* a bug in "git checkout -b" where it prints strerror(errno)
 =C2=A0despite errno possibly being zero or clobbered

* a bug in "git fetch"'s s_update_ref, which trusts the result of an
 =C2=A0errno =3D=3D ENOTDIR check to detect D/F conflicts

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
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
2.0.0.438.g337c581
