Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2021FF3D
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371008; cv=none; b=VexRF77584fXU9ZjPtxDj6FJorQkPhDlTrKW7ZNPsAYJKm7Jht1hja3sncDL7gzYYfSIF4AT7YespsuGSGBSFyFzDAy6/0gm5UPy5EpCDVONUut7r6aTRvSDx/poeTJz+e0UhHIyCxgTmADG+7Fc4kCGHVcuirylHeIFCdnHVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371008; c=relaxed/simple;
	bh=WoRYO2UzTt86uQHT88ov/rR84LqtSWR2tT1/YF9IB9I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4YNShR54CSPSr2BNu46x9OzSqOQ9C178MeaCzI7Ui89Fr2ItHfZHhbX25E9OhbcJZIQRlq+WC+vuCx3T0AClfqwVm5h03Cg+2fQmYWYnJWGwf/+T+sqGCSZsbs2dQOWuzLZW01cVK++YXoNPWj4TAMMy6lVtd4RjfiHPNKDssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LT5oyHak; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LT5oyHak"
Received: (qmail 5180 invoked by uid 109); 16 May 2025 04:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WoRYO2UzTt86uQHT88ov/rR84LqtSWR2tT1/YF9IB9I=; b=LT5oyHakCMiVY26NbE9x5Ymx/ijvUzJ8WwF+kdgNmOVOp/XiM3E8eYmHgkeXbF01f3typvlskimz7l0w1NiLluzip8VfUqKaqmCgIT89UppP2IIejx4llls4I2IrfQQyPtXpP+oxXVCpD2l5yfZhoJj4x1wWcuc550WrSHon9HAUB5F+Wf32IUrROn9/wlJKALfECsumg12ZFFOKrZb1w97VWEO3XDuGsUraJVK2LfNmu3UznxoVhgsuEdoCTxQ+R8XzUfvhMH4ZTRy2euePpe1jOWBvCS6XAQGqWc06LxiTHM2BT3lTi/A2QdJNhlvjhCwXuy79Ix/Hhd4Sk2/DVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4961 invoked by uid 111); 16 May 2025 04:50:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:09 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:50:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 10/13] hash-object: stop allowing unknown types
Message-ID: <20250516045005.GJ22242@coredump.intra.peff.net>
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

When passed the "--literally" option, hash-object will allow any
arbitrary string for its "-t" type option. Such objects are only useful
for testing or debugging, as they cannot be used in the normal way
(e.g., you cannot fetch their contents!).

Let's drop this feature, which will eventually let us simplify the
object-writing code. This is technically backwards incompatible, but
since such objects were never really functional, it seems unlikely that
anybody will notice.

We will retain the --literally flag, as it also instructs hash-object
not to worry about other format issues (e.g., type-specific things that
fsck would complain about). The documentation does not need to be
updated, as it was always vague about which checks we're loosening (it
uses only the phrase "any garbage").

The code change is a bit hard to verify from just the patch text. We can
drop our local hash_literally() helper, but it was really just wrapping
write_object_file_literally(). We now replace that with calling
index_fd(), as we do for the non-literal code path, but dropping the
INDEX_FORMAT_CHECK flag. This ends up being the same semantically as
what the _literally() code path was doing (modulo handling unknown
types, which is our goal).

We'll be able to clean up these code paths a bit more in subsequent
patches.

The existing test is flipped to show that we now reject the unknown
type. The additional "extra-long type" test is now redundant, as we bail
early upon seeing a bogus type.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/hash-object.c  | 29 +++++------------------------
 t/t1007-hash-object.sh | 11 ++---------
 2 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index cd53fa3bde..3c6949b3fa 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -24,26 +24,6 @@ enum {
 	HASH_OBJECT_WRITE = (1 << 1),
 };
 
-/*
- * This is to create corrupt objects for debugging and as such it
- * needs to bypass the data conversion performed by, and the type
- * limitation imposed by, index_fd() and its callees.
- */
-static int hash_literally(struct object_id *oid, int fd, const char *type, unsigned flags)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret;
-
-	if (strbuf_read(&buf, fd, 4096) < 0)
-		ret = -1;
-	else
-		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
-						  (flags & HASH_OBJECT_WRITE) ? WRITE_OBJECT_FILE_PERSIST : 0);
-	close(fd);
-	strbuf_release(&buf);
-	return ret;
-}
-
 static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		    int literally)
 {
@@ -56,11 +36,12 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	if (flags & HASH_OBJECT_CHECK)
 		index_flags |= INDEX_FORMAT_CHECK;
 
+	if (literally)
+		index_flags &= ~INDEX_FORMAT_CHECK;
+
 	if (fstat(fd, &st) < 0 ||
-	    (literally
-	     ? hash_literally(&oid, fd, type, flags)
-	     : index_fd(the_repository->index, &oid, fd, &st,
-			type_from_string(type), path, index_flags)))
+	    index_fd(the_repository->index, &oid, fd, &st,
+		     type_from_string(type), path, index_flags))
 		die((flags & HASH_OBJECT_WRITE)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index b3cf53ff8c..dbbe9fb0d4 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -248,15 +248,8 @@ test_expect_success 'hash-object complains about truncated type name' '
 	test_must_fail git hash-object -t bl --stdin </dev/null
 '
 
-test_expect_success '--literally' '
-	t=1234567890 &&
-	echo example | git hash-object -t $t --literally --stdin
-'
-
-test_expect_success '--literally with extra-long type' '
-	t=12345678901234567890123456789012345678901234567890 &&
-	t="$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t" &&
-	echo example | git hash-object -t $t --literally --stdin
+test_expect_success '--literally complains about non-standard types' '
+	test_must_fail git hash-object -t bogus --literally --stdin
 '
 
 test_expect_success '--stdin outside of repository (uses SHA-1)' '
-- 
2.49.0.896.g93578ceaaf

