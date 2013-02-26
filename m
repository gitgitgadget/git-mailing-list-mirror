From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Record original ref in detached HEAD
Date: Tue, 26 Feb 2013 21:28:17 +0700
Message-ID: <1361888897-1821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 15:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UALVd-0005IA-4l
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 15:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab3BZO1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2013 09:27:31 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:37174 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757487Ab3BZO1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 09:27:30 -0500
Received: by mail-da0-f54.google.com with SMTP id p1so1459129dad.27
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cxtWMYhKS++YKJCKTRrS/o2iIwLV9RBmtgpfq+qpl4k=;
        b=q3JS7Fzq/4HdxCncD675M3ZP6kLbpAvt1Jb9r9dX8jd8D3N3GRXPWYKsHOpv87OXGX
         OPL2pvx8GME/Wl8p+0zt0sDWEXdoIayiKuMB8iUzWO2O0RfnmiA9pWSLaYYESnnPsryk
         WVuUz/h1uE0H3s1BbJdVt1M+jK7krlLlmkbYtwV6SQGnR9idVq1GF4ej9eiunzo0uzCe
         VUfvYkQICVXmaASDhiEEUks4kmZqYt97V7sD7DQmnYnIrb4SQhyixJFI+zWRRx6ycXiH
         iQQHCNyvVfjOgFfFiuxv82wOnFn9SyIEPIlHL3mEJhGoJxxXT2QXbuCePyA+G1D+zScb
         aA+w==
X-Received: by 10.68.196.225 with SMTP id ip1mr23716692pbc.72.1361888850357;
        Tue, 26 Feb 2013 06:27:30 -0800 (PST)
Received: from lanh ([115.74.44.205])
        by mx.google.com with ESMTPS id vd4sm1084239pbc.35.2013.02.26.06.27.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 06:27:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Feb 2013 21:28:18 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217133>

Many times I checkout a remote branch, or a tag and after a while I
forget remember what ref I checked it out from. Saving the original
ref would help (or is it already saved somewhere?).

This exploits the fact that FETCH_HEAD stores extra info after the
SHA-1 and at least C Git is prepared to ignore the rest after 40-hex
is successfully parsed for all refs, including HEAD. We could use this
to store the original ref in detached case, as demonstrated in this
patch. "git status" and "git branch" could be modified to show this
information later on. I think it should work even with Git 0.99.8
(I have not really verified though).

So far C Git runs well for me. Other implementations like libgit2 or
JGit may be stricter and reject modified HEAD. I have to check. But I
think HEAD is a local matter and this is not a big deal.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  6 ++++--
 refs.c             | 37 ++++++++++++++++++++++++++++++-------
 refs.h             |  5 +++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..82fccbe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -594,8 +594,10 @@ static void update_refs_for_switch(const struct ch=
eckout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) =
{
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any br=
anch. */
-		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
-			   REF_NODEREF, DIE_ON_ERR);
+		update_ref_with_note(msg.buf, "HEAD",
+				     new->commit->object.sha1,
+				     new->path, NULL,
+				     REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
diff --git a/refs.c b/refs.c
index 175b9fc..b67c3b1 100644
--- a/refs.c
+++ b/refs.c
@@ -2045,10 +2045,13 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/")=
;
 }
=20
-int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int write_ref_sha1_with_note(struct ref_lock *lock,
+				    const unsigned char *sha1,
+				    const char *note,
+				    const char *logmsg)
 {
 	static char term =3D '\n';
+	static char note_separator =3D '\t';
 	struct object *o;
=20
 	if (!lock)
@@ -2071,7 +2074,10 @@ int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) !=3D 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) !=3D 1
+	    (note &&
+	     (write_in_full(lock->lock_fd, &note_separator, 1) !=3D 1 ||
+	      write_in_full(lock->lock_fd, note, strlen(note)) !=3D strlen(no=
te))) ||
+	     write_in_full(lock->lock_fd, &term, 1) !=3D 1
 		|| close_ref(lock) < 0) {
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
@@ -2114,6 +2120,13 @@ int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
=20
+int write_ref_sha1(struct ref_lock *lock,
+		   const unsigned char *sha1,
+		   const char *logmsg)
+{
+	return write_ref_sha1_with_note(lock, sha1, NULL, logmsg);
+}
+
 int create_symref(const char *ref_target, const char *refs_heads_maste=
r,
 		  const char *logmsg)
 {
@@ -2411,9 +2424,11 @@ int for_each_reflog(each_ref_fn fn, void *cb_dat=
a)
 	return retval;
 }
=20
-int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr)
+int update_ref_with_note(const char *action, const char *refname,
+			 const unsigned char *sha1,
+			 const char *note,
+			 const unsigned char *oldval,
+			 int flags, enum action_on_err onerr)
 {
 	static struct ref_lock *lock;
 	lock =3D lock_any_ref_for_update(refname, oldval, flags);
@@ -2426,7 +2441,7 @@ int update_ref(const char *action, const char *re=
fname,
 		}
 		return 1;
 	}
-	if (write_ref_sha1(lock, sha1, action) < 0) {
+	if (write_ref_sha1_with_note(lock, sha1, note, action) < 0) {
 		const char *str =3D "Cannot update the ref '%s'.";
 		switch (onerr) {
 		case MSG_ON_ERR: error(str, refname); break;
@@ -2438,6 +2453,14 @@ int update_ref(const char *action, const char *r=
efname,
 	return 0;
 }
=20
+int update_ref(const char *action, const char *refname,
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       int flags, enum action_on_err onerr)
+{
+	return update_ref_with_note(action, refname, sha1, NULL,
+				    oldval, flags, onerr);
+}
+
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list =3D list->next)
diff --git a/refs.h b/refs.h
index 1b2e2d3..9fbba2e 100644
--- a/refs.h
+++ b/refs.h
@@ -146,6 +146,11 @@ enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET=
_ON_ERR };
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
+int update_ref_with_note(const char *action, const char *refname,
+			 const unsigned char *sha1,
+			 const char *note,
+			 const unsigned char *oldval,
+			 int flags, enum action_on_err onerr);
=20
 extern int parse_hide_refs_config(const char *var, const char *value, =
const char *);
 extern int ref_is_hidden(const char *);
--=20
1.8.1.2.536.gf441e6d
