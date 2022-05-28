Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889FCC433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiE1XLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiE1XLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75938D82
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC34F137A08;
        Sat, 28 May 2022 19:11:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=CSOhXoGiozmgF3wJD85u83Vgl
        y+S494j86ZtjqeSHIA=; b=pbbRLHKQtdxFrLd1p+f6NLw0wdlVuHkz7hbiQCr+J
        nAztSmwQ7G0b8UQplKTdaNKsnCsNvD+FM0wjv45+f/RMIBWduxUjz0/jsv9GakZE
        qOsocbENF+vYStVws5oBXbRt/ScVEASrmsOXMmFRwzOJJdMytGzp1rScEaqea8qX
        Ik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C34E6137A07;
        Sat, 28 May 2022 19:11:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E4E6137A06;
        Sat, 28 May 2022 19:11:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6+ 4/7] scalar: implement `scalar diagnose`
Date:   Sat, 28 May 2022 16:11:15 -0700
Message-Id: <20220528231118.3504387-5-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 829B5106-DEDB-11EC-A1EB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Over the course of Scalar's development, it became obvious that there is
a need for a command that can gather all kinds of useful information
that can help identify the most typical problems with large
worktrees/repositories.

The `diagnose` command is the culmination of this hard-won knowledge: it
gathers the installed hooks, the config, a couple statistics describing
the data shape, among other pieces of information, and then wraps
everything up in a tidy, neat `.zip` archive.

Note: originally, Scalar was implemented in C# using the .NET API, where
we had the luxury of a comprehensive standard library that includes
basic functionality such as writing a `.zip` file. In the C version, we
lack such a commodity. Rather than introducing a dependency on, say,
libzip, we slightly abuse Git's `archive` machinery: we write out a
`.zip` of the empty try, augmented by a couple files that are added via
the `--add-file*` options. We are careful trying not to modify the
current repository in any way lest the very circumstances that required
`scalar diagnose` to be run are changed by the `diagnose` run itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/scalar/scalar.c          | 144 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  12 +++
 contrib/scalar/t/t9099-scalar.sh |  14 +++
 3 files changed, 170 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 6d58c7a698..a1e05a2146 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "archive.h"
=20
 /*
  * Remove the deepest subdirectory in the provided path string. Path mus=
t not
@@ -260,6 +261,47 @@ static int unregister_dir(void)
 	return res;
 }
=20
+static int add_directory_to_archiver(struct strvec *archiver_args,
+					  const char *path, int recurse)
+{
+	int at_root =3D !*path;
+	DIR *dir =3D opendir(at_root ? "." : path);
+	struct dirent *e;
+	struct strbuf buf =3D STRBUF_INIT;
+	size_t len;
+	int res =3D 0;
+
+	if (!dir)
+		return error_errno(_("could not open directory '%s'"), path);
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len =3D buf.len;
+	strvec_pushf(archiver_args, "--prefix=3D%s", buf.buf);
+
+	while (!res && (e =3D readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if (e->d_type =3D=3D DT_REG)
+			strvec_pushf(archiver_args, "--add-file=3D%s", buf.buf);
+		else if (e->d_type !=3D DT_DIR)
+			warning(_("skipping '%s', which is neither file nor "
+				  "directory"), buf.buf);
+		else if (recurse &&
+			 add_directory_to_archiver(archiver_args,
+						   buf.buf, recurse) < 0)
+			res =3D -1;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
 /* printf-style interface, expects `<key>=3D<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -500,6 +542,107 @@ static int cmd_clone(int argc, const char **argv)
 	return res;
 }
=20
+static int cmd_diagnose(int argc, const char **argv)
+{
+	struct option options[] =3D {
+		OPT_END(),
+	};
+	const char * const usage[] =3D {
+		N_("scalar diagnose [<enlistment>]"),
+		NULL
+	};
+	struct strbuf zip_path =3D STRBUF_INIT;
+	struct strvec archiver_args =3D STRVEC_INIT;
+	char **argv_copy =3D NULL;
+	int stdout_fd =3D -1, archiver_fd =3D -1;
+	time_t now =3D time(NULL);
+	struct tm tm;
+	struct strbuf path =3D STRBUF_INIT, buf =3D STRBUF_INIT;
+	int res =3D 0;
+
+	argc =3D parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
+
+	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
+	strbuf_addftime(&zip_path,
+			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&zip_path, ".zip");
+	switch (safe_create_leading_directories(zip_path.buf)) {
+	case SCLD_EXISTS:
+	case SCLD_OK:
+		break;
+	default:
+		error_errno(_("could not create directory for '%s'"),
+			    zip_path.buf);
+		goto diagnose_cleanup;
+	}
+	stdout_fd =3D dup(1);
+	if (stdout_fd < 0) {
+		res =3D error_errno(_("could not duplicate stdout"));
+		goto diagnose_cleanup;
+	}
+
+	archiver_fd =3D xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666)=
;
+	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
+		res =3D error_errno(_("could not redirect output"));
+		goto diagnose_cleanup;
+	}
+
+	init_zip_archiver();
+	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=3Dzip", NULL)=
;
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	write_or_die(stdout_fd, buf.buf, buf.len);
+	strvec_pushf(&archiver_args,
+		     "--add-virtual-file=3Ddiagnostics.log:%.*s",
+		     (int)buf.len, buf.buf);
+
+	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks", 0)=
) ||
+	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", 0))=
 ||
+	    (res =3D add_directory_to_archiver(&archiver_args, ".git/logs", 1))=
 ||
+	    (res =3D add_directory_to_archiver(&archiver_args, ".git/objects/in=
fo", 0)))
+		goto diagnose_cleanup;
+
+	strvec_pushl(&archiver_args, "--prefix=3D",
+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+
+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
+	argv_copy =3D xmemdupz(archiver_args.v,
+			     sizeof(char *) * archiver_args.nr);
+	res =3D write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
+			    the_repository, NULL, 0);
+	if (res) {
+		error(_("failed to write archive"));
+		goto diagnose_cleanup;
+	}
+
+	if (!res)
+		fprintf(stderr, "\n"
+		       "Diagnostics complete.\n"
+		       "All of the gathered info is captured in '%s'\n",
+		       zip_path.buf);
+
+diagnose_cleanup:
+	if (archiver_fd >=3D 0) {
+		close(1);
+		dup2(stdout_fd, 1);
+	}
+	free(argv_copy);
+	strvec_clear(&archiver_args);
+	strbuf_release(&zip_path);
+	strbuf_release(&path);
+	strbuf_release(&buf);
+
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc !=3D 1)
@@ -801,6 +944,7 @@ static struct {
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
 	{ "version", cmd_version },
+	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
 };
=20
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index cf4e5b889c..c0425e0653 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-=
files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar diagnose [<enlistment>]
 scalar delete <enlistment>
=20
 DESCRIPTION
@@ -139,6 +140,17 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scala=
r
 will be reconfigured. Use this option after each Scalar upgrade.
=20
+Diagnose
+~~~~~~~~
+
+diagnose [<enlistment>]::
+    When reporting issues with Scalar, it is often helpful to provide th=
e
+    information gathered by this command, including logs and certain
+    statistics describing the data shape of the current enlistment.
++
+The output of this command is a `.zip` file that is written into
+a directory adjacent to the worktree in the `src` directory.
+
 Delete
 ~~~~~~
=20
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sc=
alar.sh
index bb42354a8b..fbb1df2049 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -98,4 +98,18 @@ test_expect_success '`scalar [...] <dir>` errors out w=
hen dir is missing' '
 	grep "cloned. does not exist" err
 '
=20
+SQ=3D"'"
+test_expect_success UNZIP 'scalar diagnose' '
+	scalar clone "file://$(pwd)" cloned --single-branch &&
+	scalar diagnose cloned >out 2>err &&
+	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
+	zip_path=3D$(cat zip_path) &&
+	test -n "$zip_path" &&
+	unzip -v "$zip_path" &&
+	folder=3D${zip_path%.zip} &&
+	test_path_is_missing "$folder" &&
+	unzip -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out
+'
+
 test_done
--=20
2.36.1-385-g60203f3fdb

