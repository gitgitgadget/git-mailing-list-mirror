From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid
 refs
Date: Tue, 12 Jan 2016 04:58:05 -0500
Message-ID: <20160112095804.GB16501@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 10:58:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIviR-0007Bi-2V
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934184AbcALJ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:58:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:52008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933884AbcALJ6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:58:07 -0500
Received: (qmail 21254 invoked by uid 102); 12 Jan 2016 09:58:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:58:07 -0500
Received: (qmail 11558 invoked by uid 107); 12 Jan 2016 09:58:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:58:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 04:58:05 -0500
Content-Disposition: inline
In-Reply-To: <20160112095638.GA4773@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283784>

We sometimes call lock_ref_sha1_basic with REF_NODEREF
to operate directly on a symbolic ref. This is used, for
example, to move to a detached HEAD, or when updating
the contents of HEAD via checkout or symbolic-ref.

However, the first step of the function is to resolve the
refname to get the "old" sha1, and we do so without telling
resolve_ref_unsafe() that we are only interested in the
symref. As a result, we may detect a problem there not with
the symref itself, but with something it points to.

The real-world example I found (and what is used in the test
suite) is a HEAD pointing to a ref that cannot exist,
because it would cause a directory/file conflict with other
existing refs.  This situation is somewhat broken, of
course, as trying to _commit_ on that HEAD would fail. But
it's not explicitly forbidden, and we should be able to move
away from it. However, neither "git checkout" nor "git
symbolic-ref" can do so. We try to take the lock on HEAD,
which is pointing to a non-existent ref. We bail from
resolve_ref_unsafe() with errno set to EISDIR, and the lock
code thinks we are attempting to create a d/f conflict.

Of course we're not. The problem is that the lock code has
no idea what level we were at when we got EISDIR, so trying
to diagnose or remove empty directories for HEAD is not
useful.

The most obvious solution would be to call
resolve_ref_unsafe() with RESOLVE_REF_NO_RECURSE, so that we
never look beyond the symref (and any problems we find must
be attributable to it). However, that means we would not
correctly gather the "old" sha1. We do not typically care
about it for locking purposes with a symref (since the
symref has no value on its own), but it does affect what we
write into the HEAD reflog.

Another possibility is to avoid the d/f check when
REF_NORECURSE is set. But that would mean we fail to notice
a real d/f conflict. This is impossible with HEAD, but we
would not want to create refs/heads/origin/HEAD.lock if we
already have refs/heads/origin/HEAD/foo.

So instead, we attempt to resolve HEAD fully to get the old
sha1, and only if that fails do we fallback to a
non-recursive resolution. We lose nothing to the fallback,
since we know the ref cannot be resolved, and thus we have
no old sha1 in the first place. And we still get the benefit
of the d/f-checking for the symref itself.

This does mean an extra round of filesystem lookups in some
cases, but they should be rare. It only kicks in with
REF_NODEREF, and then only when the existing ref cannot be
resolved.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c             |  4 ++++
 t/t1401-symbolic-ref.sh          |  7 +++++++
 t/t2011-checkout-invalid-head.sh | 20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 180c837..ea67d82 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1901,6 +1901,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_oid.hash, &type);
+	if (!refname && (flags & REF_NODEREF))
+		refname = resolve_ref_unsafe(orig_refname,
+					     resolve_flags | RESOLVE_REF_NO_RECURSE,
+					     lock->old_oid.hash, &type);
 	if (!refname && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 5db876c..a713766 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -122,4 +122,11 @@ test_expect_success 'symbolic-ref does not create ref d/f conflicts' '
 	test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df
 '
 
+test_expect_success 'symbolic-ref handles existing pointer to invalid name' '
+	head=$(git rev-parse HEAD) &&
+	git symbolic-ref HEAD refs/heads/outer &&
+	git update-ref refs/heads/outer/inner $head &&
+	git symbolic-ref HEAD refs/heads/unrelated
+'
+
 test_done
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index d444d5e..9c1fddf 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -25,4 +25,24 @@ test_expect_success 'checkout notices failure to lock HEAD' '
 	test_must_fail git checkout -b other
 '
 
+test_expect_success 'create ref directory/file conflict scenario' '
+	git update-ref refs/heads/outer/inner master &&
+
+	# do not rely on symbolic-ref to get a known state,
+	# as it may use the same code we are testing
+	reset_to_df () {
+		echo "ref: refs/heads/outer" >.git/HEAD
+	}
+'
+
+test_expect_failure 'checkout away from d/f HEAD (to branch)' '
+	reset_to_df &&
+	git checkout master
+'
+
+test_expect_failure 'checkout away from d/f HEAD (to detached)' '
+	reset_to_df &&
+	git checkout --detach master
+'
+
 test_done
-- 
2.7.0.368.g04bc9ee
