Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A95C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C96120848
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 12:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9/yCmCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgACMG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:06:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727350AbgACMG0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Jan 2020 07:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578053185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfOALi/WaZM+mOcqtYeNlOyRjHJQT+iCaf0GTU/BAgE=;
        b=D9/yCmCGAozVtztsrBEgiBEKMgBobcDhRcxHwetGhBp6y04AuEbmT1VYsVbdHeJS4Ci942
        InMpuZ007f+zM7bahzjL7QKTyQ3Q0wgFy2oCJBh//HRZDsau+YCruqfJXb+uacyUN7v4Vi
        XlfxlR885DjCYwUpNNEXT4znbB+bZyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-mkj3XE8tPu6rWDwR-AQuYA-1; Fri, 03 Jan 2020 07:06:22 -0500
X-MC-Unique: mkj3XE8tPu6rWDwR-AQuYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C765C8024DD
        for <git@vger.kernel.org>; Fri,  3 Jan 2020 12:06:21 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3B2160BF7;
        Fri,  3 Jan 2020 12:06:17 +0000 (UTC)
From:   marcandre.lureau@redhat.com
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] RFC: commit: add a commit.all-ignore-submodules config option
Date:   Fri,  3 Jan 2020 16:06:13 +0400
Message-Id: <20200103120613.1063828-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

One of my most frequent mistake is to commit undesired submodules
changes when doing "commit -a", and I have seen a number of people doing
the same mistake in various projects. I wish there would be a config to
change this default behaviour.

submodule.<name>.ignore or diff.ignoreSubmodules have different
tradeoffs, as they change the diff or status behaviour. I just wish the
default behaviour of "commit -a" to be different, to exclude submodules
by default.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 builtin/add.c    |  6 ++++++
 builtin/commit.c | 10 +++++++++-
 cache.h          |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4c38aff419..4023ee2681 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -82,6 +82,12 @@ static void update_callback(struct diff_queue_struct *=
q,
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filepair *p =3D q->queue[i];
 		const char *path =3D p->one->path;
+
+		if (data->flags & ADD_CACHE_IGNORE_SUBMODULES &&
+		    S_ISGITLINK(p->one->mode)) {
+		    continue;
+		}
+
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
diff --git a/builtin/commit.c b/builtin/commit.c
index aa1332308a..ce37e4e6da 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -110,6 +110,7 @@ static int config_commit_verbose =3D -1; /* unspecifi=
ed */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *i=
gnored_arg;
 static char *sign_commit, *pathspec_from_file;
+static int commit_all_ignore_submodules;
=20
 /*
  * The default commit message cleanup mode will remove the lines
@@ -415,8 +416,10 @@ static const char *prepare_index(int argc, const cha=
r **argv, const char *prefix
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		int flags =3D commit_all_ignore_submodules ? ADD_CACHE_IGNORE_SUBMODUL=
ES : 0;
+
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, flags);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
@@ -1475,6 +1478,11 @@ static int git_commit_config(const char *k, const =
char *v, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(k, "commit.all-ignore-submodules")) {
+		commit_all_ignore_submodules =3D git_config_bool(k, v);
+		return 0;
+	}
+
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
diff --git a/cache.h b/cache.h
index 1554488d66..5fb3b18916 100644
--- a/cache.h
+++ b/cache.h
@@ -816,6 +816,7 @@ int remove_file_from_index(struct index_state *, cons=
t char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_IGNORE_SUBMODULES 32
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing

base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
--=20
2.25.0.rc1.1.gb0343b22ed

