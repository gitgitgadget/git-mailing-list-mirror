From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 14/48] refs.c: log_ref_write should try to return meaningful errno
Date: Tue, 10 Jun 2014 15:29:02 -0700
Message-ID: <1402439376-25839-15-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYK-0004jq-UV
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbaFJW3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 18:29:54 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60574 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qc0-f202.google.com with SMTP id r5so428576qcx.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Et7IAtwsRefXlOtT0N124uGIZ9GP8amC+oKdtpQ33vI=;
        b=UK3m7cZYwn6xRY/uZcyxoOJ6A9auDqQu/OTrWeDNfV8HbI1eSRegYIKVG/q/lLkxqM
         KIntYX9HT00Ec6FP1d7z7KNzX13DOkvt+pp/09v6ohlt+hmORiPS6gYLoXC6rrOawElZ
         IKW8ZZfDF8ymz4YXHla5cmhxaXdDZMjgP7ekUUpizDoXjwPFOrlyH8L8u8Tlafwn4Edh
         MmIJFbAwHJsCzGuvou4EMzlbRub4f4YbIyuDCn8JrcbrJ9AH6cGX0d4y5yBo5+Vb0K7/
         uPBMy/xDSHLoMhD3+xvlVd6SSc9Liz1wF81zbmkTa+haioRctIkGL6vZz7IB30fRE0T1
         fVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Et7IAtwsRefXlOtT0N124uGIZ9GP8amC+oKdtpQ33vI=;
        b=aF0bzqmeRh0s/078nS9kOuoklXVQsPAKvbpXmY/bCCIOAcrgHIdupcnJ2xveL1jXnT
         BvmRSz6JZtvTgzwJ/3ZQDO0BFK6iCNQBO3woJ4j2jykaKyRPbaJc7UWSn6sjAeauJEuX
         wuhZKxzFuyvPS6YJDnM/N1zTbWMP8bT0wY2SIrz/3DNnnY+aD8JVujqAv0/N66DisH9R
         C3TZ1OWgzsajp7E7iQTm/0P4QyNxmMzN5iJYWmzV5oVvVj+lxsopIZYIHBw3rSVxHcTj
         fmRPaXbmuwaV2blqZeZIDNK+OVVtBCLNiPrCGmfZi9MwYf11Wn+GkSh14hlYMM3fuwYq
         LtSg==
X-Gm-Message-State: ALoCoQlne7PTVX60/qH+MlqtEyqV8Y9Nz6KcfoXMSpDe0g32jAI+U7b/rVhj+TnAgUAR3i3oUiGO
X-Received: by 10.58.237.130 with SMTP id vc2mr8875772vec.25.1402439380786;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1396412yhg.2.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A0F855A473D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 28027E0B27; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251283>

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
2.0.0.574.g30c2c5e
