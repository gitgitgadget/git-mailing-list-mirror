Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5332900
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oPACWnSY"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD4A10C6
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:58:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 17EAB5B092;
	Tue, 24 Oct 2023 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698177483;
	bh=X+XcZe4iWlW5bC3/6mTpsVbNZREe5wyhsPWtwchJseA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=oPACWnSYh2wSt/8DnyBce9qw8vU6y9sz6xZDBJud7tbUMwOusI4l2OnxwANgepF5y
	 /LIZtqa+EmtDDoFzyX2AtGg29y3M8BemymP+n0p7qqT9afVSJkeqq+5CUSWp2H2Nf2
	 trl/4h758xty1JvLuN9M9H1nmjTLWobHUT/a7JRD3hUCMuGGDJgn5gEeT8Ohl4M0hC
	 cU5BYRIqnE0UyooUG9pNBbwcwSctGhSLQkiX/tNEL/i5KIH2OvW4Ptw1rgfvMQBSgK
	 l11MU7f3YKvvWQJgjHpEykyRIlkl8pdDVQVw+0Hwm32CukC8TmePS4lMioBQai6sJb
	 WzYTPBfVNFgNXfCyor1tN/4W4jnttYa+skPyhOGY9Nj8CDJicmMXJ8axwZokaHsdnM
	 sKirzwi7fjhzEuKyes8f0M71JO8tv4dj3y35Wge8VSpe8krBOXmLTVKCSXdpwuxF/I
	 wVH6vBFgiBbIx2VOMcKFeaERL2i8GdBEZhNt8NgpdhvC8EbF33p
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/1] merge-file: add an option to process object IDs
Date: Tue, 24 Oct 2023 19:56:55 +0000
Message-ID: <20231024195655.2413191-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

From: "brian m. carlson" <bk2204@github.com>

git merge-file knows how to merge files on the file system already.  It
would be helpful, however, to allow it to also merge single blobs.
Teach it an `--object-id` option which means that its arguments are
object IDs and not files to allow it to do so.

Since we obviously won't be writing the data to the first argument,
either write to the object store and print the object ID, or honor the
-p argument and print it to standard out.

We handle the empty blob specially since read_mmblob doesn't read it
directly, instead throwing an error, and otherwise users cannot specify
an empty ancestor.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-merge-file.txt | 20 +++++++++++
 builtin/merge-file.c             | 58 +++++++++++++++++++++++---------
 t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 7e9093fab6..45460f3916 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -12,6 +12,9 @@ SYNOPSIS
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	[--[no-]diff3] <current-file> <base-file> <other-file>
+'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L <other-name>]]]
+	[--ours|--theirs|--union] [-q|--quiet] [--marker-size=<n>]
+	[--[no-]diff3] <current-oid> <base-oid> <other-oid>
 
 
 DESCRIPTION
@@ -40,6 +43,10 @@ however, these conflicts are resolved favouring lines from `<current-file>`,
 lines from `<other-file>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
+If `--object-id` is specified, exactly the same behavior occurs, except that
+instead of specifying what to merge as files, it is specified as a list of
+object IDs referring to blobs.
+
 The exit value of this program is negative on error, and the number of
 conflicts otherwise (truncated to 127 if there are more than that many
 conflicts). If the merge was clean, the exit value is 0.
@@ -52,6 +59,14 @@ linkgit:git[1].
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
@@ -93,6 +108,11 @@ EXAMPLES
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
index d7eb4c6540..d308434b8e 100644
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
@@ -80,12 +88,21 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 		fname = prefix_filename(prefix, argv[i]);
 
-		if (read_mmfile(mmf, fname))
+		if (object_id) {
+			if (repo_get_oid(the_repository, argv[i], &oid))
+				ret = -1;
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
@@ -99,20 +116,29 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
 
 	if (ret >= 0) {
-		const char *filename = argv[0];
-		char *fpath = prefix_filename(prefix, argv[0]);
-		FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
+		if (object_id && !to_stdout) {
+			struct object_id oid;
+			if (result.size)
+				write_object_file(result.ptr, result.size, OBJ_BLOB, &oid);
+			else
+				oidcpy(&oid, the_hash_algo->empty_blob);
+			printf("%s\n", oid_to_hex(&oid));
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
