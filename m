Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40107C433F5
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiE1XLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiE1XLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C194C7BD
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 530B518912D;
        Sat, 28 May 2022 19:11:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=dsS2uh3bdG0FcZKVAK/UKF4JG
        Di5XPT5JAAEYtzYlT8=; b=ZdrO/A3NRA037QuUmVMrsOWCuwX9nOf2RK52MuH/n
        0m2CF5ZfU/oOQfSmheKzZ4MUy8sH47VAzACfSXs36linCX9bmZUO25Ty7zi4mRlZ
        3Pe4Js4O8Ap12WmXzRcpIryiYlxa182p5CdLATyHs7neLem7mSEqxvm4/hq4v3hL
        2c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C8CA18912C;
        Sat, 28 May 2022 19:11:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA16918912B;
        Sat, 28 May 2022 19:11:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>
Subject: [PATCH v6+ 6/7] scalar: teach `diagnose` to gather packfile info
Date:   Sat, 28 May 2022 16:11:17 -0700
Message-Id: <20220528231118.3504387-7-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 8572DA98-DEDB-11EC-86AD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

It's helpful to see if there are other crud files in the pack
directory. Let's teach the `scalar diagnose` command to gather
file size information about pack files.

While at it, also enumerate the pack files in the alternate
object directories, if any are registered.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/scalar/scalar.c          | 30 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index f06a2f3576..f745519038 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "archive.h"
+#include "object-store.h"
=20
 /*
  * Remove the deepest subdirectory in the provided path string. Path mus=
t not
@@ -594,6 +595,29 @@ static int cmd_clone(int argc, const char **argv)
 	return res;
 }
=20
+static void dir_file_stats_objects(const char *full_path, size_t full_pa=
th_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf =3D data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *dat=
a)
+{
+	struct strbuf *buf =3D data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] =3D {
@@ -656,6 +680,12 @@ static int cmd_diagnose(int argc, const char **argv)
 		     "--add-virtual-file=3Ddiagnostics.log:%.*s",
 		     (int)buf.len, buf.buf);
=20
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=3Dpacks-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks", 0)=
) ||
 	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", 0))=
 ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sc=
alar.sh
index 6e52088919..2603e2278f 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -101,6 +101,8 @@ test_expect_success '`scalar [...] <dir>` errors out =
when dir is missing' '
 SQ=3D"'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
+	git repack &&
+	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &=
&
 	scalar diagnose cloned >out 2>err &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
@@ -110,7 +112,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	folder=3D${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
 	unzip -p "$zip_path" diagnostics.log >out &&
-	test_file_not_empty out
+	test_file_not_empty out &&
+	unzip -p "$zip_path" packs-local.txt >out &&
+	grep "$(pwd)/.git/objects" out
 '
=20
 test_done
--=20
2.36.1-385-g60203f3fdb

