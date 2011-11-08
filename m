From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Copy resolve_ref() return value for longer use
Date: Tue,  8 Nov 2011 09:30:28 +0700
Message-ID: <1320719428-1802-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Tony Wang <wwwjfy@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 03:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbSY-0001lX-HH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 03:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab1KHCal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 21:30:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61625 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1KHCak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 21:30:40 -0500
Received: by qyk27 with SMTP id 27so3156387qyk.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 18:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ARdtfPfXaiW3qg0pCUplPj7i7jitnkcz+l2Fn4cf7aM=;
        b=NLh4AGxlkWXcAph8wNzlnNQepWxSiaXc/JDJ7NN7ClX0a+5POGQYOtsdVMViuPrC99
         xCKzPQpWY9e08wL9Eo/eY7pMC9J+zUKpL0NI/FS4twSnsvNhpcete8X7L33ZbjtdLJSq
         0CCWflwxgyz9Ems9OHxkxwlvFLbxgAFwFYTDI=
Received: by 10.68.47.4 with SMTP id z4mr3938615pbm.39.1320719439430;
        Mon, 07 Nov 2011 18:30:39 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id p10sm466812pbd.15.2011.11.07.18.30.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 18:30:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Nov 2011 09:30:30 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185049>

resolve_ref() may return a pointer to a static buffer. Callers that
use this value outside of a block should copy the value to avoid some
hidden resolve_ref() call that may change the static buffer's value.

The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
demonstrates this. The first call is in cmd_merge()

branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);

Then deep in lookup_commit_or_die() a few lines after, resolve_ref()
may be called again and destroy "branch".

lookup_commit_or_die
 lookup_commit_reference
  lookup_commit_reference_gently
   parse_object
    lookup_replace_object
     do_lookup_replace_object
      prepare_replace_object
       for_each_replace_ref
        do_for_each_ref
         get_loose_refs
          get_ref_dir
           get_ref_dir
            resolve_ref

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c      |    4 +++-
 builtin/commit.c        |    3 ++-
 builtin/fmt-merge-msg.c |    1 +
 builtin/merge.c         |    7 +++++--
 builtin/notes.c         |    1 +
 builtin/receive-pack.c  |    2 ++
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a80772..98ddbcd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -699,7 +699,9 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D xstrdup(resolve_ref("HEAD", rev, 0, &flag));
+	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
+	if (old.path)
+		old.path =3D xstrdup(old.path);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF)) {
 		free((char *)old.path);
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..f3a6ed2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1259,7 +1259,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	struct commit *commit;
 	struct strbuf format =3D STRBUF_INIT;
 	unsigned char junk_sha1[20];
-	const char *head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
+	const char *head;
 	struct pretty_print_context pctx =3D {0};
 	struct strbuf author_ident =3D STRBUF_INIT;
 	struct strbuf committer_ident =3D STRBUF_INIT;
@@ -1304,6 +1304,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);
=20
+	head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
 	printf("[%s%s ",
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7e2f225..cab50e0 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -268,6 +268,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch +=3D 11;
+	current_branch =3D xstrdup(current_branch);
=20
 	/* get a line */
 	while (pos < in->len) {
diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..6865cb7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1096,8 +1096,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 	 * current branch.
 	 */
 	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
-	if (branch && !prefixcmp(branch, "refs/heads/"))
-		branch +=3D 11;
+	if (branch) {
+		if (!prefixcmp(branch, "refs/heads/"))
+			branch +=3D 11;
+		branch =3D xstrdup(branch);
+	}
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit =3D NULL;
 	else
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..c6e4c86 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -828,6 +828,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
+	o->local_ref =3D xstrdup(o->local_ref);
=20
 	if (notes_merge_commit(o, t, partial, sha1))
 		die("Failed to finalize notes merge");
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..6065bf0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -696,6 +696,8 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
 	check_aliased_updates(commands);
=20
 	head_name =3D resolve_ref("HEAD", sha1, 0, NULL);
+	if (head_name)
+		head_name =3D xstrdup(head_name);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
--=20
1.7.3.1.256.g2539c.dirty
