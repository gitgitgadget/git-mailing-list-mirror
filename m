Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD41C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiE1XLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiE1XLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A159FE4
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC412190547;
        Sat, 28 May 2022 19:11:26 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=F6v9sff5yYOKoNUloIt+tzk6z
        cA0yjQwyaIq/7KlGyc=; b=l+v6JORGkG6I5ucM59P1lkULRcFhfLjX7HdTx7vFd
        v0eLAEfEwJHIt3x7W9+lApKGs5f42lR4s+SRn3XMPFF/IQbvEw162GvAN5jCqycE
        O3T1vrQ1H+eNylFuuQIGcdiRYaTJzf/JfZ29J32QqT7n+21MW/USz8pZjdhyK8so
        5E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6E6E190546;
        Sat, 28 May 2022 19:11:26 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AB6C190544;
        Sat, 28 May 2022 19:11:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6+ 1/7] archive: optionally add "virtual" files
Date:   Sat, 28 May 2022 16:11:12 -0700
Message-Id: <20220528231118.3504387-2-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7DC9867A-DEDB-11EC-A053-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the `--add-virtual-file=3D<path>:<content>` option, `git archive` no=
w
supports use cases where relatively trivial files need to be added that
do not exist on disk.

This will allow us to generate `.zip` files with generated content,
without having to add said content to the object database and without
having to write it out to disk.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[jc: tweaked <path> handling]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The changes to the way how leading components of the <path> are
   not discarded and used made the "extra entries" handling into two
   separate code to independently come up with the path stored in
   the archive, as well as the contents stored in the archive.

   The explanation of how --prefix and --add-file interacts also
   applies to the new option.

 Documentation/git-archive.txt | 13 +++++-
 archive.c                     | 77 ++++++++++++++++++++++++++---------
 t/t5003-archive-zip.sh        | 12 ++++++
 3 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.tx=
t
index 94519aae23..b41cc5bc2e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -51,7 +51,7 @@ OPTIONS
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
 	rightmost value is used for all tracked files.  See below which
-	value gets used by `--add-file`.
+	value gets used by `--add-file` and `--add-virtual-file`.
=20
 -o <file>::
 --output=3D<file>::
@@ -63,6 +63,17 @@ OPTIONS
 	concatenating the value of the last `--prefix` option (if any)
 	before this `--add-file` and the basename of <file>.
=20
+--add-virtual-file=3D<path>:<content>::
+	Add the specified contents to the archive.  Can be repeated to add
+	multiple files.  The path of the file in the archive is built
+	by concatenating the value of the last `--prefix` option (if any)
+	before this `--add-virtual-file` and `<path>`.
++
+The `<path>` cannot contain any colon, the file mode is limited to
+a regular file, and the option may be subject to platform-dependent
+command-line limits. For non-trivial cases, write an untracked file
+and use `--add-file` instead.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index e2121ebefb..d26f4ef945 100644
--- a/archive.c
+++ b/archive.c
@@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const struct =
object_id *oid,
 struct extra_file_info {
 	char *base;
 	struct stat stat;
+	void *content;
 };
=20
 int write_archive_entries(struct archiver_args *args,
@@ -331,19 +332,27 @@ int write_archive_entries(struct archiver_args *arg=
s,
=20
 		put_be64(fake_oid.hash, i + 1);
=20
-		strbuf_reset(&path_in_archive);
-		if (info->base)
-			strbuf_addstr(&path_in_archive, info->base);
-		strbuf_addstr(&path_in_archive, basename(path));
-
-		strbuf_reset(&content);
-		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
-			err =3D error_errno(_("cannot read '%s'"), path);
-		else
-			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
-					  path_in_archive.len,
+		if (!info->content) {
+			strbuf_reset(&path_in_archive);
+			if (info->base)
+				strbuf_addstr(&path_in_archive, info->base);
+			strbuf_addstr(&path_in_archive, basename(path));
+
+			strbuf_reset(&content);
+			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
+				err =3D error_errno(_("could not read '%s'"), path);
+			else
+				err =3D write_entry(args, &fake_oid, path_in_archive.buf,
+						  path_in_archive.len,
+						  canon_mode(info->stat.st_mode),
+						  content.buf, content.len);
+		} else {
+			err =3D write_entry(args, &fake_oid,
+					  path, strlen(path),
 					  canon_mode(info->stat.st_mode),
-					  content.buf, content.len);
+					  info->content, info->stat.st_size);
+		}
+
 		if (err)
 			break;
 	}
@@ -493,6 +502,7 @@ static void extra_file_info_clear(void *util, const c=
har *str)
 {
 	struct extra_file_info *info =3D util;
 	free(info->base);
+	free(info->content);
 	free(info);
 }
=20
@@ -514,14 +524,40 @@ static int add_file_cb(const struct option *opt, co=
nst char *arg, int unset)
 	if (!arg)
 		return -1;
=20
-	path =3D prefix_filename(args->prefix, arg);
-	item =3D string_list_append_nodup(&args->extra_files, path);
-	item->util =3D info =3D xmalloc(sizeof(*info));
+	info =3D xmalloc(sizeof(*info));
 	info->base =3D xstrdup_or_null(base);
-	if (stat(path, &info->stat))
-		die(_("File not found: %s"), path);
-	if (!S_ISREG(info->stat.st_mode))
-		die(_("Not a regular file: %s"), path);
+
+	if (!strcmp(opt->long_name, "add-file")) {
+		path =3D prefix_filename(args->prefix, arg);
+		if (stat(path, &info->stat))
+			die(_("File not found: %s"), path);
+		if (!S_ISREG(info->stat.st_mode))
+			die(_("Not a regular file: %s"), path);
+		info->content =3D NULL; /* read the file later */
+	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
+		const char *colon =3D strchr(arg, ':');
+		char *p;
+
+		if (!colon)
+			die(_("missing colon: '%s'"), arg);
+
+		p =3D xstrndup(arg, colon - arg);
+		if (!args->prefix)
+			path =3D p;
+		else {
+			path =3D prefix_filename(args->prefix, p);
+			free(p);
+		}
+		memset(&info->stat, 0, sizeof(info->stat));
+		info->stat.st_mode =3D S_IFREG | 0644;
+		info->content =3D xstrdup(colon + 1);
+		info->stat.st_size =3D strlen(info->content);
+	} else {
+		BUG("add_file_cb() called for %s", opt->long_name);
+	}
+	item =3D string_list_append_nodup(&args->extra_files, path);
+	item->util =3D info;
+
 	return 0;
 }
=20
@@ -554,6 +590,9 @@ static int parse_archive_args(int argc, const char **=
argv,
 		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
 		  N_("add untracked file to archive"), 0, add_file_cb,
 		  (intptr_t)&base },
+		{ OPTION_CALLBACK, 0, "add-virtual-file", args,
+		  N_("path:content"), N_("add untracked file to archive"), 0,
+		  add_file_cb, (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index d726964307..d6027189e2 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -206,6 +206,18 @@ test_expect_success 'git archive --format=3Dzip --ad=
d-file' '
 check_zip with_untracked
 check_added with_untracked untracked untracked
=20
+test_expect_success UNZIP 'git archive --format=3Dzip --add-virtual-file=
' '
+	git archive --format=3Dzip >with_file_with_content.zip \
+		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
+	test_when_finished "rm -rf tmp-unpack" &&
+	mkdir tmp-unpack && (
+		cd tmp-unpack &&
+		"$GIT_UNZIP" ../with_file_with_content.zip &&
+		test_path_is_file hello &&
+		test world =3D $(cat hello)
+	)
+'
+
 test_expect_success 'git archive --format=3Dzip --add-file twice' '
 	echo untracked >untracked &&
 	git archive --format=3Dzip --prefix=3Done/ --add-file=3Duntracked \
--=20
2.36.1-385-g60203f3fdb

