Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1BBC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKVAJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKVAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:09:29 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284E92B65
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:09:28 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EC9671F910;
        Tue, 22 Nov 2022 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1669075768;
        bh=+Z7KL4KRzdqTu1RVSw9nMOOhNyyOKVIRMLOWQggyhiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAxhiJkBBCXs5zENbffbFyk8ru5XuxU4nGmrkQq29y14Vxbc3h8MsgyDSiPXOhl4v
         9AuhpZSh8xpfy5Qmxa6YZy8o2zVdG2hAhvlgOkuToZfBurnaj0zv/CaZIRP5gwY7DQ
         AF4eB0Z4jV1kfPCLOXPW1tpYgfOlPNuFAyUYHLKA=
Date:   Tue, 22 Nov 2022 00:09:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] prune: recursively prune objects directory
Message-ID: <20221122000927.M873500@dcvr>
References: <20221119201213.2398081-1-e@80x24.org>
 <xmqq5yf8yhe0.fsf@gitster.g>
 <20221121104427.M268307@dcvr>
 <xmqqpmdgv4it.fsf@gitster.g>
 <xmqqleo3vraj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqleo3vraj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>  	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
> >> -	remove_temporary_files(get_object_directory());
> >>  	s = mkpathdup("%s/pack", get_object_directory());
> >>  	remove_temporary_files(s);
> >>  	free(s);
> >
> > I actually was hinting at making the remove_temporary_files()
> > recurse, so that you do not need the separate invocation in pack/
> > subdirectory.
> >
> > Or make 256 calls for each of the fan-out subdirectory, in which
> > case the ENOENT silencing you did would really matter and shine.
> 
> But of course, neither is any part of this topic.  They are possible
> follow-on works.
> 
> Thanks and sorry for making a confusing statement that could be
> mistaken as "let's do this too", which wasn't what I meant.

Oh, no worries.  I already wrote this earlier and got distracted
with something else while waiting for tests :x.  Anyways, the
below supercedes my original patch and I think it's better in
every way.

I am unsure about duplicating ishex() from name-rev.c, however...

------8<-----
Subject: [PATCH] prune: recursively prune objects directory

$GIT_DIR/objects/pack may be removed to save inodes in shared
repositories, so avoid scanning it if it does not exist.  Loose
object directories ($GIT_DIR/objects/??) may have old temporary
files, so we now prune those, too.

Recursion is limited to a single level since git doesn't use
deeper levels.  This avoids the risk of stack overflows via
infinite recursion when pruning untrusted repos.

We'll also emit the system error in case a directory cannot be
opened to help users diagnose permissions problems or resource
constraints.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/prune.c  | 28 ++++++++++++++++++++--------
 t/t5304-prune.sh | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index df376b2ed1..0f6a33690a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -114,25 +114,41 @@ static int prune_subdir(unsigned int nr, const char *path, void *data)
 	return 0;
 }
 
+/*
+ * XXX ishex is duplicated in builtin/name-rev.c, perhaps git-compat-util.h
+ * is a better home for it
+ */
+#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+static int is_loose_prefix(const char *d_name)
+{
+	return strlen(d_name) == 2 && ishex(d_name[0]) && ishex(d_name[1]);
+}
+
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
  * files beginning with "tmp_") accumulating in the object
  * and the pack directories.
  */
-static void remove_temporary_files(const char *path)
+static void remove_temporary_files(const char *path, int recurse)
 {
 	DIR *dir;
 	struct dirent *de;
 
 	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "Unable to open directory %s\n", path);
+		warning_errno(_("unable to open directory %s"), path);
 		return;
 	}
 	while ((de = readdir(dir)) != NULL)
-		if (starts_with(de->d_name, "tmp_"))
+		if (starts_with(de->d_name, "tmp_")) {
 			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
+		} else if (recurse && (strcmp(de->d_name, "packs") == 0 ||
+					is_loose_prefix(de->d_name))) {
+			char *s = mkpathdup("%s/%s", path, de->d_name);
+			remove_temporary_files(s, 0);
+			free(s);
+		}
 	closedir(dir);
 }
 
@@ -150,7 +166,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			 N_("limit traversal to objects outside promisor packfiles")),
 		OPT_END()
 	};
-	char *s;
 
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
@@ -186,10 +201,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 				      prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(get_object_directory());
-	s = mkpathdup("%s/pack", get_object_directory());
-	remove_temporary_files(s);
-	free(s);
+	remove_temporary_files(get_object_directory(), 1);
 
 	if (is_repository_shallow(the_repository)) {
 		perform_reachability_traversal(&revs);
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 8ae314af58..8c2278035e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -29,6 +29,22 @@ test_expect_success setup '
 	git gc
 '
 
+test_expect_success 'prune stale loose objects' '
+	mkdir .git/objects/aa &&
+	>.git/objects/aa/tmp_foo &&
+	test-tool chmtime =-86501 .git/objects/aa/tmp_foo &&
+	git prune --expire 1.day &&
+	test_path_is_missing .git/objects/aa/tmp_foo
+'
+
+test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
+	git clone -q --shared --template= --bare . bare.git &&
+	rmdir bare.git/objects/pack &&
+	git --git-dir=bare.git prune --no-progress 2>prune.err &&
+	test_must_be_empty prune.err &&
+	rm -r bare.git prune.err
+'
+
 test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	>.git/objects/tmp_1.pack &&
