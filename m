From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/10] clone: factor out checkout code
Date: Tue, 10 Jan 2012 16:57:00 +0700
Message-ID: <1326189427-20800-4-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:57:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYSm-0005BT-1b
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab2AJJ5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:57:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2AJJ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:57:46 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vMX6M8uMfsIyQKnVd8u83C4Whris8ExLUQPM7CEaLpY=;
        b=ig2bgwe5g7/XQNAi7YME5hdc6r2croilfhClOjbrlcg1Rx1TIuNSoNNxCE8TxVruEc
         Fmz3OFvVk8kzmPmCYVFedltUXC4KrRAWHqc2Cgyk82IbgLLrjdS44eGzwbM730FcZiG2
         vmxCvsutsJ6dyn+ndR/lFEUvdro2PMeU3F9Hc=
Received: by 10.50.155.195 with SMTP id vy3mr1780436igb.12.1326189465985;
        Tue, 10 Jan 2012 01:57:45 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id va6sm50508249igc.6.2012.01.10.01.57.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:57:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:37 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188235>

Read HEAD from disk instead of relying on local variable
our_head_points_at. This reduces complexity of cmd_clone() a little
bit.

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
1.7.3.1.256.g2539c.dirty
