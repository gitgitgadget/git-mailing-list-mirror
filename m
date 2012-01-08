From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] clone: factor out checkout code
Date: Sun,  8 Jan 2012 18:46:25 +0700
Message-ID: <1326023188-15559-3-git-send-email-pclouds@gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 12:47:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrDm-0000ex-M5
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 12:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2AHLrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 06:47:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39267 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2AHLrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 06:47:19 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5239138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4O4khy0GDiXqrcsujjeft2Sq7JPGXDPN4L1PcTS2dm4=;
        b=CrPOMnCfX74Jym+SSqI5HcOK+NdB3keci6VqU1ZIdbpxswNkyFeERa9xe0N5M6yOdq
         Fo6O1vDdFftGd4G+A4Sr2ds85cJ2/s+rZFK+Wq5LRfX8cCPJ6C0/Gt6kDIfsZJBRf0yx
         EpSBI5RTOtG+y87mCS6oKSSKjg+vBRQIgwZX0=
Received: by 10.50.170.35 with SMTP id aj3mr14802519igc.2.1326023239568;
        Sun, 08 Jan 2012 03:47:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.35.243])
        by mx.google.com with ESMTPS id 36sm237695161ibc.6.2012.01.08.03.47.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 03:47:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 Jan 2012 18:46:47 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188101>

Read HEAD from disk instead of relying on local variable
our_head_points_at, so that if earlier code fails to make HEAD
properly, it'll be detected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |  101 +++++++++++++++++++++++++++++++----------------=
-------
 1 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8dde1ea..100056d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -448,6 +448,63 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static int checkout(void)
+{
+	unsigned char sha1[20];
+	char *head;
+	struct lock_file *lock_file;
+	struct unpack_trees_options opts;
+	struct tree *tree;
+	struct tree_desc t;
+	int err =3D 0, fd;
+
+	if (option_no_checkout)
+		return 0;
+
+	head =3D resolve_refdup("HEAD", sha1, 1, NULL);
+	if (!head) {
+		warning(_("remote HEAD refers to nonexistent ref, "
+			  "unable to checkout.\n"));
+		return 0;
+	}
+	if (strcmp(head, "HEAD")) {
+		if (prefixcmp(head, "refs/heads/"))
+			die(_("HEAD not found below refs/heads!"));
+	}
+	free(head);
+
+	/* We need to be in the new work tree for the checkout */
+	setup_work_tree();
+
+	lock_file =3D xcalloc(1, sizeof(struct lock_file));
+	fd =3D hold_locked_index(lock_file, 1);
+
+	memset(&opts, 0, sizeof opts);
+	opts.update =3D 1;
+	opts.merge =3D 1;
+	opts.fn =3D oneway_merge;
+	opts.verbose_update =3D (option_verbosity > 0);
+	opts.src_index =3D &the_index;
+	opts.dst_index =3D &the_index;
+
+	tree =3D parse_tree_indirect(sha1);
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+	unpack_trees(1, &t, &opts);
+
+	if (write_cache(fd, active_cache, active_nr) ||
+	    commit_locked_index(lock_file))
+		die(_("unable to write new index file"));
+
+	err |=3D run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
+			sha1_to_hex(sha1), "1", NULL);
+
+	if (!err && option_recursive)
+		err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+
+	return err;
+}
+
 static int write_one_config(const char *key, const char *value, void *=
data)
 {
 	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
@@ -722,13 +779,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		/* Source had detached HEAD pointing somewhere. */
 		update_ref(reflog_msg.buf, "HEAD", remote_head->old_sha1,
 			   NULL, REF_NODEREF, DIE_ON_ERR);
-		our_head_points_at =3D remote_head;
-	} else {
-		/* Nothing to checkout out */
-		if (!option_no_checkout)
-			warning(_("remote HEAD refers to nonexistent ref, "
-				"unable to checkout.\n"));
-		option_no_checkout =3D 1;
 	}
=20
 	if (transport) {
@@ -736,42 +786,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		transport_disconnect(transport);
 	}
=20
-	if (!option_no_checkout) {
-		struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file))=
;
-		struct unpack_trees_options opts;
-		struct tree *tree;
-		struct tree_desc t;
-		int fd;
-
-		/* We need to be in the new work tree for the checkout */
-		setup_work_tree();
-
-		fd =3D hold_locked_index(lock_file, 1);
-
-		memset(&opts, 0, sizeof opts);
-		opts.update =3D 1;
-		opts.merge =3D 1;
-		opts.fn =3D oneway_merge;
-		opts.verbose_update =3D (option_verbosity > 0);
-		opts.src_index =3D &the_index;
-		opts.dst_index =3D &the_index;
-
-		tree =3D parse_tree_indirect(our_head_points_at->old_sha1);
-		parse_tree(tree);
-		init_tree_desc(&t, tree->buffer, tree->size);
-		unpack_trees(1, &t, &opts);
-
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(lock_file))
-			die(_("unable to write new index file"));
-
-		err |=3D run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
-				sha1_to_hex(our_head_points_at->old_sha1), "1",
-				NULL);
-
-		if (!err && option_recursive)
-			err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
-	}
+	err =3D checkout();
=20
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
--=20
1.7.8.36.g69ee2
