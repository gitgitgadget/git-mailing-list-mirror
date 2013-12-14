From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/21] refs: detach split repos' HEAD when the linked ref is updated/deleted
Date: Sat, 14 Dec 2013 17:55:05 +0700
Message-ID: <1387018507-21999-20-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmqQ-0001Or-UH
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab3LNKxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:53:10 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40232 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab3LNKxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:53:08 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so3479353pdj.25
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WcSqI6q70DG97vriFaAeGz2fxdT5KK+Gbf6kCwTaYWc=;
        b=gY2TFJZO7Enj+wyldNL40yYAQWVocMXcDFx5Mzjt+eltkaxF1VCl5C0lw0DvOUC6/h
         DOID6GbqAmtb75C6V1EV8PhyoTr9MXs/jYQcN/ed6cNltfrTmgGE04gUvyDnL5cmC63Z
         gbjBjPo/dtfWqZHGypH2ajVBW7+RWtJm8+YLN1eQ6KDzIfkKAybgK8JauT+4Uj8ygh9I
         dHL7eIka0JxQh3A8lLqeLYp7PcP+C2ZMKbjBuLIo/Y+LgURucbyXqN3RA2i7d5CImJXC
         tcbcjXpNpw16buvmz5lrXFwdzD4tP9kAx3xJCuN25dSTaZdwoDzGbEjuf9zXLAqhRTj5
         lPHA==
X-Received: by 10.66.139.196 with SMTP id ra4mr8753327pab.103.1387018388307;
        Sat, 14 Dec 2013 02:53:08 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id tu6sm11405443pbc.41.2013.12.14.02.53.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:53:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:58:01 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239301>

This is effective when a ref is updated from the super repository as
well as all linked repositories because "repos" directory is shared
between all repos.

We could even forbid a ref update if it's some repo's HEAD. But I'd
rather see a generic, permanent ref locking mechanism in place first
and make use of it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/refs.c b/refs.c
index 3691ef5..d856b1a 100644
--- a/refs.c
+++ b/refs.c
@@ -2462,6 +2462,41 @@ static int repack_without_ref(const char *refnam=
e)
 	return repack_without_refs(&refname, 1);
 }
=20
+static void detach_repos_refs(const char *refname, const unsigned char=
 *sha1)
+{
+	struct dirent *d;
+	DIR *dir;
+
+	if (!strncmp(refname, "repos/", 6) ||
+	    !strchr(refname, '/') ||
+	    (dir =3D opendir(git_path("repos"))) =3D=3D NULL)
+		return;
+
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		struct strbuf sb_ref =3D STRBUF_INIT;
+		unsigned char ref_sha1[20];
+		const char *ref;
+		int flags;
+
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_addf(&sb_ref, "repos/%s/HEAD", d->d_name);
+		ref =3D resolve_ref_unsafe(sb_ref.buf, ref_sha1, 1, &flags);
+		if (flags & REF_ISSYMREF && ref && !strcmp(ref, refname)) {
+			struct strbuf msg =3D STRBUF_INIT;
+			strbuf_addf(&msg, "repos: detach from %s by %s",
+				    ref, real_path(get_git_dir()));
+			update_ref(msg.buf, sb_ref.buf, sha1, NULL,
+				   REF_NODEREF, DIE_ON_ERR);
+			strbuf_release(&msg);
+			warning(_("detach HEAD of linked repository %s from %s"),
+				d->d_name, refname);
+		}
+		strbuf_release(&sb_ref);
+	}
+	closedir(dir);
+}
+
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2485,6 +2520,7 @@ int delete_ref(const char *refname, const unsigne=
d char *sha1, int delopt)
 	lock =3D lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
+	detach_repos_refs(lock->ref_name, lock->old_sha1);
 	ret |=3D delete_ref_loose(lock, flag);
=20
 	/* removing the loose one could have resurrected an earlier
@@ -2790,6 +2826,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
+	detach_repos_refs(lock->ref_name, lock->old_sha1);
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) !=3D 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) !=3D 1
 		|| close_ref(lock) < 0) {
--=20
1.8.5.1.77.g42c48fa
