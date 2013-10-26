From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses
Date: Sat, 26 Oct 2013 09:09:20 +0700
Message-ID: <1382753360-32037-1-git-send-email-pclouds@gmail.com>
References: <20131025034947.GA4959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 04:05:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZtFp-0007Ve-EN
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 04:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab3JZCFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Oct 2013 22:05:25 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64968 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3JZCFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 22:05:24 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so4518816pdj.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=n2iyc/7XbntPc6g+GF+rSEZVEoa+jiYDqAhwz8Ib0Bs=;
        b=HpABfh969yR1FVbcTrVDenESHSmXyuBEJqru1QBvo0z3rZlG4+QD8kStfOBT9M/x+8
         NMnQPYmqIlxbeo3wju7+dbkh3HwM2fpZVEVWd+zlUJw24Ba1ofTwAHWKfh/FpWQ5njrm
         XfvhC9KOtG4Sb8Sa5yS7TRCj8dWV/BZywapdNVyKlDlvO5Nh2wC9OCSfjt4ql4xGTaSL
         L0+D69Uau+822Pa0N7dc6Mu58eLEFAeXK7i/2uDfC3qaj9dZVICD5iGm7ywf8FcQFUUa
         tQk5FxpimQfvuJ7ooZZwXP6Tw/SZbePTDFSqX6YA2NG7dpz7UaNeMaOPER3kTa0cKWI5
         oWZQ==
X-Received: by 10.66.197.135 with SMTP id iu7mr13679194pac.149.1382753124010;
        Fri, 25 Oct 2013 19:05:24 -0700 (PDT)
Received: from lanh ([115.73.231.247])
        by mx.google.com with ESMTPSA id lm2sm16832383pab.2.2013.10.25.19.05.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Oct 2013 19:05:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 26 Oct 2013 09:09:26 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20131025034947.GA4959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236729>

Normally parse_pathspec() is used on command line arguments where it
can do fancy thing like parsing magic on each argument or adding magic
for all pathspecs based on --*-pathspecs options.

There's another use of parse_pathspec(), where pathspec is needed, but
the input is known to be pure paths. In this case we usually don't
want --*-pathspecs to interfere. And we definitely do not want to
parse magic in these paths, regardless of --literal-pathspecs.

Add new flag PATHSPEC_LITERAL_PATH for this purpose. When it's set,
--*-pathspecs are ignored, no magic is parsed. And if the caller
allows PATHSPEC_LITERAL (i.e. the next calls can take literal magic),
then PATHSPEC_LITERAL will be set.

This fixes cases where git chokes when GIT_*_PATHSPECS are set because
parse_pathspec() indicates it won't take any magic. But
GIT_*_PATHSPECS add them anyway. These are

   export GIT_LITERAL_PATHSPECS=3D1
   git blame -- something
   git log --follow something
   git log --merge

"git ls-files --with-tree=3Dpath" (aka parse_pathspec() in
overlay_tree_on_cache()) is safe because the input is empty, and
producing one pathspec due to PATHSPEC_PREFER_CWD does not take any
magic into account.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Jeff, how about this?
=20
 It's similar to your last suggestion (i.e.  relaxing the magic mask
 about literal magic). In addition, it forces literal magic
 unconditionally in this case, which I think is the right thing to do.
 And it will fix other --*-pathspecs as well.

 builtin/blame.c            | 4 +++-
 pathspec.c                 | 9 ++++++++-
 pathspec.h                 | 7 +++++++
 revision.c                 | 3 ++-
 t/t6130-pathspec-noglob.sh | 7 +++++++
 tree-diff.c                | 4 +++-
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6da7233..1407ae7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -409,7 +409,9 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC, 0, "", paths)=
;
+	parse_pathspec(&diff_opts.pathspec,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_LITERAL_PATH, "", paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..4cf2bd3 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -128,7 +128,11 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 		die(_("global 'literal' pathspec setting is incompatible "
 		      "with all other global pathspec settings"));
=20
-	if (elt[0] !=3D ':' || literal_global) {
+	if (flags & PATHSPEC_LITERAL_PATH)
+		global_magic =3D 0;
+
+	if (elt[0] !=3D ':' || literal_global ||
+	    (flags & PATHSPEC_LITERAL_PATH)) {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
 		/* longhand */
@@ -405,6 +409,9 @@ void parse_pathspec(struct pathspec *pathspec,
 		item[i].magic =3D prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
+		if ((flags & PATHSPEC_LITERAL_PATH) &&
+		    !(magic_mask & PATHSPEC_LITERAL))
+			item[i].magic |=3D PATHSPEC_LITERAL;
 		if (item[i].magic & magic_mask)
 			unsupported_magic(entry,
 					  item[i].magic & magic_mask,
diff --git a/pathspec.h b/pathspec.h
index 944baeb..a75e924 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -58,6 +58,13 @@ struct pathspec {
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
 #define PATHSPEC_PREFIX_ORIGIN (1<<6)
 #define PATHSPEC_KEEP_ORDER (1<<7)
+/*
+ * For the callers that just need pure paths from somewhere else, not
+ * from command line. Global --*-pathspecs options are ignored. No
+ * magic is parsed in each pathspec either. If PATHSPEC_LITERAL is
+ * allowed, then it will automatically set for every pathspec.
+ */
+#define PATHSPEC_LITERAL_PATH (1<<8)
=20
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
diff --git a/revision.c b/revision.c
index 0173e01..9b9e22e 100644
--- a/revision.c
+++ b/revision.c
@@ -1372,7 +1372,8 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 			i++;
 	}
 	free_pathspec(&revs->prune_data);
-	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC, 0, "", prune);
+	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITE=
RAL,
+		       PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited =3D 1;
 }
=20
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ea00d71..6583532 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -108,6 +108,13 @@ test_expect_success 'no-glob environment variable =
works' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'blame takes global pathspec flags' '
+	git --literal-pathspecs blame -- foo &&
+	git --icase-pathspecs   blame -- foo &&
+	git --glob-pathspecs    blame -- foo &&
+	git --noglob-pathspecs  blame -- foo
+'
+
 test_expect_success 'setup xxx/bar' '
 	mkdir xxx &&
 	test_commit xxx xxx/bar
diff --git a/tree-diff.c b/tree-diff.c
index ccf9d7c..456660c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -254,7 +254,9 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 			path[0] =3D p->one->path;
 			path[1] =3D NULL;
 			free_pathspec(&opt->pathspec);
-			parse_pathspec(&opt->pathspec, PATHSPEC_ALL_MAGIC, 0, "", path);
+			parse_pathspec(&opt->pathspec,
+				       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+				       PATHSPEC_LITERAL_PATH, "", path);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
--=20
1.8.2.83.gc99314b
