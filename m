From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/12] Add and use skip_prefix_defval()
Date: Wed, 18 Dec 2013 21:53:48 +0700
Message-ID: <1387378437-20646-4-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIW8-0003P2-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3LROyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:24 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:47017 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3LROyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:23 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so8627409pbc.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i0csYz45Og0A8Tq43jKniTLLpWsugMM1lmvENxQNKRY=;
        b=GulKx/5F9Gu348SxqHKIO9sbVqt/EDIARvQZybVyqmwxZj2JsaibtPbmDpeOTa73ot
         GkwKbAPYDIe2r8Mk0pPlnSKr5hAkmgkfiMrtkKIElOETjAROgi9b9qoUcMKEDH49+SQi
         o35o8JaF5P4OSDzRbzpDAtfqKmVZ0hm3ktG6U5W/nhfRsjk4eSiJgJk3URTd1lQzZOhx
         wNZW6OKpxMpKA0Sr6EvbMP7TSyCTv8/ebKsDUbUZ00QJqCwVVRe5bpSnLmMVbuGhBR/q
         t8TN+tS8TJCU2IeaBZqJsdegs8LwjRwanYqYB2wYuXg/pYCNMnYmiUDV0aNv6qnsgr8o
         BcLw==
X-Received: by 10.66.102.4 with SMTP id fk4mr33752910pab.59.1387378462082;
        Wed, 18 Dec 2013 06:54:22 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id vh3sm568359pbc.8.2013.12.18.06.54.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:18 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239442>

This is a variant of skip_prefix() that returns a specied pointer
instead of NULL if no prefix is found. It's helpful to simplify

  if (starts_with(foo, "bar"))
    foo +=3D 3;

into

  foo =3D skip_prefix_gently(foo, "bar", foo);

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c    |  6 ++----
 builtin/fast-export.c |  3 +--
 builtin/merge.c       |  4 ++--
 builtin/show-branch.c | 14 +++++---------
 git-compat-util.h     |  9 +++++++--
 git.c                 |  3 +--
 notes.c               |  6 ++----
 wt-status.c           | 12 ++++--------
 8 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..6531ed4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1151,10 +1151,8 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 		const char *argv0 =3D argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die (_("--track needs a branch name"));
-		if (starts_with(argv0, "refs/"))
-			argv0 +=3D 5;
-		if (starts_with(argv0, "remotes/"))
-			argv0 +=3D 8;
+		argv0 =3D skip_prefix_defval(argv0, "refs/", argv0);
+		argv0 =3D skip_prefix_defval(argv0, "remotes/", argv0);
 		argv0 =3D strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die (_("Missing branch name; try -b"));
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8d8a3a..cd0a302 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -476,8 +476,7 @@ static void handle_tag(const char *name, struct tag=
 *tag)
 		}
 	}
=20
-	if (starts_with(name, "refs/tags/"))
-		name +=3D 10;
+	name =3D skip_prefix_defval(name, "refs/tags/", name);
 	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
 	       name, tagged_mark,
 	       (int)(tagger_end - tagger), tagger,
diff --git a/builtin/merge.c b/builtin/merge.c
index 4941a6c..590d907 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1106,8 +1106,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * current branch.
 	 */
 	branch =3D branch_to_free =3D resolve_refdup("HEAD", head_sha1, 0, &f=
lag);
-	if (branch && starts_with(branch, "refs/heads/"))
-		branch +=3D 11;
+	if (branch)
+		branch =3D skip_prefix_defval(branch, "refs/heads/", branch);
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit =3D NULL;
 	else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d9217ce..6078132 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -284,8 +284,7 @@ static void show_one_commit(struct commit *commit, =
int no_name)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str =3D pretty.buf;
 	}
-	if (starts_with(pretty_str, "[PATCH] "))
-		pretty_str +=3D 8;
+	pretty_str =3D skip_prefix_defval(pretty_str, "[PATCH] ", pretty_str)=
;
=20
 	if (!no_name) {
 		if (name && name->head_name) {
@@ -473,14 +472,13 @@ static void snarf_refs(int head, int remotes)
 	}
 }
=20
-static int rev_is_head(char *head, int headlen, char *name,
+static int rev_is_head(const char *head, int headlen, const char *name=
,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (starts_with(head, "refs/heads/"))
-		head +=3D 11;
+	head =3D skip_prefix_defval(head, "refs/heads/", head);
 	if (starts_with(name, "refs/heads/"))
 		name +=3D 11;
 	else if (starts_with(name, "heads/"))
@@ -811,10 +809,8 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
 					head_sha1, NULL))
 				has_head++;
 		}
-		if (!has_head) {
-			int offset =3D starts_with(head, "refs/heads/") ? 11 : 0;
-			append_one_rev(head + offset);
-		}
+		if (!has_head)
+			append_one_rev(skip_prefix_defval(head, "refs/heads/", head));
 	}
=20
 	if (!ref_name_cnt) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 84f1078..b72a80d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -354,10 +354,15 @@ extern int prefixcmp(const char *str, const char =
*prefix);
 extern int ends_with(const char *str, const char *suffix);
 extern int suffixcmp(const char *str, const char *suffix);
=20
-static inline const char *skip_prefix(const char *str, const char *pre=
fix)
+static inline const char *skip_prefix_defval(const char *str, const ch=
ar *prefix, const char *defval)
 {
 	size_t len =3D strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	return strncmp(str, prefix, len) ? defval : str + len;
+}
+
+static inline const char *skip_prefix(const char *str, const char *pre=
fix)
+{
+	return skip_prefix_defval(str, prefix, NULL);
 }
=20
 static inline int starts_with(const char *str, const char *prefix)
diff --git a/git.c b/git.c
index 35fda7e..321ae81 100644
--- a/git.c
+++ b/git.c
@@ -579,8 +579,7 @@ int main(int argc, char **av)
 	argc--;
 	handle_options(&argv, &argc, NULL);
 	if (argc > 0) {
-		if (starts_with(argv[0], "--"))
-			argv[0] +=3D 2;
+		argv[0] =3D skip_prefix_defval(argv[0], "--", argv[0]);
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
diff --git a/notes.c b/notes.c
index 5f07c0b..31f513b 100644
--- a/notes.c
+++ b/notes.c
@@ -1243,10 +1243,8 @@ static void format_note(struct notes_tree *t, co=
nst unsigned char *object_sha1,
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
 		} else {
-			if (starts_with(ref, "refs/"))
-				ref +=3D 5;
-			if (starts_with(ref, "notes/"))
-				ref +=3D 6;
+			ref =3D skip_prefix_defval(ref, "refs/", ref);
+			ref =3D skip_prefix_defval(ref, "notes/", ref);
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
 	}
diff --git a/wt-status.c b/wt-status.c
index 4e55810..1f65039 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1179,14 +1179,10 @@ static void wt_status_get_detached_from(struct =
wt_status_state *state)
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
 	     ((commit =3D lookup_commit_reference_gently(sha1, 1)) !=3D NULL =
&&
 	      !hashcmp(cb.nsha1, commit->object.sha1)))) {
-		int ofs;
-		if (starts_with(ref, "refs/tags/"))
-			ofs =3D strlen("refs/tags/");
-		else if (starts_with(ref, "refs/remotes/"))
-			ofs =3D strlen("refs/remotes/");
-		else
-			ofs =3D 0;
-		state->detached_from =3D xstrdup(ref + ofs);
+		const char *p;
+		if ((p =3D skip_prefix_defval(ref, "refs/tags/", ref)) =3D=3D ref)
+			p =3D skip_prefix_defval(ref, "refs/remotes/", ref);
+		state->detached_from =3D xstrdup(p);
 	} else
 		state->detached_from =3D
 			xstrdup(find_unique_abbrev(cb.nsha1, DEFAULT_ABBREV));
--=20
1.8.5.1.208.g019362e
