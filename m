Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE021CC5A
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370996; cv=none; b=RKDOK/LsEfQa4lhMGYMz6g7JcRvi8miaFr2CSSDw86r4RZ2jy4Iwvz4XTur4nS7SsUCxH7Lx4UWOjxi8xsxvXVqlt4xvXtjCF0011l7IhIH2GQ+ywYLtRABQSvrXF8GuM06WZersFLwPv/ayGEQ+KBlxjkv8rRlieKR5jkUVC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370996; c=relaxed/simple;
	bh=ZQEdVHuqm5WO9QnW9t26bckktRYrqJ9AbswHgGMpQRQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8WH50OjbA8Y9lRJ4QfPM/usDUvAk/BKwXwq5qqicpkqWCatMsgL1peiKpKzF/T3Po1DfjAoyXLXSESv1NNnzHkhoBqX9CJvV9FZ76LH8HB8yCh+pcoehSe8/Xha8kW38rZoKCKabXMymaAeHauwcohI03hi1+LbhI6YyZY3/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WaiLHtsK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WaiLHtsK"
Received: (qmail 5166 invoked by uid 109); 16 May 2025 04:49:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZQEdVHuqm5WO9QnW9t26bckktRYrqJ9AbswHgGMpQRQ=; b=WaiLHtsKqDWZoCzRrNHHWKhFI4sNmjdSNwod8kA2qpGgGtqauqKHrKN3J8cqKiRf7a8OA6JXIdQ1XLdTDLzW8UBADZzaFs8W8z5QJ7fanwEH2KZaNaeFbI9N3I3K0+x6T1seNL3Zl1oGqaGTFauabYQhXgA7Hi849p28+sPJOsOa40D3jodx2g4v4j90MAj3G4ATROxae09dNgpVuO/XGg31Zp+qgbKJ4jRp5odOdsAQkiZfBxIYgCjeLVQqaxmCynfkIvMKz1QIfYExT6pL/QBYgIqJf3ESjADwbLaFeUre9olFhEM9ReiUsP/Bt3AWYVu6UlFuhc9Euy19velljg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4911 invoked by uid 111); 16 May 2025 04:49:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 06/13] fsck: stop using object_info->type_name strbuf
Message-ID: <20250516044953.GF22242@coredump.intra.peff.net>
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

When fsck-ing a loose object, we use object_info's type_name strbuf to
record the parsed object type as a string. For most objects this is
redundant with the object_type enum, but it does let us report the
string when we encounter an object with an unknown type (for which there
is no matching enum value).

There are a few downsides, though:

  1. The code to report these cases is not actually robust. Since we did
     not pass a strbuf to unpack_loose_header(), we only retrieved types
     from headers up to 32 bytes. In longer cases, we'd simply say
     "object corrupt or missing".

  2. This is the last caller that uses object_info's type_name strbuf
     support. It would be nice to refactor it so that we can simplify
     that code.

  3. Likewise, we'll check the hash of the object using its unknown type
     (again, as long as that type is short enough). That depends on the
     hash_object_file_literally() code, which we'd eventually like to
     get rid of.

So we can simplify things by bailing immediately in read_loose_object()
when we encounter an unknown type. This has a few user-visible effects:

  a. Instead of producing a single line of error output like this:

       error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object is of unknown type 'bogus': .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6

     we'll now issue two lines (the first from read_loose_object() when
     we see the unparsable header, and the second from the fsck code,
     since we couldn't read the object):

       error: unable to parse type from header 'bogus 4' of .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
       error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object corrupt or missing: .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6

     This is a little more verbose, but this sort of error should be
     rare (such objects are almost impossible to work with, and cannot
     be transferred between repositories as they are not representable
     in packfiles). And as a bonus, reporting the broken header in full
     could help with debugging other cases (e.g., a header like "blob
     xyzzy\0" would fail in parsing the size, but previously we'd not
     have showed the offending bytes).

  b. An object with an unknown type will be reported as corrupt, without
     actually doing a hash check. Again, I think this is unlikely to
     matter in practice since such objects are totally unusable.

We'll update one fsck test to match the new error strings. And we can
remove another test that covered the case of an object with an unknown
type _and_ a hash corruption. Since we'll skip the hash check now in
this case, the test is no longer interesting.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 13 ++-----------
 object-file.c   | 12 +++++++++---
 t/t1450-fsck.sh | 29 +++--------------------------
 3 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6cac28356c..e7d96a9c8e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -614,12 +614,11 @@ static void get_default_heads(void)
 struct for_each_loose_cb
 {
 	struct progress *progress;
-	struct strbuf obj_type;
 };
 
-static int fsck_loose(const struct object_id *oid, const char *path, void *data)
+static int fsck_loose(const struct object_id *oid, const char *path,
+		      void *data UNUSED)
 {
-	struct for_each_loose_cb *cb_data = data;
 	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	unsigned long size;
@@ -629,8 +628,6 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	struct object_id real_oid = *null_oid(the_hash_algo);
 	int err = 0;
 
-	strbuf_reset(&cb_data->obj_type);
-	oi.type_name = &cb_data->obj_type;
 	oi.sizep = &size;
 	oi.typep = &type;
 
@@ -642,10 +639,6 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 			err = error(_("%s: object corrupt or missing: %s"),
 				    oid_to_hex(oid), path);
 	}
-	if (type != OBJ_NONE && type < 0)
-		err = error(_("%s: object is of unknown type '%s': %s"),
-			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
-			    path);
 	if (err < 0) {
 		errors_found |= ERROR_OBJECT;
 		free(contents);
@@ -697,7 +690,6 @@ static void fsck_object_dir(const char *path)
 {
 	struct progress *progress = NULL;
 	struct for_each_loose_cb cb_data = {
-		.obj_type = STRBUF_INIT,
 		.progress = progress,
 	};
 
@@ -712,7 +704,6 @@ static void fsck_object_dir(const char *path)
 				      &cb_data);
 	display_progress(progress, 256);
 	stop_progress(&progress);
-	strbuf_release(&cb_data.obj_type);
 }
 
 static int fsck_head_link(const char *head_ref_name,
diff --git a/object-file.c b/object-file.c
index 1127e154f6..7a35bde96e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1662,6 +1662,12 @@ int read_loose_object(const char *path,
 		goto out_inflate;
 	}
 
+	if (*oi->typep < 0) {
+		error(_("unable to parse type from header '%s' of %s"),
+		      hdr, path);
+		goto out_inflate;
+	}
+
 	if (*oi->typep == OBJ_BLOB &&
 	    *size > repo_settings_get_big_file_threshold(the_repository)) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
@@ -1672,9 +1678,9 @@ int read_loose_object(const char *path,
 			error(_("unable to unpack contents of %s"), path);
 			goto out_inflate;
 		}
-		hash_object_file_literally(the_repository->hash_algo,
-					   *contents, *size,
-					   oi->type_name->buf, real_oid);
+		hash_object_file(the_repository->hash_algo,
+				 *contents, *size,
+				 *oi->typep, real_oid);
 		if (!oideq(expected_oid, real_oid))
 			goto out_inflate;
 	}
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0105045376..3f52dd5abc 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -71,30 +71,6 @@ test_expect_success 'object with hash mismatch' '
 	)
 '
 
-test_expect_success 'object with hash and type mismatch' '
-	git init --bare hash-type-mismatch &&
-	(
-		cd hash-type-mismatch &&
-
-		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
-		oldoid=$oid &&
-		old=$(test_oid_to_path "$oid") &&
-		new=$(dirname $old)/$(test_oid ff_2) &&
-		oid="$(dirname $new)$(basename $new)" &&
-
-		mv objects/$old objects/$new &&
-		git update-index --add --cacheinfo 100644 $oid foo &&
-		tree=$(git write-tree) &&
-		cmt=$(echo bogus | git commit-tree $tree) &&
-		git update-ref refs/heads/bogus $cmt &&
-
-
-		test_must_fail git fsck 2>out &&
-		grep "^error: $oldoid: hash-path mismatch, found at: .*$new" out &&
-		grep "^error: $oldoid: object is of unknown type '"'"'garbage'"'"'" out
-	)
-'
-
 test_expect_success 'zlib corrupt loose object output ' '
 	git init --bare corrupt-loose-output &&
 	(
@@ -1001,8 +977,9 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 
 		test_must_fail git fsck 2>err &&
 		grep -e "^error" -e "^fatal" err >errors &&
-		test_line_count = 1 errors &&
-		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
+		test_line_count = 2 errors &&
+		test_grep "unable to parse type from header .garbage" err &&
+		test_grep "$garbage_blob: object corrupt or missing:" err
 	)
 '
 
-- 
2.49.0.896.g93578ceaaf

