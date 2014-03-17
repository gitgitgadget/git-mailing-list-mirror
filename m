From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] log: add --nonlinear-barrier to help see non-linear history
Date: Mon, 17 Mar 2014 19:51:16 +0700
Message-ID: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
References: <1391867417-979-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 13:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPX0h-0003tY-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 13:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbaCQMvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 08:51:13 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51161 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119AbaCQMuf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 08:50:35 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so5637752pbc.18
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P+ozg9t7oUp6ErRfpDnvggGnqILS7/qkUoXQ/s39LxM=;
        b=Nr6p11Z8Fm30IQ7BiE6grpB15f757n10ge+Wti/qoMBXZTVGbAO23N4zgfV2vJRp5L
         7o+V90aHKft1T4S3kqMwiXKeoxmfnQxuG6TtSBSWGJ32Rrq3fu8ucflQux5I8bS+nNI4
         DfNNJHNZ4NB9EE8VQRj7tFb2uJ42pMTmmfBZN1e8p79gOStiUACXcQY+t7HqQF2NVR5b
         4SjGkFJs4Pd2HdEhwJ+u3LvrxyXm/XGVrVrp20vReT8pnJNaskPI5RjjSO64yCUNghYF
         oNQ2BcGSrc9UPGIfggNEbNqPol+EZLfgiObNkKA2CR5H7UaYYd+lKqkvakNrAeYw/5AC
         j47A==
X-Received: by 10.66.180.200 with SMTP id dq8mr25690911pac.104.1395060634791;
        Mon, 17 Mar 2014 05:50:34 -0700 (PDT)
Received: from lanh ([115.73.237.95])
        by mx.google.com with ESMTPSA id op3sm42980793pbc.40.2014.03.17.05.50.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 05:50:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 17 Mar 2014 19:51:17 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1391867417-979-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244246>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 renames the option name to --nonlinear-barrier and fixes using it
 with --dense. Best used with --no-merges to see patch series.

 Documentation/rev-list-options.txt |  7 ++++++
 log-tree.c                         |  4 +++
 revision.c                         | 51 ++++++++++++++++++++++++++++++=
+++++---
 revision.h                         |  6 +++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 03533af..435aa2d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -750,6 +750,13 @@ This enables parent rewriting, see 'History Simpli=
fication' below.
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
=20
+--nonlinear-barrier[=3D<barrier>]::
+	When --graph is not used, all history branches are flatten and
+	could be hard to see that the two consecutive commits do not
+	belong to a linear branch. This option puts a barrier in
+	between them in that case. If `<barrier>` is specified, it
+	is the string that will be shown instead of the default one.
+
 ifdef::git-rev-list[]
 --count::
 	Print a number stating how many commits would have been
diff --git a/log-tree.c b/log-tree.c
index 08970bf..17862f6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -805,12 +805,16 @@ int log_tree_commit(struct rev_info *opt, struct =
commit *commit)
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
=20
+	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
+		printf("\n%s\n", opt->break_bar);
 	shown =3D log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent =3D NULL;
 		show_log(opt);
 		shown =3D 1;
 	}
+	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
+		printf("\n%s\n", opt->break_bar);
 	opt->loginfo =3D NULL;
 	maybe_flush_or_die(stdout, "stdout");
 	return shown;
diff --git a/revision.c b/revision.c
index a68fde6..0a4849e 100644
--- a/revision.c
+++ b/revision.c
@@ -1832,6 +1832,12 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature =3D 1;
+	} else if (!strcmp(arg, "--nonlinear-barrier")) {
+		revs->track_linear =3D 1;
+		revs->break_bar =3D "                    ..........";
+	} else if (starts_with(arg, "--nonlinear-barrier=3D")) {
+		revs->track_linear =3D 1;
+		revs->break_bar =3D xstrdup(arg + 20);
 	} else if (starts_with(arg, "--show-notes=3D") ||
 		   starts_with(arg, "--notes=3D")) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -2897,6 +2903,32 @@ enum commit_action simplify_commit(struct rev_in=
fo *revs, struct commit *commit)
 	return action;
 }
=20
+define_commit_slab(saved_linear, int);
+
+static void track_linear(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *p =3D revs->previous_parents;
+
+	if (p) {
+		int got_parent =3D 0;
+		for (; p && !got_parent; p =3D p->next)
+			got_parent =3D !hashcmp(p->item->object.sha1,
+					      commit->object.sha1);
+		revs->linear =3D got_parent;
+		free_commit_list(revs->previous_parents);
+	} else
+		revs->linear =3D 1;
+	if (revs->reverse) {
+		if (!revs->saved_linear_slab) {
+			revs->saved_linear_slab =3D xmalloc(sizeof(struct saved_linear));
+			init_saved_linear(revs->saved_linear_slab);
+		}
+
+		*saved_linear_at(revs->saved_linear_slab, commit) =3D revs->linear;
+	}
+	revs->previous_parents =3D copy_commit_list(commit->parents);
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -2936,6 +2968,8 @@ static struct commit *get_revision_1(struct rev_i=
nfo *revs)
 			die("Failed to simplify parents of commit %s",
 			    sha1_to_hex(commit->object.sha1));
 		default:
+			if (revs->track_linear)
+				track_linear(revs, commit);
 			return commit;
 		}
 	} while (revs->commits);
@@ -3102,14 +3136,25 @@ struct commit *get_revision(struct rev_info *re=
vs)
 		revs->reverse_output_stage =3D 1;
 	}
=20
-	if (revs->reverse_output_stage)
-		return pop_commit(&revs->commits);
+	if (revs->reverse_output_stage) {
+		c =3D pop_commit(&revs->commits);
+		if (revs->track_linear)
+			revs->linear =3D *saved_linear_at(revs->saved_linear_slab, c);
+		return c;
+	}
=20
 	c =3D get_revision_internal(revs);
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
-	if (!c)
+	if (!c) {
 		free_saved_parents(revs);
+		if (revs->saved_linear_slab)
+			clear_saved_linear(revs->saved_linear_slab);
+		if (revs->previous_parents) {
+			free_commit_list(revs->previous_parents);
+			revs->previous_parents =3D NULL;
+		}
+	}
 	return c;
 }
=20
diff --git a/revision.h b/revision.h
index 88967d6..bffdc15 100644
--- a/revision.h
+++ b/revision.h
@@ -134,6 +134,7 @@ struct rev_info {
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
+			track_linear:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 	unsigned int	leak_pending:1;
@@ -195,6 +196,11 @@ struct rev_info {
=20
 	/* copies of the parent lists, for --full-diff display */
 	struct saved_parents *saved_parents_slab;
+
+	struct commit_list *previous_parents;
+	struct saved_linear *saved_linear_slab;
+	char *break_bar;
+	unsigned int linear;
 };
=20
 extern int ref_excluded(struct string_list *, const char *path);
--=20
1.9.0.40.gaa8c3ea
