Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68A61FCE
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370980; cv=none; b=QYMLQbi4jh4vGuGVzkSjS0lc2EvxzhXmM85HnMTJVdpwu1BFq2h0IWP86RvTCYgGmqceZJoYbDcK5d0emdXRqB0qNO6UWDDnkOG5aJ3S72adSukIPWI7ZPSqF/1jk8+mGHapkXWQ6AiDU9cutdAEh770zylG2dAmqey5LwSOtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370980; c=relaxed/simple;
	bh=ol+GPTJ5XuSnubdvbDhWnRIyd3GunFdG/oLlJtB5pOM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrClmDpS5XNZVU3IYIbEZfVd2RRonlzgm782wuFSfrkUavyebixOgFWF34GfCzz+TCx9b845MjMEHQx+TBxrQhIHQLZ74po2fb9AzJVT2YxV6Ofck/ptqEFfqS5U85cJoV0gjr42yYhwz/tQuZox2bs+ZemJU1+oADPbyOsa6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SSte/L4u; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SSte/L4u"
Received: (qmail 5150 invoked by uid 109); 16 May 2025 04:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ol+GPTJ5XuSnubdvbDhWnRIyd3GunFdG/oLlJtB5pOM=; b=SSte/L4ugI63nhc0I3wXBnYSdcqNH2vS55dSJ8LP1jEVJv5qXpJt/PodVLhAKmImYwhFyjZRNR502sECtgouTwJ/xW+1IOFDrDG9Ul03hbxcwBfmX63X/MNmq17rth2oOKZywxSTVU9xp5kbB/wNZh8Bw+tOB91BzmpSW5kAiV/sAiBZJoRGuk8d9nKiWdkVU2/BaxkSiyownFlwpaUQBw+KSMjWZVlzoDBxmvlQcVNRhIhU/DRVIPlNKUPa+qhFZLgsgP17uXOYdNSIOvSbZgQq3qT4nrpiHvVTaGCzkjanFhlDO5iPy1pdhATwsYJIkcaB0SvLm7ahO6Yu2urLJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4895 invoked by uid 111); 16 May 2025 04:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 02/13] cat-file: make --allow-unknown-type a noop
Message-ID: <20250516044935.GB22242@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net>

The cat-file command has some minor support for handling objects with
"unknown" types. I.e., strings that are not "blob", "commit", "tree", or
"tag".

In theory this could be used for debugging or experimenting with
extensions to Git. But in practice this support is not very useful:

  1. You can get the type and size of such objects, but nothing else.
     Not even the contents!

  2. Only loose objects are supported, since packfiles use numeric ids
     for the types, rather than strings.

  3. Likewise you cannot ever transfer objects between repositories,
     because they cannot be represented in the packfiles used for the
     on-the-wire protocol.

The support for these unknown types complicates the object-parsing code,
and has led to bugs such as b748ddb7a4 (unpack_loose_header(): fix
infinite loop on broken zlib input, 2025-02-25). So let's drop it.

The first step is to remove the user-facing parts, which are accessible
only via cat-file. This is technically backwards-incompatible, but given
the limitations listed above, these objects couldn't possibly be useful
in any workflow.

However, we can't just rip out the option entirely. That would hurt a
caller who ran:

  git cat-file -t --allow-unknown-object <oid>

and fed it normal, well-formed objects. There --allow-unknown-type was
doing nothing, but we wouldn't want to start bailing with an error. So
to protect any such callers, we'll retain --allow-unknown-type as a
noop.

The code change is fairly small (but we'll able to clean up more code in
follow-on patches). The test updates drop any use of the option. We
still retain tests that feed the broken objects to cat-file without
--allow-unknown-type, as we should continue to confirm that those
objects are rejected. Note that in one spot we can drop a layer of loop,
re-indenting the body; viewing the diff with "-w" helps there.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.adoc |   6 +-
 builtin/cat-file.c              |  18 +--
 t/t1006-cat-file.sh             | 211 ++++++++------------------------
 3 files changed, 56 insertions(+), 179 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index fc4b92f104..cde79ad242 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -9,8 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' <type> <object>
-'git cat-file' (-e | -p) <object>
-'git cat-file' (-t | -s) [--allow-unknown-type] <object>
+'git cat-file' (-e | -p | -t | -s) <object>
 'git cat-file' (--textconv | --filters)
 	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
@@ -202,9 +201,6 @@ flush::
 	only once, even if it is stored multiple times in the
 	repository.
 
---allow-unknown-type::
-	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
-
 --follow-symlinks::
 	With `--batch` or `--batch-check`, follow symlinks inside the
 	repository when requesting objects with extended SHA-1
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3914a2a3f6..4adc19aa29 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -100,8 +100,7 @@ static int stream_blob(const struct object_id *oid)
 	return 0;
 }
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
-			int unknown_type)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
 	int ret;
 	struct object_id oid;
@@ -121,9 +120,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (!path && opt_cw)
 		get_oid_flags |= GET_OID_REQUIRE_PATH;
 
-	if (unknown_type)
-		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
-
 	if (get_oid_with_context(the_repository, obj_name, get_oid_flags, &oid,
 				 &obj_context))
 		die("Not a valid object name %s", obj_name);
@@ -1038,8 +1034,7 @@ int cmd_cat_file(int argc,
 
 	const char * const builtin_catfile_usage[] = {
 		N_("git cat-file <type> <object>"),
-		N_("git cat-file (-e | -p) <object>"),
-		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
+		N_("git cat-file (-e | -p | -t | -s) <object>"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
@@ -1057,8 +1052,8 @@ int cmd_cat_file(int argc,
 		OPT_GROUP(N_("Emit [broken] object attributes")),
 		OPT_CMDMODE('t', NULL, &opt, N_("show object type (one of 'blob', 'tree', 'commit', 'tag', ...)"), 't'),
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
-		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
-			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_HIDDEN_BOOL(0, "allow-unknown-type", &unknown_type,
+			  N_("historical option -- no-op")),
 		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */
@@ -1209,10 +1204,7 @@ int cmd_cat_file(int argc,
 		obj_name = argv[1];
 	}
 
-	if (unknown_type && opt != 't' && opt != 's')
-		die("git cat-file --allow-unknown-type: use with -s or -t");
-
-	ret = cat_one_file(opt, exp_type, obj_name, unknown_type);
+	ret = cat_one_file(opt, exp_type, obj_name);
 
 out:
 	list_objects_filter_release(&batch.objects_filter);
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ce8b27bf54..d96d02ad7d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -136,18 +136,6 @@ $content"
 	test_cmp expect actual
     '
 
-    test_expect_success "Type of $type is correct using --allow-unknown-type" '
-	echo $type >expect &&
-	git cat-file -t --allow-unknown-type $oid >actual &&
-	test_cmp expect actual
-    '
-
-    test_expect_success "Size of $type is correct using --allow-unknown-type" '
-	echo $size >expect &&
-	git cat-file -s --allow-unknown-type $oid >actual &&
-	test_cmp expect actual
-    '
-
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	echo_without_newline "$content" >expect &&
@@ -677,95 +665,67 @@ test_expect_success 'setup bogus data' '
 	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
 '
 
-for arg1 in '' --allow-unknown-type
+for arg1 in -s -t -p
 do
-	for arg2 in -s -t -p
-	do
-		if test "$arg1" = "--allow-unknown-type" && test "$arg2" = "-p"
-		then
-			continue
-		fi
+	test_expect_success "cat-file $arg1 error on bogus short OID" '
+		cat >expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
 
+		test_must_fail git cat-file $arg1 $bogus_short_oid >out 2>actual &&
+		test_must_be_empty out &&
+		test_cmp expect actual
+	'
 
-		test_expect_success "cat-file $arg1 $arg2 error on bogus short OID" '
-			cat >expect <<-\EOF &&
-			fatal: invalid object type
+	test_expect_success "cat-file $arg1 error on bogus full OID" '
+		if test "$arg1" = "-p"
+		then
+			cat >expect <<-EOF
+			error: header for $bogus_long_oid too long, exceeds 32 bytes
+			fatal: Not a valid object name $bogus_long_oid
+			EOF
+		else
+			cat >expect <<-EOF
+			error: header for $bogus_long_oid too long, exceeds 32 bytes
+			fatal: git cat-file: could not get object info
 			EOF
+		fi &&
 
-			if test "$arg1" = "--allow-unknown-type"
-			then
-				git cat-file $arg1 $arg2 $bogus_short_oid
-			else
-				test_must_fail git cat-file $arg1 $arg2 $bogus_short_oid >out 2>actual &&
-				test_must_be_empty out &&
-				test_cmp expect actual
-			fi
-		'
+		test_must_fail git cat-file $arg1 $bogus_long_oid >out 2>actual &&
+		test_must_be_empty out &&
+		test_cmp expect actual
+	'
 
-		test_expect_success "cat-file $arg1 $arg2 error on bogus full OID" '
-			if test "$arg2" = "-p"
-			then
-				cat >expect <<-EOF
-				error: header for $bogus_long_oid too long, exceeds 32 bytes
-				fatal: Not a valid object name $bogus_long_oid
-				EOF
-			else
-				cat >expect <<-EOF
-				error: header for $bogus_long_oid too long, exceeds 32 bytes
-				fatal: git cat-file: could not get object info
-				EOF
-			fi &&
-
-			if test "$arg1" = "--allow-unknown-type"
-			then
-				git cat-file $arg1 $arg2 $bogus_short_oid
-			else
-				test_must_fail git cat-file $arg1 $arg2 $bogus_long_oid >out 2>actual &&
-				test_must_be_empty out &&
-				test_cmp expect actual
-			fi
-		'
+	test_expect_success "cat-file $arg1 error on missing short OID" '
+		cat >expect.err <<-EOF &&
+		fatal: Not a valid object name $(test_oid deadbeef_short)
+		EOF
+		test_must_fail git cat-file $arg1 $(test_oid deadbeef_short) >out 2>err.actual &&
+		test_must_be_empty out &&
+		test_cmp expect.err err.actual
+	'
 
-		test_expect_success "cat-file $arg1 $arg2 error on missing short OID" '
-			cat >expect.err <<-EOF &&
-			fatal: Not a valid object name $(test_oid deadbeef_short)
+	test_expect_success "cat-file $arg1 error on missing full OID" '
+		if test "$arg1" = "-p"
+		then
+			cat >expect.err <<-EOF
+			fatal: Not a valid object name $(test_oid deadbeef)
 			EOF
-			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef_short) >out 2>err.actual &&
-			test_must_be_empty out &&
-			test_cmp expect.err err.actual
-		'
-
-		test_expect_success "cat-file $arg1 $arg2 error on missing full OID" '
-			if test "$arg2" = "-p"
-			then
-				cat >expect.err <<-EOF
-				fatal: Not a valid object name $(test_oid deadbeef)
-				EOF
-			else
-				cat >expect.err <<-\EOF
-				fatal: git cat-file: could not get object info
-				EOF
-			fi &&
-			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef) >out 2>err.actual &&
-			test_must_be_empty out &&
-			test_cmp expect.err err.actual
-		'
-	done
+		else
+			cat >expect.err <<-\EOF
+			fatal: git cat-file: could not get object info
+			EOF
+		fi &&
+		test_must_fail git cat-file $arg1 $(test_oid deadbeef) >out 2>err.actual &&
+		test_must_be_empty out &&
+		test_cmp expect.err err.actual
+	'
 done
 
-test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+test_expect_success '-e is OK with a broken object' '
 	git cat-file -e $bogus_short_oid
 '
 
-test_expect_success '-e can not be combined with --allow-unknown-type' '
-	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_oid
-'
-
-test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
-	test_must_fail git cat-file -p $bogus_short_oid &&
-	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_oid
-'
-
 test_expect_success '<type> <hash> does not work with objects of broken types' '
 	cat >err.expect <<-\EOF &&
 	fatal: invalid object type "bogus"
@@ -788,60 +748,8 @@ test_expect_success 'broken types combined with --batch and --batch-check' '
 	test_cmp err.expect err.actual
 '
 
-test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
-	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
-	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
-'
-
-test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
-	cat >expect <<-EOF &&
-	$bogus_short_type
-	EOF
-	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
-	test_cmp expect actual &&
-
-	# Create it manually, as "git replace" will die on bogus
-	# types.
-	head=$(git rev-parse --verify HEAD) &&
-	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_oid" &&
-	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_oid" $head $ZERO_OID REF_SKIP_OID_VERIFICATION &&
-
-	cat >expect <<-EOF &&
-	commit
-	EOF
-	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success "Type of broken object is correct" '
-	echo $bogus_short_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success "Size of broken object is correct" '
-	echo $bogus_short_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_short_oid >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'clean up broken object' '
-	rm .git/objects/$(test_oid_to_path $bogus_short_oid)
-'
-
-test_expect_success "Type of broken object is correct when type is large" '
-	echo $bogus_long_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_long_oid >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success "Size of large broken object is correct when type is large" '
-	echo $bogus_long_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_long_oid >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'clean up broken object' '
+test_expect_success 'clean up broken objects' '
+	rm .git/objects/$(test_oid_to_path $bogus_short_oid) &&
 	rm .git/objects/$(test_oid_to_path $bogus_long_oid)
 '
 
@@ -903,25 +811,6 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 	)
 '
 
-test_expect_success 'truncated object with --allow-unknown-type' - <<\EOT
-	objtype='a really long type name that exceeds the 32-byte limit' &&
-	blob=$(git hash-object -w --literally -t "$objtype" /dev/null) &&
-	objpath=.git/objects/$(test_oid_to_path "$blob") &&
-
-	# We want to truncate the object far enough in that we don't hit the
-	# end while inflating the first 32 bytes (since we want to have to dig
-	# for the trailing NUL of the header). But we don't want to go too far,
-	# since our header isn't very big. And of course we are counting
-	# deflated zlib bytes in the on-disk file, so it's a bit of a guess.
-	# Empirically 50 seems to work.
-	mv "$objpath" obj.bak &&
-	test_when_finished 'mv obj.bak "$objpath"' &&
-	test_copy_bytes 50 <obj.bak >"$objpath" &&
-
-	test_must_fail git cat-file --allow-unknown-type -t $blob 2>err &&
-	test_grep "unable to unpack $blob header" err
-EOT
-
 test_expect_success 'object reading handles zlib dictionary' - <<\EOT
 	echo 'content that will be recompressed' >file &&
 	blob=$(git hash-object -w file) &&
-- 
2.49.0.896.g93578ceaaf

