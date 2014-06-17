From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Tue, 17 Jun 2014 08:53:28 -0700
Message-ID: <1403020442-31049-15-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvkM-0006Gv-DD
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbaFQP4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 11:56:24 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:33587 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1489271oac.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HY9G3JVuY4w1Bw5uK9xS9BwCFssastdzqLnvUbC+8TQ=;
        b=h5WtKygUpRari5I+Ydwrjfbn/D1NtQDXaqainVpEIQ4sl/9Koiedp1ciDNKGhr2WHo
         qr/o4sLbmzaMS85oGRA8c2Mm6LmooLmU8ZaBxWXh9PHtXIXuoyDnKgmSZ5qxG2cWx4rT
         GLXmPVvKeHWGDKZXQCtDfyf2pr0qpgr6rAsDxE5Q7SLxOIBqRl4K3qJvVw8RZV7hJMNy
         TBWlQpnD3xH72kJvFRX3CRYTkkwl30N8BkqqWS4C++5fvmagM9l6gdhhTWS6IxL5WO6M
         kCt80fs+mibtJ5Kv1wOqR3UMTD3B6CMzrHt8UjZ5q8iuSvBy7tltgDIXb2OsLZbDmJas
         IV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HY9G3JVuY4w1Bw5uK9xS9BwCFssastdzqLnvUbC+8TQ=;
        b=Q4/GMFrzdzRIUd9k9erDVynVdKSLRnE0zqa5DRulptLTCYk/mrbiuj6M4DDpOyzJD4
         3Zi8hi4KKubrUZbu4nRkkWlbzL5YlfVtjghnhjKIvhQksU0fq5/s3swVemZpeYqq4/FI
         B4IcYSxyS/S3zwehgaBkJh+cSNQCAyj09ChC6IZQMGrdwcI0diDjT19F2ub+GQHMMJ06
         DMunJdxWs1m+UARTTN45ZcdoaSwMtI7K0HlJw3EHvNVi8+xhsRssJA5zy2KPyuAmdGD0
         oao0JniHhSSK6ko3Bs+0FsGmkPVCZSwTIxhcUqVhjOzF5gqKSGUFEeI/OiqD0ygv1whj
         Ofgg==
X-Gm-Message-State: ALoCoQnZh17xBHUptOyNfIzweT+q0G5aVd+LIBVg4FTDrdTDHAHfhAoT7SXgCNSSUC8yl8tqC1Tn
X-Received: by 10.42.249.207 with SMTP id ml15mr326055icb.21.1403020444872;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1208713yhk.4.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B30D35A45B3;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 770D4E1662; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251903>

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
index 211429d..1f2eb24 100644
--- a/refs.c
+++ b/refs.c
@@ -1979,6 +1979,7 @@ static int remove_empty_directories(const char *f=
ile)
 	result =3D remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
 	save_errno =3D errno;
=20
+	errno =3D save_errno;
 	strbuf_release(&path);
 	errno =3D save_errno;
=20
@@ -2859,8 +2860,19 @@ static int log_ref_write(const char *refname, co=
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
@@ -2869,14 +2881,17 @@ static int is_branch(const char *refname)
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
@@ -2886,19 +2901,23 @@ int write_ref_sha1(struct ref_lock *lock,
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
2.0.0.438.gec92e5c
