From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Thu, 12 Jun 2014 10:21:05 -0700
Message-ID: <1402593699-13983-15-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iz-0008VI-C8
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933653AbaFLRXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2014 13:23:38 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47786 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so99573qcv.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Bcbw9FJt0tmws/HvhC+xHgOdNM9i5VcbzDSJ9tMXZAg=;
        b=WcVW3nxNNeXdXqZ/qn6v1kSlst7gyGC6ypOfSTR0hpwcr9/wjlFf1frdrltSnekj+N
         59hX/1700C6Cflrg7JsFp0HUgHk0iY7bgpW6lbbluoe1viIPsfTYP0UySmqrohf8ZQjp
         8uescKNwvJ720nhXM9dhd7LlYRnEa8OD2aPFd5u+jjHdY4pW+5Vg7dH+fNKng+dA+cqD
         VMK1HsUbh9LDehWz4JQ/zyoDe5vyXdnpR3nfHdpcQOXm/XCEuX9zLiEuufnHjT/aos7N
         adXBFuOSNzhB8nuozwyl1N0uTwSm37CbXAjjf6+1a3ufAxEVA9LIyu3wyughOhrIheSJ
         oLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Bcbw9FJt0tmws/HvhC+xHgOdNM9i5VcbzDSJ9tMXZAg=;
        b=fVqUgt6UbdA+cabyk9rgO7k1AhBk1I4AOnb53UJ0a7Fj6uNlNTvtDp8d9tUN5qjYSh
         tL8CPUi9FlV/NqH3reQEjQF45yKnnNK1iAzHMtrhjhttGAZE/RM5Dqmg4cphR+v2m+Iz
         3pw76ErO7MQIOxBAbIjGwKSEWvmpqJFJcRdyDe8XMvP6ey10HwiUj1KIVhfYwSYi/Qyi
         c+U7XcDGZzUqySQGceUIUNbNOqzyLsVr2uk0IapKymOvqX4yzqRlBPhugPbcQHPSbo/f
         LNb70+ENYw5UuTlVm1FoxoOUfagdMc83Hlk3Khc+TozPhg0dmMyIXdT6pqU0uWEHIO5w
         2r8g==
X-Gm-Message-State: ALoCoQnhlA8+l7u48zVeBRAYBZOmgKes/+KA8l1pR1zapkVaw5qTFLSV9eHJPnKhSnIGiwZqwYXD
X-Received: by 10.236.35.5 with SMTP id t5mr6534232yha.9.1402593703415;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si113012yhb.3.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 481A131C6AC;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB077E0EC6; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251451>

Making errno from write_ref_sha1() meaningful, which should fix

* a bug in "git checkout -b" where it prints strerror(errno)
 =C2=A0despite errno possibly being zero or clobbered

* a bug in "git fetch"'s s_update_ref, which trusts the result of an
 =C2=A0errno =3D=3D ENOTDIR check to detect D/F conflicts

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index a4c728c..31ae63e 100644
--- a/refs.c
+++ b/refs.c
@@ -1951,6 +1951,7 @@ static int remove_empty_directories(const char *f=
ile)
 	result =3D remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
 	save_errno =3D errno;
=20
+	errno =3D save_errno;
 	strbuf_release(&path);
 	errno =3D save_errno;
=20
@@ -2831,8 +2832,19 @@ static int log_ref_write(const char *refname, co=
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
@@ -2841,14 +2853,17 @@ static int is_branch(const char *refname)
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
@@ -2858,19 +2873,23 @@ int write_ref_sha1(struct ref_lock *lock,
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
2.0.0.599.g83ced0e
