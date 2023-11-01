Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D118E06
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V6MQ8HI7"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3F102
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 12:24:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8D86A5B0C4;
	Wed,  1 Nov 2023 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698866666;
	bh=iwASfeCYO9WW/5C7sgWaSjU5KBjClYpCNCiaQo8ORrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=V6MQ8HI7EB+x6TXp6EmKxOOBd89h4ydQ8svXdNJuLU6A5Max6N5PPUgrp+rPXqOE4
	 KPpzPqbH4AddVHgmK5zI0LXnsjlcHOplc4A/yuD5lmwq4gdlAmZzH3J1RTA8i8+vss
	 TFxtuffq0XM+4DwLaCdEiS0XlHUlSBJF5wZwWJVEWWrW1sJv5Rg6Pp7Q6PpsQ8wXRu
	 fpYVTsOW0GXo6/6cl1aoJSWlJVATFwo1sgDJjEaagNeLc8HNkxrYfc32iXMo2n5hWc
	 /Gj+pNl0nLdoxbeIpuOYQ14d1D62moQaa9RmrNitFeAdTvl5OFNo0w3zsRqxS8wDu5
	 SyzDSzIm2bHbL63XqypoJqNt0X+RebSjcbGl14Cc6Suqauj+kj7W1rq3ICdnVO2y6L
	 CrFtJB76/sw/h4fo4unKfQXUSB5JM1TP9mQ+fE0oxznIkbFC2R242vh3EEFeozGbzT
	 pMz8DlPsyjqJzllg1xwiZoXpnvTCn4F/4+MNWs1z1bZFR2zy+ex
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 2/2] merge-file: add an option to process object IDs
Date: Wed,  1 Nov 2023 19:24:19 +0000
Message-ID: <20231101192419.794162-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101192419.794162-1-sandals@crustytoothpaste.net>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <bk2204@github.com>

git merge-file knows how to merge files on the file system already.  It
would be helpful, however, to allow it to also merge single blobs.
Teach it an `--object-id` option which means that its arguments are
object IDs and not files to allow it to do so.

We handle the empty blob specially since read_mmblob doesn't read it
directly and otherwise users cannot specify an empty ancestor.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-merge-file.txt | 19 +++++++++-
 builtin/merge-file.c             | 62 +++++++++++++++++++++++---------
 t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index bf0a18cf02..6a081eacb7 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
-	[--[no-]diff3] <current> <base> <other>
+	[--[no-]diff3] [--object-id] <current> <base> <other>
 
 
 DESCRIPTION
@@ -41,6 +41,10 @@ however, these conflicts are resolved favouring lines from `<current>`,
 lines from `<other>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
+If `--object-id` is specified, exactly the same behavior occurs, except that
+instead of specifying what to merge as files, it is specified as a list of
+object IDs referring to blobs.
+
 The exit value of this program is negative on error, and the number of
 conflicts otherwise (truncated to 127 if there are more than that many
 conflicts). If the merge was clean, the exit value is 0.
@@ -53,6 +57,14 @@ linkgit:git[1].
 OPTIONS
 -------
 
+--object-id::
+	Specify the contents to merge as blobs in the current repository instead of
+	files.  In this case, the operation must take place within a valid repository.
++
+If the `-p` option is specified, the merged file (including conflicts, if any)
+goes to standard output as normal; otherwise, the merged file is written to the
+object store and the object ID of its blob is written to standard output.
+
 -L <label>::
 	This option may be given up to three times, and
 	specifies labels to be used in place of the
@@ -94,6 +106,11 @@ EXAMPLES
 	merges tmp/a123 and tmp/c345 with the base tmp/b234, but uses labels
 	`a` and `c` instead of `tmp/a123` and `tmp/c345`.
 
+`git merge-file -p --object-id abc1234 def567 890abcd`::
+
+	combines the changes of the blob abc1234 and 890abcd since def567,
+	tries to merge them and writes the result to standard output
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index d7eb4c6540..832c93d8d5 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,5 +1,8 @@
 #include "builtin.h"
 #include "abspath.h"
+#include "hex.h"
+#include "object-name.h"
+#include "object-store.h"
 #include "config.h"
 #include "gettext.h"
 #include "setup.h"
@@ -31,10 +34,11 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmfile_t mmfs[3] = { 0 };
 	mmbuffer_t result = { 0 };
 	xmparam_t xmp = { 0 };
-	int ret = 0, i = 0, to_stdout = 0;
+	int ret = 0, i = 0, to_stdout = 0, object_id = 0;
 	int quiet = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
+		OPT_BOOL(0,   "object-id", &object_id, N_("use object IDs instead of filenames")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
 		OPT_SET_INT(0, "zdiff3", &xmp.style, N_("use a zealous diff3 based merge"),
 				XDL_MERGE_ZEALOUS_DIFF3),
@@ -71,8 +75,12 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
+	if (object_id)
+		setup_git_directory();
+
 	for (i = 0; i < 3; i++) {
 		char *fname;
+		struct object_id oid;
 		mmfile_t *mmf = mmfs + i;
 
 		if (!names[i])
@@ -80,12 +88,22 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 		fname = prefix_filename(prefix, argv[i]);
 
-		if (read_mmfile(mmf, fname))
+		if (object_id) {
+			if (repo_get_oid(the_repository, argv[i], &oid))
+				ret = error(_("object '%s' does not exist"),
+					      argv[i]);
+			else if (!oideq(&oid, the_hash_algo->empty_blob))
+				read_mmblob(mmf, &oid);
+			else
+				read_mmfile(mmf, "/dev/null");
+		} else if (read_mmfile(mmf, fname)) {
 			ret = -1;
-		else if (mmf->size > MAX_XDIFF_SIZE ||
-			 buffer_is_binary(mmf->ptr, mmf->size))
+		}
+		if (ret != -1 && (mmf->size > MAX_XDIFF_SIZE ||
+		    buffer_is_binary(mmf->ptr, mmf->size))) {
 			ret = error("Cannot merge binary files: %s",
 				    argv[i]);
+		}
 
 		free(fname);
 		if (ret)
@@ -99,20 +117,32 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
 
 	if (ret >= 0) {
-		const char *filename = argv[0];
-		char *fpath = prefix_filename(prefix, argv[0]);
-		FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
+		if (object_id && !to_stdout) {
+			struct object_id oid;
+			if (result.size) {
+				if (write_object_file(result.ptr, result.size, OBJ_BLOB, &oid) < 0)
+					ret = error(_("Could not write object file"));
+			} else {
+				oidcpy(&oid, the_hash_algo->empty_blob);
+			}
+			if (ret >= 0)
+				printf("%s\n", oid_to_hex(&oid));
+		} else {
+			const char *filename = argv[0];
+			char *fpath = prefix_filename(prefix, argv[0]);
+			FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
 
-		if (!f)
-			ret = error_errno("Could not open %s for writing",
-					  filename);
-		else if (result.size &&
-			 fwrite(result.ptr, result.size, 1, f) != 1)
-			ret = error_errno("Could not write to %s", filename);
-		else if (fclose(f))
-			ret = error_errno("Could not close %s", filename);
+			if (!f)
+				ret = error_errno("Could not open %s for writing",
+						  filename);
+			else if (result.size &&
+				 fwrite(result.ptr, result.size, 1, f) != 1)
+				ret = error_errno("Could not write to %s", filename);
+			else if (fclose(f))
+				ret = error_errno("Could not close %s", filename);
+			free(fpath);
+		}
 		free(result.ptr);
-		free(fpath);
 	}
 
 	if (ret > 127)
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 1a7082323d..2c92209eca 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -65,11 +65,30 @@ test_expect_success 'merge with no changes' '
 	test_cmp test.txt orig.txt
 '
 
+test_expect_success 'merge with no changes with --object-id' '
+	git add orig.txt &&
+	git merge-file -p --object-id :orig.txt :orig.txt :orig.txt >actual &&
+	test_cmp actual orig.txt
+'
+
 test_expect_success "merge without conflict" '
 	cp new1.txt test.txt &&
 	git merge-file test.txt orig.txt new2.txt
 '
 
+test_expect_success 'merge without conflict with --object-id' '
+	git add orig.txt new2.txt &&
+	git merge-file --object-id :orig.txt :orig.txt :new2.txt >actual &&
+	git rev-parse :new2.txt >expected &&
+	test_cmp actual expected
+'
+
+test_expect_success 'can accept object ID with --object-id' '
+	git merge-file --object-id $(test_oid empty_blob) $(test_oid empty_blob) :new2.txt >actual &&
+	git rev-parse :new2.txt >expected &&
+	test_cmp actual expected
+'
+
 test_expect_success 'works in subdirectory' '
 	mkdir dir &&
 	cp new1.txt dir/a.txt &&
@@ -138,6 +157,31 @@ test_expect_success "expected conflict markers" '
 	test_cmp expect.txt test.txt
 '
 
+test_expect_success "merge with conflicts with --object-id" '
+	git add backup.txt orig.txt new3.txt &&
+	test_must_fail git merge-file -p --object-id :backup.txt :orig.txt :new3.txt >actual &&
+	sed -e "s/<< test.txt/<< :backup.txt/" \
+	    -e "s/>> new3.txt/>> :new3.txt/" \
+	    expect.txt >expect &&
+	test_cmp expect actual &&
+	test_must_fail git merge-file --object-id :backup.txt :orig.txt :new3.txt >oid &&
+	git cat-file blob "$(cat oid)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "merge with conflicts with --object-id with labels" '
+	git add backup.txt orig.txt new3.txt &&
+	test_must_fail git merge-file -p --object-id \
+		-L test.txt -L orig.txt -L new3.txt \
+		:backup.txt :orig.txt :new3.txt >actual &&
+	test_cmp expect.txt actual &&
+	test_must_fail git merge-file --object-id \
+		-L test.txt -L orig.txt -L new3.txt \
+		:backup.txt :orig.txt :new3.txt >oid &&
+	git cat-file blob "$(cat oid)" >actual &&
+	test_cmp expect.txt actual
+'
+
 test_expect_success "merge conflicting with --ours" '
 	cp backup.txt test.txt &&
 
@@ -256,6 +300,14 @@ test_expect_success 'binary files cannot be merged' '
 	grep "Cannot merge binary files" merge.err
 '
 
+test_expect_success 'binary files cannot be merged with --object-id' '
+	cp "$TEST_DIRECTORY"/test-binary-1.png . &&
+	git add orig.txt new1.txt test-binary-1.png &&
+	test_must_fail git merge-file --object-id \
+		:orig.txt :test-binary-1.png :new1.txt 2> merge.err &&
+	grep "Cannot merge binary files" merge.err
+'
+
 test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
 	sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" <new5.txt >new6.txt &&
 	sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" <new5.txt >new7.txt &&
@@ -389,4 +441,10 @@ test_expect_success 'conflict sections match existing line endings' '
 	test $(tr "\015" Q <nolf.txt | grep "^[<=>].*Q$" | wc -l) = 0
 '
 
+test_expect_success '--object-id fails without repository' '
+	empty="$(test_oid empty_blob)" &&
+	nongit test_must_fail git merge-file --object-id $empty $empty $empty 2>err &&
+	grep "not a git repository" err
+'
+
 test_done
