Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C931CA6A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631777; cv=none; b=svhmF5k8jr/YfbkgZWwTqCQK3BdOFsj9Z6YobpHcBq7cMHAusuEorXw2+MnSd+fhYCWzoajhGjEZlELXy3WAZY4rHcCNjR4v3Hsglhg5kxgBKzW9Ur5DmnhGgFNKvK4IwUVP0S8Wlx3wibJTrWhvpIonN2wFLg86dnRZk0TRaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631777; c=relaxed/simple;
	bh=HX4O/Xa8tRWe1t4l6Q0LmN0zBEOsVg7UHpyfwLYQxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9d/XVJld6xZYD2RTYfaWi5Olo+RSo21v+INkuZV7ZXmPoROr1LcWx7JBZbjRxOdHNKQS5bfVucPc2CP4JxpLQOB1CX5wei2G3yD6FUqrcoZhHYgaVLz0QRGSRi56FPQP8QzvPAB510MBeljR1qwuns+4AVcFapbFFeO9BTawCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Leb40RmZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Leb40RmZ"
Received: (qmail 31214 invoked by uid 109); 19 Aug 2025 19:29:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HX4O/Xa8tRWe1t4l6Q0LmN0zBEOsVg7UHpyfwLYQxqY=; b=Leb40RmZsnzv6t/YJ6RZF1YkOwERsRjTHnDPuz1Fe/1DIWkQNJ8IkgjhN62YejxB5/5s2nMB9wC+c0+8bZs6in00V2Ct4IcOZCMPyBBqYgtUwjZzSZ8MHg8X+vLOY+D1JUeRGIgB0Oz6g9XbrDTQ00Y4pH7KDTFO/Q1W1qXWBP6n/ns/4qiYTwb/6OVYzPdW0I3R30NV1ebUrx2BbI4LEE+Hd8jTqbMVPg1FfG5vM8anx5Z1+IodQZdj/5UNc5Lid7Rj7Ryc1OpzaICI+oI+tT8eVrZJ10QbgyGTuRgOhApFDHhWzylBoNShINlJjoeSPpf6UKJpA1RVp7rgFAA9Fw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:29:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46458 invoked by uid 111); 19 Aug 2025 19:29:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:29:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:29:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <20250819192934.GD1059295@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192004.GA1058857@coredump.intra.peff.net>

When given an expected "before" state, the ref-writing code will avoid
overwriting any ref that does not match that expected state. We use the
null oid as a sentinel value for "nothing should exist", and likewise
that is the sentinel value we get when trying to read a ref that does
not exist.

But there's one corner case where this is ambiguous: dangling symrefs.
Trying to read them will yield the null oid, but there is potentially
something of value there: the dangling symref itself.

For a normal recursive write, this is OK. Imagine we have a symref
"FOO_HEAD" that points to a ref "refs/heads/bar" that does not exist,
and we try to write to it with a create operation like:

  oid=$(git rev-parse HEAD) ;# or whatever
  git symbolic-ref FOO_HEAD refs/heads/bar
  echo "create FOO_HEAD $oid" | git update-ref --stdin

The attempt to resolve FOO_HEAD will actually resolve "bar", yielding
the null oid. That matches our expectation, and the write proceeds. This
is correct, because we are not writing FOO_HEAD at all, but writing its
destination "bar", which in fact does not exist.

But what if the operation asked not to dereference symrefs? Like this:

  echo "create FOO_HEAD $oid" | git update-ref --no-deref --stdin

Resolving FOO_HEAD would still result in a null oid, and the write will
proceed. But it will overwrite FOO_HEAD itself, removing the fact that
it ever pointed to "bar".

This case is a little esoteric; we are clobbering a symref with a
no-deref write of a regular ref value. But the same problem occurs when
writing symrefs. For example:

  echo "symref-create FOO_HEAD refs/heads/other" |
  git update-ref --no-deref --stdin

The "create" operation asked us to create FOO_HEAD only if it did not
exist. But we silently overwrite the existing value.

You can trigger this without using update-ref via the fetch
followRemoteHEAD code. In "create" mode, it should not overwrite an
existing value. But if you manually create a symref pointing to a value
that does not yet exist (either via symbolic-ref or with "remote add
-m"), create mode will happily overwrite it.

Instead, we should detect this case and refuse to write. The correct
specification to overwrite FOO_HEAD in this case is to provide an
expected target ref value, like:

  echo "symref-update FOO_HEAD refs/heads/other ref refs/heads/bar" |
  git update-ref --no-deref --stdin

Note that the non-symref "update" directive does not allow you to do
this (you can only specify an oid). This is a weakness in the update-ref
interface, and you'd have to overwrite unconditionally, like:

  echo "update FOO_HEAD $oid" | git update-ref --no-deref --stdin

Likewise other symref operations like symref-delete do not accept the
"ref" keyword. You should be able to do:

  echo "symref-delete FOO_HEAD ref refs/heads/bar"

but cannot (and can only delete unconditionally). This patch doesn't
address those gaps. We may want to do so in a future patch for
completeness, but it's not clear if anybody actually wants to perform
those operations. The symref update case (specifically, via
followRemoteHEAD) is what I ran into in the wild.

The code for the fix is relatively straight-forward given the discussion
above. But note that we have to implement it independently for the files
and reftable backends. The "old oid" checks happen as part of the
locking process, which is implemented separately for each system. We may
want to factor this out somehow, but it's beyond the scope of this
patch. (Another curiosity is that the messages in the reftable code are
marked for translation, but the ones in the files backend are not. I
followed local convention in each case, but we may want to harmonize
this at some point).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c    | 34 ++++++++++++++++++++++++++++++----
 refs/reftable-backend.c | 30 +++++++++++++++++++++++++++---
 t/t1400-update-ref.sh   | 21 +++++++++++++++++++++
 t/t5510-fetch.sh        |  9 +++++++++
 4 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 905555365b..a4419ef62d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2512,13 +2512,37 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
  */
 static enum ref_transaction_error check_old_oid(struct ref_update *update,
 						struct object_id *oid,
+						struct strbuf *referent,
 						struct strbuf *err)
 {
 	if (update->flags & REF_LOG_ONLY ||
-	    !(update->flags & REF_HAVE_OLD) ||
-	    oideq(oid, &update->old_oid))
+	    !(update->flags & REF_HAVE_OLD))
 		return 0;
 
+	if (oideq(oid, &update->old_oid)) {
+		/*
+		 * Normally matching the expected old oid is enough. Either we
+		 * found the ref at the expected state, or we are creating and
+		 * expect the null oid (and likewise found nothing).
+		 *
+		 * But there is one exception for the null oid: if we found a
+		 * symref pointing to nothing we'll also get the null oid. In
+		 * regular recursive mode, that's good (we'll write to what the
+		 * symref points to, which doesn't exist). But in no-deref
+		 * mode, it means we'll clobber the symref, even though the
+		 * caller asked for this to be a creation event. So flag
+		 * that case to preserve the dangling symref.
+		 */
+		if ((update->flags & REF_NO_DEREF) && referent->len &&
+		    is_null_oid(oid)) {
+			strbuf_addf(err, "cannot lock ref '%s': "
+				    "dangling symref already exists",
+				    ref_update_original_update_refname(update));
+			return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+		}
+		return 0;
+	}
+
 	if (is_null_oid(&update->old_oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
@@ -2658,7 +2682,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 			if (update->old_target)
 				ret = ref_update_check_old_target(referent.buf, update, err);
 			else
-				ret = check_old_oid(update, &lock->old_oid, err);
+				ret = check_old_oid(update, &lock->old_oid,
+						    &referent, err);
 			if (ret)
 				goto out;
 		} else {
@@ -2690,7 +2715,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 			ret = REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
 			goto out;
 		} else {
-			ret = check_old_oid(update, &lock->old_oid, err);
+			ret = check_old_oid(update, &lock->old_oid,
+					    &referent, err);
 			if  (ret) {
 				goto out;
 			}
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 99fafd75eb..ef98584bf9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1272,9 +1272,33 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		ret = ref_update_check_old_target(referent->buf, u, err);
 		if (ret)
 			return ret;
-	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD &&
-		   !oideq(&current_oid, &u->old_oid)) {
-		if (is_null_oid(&u->old_oid)) {
+	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD) {
+		if (oideq(&current_oid, &u->old_oid)) {
+			/*
+			 * Normally matching the expected old oid is enough. Either we
+			 * found the ref at the expected state, or we are creating and
+			 * expect the null oid (and likewise found nothing).
+			 *
+			 * But there is one exception for the null oid: if we found a
+			 * symref pointing to nothing we'll also get the null oid. In
+			 * regular recursive mode, that's good (we'll write to what the
+			 * symref points to, which doesn't exist). But in no-deref
+			 * mode, it means we'll clobber the symref, even though the
+			 * caller asked for this to be a creation event. So flag
+			 * that case to preserve the dangling symref.
+			 *
+			 * Everything else is OK and we can fall through to the
+			 * end of the conditional chain.
+			 */
+			if ((u->flags & REF_NO_DEREF) &&
+			    referent->len &&
+			    is_null_oid(&u->old_oid)) {
+				strbuf_addf(err, _("cannot lock ref '%s': "
+					    "dangling symref already exists"),
+					    ref_update_original_update_refname(u));
+				return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+			}
+		} else if (is_null_oid(&u->old_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference already exists"),
 				    ref_update_original_update_refname(u));
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d29d23cb89..29b31e3b9b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2310,4 +2310,25 @@ test_expect_success 'update-ref should also create reflog for HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'dangling symref not overwritten by creation' '
+	test_when_finished "git update-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	test_must_fail git update-ref --no-deref --stdin 2>err <<-\EOF &&
+	create refs/heads/dangling HEAD
+	EOF
+	test_grep "cannot lock.*dangling symref already exists" err &&
+	test_must_fail git rev-parse --verify refs/heads/dangling &&
+	test_must_fail git rev-parse --verify refs/heads/does-not-exist
+'
+
+test_expect_success 'dangling symref overwritten without old oid' '
+	test_when_finished "git update-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	git update-ref --no-deref --stdin <<-\EOF &&
+	update refs/heads/dangling HEAD
+	EOF
+	git rev-parse --verify refs/heads/dangling &&
+	test_must_fail git rev-parse --verify refs/heads/does-not-exist
+'
+
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 24379ec7aa..83d1aadf9f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -232,6 +232,15 @@ test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'followRemoteHEAD create does not overwrite dangling symref' '
+	git -C two remote add -m does-not-exist custom-head ../one &&
+	test_config -C two remote.custom-head.followRemoteHEAD create &&
+	git -C two fetch custom-head &&
+	echo refs/remotes/custom-head/does-not-exist >expect &&
+	git -C two symbolic-ref refs/remotes/custom-head/HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch --prune on its own works as expected' '
 	git clone . prune &&
 	(
-- 
2.51.0.326.gecbb38d78e
