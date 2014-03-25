From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/2] log: add --show-linear-break to help see non-linear history
Date: Tue, 25 Mar 2014 20:23:27 +0700
Message-ID: <1395753807-23228-2-git-send-email-pclouds@gmail.com>
References: <1395294254-941-1-git-send-email-pclouds@gmail.com>
 <1395753807-23228-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 14:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRJY-0001lh-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbaCYNWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 09:22:44 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46886 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaCYNWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 09:22:43 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so446001pad.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wr6T1SrlTNL157e0ponvSLOgMqo0SOMEwAP2id1ooZk=;
        b=RANAV3pwVBDGRiKgPHPu6xouNKlPPv8Ik0fTpPFblcIwsPeTJwnU6KS4Sw9w7vVdnL
         aoP1JPMJBawEYTTAqKXjfwjc5VYsC6a6qrW8ARIXizG24p0zBayrDCCoq9R4Vjim+ehs
         LEtKD/TuC/gdRIbW7x08UVO7F0prfAfrmVpVXOWWaqTVrkVJA2G1kLKCgL0VfHfruQWV
         oqsnX/MhCjHBoN6ni9HO9dwt3Aj4a7FR6+ZDs4IL8Sf1Rk3vDGySXV1cwBxlAE7xx6zU
         jWGcsKqOXM3pftMc/L1CJXXvixgv25rpsSd0eO3FGC2th8EpLdLcesAuWMEp26JRGO3Y
         WtjA==
X-Received: by 10.67.14.69 with SMTP id fe5mr79212798pad.120.1395753762611;
        Tue, 25 Mar 2014 06:22:42 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id op3sm44678382pbc.40.2014.03.25.06.22.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 06:22:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Mar 2014 20:23:34 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395753807-23228-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245032>

Option explanation is in rev-list-options.txt. The interaction with -z
is left undecided.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Mar 21, 2014 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 >>  * Get rid of saved_linear, use another flag in struct object inste=
ad
 >
 > I cannot offhand say if I like this change or not.  A flag bit is a
 > scarce and limited resource; commit slabs felt more suited for
 > implementation of corner case eye-candies.

 I leave it in bit 26. We can move it out when we run low on flag bits.

 >>  * Fix not showing the break bar after a root commit if the dag gra=
ph
 >>    has multiple roots
 >
 > I definitely do not like the way a commit-list data structure is
 > abused to hold a phoney element that points at a NULL with its item
 > pointer.  Allocate a single bit in revs that says "I haven't done
 > anything yet" if you want to catch the "first-ness" without breaking
 > what commit_list_insert() and friends are expecting to see---they
 > never expect to see a NULL asked to be on the list, AFAIK.

 Fixed.

 >>  * Make it work with --graph (although I don't really see the point=
 of
 >>    using both at the same time)
 >
 > I do not see the point, either.  I vaguely recall that the previous
 > iteration refused the combination at the option parser level, which
 > I think would be the right thing to do.

 Fixed.

 Documentation/rev-list-options.txt |  7 ++++++
 log-tree.c                         |  4 ++++
 object.h                           |  2 +-
 revision.c                         | 48 ++++++++++++++++++++++++++++++=
+++++---
 revision.h                         | 10 +++++++-
 5 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 9a3da36..b813961 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -758,6 +758,13 @@ This enables parent rewriting, see 'History Simpli=
fication' below.
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
=20
+--show-linear-break[=3D<barrier>]::
+	When --graph is not used, all history branches are flattened
+	which can make it hard to see that the two consecutive commits
+	do not belong to a linear branch. This option puts a barrier
+	in between them in that case. If `<barrier>` is specified, it
+	is the string that will be shown instead of the default one.
+
 ifdef::git-rev-list[]
 --count::
 	Print a number stating how many commits would have been
diff --git a/log-tree.c b/log-tree.c
index 5ce217d..cf2f86c 100644
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
diff --git a/object.h b/object.h
index 9918777..6e12f2c 100644
--- a/object.h
+++ b/object.h
@@ -28,7 +28,7 @@ struct object_array {
 #define TYPE_BITS   3
 /*
  * object flag allocation:
- * revision.h:      0---------10
+ * revision.h:      0---------10                                26
  * fetch-pack.c:    0---4
  * walker.c:        0-2
  * upload-pack.c:               11----------------19
diff --git a/revision.c b/revision.c
index 78b5c3a..f834aa9 100644
--- a/revision.c
+++ b/revision.c
@@ -1831,6 +1831,14 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature =3D 1;
+	} else if (!strcmp(arg, "--show-linear-break") ||
+		   starts_with(arg, "--show-linear-break=3D")) {
+		if (starts_with(arg, "--show-linear-break=3D"))
+			revs->break_bar =3D xstrdup(arg + 20);
+		else
+			revs->break_bar =3D "                    ..........";
+		revs->track_linear =3D 1;
+		revs->track_first_time =3D 1;
 	} else if (starts_with(arg, "--show-notes=3D") ||
 		   starts_with(arg, "--notes=3D")) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -1954,6 +1962,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 			unkv[(*unkc)++] =3D arg;
 		return opts;
 	}
+	if (revs->graph && revs->track_linear)
+		die("--show-linear-break and --graph are incompatible");
=20
 	return 1;
 }
@@ -2896,6 +2906,27 @@ enum commit_action simplify_commit(struct rev_in=
fo *revs, struct commit *commit)
 	return action;
 }
=20
+static void track_linear(struct rev_info *revs, struct commit *commit)
+{
+	if (revs->track_first_time) {
+		revs->linear =3D 1;
+		revs->track_first_time =3D 0;
+	} else {
+		struct commit_list *p;
+		for (p =3D revs->previous_parents; p; p =3D p->next)
+			if (p->item =3D=3D NULL || /* first commit */
+			    !hashcmp(p->item->object.sha1, commit->object.sha1))
+				break;
+		revs->linear =3D p !=3D NULL;
+	}
+	if (revs->reverse) {
+		if (revs->linear)
+			commit->object.flags |=3D TRACK_LINEAR;
+	}
+	free_commit_list(revs->previous_parents);
+	revs->previous_parents =3D copy_commit_list(commit->parents);
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -2935,6 +2966,8 @@ static struct commit *get_revision_1(struct rev_i=
nfo *revs)
 			die("Failed to simplify parents of commit %s",
 			    sha1_to_hex(commit->object.sha1));
 		default:
+			if (revs->track_linear)
+				track_linear(revs, commit);
 			return commit;
 		}
 	} while (revs->commits);
@@ -3101,14 +3134,23 @@ struct commit *get_revision(struct rev_info *re=
vs)
 		revs->reverse_output_stage =3D 1;
 	}
=20
-	if (revs->reverse_output_stage)
-		return pop_commit(&revs->commits);
+	if (revs->reverse_output_stage) {
+		c =3D pop_commit(&revs->commits);
+		if (revs->track_linear)
+			revs->linear =3D !!(c && c->object.flags & TRACK_LINEAR);
+		return c;
+	}
=20
 	c =3D get_revision_internal(revs);
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
-	if (!c)
+	if (!c) {
 		free_saved_parents(revs);
+		if (revs->previous_parents) {
+			free_commit_list(revs->previous_parents);
+			revs->previous_parents =3D NULL;
+		}
+	}
 	return c;
 }
=20
diff --git a/revision.h b/revision.h
index 0262bbd..d9907dd 100644
--- a/revision.h
+++ b/revision.h
@@ -19,7 +19,8 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
-#define ALL_REV_FLAGS	((1u<<11)-1)
+#define TRACK_LINEAR	(1u<<26)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | TRACK_LINEAR)
=20
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -138,6 +139,10 @@ struct rev_info {
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 	unsigned int	leak_pending:1;
+	/* --show-linear-break */
+	unsigned int	track_linear:1,
+			track_first_time:1,
+			linear:1;
=20
 	enum date_mode date_mode;
=20
@@ -198,6 +203,9 @@ struct rev_info {
=20
 	/* copies of the parent lists, for --full-diff display */
 	struct saved_parents *saved_parents_slab;
+
+	struct commit_list *previous_parents;
+	const char *break_bar;
 };
=20
 extern int ref_excluded(struct string_list *, const char *path);
--=20
1.9.1.345.ga1a145c
