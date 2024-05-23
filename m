Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87284DE9
	for <git@vger.kernel.org>; Thu, 23 May 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504618; cv=none; b=CAwAEVkv+p2FD1QZSvS2F7iEj3AT6o3O/EEF4c8n2D01tKjsXo9c9zcnzKk1X5VpdfjuQh7QFU40VSOTijd0G4pcy/7OUcnBBKqRMkpXKe2bplYKpmUMIs96stFSLTP+PhI8t2sSi/zmU+eJKjnv6uhd+eFP11eLmAzdKby4AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504618; c=relaxed/simple;
	bh=yyTcVI5f0Xv+3jSRGvU9Cjq3Ef4aZTUJehxc94KhjFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzPGNSyItIcAyj8zm0rSaShrTbRqhXDq/ph3Yycjdwf677QuRESFhgrINDIvDll9oR+o2VrYVN6rq9TOdqdFCshMP6PHRVeDksUr4mBBYjqeYk/RB2Rol4taVd1NtztRdxtsy/Nd5qZDRSD1jCiIKgtj1f4hfVchZI9t0O75TTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WIRid3/0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIRid3/0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CDBBC236AC;
	Thu, 23 May 2024 18:50:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=yyTcVI5f0Xv+3jSRGvU9Cjq3E
	f4aZTUJehxc94KhjFg=; b=WIRid3/0WRsysHfrOoJHBp6m3Qu/NmcqFeF9VC6bc
	N/gyxX06oXjhkpI1SHHgbQGwR77vb9e1KS/eIVJlzuS5M94FoV2hEh7ym0lgz5ox
	NGI0QBGy8PLwWoGjhwDlGGcdVG1kqJ7lhwbDz455tqc/eXfY+0ifpEL3h87sP3Fa
	f4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C51D5236AB;
	Thu, 23 May 2024 18:50:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DEAD236AA;
	Thu, 23 May 2024 18:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] show_log: factor out interdiff/range-diff generation
Date: Thu, 23 May 2024 15:50:06 -0700
Message-ID: <20240523225007.2871766-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240523225007.2871766-1-gitster@pobox.com>
References: <20240523225007.2871766-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 D0656F90-1956-11EF-9648-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

The integration of "git range-diff" with "git format-patch" for a
single patch (i.e., not generating "range-diff" into the cover
letter) hooks into log-tree.c:show_log(), which is responsible for
writing the log message out and other stuff.  Essentially,
everything you see before the diffstat and the patch is generated
there.

Split out the code that spits out the interdiff/range-diff into a
separate helper function show_diff_of_diff().  Hopefully this will
make it easier to move things around in the output stream in the
future patches.

This is supposed to be a no-op refactoring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c | 88 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 41416de4e3..e7cd2c491f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -673,6 +673,53 @@ static void next_commentary_block(struct rev_info *o=
pt, struct strbuf *sb)
 	opt->shown_dashes =3D 1;
 }
=20
+static void show_diff_of_diff(struct rev_info *opt)
+{
+	if (!cmit_fmt_is_mail(opt->commit_format))
+		return;
+
+	if (opt->idiff_oid1) {
+		struct diff_queue_struct dq;
+
+		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
+		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+		next_commentary_block(opt, NULL);
+		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
+		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
+			       &opt->diffopt);
+
+		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
+	}
+
+	if (opt->rdiff1) {
+		struct diff_queue_struct dq;
+		struct diff_options opts;
+		struct range_diff_options range_diff_opts =3D {
+			.creation_factor =3D opt->creation_factor,
+			.dual_color =3D 1,
+			.diffopt =3D &opts
+		};
+
+		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
+		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+		next_commentary_block(opt, NULL);
+		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+		/*
+		 * Pass minimum required diff-options to range-diff; others
+		 * can be added later if deemed desirable.
+		 */
+		repo_diff_setup(the_repository, &opts);
+		opts.file =3D opt->diffopt.file;
+		opts.use_color =3D opt->diffopt.use_color;
+		diff_setup_done(&opts);
+		show_range_diff(opt->rdiff1, opt->rdiff2, &range_diff_opts);
+
+		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
+	}
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf =3D STRBUF_INIT;
@@ -857,46 +904,7 @@ void show_log(struct rev_info *opt)
 	free(ctx.notes_message);
 	free(ctx.after_subject);
=20
-	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
-		struct diff_queue_struct dq;
-
-		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
-		DIFF_QUEUE_CLEAR(&diff_queued_diff);
-
-		next_commentary_block(opt, NULL);
-		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
-		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
-			       &opt->diffopt);
-
-		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
-	}
-
-	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
-		struct diff_queue_struct dq;
-		struct diff_options opts;
-		struct range_diff_options range_diff_opts =3D {
-			.creation_factor =3D opt->creation_factor,
-			.dual_color =3D 1,
-			.diffopt =3D &opts
-		};
-
-		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
-		DIFF_QUEUE_CLEAR(&diff_queued_diff);
-
-		next_commentary_block(opt, NULL);
-		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
-		/*
-		 * Pass minimum required diff-options to range-diff; others
-		 * can be added later if deemed desirable.
-		 */
-		repo_diff_setup(the_repository, &opts);
-		opts.file =3D opt->diffopt.file;
-		opts.use_color =3D opt->diffopt.use_color;
-		diff_setup_done(&opts);
-		show_range_diff(opt->rdiff1, opt->rdiff2, &range_diff_opts);
-
-		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
-	}
+	show_diff_of_diff(opt);
 }
=20
 int log_tree_diff_flush(struct rev_info *opt)
--=20
2.45.1-246-gb9cfe4845c

