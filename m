Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB3C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiE1XLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiE1XLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49D12611
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE28E189126;
        Sat, 28 May 2022 19:11:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=OrY2E1MnAYGcRywEjH04S9O6A
        TBVjNDh4nqB3bBV6/4=; b=Bt3V9eFHjPLfY4OblC4q256Ppq7yqnjiyi2Hf6wAh
        /lfNOUMxReeEbchf1/chVntKa952Juq87zqPp0AuC1zRq1FyuRkkgQEASXe6pKAo
        Ude4FksFiSYdmqbO4xGlgZGAGrsIxSMj/7XQpKgc4wnvGcnLGIY/ORwP11yTWfw/
        GI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6994189125;
        Sat, 28 May 2022 19:11:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6DCBE189124;
        Sat, 28 May 2022 19:11:26 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths containing colons
Date:   Sat, 28 May 2022 16:11:13 -0700
Message-Id: <20220528231118.3504387-3-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7FC7D5EE-DEDB-11EC-8D81-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By allowing the path to be enclosed in double-quotes, we can avoid
the limitation that paths cannot contain colons.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Tightened shell variable quoting

 Documentation/git-archive.txt | 14 ++++++++++----
 archive.c                     | 30 ++++++++++++++++++++----------
 t/t5003-archive-zip.sh        |  8 ++++++++
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.tx=
t
index b41cc5bc2e..56989a2f34 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -69,10 +69,16 @@ OPTIONS
 	by concatenating the value of the last `--prefix` option (if any)
 	before this `--add-virtual-file` and `<path>`.
 +
-The `<path>` cannot contain any colon, the file mode is limited to
-a regular file, and the option may be subject to platform-dependent
-command-line limits. For non-trivial cases, write an untracked file
-and use `--add-file` instead.
+The `<path>` argument can start and end with a literal double-quote
+character; the contained file name is interpreted as a C-style string,
+i.e. the backslash is interpreted as escape character. The path must
+be quoted if it contains a colon, to avoid the colon from being
+misinterpreted as the separator between the path and the contents, or
+if the path begins or ends with a double-quote character.
++
+The file mode is limited to a regular file, and the option may be
+subject to platform-dependent command-line limits. For non-trivial
+cases, write an untracked file and use `--add-file` instead.
=20
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
diff --git a/archive.c b/archive.c
index d26f4ef945..48aba4ac46 100644
--- a/archive.c
+++ b/archive.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "quote.h"
=20
 static char const * const archive_usage[] =3D {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -535,22 +536,31 @@ static int add_file_cb(const struct option *opt, co=
nst char *arg, int unset)
 			die(_("Not a regular file: %s"), path);
 		info->content =3D NULL; /* read the file later */
 	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
-		const char *colon =3D strchr(arg, ':');
-		char *p;
+		struct strbuf buf =3D STRBUF_INIT;
+		const char *p =3D arg;
+
+		if (*p !=3D '"')
+			p =3D strchr(p, ':');
+		else if (unquote_c_style(&buf, p, &p) < 0)
+			die(_("unclosed quote: '%s'"), arg);
=20
-		if (!colon)
+		if (!p || *p !=3D ':')
 			die(_("missing colon: '%s'"), arg);
=20
-		p =3D xstrndup(arg, colon - arg);
-		if (!args->prefix)
-			path =3D p;
-		else {
-			path =3D prefix_filename(args->prefix, p);
-			free(p);
+		if (p =3D=3D arg)
+			die(_("empty file name: '%s'"), arg);
+
+		path =3D buf.len ?
+			strbuf_detach(&buf, NULL) : xstrndup(arg, p - arg);
+
+		if (args->prefix) {
+			char *save =3D path;
+			path =3D prefix_filename(args->prefix, path);
+			free(save);
 		}
 		memset(&info->stat, 0, sizeof(info->stat));
 		info->stat.st_mode =3D S_IFREG | 0644;
-		info->content =3D xstrdup(colon + 1);
+		info->content =3D xstrdup(p + 1);
 		info->stat.st_size =3D strlen(info->content);
 	} else {
 		BUG("add_file_cb() called for %s", opt->long_name);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index d6027189e2..3992d08158 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -207,13 +207,21 @@ check_zip with_untracked
 check_added with_untracked untracked untracked
=20
 test_expect_success UNZIP 'git archive --format=3Dzip --add-virtual-file=
' '
+	if test_have_prereq FUNNYNAMES
+	then
+		PATHNAME=3D"pathname with : colon"
+	else
+		PATHNAME=3D"pathname without colon"
+	fi &&
 	git archive --format=3Dzip >with_file_with_content.zip \
+		--add-virtual-file=3D\""$PATHNAME"\": \
 		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
+		test_path_is_file "$PATHNAME" &&
 		test world =3D $(cat hello)
 	)
 '
--=20
2.36.1-385-g60203f3fdb

