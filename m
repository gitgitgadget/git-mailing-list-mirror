From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Fri, 20 Jun 2014 07:42:55 -0700
Message-ID: <1403275409-28173-15-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05T-000410-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbaFTOqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2014 10:46:24 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:56522 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so505951qcv.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ApbUwsgNMDCCx6uHKJ+p8PGBQH6+Kqi3NV6ft8Tmii0=;
        b=YhDFpwbfk3dLfCSLEH5flz1hPM5tRnaqT9tja6Tas/yY1DQ/HimWSdr+srVtLQH8/v
         c3ZASHVhI9bIdXLDYq8z9Ihfuwq2Rj8Zj2tmQ28GUaNSrGfwytjd3DlWj4b8nIuNh+Ce
         6Dp3Lv8ou7lFcBiSPnAJgn1s8cPGr0IEJVRligGB1niwf7GITTh+a+0IPjxe3FS8eCOx
         cHO5iUmOEtz1g9xzENXL+jaa6/vMhL3ihQmRH83J4uqvZwRGqdiasp9u9D7ybZ2K2CYH
         GTJuAjE4ELmuYpJhiKSFMVGfB6KNQXwUJSa7xqEjOgjWru2HLQ49XSGQDysMrkcLNj6P
         6ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ApbUwsgNMDCCx6uHKJ+p8PGBQH6+Kqi3NV6ft8Tmii0=;
        b=BEHsraq9UYLJUu32Y04NwCPMfe1uI2biV4zbzgY+pPf0Ur3yIkTwDymOIAKL0c+d69
         erCq0VANFzJ+zsDgsApI27Lch4V+Mj85DyWfGZsMZuMTVYLblqq63iR16x/DQbn4QJm+
         fU+f6EHG6pmqUjYFxUjdaLYwbh9Pae9XSWzH4EXMf5WTy+UFdI6jugyQgZPLhAWNSRUe
         hfvRh0NhgaCMxh6HMglvo5dQ8TtefzTpnSWRzbXnarx0o9/acjToYV8h04xRPf/5Yohb
         /EjP7OiIucDXkwbANoKbDdtMQ8WKdrpR7N+2qF+4Qljr1ud6Y3RPaAW2i64tfQRAg6Us
         RaTQ==
X-Gm-Message-State: ALoCoQmADtGO2GGxi+fLH37pLvI1wJ0ahS86WF3qkjspUHr17e/K2z3bbh91YNG2cHXIhAjtjtkY
X-Received: by 10.236.150.114 with SMTP id y78mr1448204yhj.7.1403275412658;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664703yhb.3.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 845335A4551;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 40C6BE0961; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252264>

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
2.0.0.420.g181e020.dirty
