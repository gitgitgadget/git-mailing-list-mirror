Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C3EE3F0F
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjILTc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbjILTcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:32:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E24E50
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:32:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BA7E18299;
        Tue, 12 Sep 2023 15:32:46 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=cg6Hu9GK9XVINhl0alptALxxr
        ILsMKJDvHg3FRDYNes=; b=Wg0QQVp1vVKffWCaMubAjbfTlSOnNoHkUXSD437Hn
        ebsPSZrf5aWOfVpOfucayGZasxuPna/T5yQQcUMzORF30Y4sZWkMLvPH9p+Fa+Lw
        nR4uCQ2+soF9dCP5JW8MlmHmPyuJQeJx2XdLVWjdPgCH2U2sCCIToVWnb0BwQl3A
        gM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03A8C18298;
        Tue, 12 Sep 2023 15:32:46 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FC7B18297;
        Tue, 12 Sep 2023 15:32:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] update-index: add --show-index-version
Date:   Tue, 12 Sep 2023 12:32:34 -0700
Message-ID: <20230912193235.776292-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-158-g94e83dcf5b
In-Reply-To: <20230912193235.776292-1-gitster@pobox.com>
References: <20230818233729.2766281-1-gitster@pobox.com>
 <20230912193235.776292-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 24494662-51A3-11EE-8F5A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git update-index --index-version N" is used to set the index format
version to a specific version, but there was no way to query the
current version used in the on-disk index file.

Teach the command a new "--show-index-version" option, and also
teach the "--index-version N" option to report what the version was
when run with the "--verbose" option.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt |  6 +++++-
 builtin/update-index.c             | 19 ++++++++++++------
 t/t2107-update-index-basic.sh      | 31 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
index 71d6ef9457..1271486ae9 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -162,7 +162,8 @@ you will need to handle the situation manually.
 	Write the resulting index out in the named on-disk format version.
 	Supported versions are 2, 3 and 4. The current default version is 2
 	or 3, depending on whether extra features are used, such as
-	`git add -N`.
+	`git add -N`.  With `--verbose`, also report the version the index
+	file uses before and after this command.
 +
 Version 4 performs a simple pathname compression that reduces index
 size by 30%-50% on large repositories, which results in faster load
@@ -171,6 +172,9 @@ and support for it was added to libgit2 in 2016 and t=
o JGit in 2020.
 Older versions of this manual page called it "relatively young", but
 it should be considered mature technology these days.
=20
+--show-index-version::
+	Report the index format version used by the on-disk index file.
+	See `--index-version` above.
=20
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5fab9ad2ec..8c3454c1c1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1089,6 +1089,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			resolve_undo_clear_callback),
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
 			N_("write index in this format")),
+		OPT_SET_INT(0, "show-index-version", &preferred_index_format,
+			    N_("report on-disk index format version"), -1),
 		OPT_BOOL(0, "split-index", &split_index,
 			N_("enable or disable split index")),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
@@ -1181,15 +1183,20 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
=20
 	getline_fn =3D nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	if (preferred_index_format) {
-		if (preferred_index_format < INDEX_FORMAT_LB ||
-		    INDEX_FORMAT_UB < preferred_index_format)
+		if (preferred_index_format < 0) {
+			printf(_("%d\n"), the_index.version);
+		} else if (preferred_index_format < INDEX_FORMAT_LB ||
+			   INDEX_FORMAT_UB < preferred_index_format) {
 			die("index-version %d not in range: %d..%d",
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
-
-		if (the_index.version !=3D preferred_index_format)
-			the_index.cache_changed |=3D SOMETHING_CHANGED;
-		the_index.version =3D preferred_index_format;
+		} else {
+			if (the_index.version !=3D preferred_index_format)
+				the_index.cache_changed |=3D SOMETHING_CHANGED;
+			report(_("index-version: was %d, set to %d"),
+			       the_index.version, preferred_index_format);
+			the_index.version =3D preferred_index_format;
+		}
 	}
=20
 	if (read_from_stdin) {
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.s=
h
index 89b285fa3a..22f4c92399 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -111,4 +111,35 @@ test_expect_success '--chmod=3D+x and chmod=3D-x in =
the same argument list' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--index-version' '
+	git commit --allow-empty -m snap &&
+	git reset --hard &&
+	git rm -f -r --cached . &&
+
+	# The default index version is 2 --- update this test
+	# when you change it in the code
+	git update-index --show-index-version >actual &&
+	echo 2 >expect &&
+	test_cmp expect actual &&
+
+	# The next test wants us to be using version 2
+	git update-index --index-version 2 &&
+
+	git update-index --index-version 4 --verbose >actual &&
+	echo "index-version: was 2, set to 4" >expect &&
+	test_cmp expect actual &&
+
+	git update-index --index-version 4 --verbose >actual &&
+	echo "index-version: was 4, set to 4" >expect &&
+	test_cmp expect actual &&
+
+	git update-index --index-version 2 --verbose >actual &&
+	echo "index-version: was 4, set to 2" >expect &&
+	test_cmp expect actual &&
+
+	# non-verbose should be silent
+	git update-index --index-version 4 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
--=20
2.42.0-158-g94e83dcf5b

