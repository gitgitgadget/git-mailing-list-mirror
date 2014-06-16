From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Mon, 16 Jun 2014 11:03:45 -0700
Message-ID: <1402941859-29354-15-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKq-0007ty-4O
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbaFPSIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 14:08:23 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:55520 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so432431pde.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NuL3u7NLjzwXzf8LrA4yydAz8Ow8cwYv20K2Jblrkpg=;
        b=ZErzRqq0O+lcEIp65p/DiPYk101B74UIasmLlRM2IisQNWrreYpR01F94In+ohX9SP
         lP5mnzLaoAI7cJ2NffOL6ZOQpXlkgLlM/91t+Y+bOfqOZnZ4a1lRuMl13X5aXA1FT+oX
         TN2TlvjvUruiznBFMj9vO5GhFLqM+FwFg/PO4XceBelRMD7vXxJYhHh+s4Pc6jpMz8qc
         esegGiDiTXGMFGjqKJgrgPmEjyR+gOzhmMF/G+zXAfSoLsbaNTkqpudMb8HEx2cVax1i
         F8jCAKnMlcN1nsMeKu2BnIgXATx0DbNv9TBe+XSLPnscKkg2BzN08zarVq3iVakvNc/M
         hgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NuL3u7NLjzwXzf8LrA4yydAz8Ow8cwYv20K2Jblrkpg=;
        b=lDi+TeiU/7eqb1UkN+s06K4gJn4ssNKEyIeGVy6vzSfhK/3UrmwFRTOlWIHNQUl1th
         vYpD5+0NOMNr8FTm/hKOwHMd5iYaf85Ln17w+PuxY+MC5lsqCAb+i7qpjwcNu3PJPFPd
         Wly+P8TNhQxE/bD7kK9i3e8MXYeH7lr/3Gdf/6UidTQv3uI6N6Sr0w5uzZ9ew11A3AWd
         c4sPHbolFHgJuSqArXUDiXqAvw851ZQ7id8YwPuVBDTty3xELxcehzSPVTO9zZQKEH76
         i9n3fl2bav52DoPGQ73rMEoDR17mM6YIw+vjpxafxwcY1Jsqkl2d3Ng+Lza5i0p5klBE
         5pDA==
X-Gm-Message-State: ALoCoQnt5VKx4Rm1dFB2mxmgtREtceBfYLOvqRVCzjn8s1A/osxAUyEhP87Q+LQk7fCo2D0guFbH
X-Received: by 10.66.160.34 with SMTP id xh2mr1693765pab.6.1402941862839;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si997323yhk.4.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A1D9A31C8AD;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60110E13D6; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251785>

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
2.0.0.282.g3799eda.dirty
