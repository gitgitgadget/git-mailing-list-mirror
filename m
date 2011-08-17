From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] commit: accept tag objects in HEAD/MERGE_HEAD
Date: Wed, 17 Aug 2011 08:42:49 +0700
Message-ID: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 03:43:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtV9s-0007K3-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 03:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab1HQBm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 21:42:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55633 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 21:42:57 -0400
Received: by pzk37 with SMTP id 37so191077pzk.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LjgiY7yf7EVtMUZ1eggrbymNqji9/dvHI3dw+gv40yg=;
        b=xx7rHhe1hP4JkZ2JSemYbqMXkvrir+LTtD0CST9Dn6Z7ZYK9FXw1dWrajkILW1/3nm
         ICCdwvSkkGFcSwcnWfKmgTqRNzOyL3lWWE256UAwB8EMZU0ax8p/v6C+8OPBduBN60Ot
         skh1+dhuw3JCCIyDK30DMtG8VK7W1lwCHnPSk=
Received: by 10.143.91.8 with SMTP id t8mr176201wfl.250.1313545376748;
        Tue, 16 Aug 2011 18:42:56 -0700 (PDT)
Received: from tre ([115.73.228.117])
        by mx.google.com with ESMTPS id s9sm209803pbk.34.2011.08.16.18.42.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 18:42:55 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Wed, 17 Aug 2011 08:42:50 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179493>

HEAD, MERGE_HEAD (or any other branches) should only have SHA-1 of a
commit object. However broken tools can put a tag object there. While
it's wrong, it'd be better to tolerate the situation and move on
("commit" is an often used operation, unable to commit could be bad).

In worse cases, where we cannot even resolve HEAD to a commit, die()
instead of segfault.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |   15 +++++++++------
 commit.c         |   12 ++++++++++++
 commit.h         |    1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2088b6b..f327595 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1387,6 +1387,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents =3D NULL, **pptr =3D &parents;
+	struct commit *commit;
 	struct stat statbuf;
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
@@ -1423,12 +1424,11 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 			reflog_msg =3D "commit (initial)";
 	} else if (amend) {
 		struct commit_list *c;
-		struct commit *commit;
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (amend)";
-		commit =3D lookup_commit(head_sha1);
-		if (!commit || parse_commit(commit))
+		commit =3D lookup_expect_commit(head_sha1, "HEAD");
+		if (parse_commit(commit))
 			die(_("could not parse HEAD commit"));
=20
 		for (c =3D commit->parents; c; c =3D c->next)
@@ -1439,7 +1439,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (merge)";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit =3D lookup_expect_commit(head_sha1, "HEAD");
+		pptr =3D &commit_list_insert(commit, pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1448,7 +1449,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
+			commit =3D lookup_expect_commit(sha1, "MERGE_HEAD");
+			pptr =3D &commit_list_insert(commit, pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
@@ -1465,7 +1467,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit =3D lookup_expect_commit(head_sha1, "HEAD");
+		pptr =3D &commit_list_insert(commit, pptr)->next;
 	}
=20
 	/* Finally, get the commit message */
diff --git a/commit.c b/commit.c
index ac337c7..dc22695 100644
--- a/commit.c
+++ b/commit.c
@@ -39,6 +39,18 @@ struct commit *lookup_commit_reference(const unsigne=
d char *sha1)
 	return lookup_commit_reference_gently(sha1, 0);
 }
=20
+struct commit *lookup_expect_commit(const unsigned char *sha1,
+				    const char *ref_name)
+{
+	struct commit *c =3D lookup_commit_reference(sha1);
+	if (!c)
+		die(_("could not parse %s"), ref_name);
+	if (hashcmp(sha1, c->object.sha1))
+		warning(_("%s %s is not a commit!"),
+			ref_name, sha1_to_hex(sha1));
+	return c;
+}
+
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj =3D lookup_object(sha1);
diff --git a/commit.h b/commit.h
index feb809f..0e36fd0 100644
--- a/commit.h
+++ b/commit.h
@@ -37,6 +37,7 @@ struct commit *lookup_commit_reference(const unsigned=
 char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha=
1,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
+struct commit *lookup_expect_commit(const unsigned char *sha1, const c=
har *ref_name);
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size);
 int parse_commit(struct commit *item);
--=20
1.7.4.74.g639db
