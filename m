From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/21] revision: include repos/../HEAD in --all
Date: Sat, 14 Dec 2013 17:55:07 +0700
Message-ID: <1387018507-21999-22-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmqb-0001SP-Ni
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab3LNKxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:53:21 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56448 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3LNKxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:53:20 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so3496974pde.28
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zMmDYOfPwDMkU94tj/a/kyZ14J++Aj56c/uwkAOMh1c=;
        b=ijyEMJruno6xyLSb/1EK5CppH7VT5ERyb1oJoBGWT5XN/A+qa78e8ptWb/z+2FH0gv
         yTdHe7h/EyhqZp43rrRwr7G6CaSYI7K+3Gou32kucz5gZ0Dk4hzthZSRfX65PLgTtptX
         3PY6PzM/RqIEsxtFqSq17ynV1wUhdY8a7hIQQQuNTrI1V95QqH+pN4BQpoDttwEuTJV6
         nUtvU87kZVOkplPng5dT/auQj4JYM8y+bIGHxtSie1w/UrNKv5AqqGJ6gEYtVQEF9rE0
         6UbzzNHQdBlvCoUtOGSojY9NYJk6msCJuDns7d8RLMeXRRQMHWBMu4emOLJGsQXDi4zs
         4cRw==
X-Received: by 10.68.129.130 with SMTP id nw2mr8974903pbb.88.1387018400547;
        Sat, 14 Dec 2013 02:53:20 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id qf1sm3230470pbb.12.2013.12.14.02.53.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:53:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:58:13 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239303>

This makes sure repack won't drop detached HEADS from $GIT_DIR/repos/

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c     | 21 +++++++++++++++++++++
 refs.h     |  1 +
 revision.c |  1 +
 3 files changed, 23 insertions(+)

diff --git a/refs.c b/refs.c
index 8ef1cb0..a9c8651 100644
--- a/refs.c
+++ b/refs.c
@@ -1740,6 +1740,27 @@ static int do_one_head_ref(const char *ref, cons=
t char *submodule,
 	return 0;
 }
=20
+int repos_head_ref_submodule(const char *submodule, each_ref_fn fn, vo=
id *cb_data)
+{
+	DIR *dir =3D opendir(git_path("repos"));
+	int ret =3D 0;
+	struct dirent *d;
+
+	if (!dir)
+		return ret;
+
+	while (!ret && (d =3D readdir(dir)) !=3D NULL) {
+		struct strbuf sb_ref =3D STRBUF_INIT;
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_addf(&sb_ref, "repos/%s/HEAD", d->d_name);
+		ret =3D do_one_head_ref(sb_ref.buf, submodule, fn, cb_data);
+		strbuf_release(&sb_ref);
+	}
+	closedir(dir);
+	return ret;
+}
+
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_one_head_ref("HEAD", NULL, fn, cb_data);
diff --git a/refs.h b/refs.h
index 87a1a79..05686e4 100644
--- a/refs.h
+++ b/refs.h
@@ -70,6 +70,7 @@ extern int for_each_glob_ref(each_ref_fn, const char =
*pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, cons=
t char* prefix, void *);
=20
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, v=
oid *cb_data);
+extern int repos_head_ref_submodule(const char *submodule, each_ref_fn=
 fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn f=
n, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char=
 *prefix,
 		each_ref_fn fn, void *cb_data);
diff --git a/revision.c b/revision.c
index 05d2d77..c4150ed 100644
--- a/revision.c
+++ b/revision.c
@@ -2004,6 +2004,7 @@ static int handle_revision_pseudo_opt(const char =
*submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		handle_refs(submodule, revs, *flags, repos_head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
--=20
1.8.5.1.77.g42c48fa
