Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DF1284687
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047001; cv=none; b=M2oi2NEJMINq5Aq6ZfUFIz6clOOh2XlnqDU5GfnJlNA8u5BeqiWo/gdn/A6sdYbs3Dqg8eI0bovGWs273m/p23jL3dOB59aNjnQQp3iH4OePoc9b6GxKOpQ4IRJFmdtfdOYTFPdw79u5AOokkisfm/exJAuzTrULCIPHudRcpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047001; c=relaxed/simple;
	bh=c/fKQsp8CVjmzOXqc75yH30/0X0s5pIFozMal0+I37A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSHLSHA2mJJmgH6KULgsEyOV4OKQXoY2oqdH7ltnHNG6qeoB04C0hA0vq7HeNVtjVLZ+0cwtqk0k9c1VbdQqYwZIIAhrdcxmWLpvXlSI8mXHe9JldPhLVMBfJ6UFt/EWQet2NXy9otVXwxT+hGFiA/IhFR1DFED5EqPvVj4nI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Z2OemvBb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Z2OemvBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=c/fKQsp8CVjmzOXqc75yH30/0X0s5pIFozMal0+I37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Z2OemvBbIfONV4sTpbU0i2YAHKGT3PI38s6yH4sKywLC63IO0PyYbblJV5nmq2fW8
	 KrvIf1h69JE3e16bdFiChJA6zGyI0WwWzHRGgeSg6YjMzFDIXIvjoDP5fOmG+rXRSP
	 fhw2Hvh7z/wyO+qjBrD/7QvtNNyKVWcL2paoDcTYjxhlHqkvrq/ESWe9ssOc3gtkpc
	 VZ98kqsW4Nxwshn7ChX36LW3aCVmlo2dGApGMGc7Uqd6bISxaoo8l0wXy1SzdzAv7K
	 U0NNAC8BVCQ++wbjU8a5HHPXOR56JKkG1D3AIb/+MaqBH3nyZcIRshYjpJHxnln4Dx
	 mFhCDj+Iy4pIJD8yLgEeQK0WNVOjs/0pkfS9WXBANDVOPvkr7lJIWDEcGeSpSPowR/
	 rAaJ49VmDXNzEJdWdcWVFuoWOBT3eV9cA6eDJOgW1o2CrbgflYgH+SLetxLbQiMQ1z
	 oojv3AZJN4StLaidSghAIkjZufEOrjnHvzeh8E5Gwws60wHjc2y
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 90046201A1;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 7/9] fsck: consider gpgsig headers expected in tags
Date: Thu,  9 Oct 2025 21:56:24 +0000
Message-ID: <20251009215626.3089287-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we're creating a tag, we want to make sure that gpgsig and
gpgsig-sha256 headers are allowed for the commit.  The default fsck
behavior is to ignore the fact that they're left over, but some of our
tests enable strict checking which flags them nonetheless.  Add
improved checking for these headers as well as documentation and several
tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/fsck-msgids.adoc |  6 ++++
 fsck.c                         | 18 ++++++++++++
 fsck.h                         |  2 ++
 t/t1450-fsck.sh                | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..52d9a8a811 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -10,6 +10,12 @@
 `badFilemode`::
 	(INFO) A tree contains a bad filemode entry.
 
+`badGpgsig`::
+	(ERROR) A tag contains a bad (truncated) signature (e.g., `gpgsig`) header.
+
+`badHeaderContinuation`::
+	(ERROR) A continuation header (such as for `gpgsig`) is unexpectedly truncated.
+
 `badName`::
 	(ERROR) An author/committer name is empty.
 
diff --git a/fsck.c b/fsck.c
index 171b424dd5..341e100d24 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1067,6 +1067,24 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
 
+	if (buffer < buffer_end && (skip_prefix(buffer, "gpgsig ", &buffer) || skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {
+		eol = memchr(buffer, '\n', buffer_end - buffer);
+		if (!eol) {
+			ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_GPGSIG, "invalid format - unexpected end after 'gpgsig' or 'gpgsig-sha256' line");
+			goto done;
+		}
+		buffer = eol + 1;
+
+		while (buffer < buffer_end && starts_with(buffer, " ")) {
+			eol = memchr(buffer, '\n', buffer_end - buffer);
+			if (!eol) {
+				ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_HEADER_CONTINUATION, "invalid format - unexpected end in 'gpgsig' or 'gpgsig-sha256' continuation line");
+				goto done;
+			}
+			buffer = eol + 1;
+		}
+	}
+
 	if (buffer < buffer_end && !starts_with(buffer, "\n")) {
 		/*
 		 * The verify_headers() check will allow
diff --git a/fsck.h b/fsck.h
index dd7df3d5b3..c26616d7eb 100644
--- a/fsck.h
+++ b/fsck.h
@@ -25,9 +25,11 @@ enum fsck_msg_type {
 	FUNC(NUL_IN_HEADER, FATAL) \
 	FUNC(UNTERMINATED_HEADER, FATAL) \
 	/* errors */ \
+	FUNC(BAD_HEADER_CONTINUATION, ERROR) \
 	FUNC(BAD_DATE, ERROR) \
 	FUNC(BAD_DATE_OVERFLOW, ERROR) \
 	FUNC(BAD_EMAIL, ERROR) \
+	FUNC(BAD_GPGSIG, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5ae86c42be..c4b651c2dc 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -454,6 +454,60 @@ test_expect_success 'tag with NUL in header' '
 	test_grep "error in tag $tag.*unterminated header: NUL at offset" out
 '
 
+test_expect_success 'tag accepts gpgsig header even if not validly signed' '
+	test_oid_cache <<-\EOF &&
+	header sha1:gpgsig-sha256
+	header sha256:gpgsig
+	EOF
+	header=$(test_oid header) &&
+	sha=$(git rev-parse HEAD) &&
+	cat >good-tag <<-EOF &&
+	object $sha
+	type commit
+	tag good
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+	$header -----BEGIN PGP SIGNATURE-----
+	 Not a valid signature
+	 -----END PGP SIGNATURE-----
+
+	This is a good tag.
+	EOF
+
+	tag=$(git hash-object --literally -t tag -w --stdin <good-tag) &&
+	test_when_finished "remove_object $tag" &&
+	git update-ref refs/tags/good $tag &&
+	test_when_finished "git update-ref -d refs/tags/good" &&
+	git -c fsck.extraHeaderEntry=error fsck --tags
+'
+
+test_expect_success 'tag rejects invalid headers' '
+	test_oid_cache <<-\EOF &&
+	header sha1:gpgsig-sha256
+	header sha256:gpgsig
+	EOF
+	header=$(test_oid header) &&
+	sha=$(git rev-parse HEAD) &&
+	cat >bad-tag <<-EOF &&
+	object $sha
+	type commit
+	tag good
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+	$header -----BEGIN PGP SIGNATURE-----
+	 Not a valid signature
+	 -----END PGP SIGNATURE-----
+	junk
+
+	This is a bad tag with junk at the end of the headers.
+	EOF
+
+	tag=$(git hash-object --literally -t tag -w --stdin <bad-tag) &&
+	test_when_finished "remove_object $tag" &&
+	git update-ref refs/tags/bad $tag &&
+	test_when_finished "git update-ref -d refs/tags/bad" &&
+	test_must_fail git -c fsck.extraHeaderEntry=error fsck --tags 2>out &&
+	test_grep "error in tag $tag.*invalid format - extra header" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_must_be_empty actual
