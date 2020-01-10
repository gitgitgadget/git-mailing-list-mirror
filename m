Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48431C33C99
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 07:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FC02073A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 07:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNG2nf1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAJHTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:19:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgAJHTm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jan 2020 02:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578640781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7phnacVaKQr4FvlIz0uwA4M/u85Tz3nida7bD8529Y4=;
        b=ZNG2nf1sk+X5U9N+Wr0NlgWhdwNzwohxxBDHVSEwR/Iy/drW6VUivcDBvyINZjI7pQ/fIs
        VgFnxE+3HpvMaMAJ5GmJbEBilN3Hwu3rXrNzVXROFFVhsIPoPLBs2XXfjjoGRYEPpZOmI8
        SaowQlieKlD/84SHKZjAnO8W1Z6hS/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-hwRBTR4tNGe_1oaQ692J3w-1; Fri, 10 Jan 2020 02:19:40 -0500
X-MC-Unique: hwRBTR4tNGe_1oaQ692J3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8495D10054E3
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 07:19:39 +0000 (UTC)
Received: from localhost (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B04F272B4;
        Fri, 10 Jan 2020 07:19:34 +0000 (UTC)
From:   marcandre.lureau@redhat.com
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] RFC: allow branch --edit-description during rebase
Date:   Fri, 10 Jan 2020 11:19:29 +0400
Message-Id: <20200110071929.119000-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This patch aims to allow editing of branch description during a rebase.

A common use case of rebasing is to iterate over a series of patches
after receiving reviews. During the rebase, various patches will be
modified, and it is often requested to put a summary of the changes for
the next version in the cover letter ("v2: - fixed this, - changed
that.."). This helps the reviewer to focus on the difference with the
previous version.  Unfortunately, git branch --edit-description doesn't
allow yet to modify the content during a rebase, and forces the author
to use memory muscles to update the description after finishing the
rebase.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 builtin/branch.c | 19 ++++++++++++++++---
 worktree.c       | 19 +++++++++++++++++++
 worktree.h       |  7 +++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..f7122d31d6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -613,6 +613,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 	int icase =3D 0;
 	static struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &sortin=
g;
 	struct ref_format format =3D REF_FORMAT_INIT;
+	struct wt_status_state state;
=20
 	struct option options[] =3D {
 		OPT_GROUP(N_("Generic options")),
@@ -664,6 +665,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
=20
 	setup_ref_filter_porcelain_msg();
=20
+	memset(&state, 0, sizeof(state));
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind =3D FILTER_REFS_BRANCHES;
 	filter.abbrev =3D -1;
@@ -745,13 +748,21 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		string_list_clear(&output, 0);
 		return 0;
 	} else if (edit_description) {
-		const char *branch_name;
+		const char *branch_name =3D NULL;
 		struct strbuf branch_ref =3D STRBUF_INIT;
=20
 		if (!argc) {
-			if (filter.detached)
+		    if (filter.detached) {
+			const struct worktree *wt =3D worktree_get_current();
+
+			if (wt_status_check_rebase(wt, &state)) {
+				branch_name =3D state.branch;
+			}
+
+			if (!branch_name)
 				die(_("Cannot give description to detached HEAD"));
-			branch_name =3D head;
+		    } else
+			    branch_name =3D head;
 		} else if (argc =3D=3D 1)
 			branch_name =3D argv[0];
 		else
@@ -851,5 +862,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
+	free(state.branch);
+	free(state.onto);
 	return 0;
 }
diff --git a/worktree.c b/worktree.c
index 5b4793caa3..0318c6f6a6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -396,6 +396,25 @@ int is_worktree_being_bisected(const struct worktree=
 *wt,
 	return found_rebase;
 }
=20
+const struct worktree *worktree_get_current(void)
+{
+	static struct worktree **worktrees;
+	int i =3D 0;
+
+	if (worktrees)
+		free_worktrees(worktrees);
+	worktrees =3D get_worktrees(0);
+
+	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
+		if (wt->is_current)
+			return wt;
+	}
+
+	return NULL;
+}
+
 /*
  * note: this function should be able to detect shared symref even if
  * HEAD is temporarily detached (e.g. in the middle of rebase or
diff --git a/worktree.h b/worktree.h
index caecc7a281..4fe2b78d24 100644
--- a/worktree.h
+++ b/worktree.h
@@ -91,6 +91,13 @@ void free_worktrees(struct worktree **);
 const struct worktree *find_shared_symref(const char *symref,
 					  const char *target);
=20
+
+/*
+ * Return the current worktree. The result may be destroyed by the
+ * next call.
+ */
+const struct worktree *worktree_get_current(void);
+
 /*
  * Similar to head_ref() for all HEADs _except_ one from the current
  * worktree, which is covered by head_ref().

base-commit: 042ed3e048af08014487d19196984347e3be7d1c
prerequisite-patch-id: 9b3cf75545ec4a1e702c8c2b2aae8edf241b87f2
--=20
2.25.0.rc1.20.g2443f3f80d.dirty

