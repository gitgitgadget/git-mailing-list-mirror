Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AE21CA05
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371006; cv=none; b=QU/CN9W4Rn7frcY5Br1cC2pkPX21ASgRVNec8oWBT4zXdROj/afXeh3v++bWZzSrskPOiqeFCMqM7xmikhGcp6k4U7iFcQd6E6afodHbWKH3mfckreTn7qxbgFFdNQo+1Xf9e9hEHwzq45swi6VO//VMt4aEizQsdJvFqOPR88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371006; c=relaxed/simple;
	bh=WVzIgnRCeypfbOdrwv9bEbHriiUPSwRac4HJMu1tqqg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/gKU8mwuAwOmi91aaZfRts4ijdv6gqGB5SAR3AYF6EEo9KUbeo+ZovwqTtE/60BzVryH17Iqk1gPmP+/MroeveEEyc6jHU5SSKU6yPj5qERuvLgzRMRuxqPeZFB/jsQeQ5w4W/xwryt/ldMrYZ1tEV7htJNo0SRZIq2a7DCkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YYOZU6tS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YYOZU6tS"
Received: (qmail 5177 invoked by uid 109); 16 May 2025 04:50:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WVzIgnRCeypfbOdrwv9bEbHriiUPSwRac4HJMu1tqqg=; b=YYOZU6tSkxl85K9NaX+OtpqeoUzkRh571FqJjQcLMeGJcWP5jEbHSMDh2J2AIi+WyPQ5hwp1Pz+XnsCgBO/5uFOVSAlkSZtRAaWgDTwVH6SjV4gV/f8vhDO5PxExrLBkSiKnJoUsrmoszkq+gr5v1qvj1BWzqdyE2eeiPnwAbWnB90PKpgAqSx9pR0UVSru1qUZNf92ApSdksoVkUq/84wk80ebOO0VSXrMWs0u+kXmWU4QE2n5te/dooG33D5yzYcJW6k9Lpdq6vpqEpAGA4cPsWvGY3SKJ6ypfSYEyThldB/D/MOuorQapyMcttPmaWtUFhgHKuKzrGgw6tVUI2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4956 invoked by uid 111); 16 May 2025 04:50:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:50:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 09/13] t: add lib-loose.sh
Message-ID: <20250516045002.GI22242@coredump.intra.peff.net>
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

This commit adds a shell library for writing raw loose objects into the
object database. Normally this is done with hash-object, but the
specific intent here is to allow broken objects that hash-object may not
support.

We'll convert several cases that use "hash-object --literally" to write
objects with invalid types. That works currently, but dropping this
dependency will allow us to remove that feature and simplify the
object-writing code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-loose.sh                      | 30 +++++++++++++++++++++++++++++
 t/t1006-cat-file.sh                 |  5 +++--
 t/t1450-fsck.sh                     |  3 ++-
 t/t1512-rev-parse-disambiguation.sh |  5 +++--
 4 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 t/lib-loose.sh

diff --git a/t/lib-loose.sh b/t/lib-loose.sh
new file mode 100644
index 0000000000..3613631eaf
--- /dev/null
+++ b/t/lib-loose.sh
@@ -0,0 +1,30 @@
+# Support routines for hand-crafting loose objects.
+
+# Write a loose object into the odb at $1, with object type $2 and contents
+# from stdin. Writes the oid to stdout. Example:
+#
+#   oid=$(echo foo | loose_obj .git/objects blob)
+#
+loose_obj () {
+	cat >tmp_loose.content &&
+	size=$(wc -c <tmp_loose.content) &&
+	{
+		# Do not quote $size here; we want the shell
+		# to strip whitespace that "wc" adds on some platforms.
+		printf "%s %s\0" "$2" $size &&
+		cat tmp_loose.content
+	} >tmp_loose.raw &&
+
+	oid=$(test-tool $test_hash_algo <tmp_loose.raw) &&
+	suffix=${oid#??} &&
+	prefix=${oid%$suffix} &&
+	dir=$1/$prefix &&
+	file=$dir/$suffix &&
+
+	test-tool zlib deflate <tmp_loose.raw >tmp_loose.zlib &&
+	mkdir -p "$dir" &&
+	mv tmp_loose.zlib "$file" &&
+
+	rm tmp_loose.raw tmp_loose.content &&
+	echo "$oid"
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d96d02ad7d..317da6869c 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -3,6 +3,7 @@
 test_description='git cat-file'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-loose.sh"
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -657,12 +658,12 @@ test_expect_success 'setup bogus data' '
 	bogus_short_type="bogus" &&
 	bogus_short_content="bogus" &&
 	bogus_short_size=$(strlen "$bogus_short_content") &&
-	bogus_short_oid=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+	bogus_short_oid=$(echo_without_newline "$bogus_short_content" | loose_obj .git/objects $bogus_short_type) &&
 
 	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
 	bogus_long_content="bogus" &&
 	bogus_long_size=$(strlen "$bogus_long_content") &&
-	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | loose_obj .git/objects $bogus_long_type)
 '
 
 for arg1 in -s -t -p
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3f52dd5abc..5ae86c42be 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -7,6 +7,7 @@ test_description='git fsck random collection of tests
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-loose.sh"
 
 test_expect_success setup '
 	git config gc.auto 0 &&
@@ -973,7 +974,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 	(
 		cd garbage-type &&
 
-		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
+		garbage_blob=$(loose_obj objects garbage </dev/null) &&
 
 		test_must_fail git fsck 2>err &&
 		grep -e "^error" -e "^fatal" err >errors &&
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 70f1e0a998..1a380a4184 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -24,6 +24,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-loose.sh"
 
 test_cmp_failed_rev_parse () {
 	dir=$1
@@ -67,8 +68,8 @@ test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
 		cd blob.bad &&
 
 		# Both have the prefix "bad0"
-		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
-		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
+		echo xyzfaowcoh | loose_obj objects bad &&
+		echo xyzhjpyvwl | loose_obj objects bad
 	) &&
 
 	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
-- 
2.49.0.896.g93578ceaaf

