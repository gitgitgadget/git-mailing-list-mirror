Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96133C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiE1XLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiE1XLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714AC51318
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B47E911962C;
        Sat, 28 May 2022 19:11:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=RCeX1vHy1MXHvwvOXEMKBqGQA
        Q2VQFAWGTj2A/SBRog=; b=HFfFtOSFGj4MnWIyBJ9lFuTAqkuYgSMRZbLaQMxsM
        Efhzjf0PyBwRRBZDD1npL3HY0kcFNfuSDXf9zvf4BPxBKzWpvpr8TJAgc92E8BLi
        c6yChG5fnMj4ddRDpjBRwlw35cLTK89FBPPjcqSumBnwJBhTDQRH6dWjYkLtotY6
        B4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA93811962B;
        Sat, 28 May 2022 19:11:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18642119629;
        Sat, 28 May 2022 19:11:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>
Subject: [PATCH v6+ 7/7] scalar: teach `diagnose` to gather loose objects information
Date:   Sat, 28 May 2022 16:11:18 -0700
Message-Id: <20220528231118.3504387-8-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 875231D8-DEDB-11EC-8744-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

When operating at the scale that Scalar wants to support, certain data
shapes are more likely to cause undesirable performance issues, such as
large numbers of loose objects.

By including statistics about this, `scalar diagnose` now makes it
easier to identify such scenarios.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/scalar/scalar.c          | 59 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  5 ++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index f745519038..28176914e5 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -618,6 +618,60 @@ static int dir_file_stats(struct object_directory *o=
bject_dir, void *data)
 	return 0;
 }
=20
+static int count_files(char *path)
+{
+	DIR *dir =3D opendir(path);
+	struct dirent *e;
+	int count =3D 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e =3D readdir(dir)) !=3D NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type =3D=3D DT_REG)
+			count++;
+
+	closedir(dir);
+	return count;
+}
+
+static void loose_objs_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir =3D opendir(path);
+	struct dirent *e;
+	int count;
+	int total =3D 0;
+	unsigned char c;
+	struct strbuf count_path =3D STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Object directory stats for ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&count_path, path);
+	strbuf_addch(&count_path, '/');
+	base_path_len =3D count_path.len;
+
+	while ((e =3D readdir(dir)) !=3D NULL)
+		if (!is_dot_or_dotdot(e->d_name) &&
+		    e->d_type =3D=3D DT_DIR && strlen(e->d_name) =3D=3D 2 &&
+		    !hex_to_bytes(&c, e->d_name, 1)) {
+			strbuf_setlen(&count_path, base_path_len);
+			strbuf_addstr(&count_path, e->d_name);
+			total +=3D (count =3D count_files(count_path.buf));
+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
+		}
+
+	strbuf_addf(buf, "Total: %d loose objects", total);
+
+	strbuf_release(&count_path);
+	closedir(dir);
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] =3D {
@@ -686,6 +740,11 @@ static int cmd_diagnose(int argc, const char **argv)
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
=20
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=3Dobjects-local.txt:");
+	loose_objs_stats(&buf, ".git/objects");
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks", 0)=
) ||
 	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", 0))=
 ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sc=
alar.sh
index 2603e2278f..10b1172a8a 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -103,6 +103,7 @@ test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &=
&
+	test_commit -C cloned/src loose &&
 	scalar diagnose cloned >out 2>err &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
@@ -114,7 +115,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	unzip -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
 	unzip -p "$zip_path" packs-local.txt >out &&
-	grep "$(pwd)/.git/objects" out
+	grep "$(pwd)/.git/objects" out &&
+	unzip -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [1-9]" out
 '
=20
 test_done
--=20
2.36.1-385-g60203f3fdb

