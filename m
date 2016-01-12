From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
Date: Tue, 12 Jan 2016 16:45:09 -0500
Message-ID: <20160112214509.GC2841@sigill.intra.peff.net>
References: <20160112214318.GA2527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:45:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ6kj-0008En-VK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 22:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbcALVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 16:45:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52577 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751577AbcALVpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 16:45:11 -0500
Received: (qmail 19667 invoked by uid 102); 12 Jan 2016 21:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:45:11 -0500
Received: (qmail 18840 invoked by uid 107); 12 Jan 2016 21:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:45:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 16:45:09 -0500
Content-Disposition: inline
In-Reply-To: <20160112214318.GA2527@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283848>

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

To make things even more complicated, we only get EISDIR in
the loose-ref case. If the refs are packed, the resolution
may "succeed", giving us the pointed-to ref in "refname",
but a null oid. Later, we say "ah, the null oid means we are
creating; let's make sure there is room for it", but
mistakenly check against the _resolved_ refname, not the
original.

We can fix this by making two tweaks:

  1. Call resolve_ref_unsafe() with RESOLVE_REF_NO_RECURSE
     when REF_NODEREF is set. This means any errors
     we get will be from the orig_refname, and we can act
     accordingly.

     We already do this in the REF_DELETING case, but we
     should do it for update, too.

  2. If we do get a "refname" return from
     resolve_ref_unsafe(), even with RESOLVE_REF_NO_RECURSE
     it may be the name of the ref pointed-to by a symref.
     We already normalize this back to orig_refname before
     taking the lockfile, but we need to do so before the
     null_oid check.

While we're rearranging the REF_NODEREF handling, we can
also bump the initialization of lflags to the top of the
function, where we are setting up other flags. This saves us
from having yet another conditional block on REF_NODEREF
just to set it later.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c             | 19 ++++++++++---------
 t/t1401-symbolic-ref.sh          |  7 +++++++
 t/t2011-checkout-invalid-head.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69c3ecf..81c92b4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1887,7 +1887,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int type, lflags;
+	int type;
+	int lflags = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
 	int attempts_remaining = 3;
@@ -1898,10 +1899,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_DELETING) {
+	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
-		if (flags & REF_NODEREF)
-			resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	if (flags & REF_NODEREF) {
+		resolve_flags |= RESOLVE_REF_NO_RECURSE;
+		lflags |= LOCK_NO_DEREF;
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
@@ -1937,6 +1939,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 		goto error_return;
 	}
+
+	if (flags & REF_NODEREF)
+		refname = orig_refname;
+
 	/*
 	 * If the ref did not exist and we are creating it, make sure
 	 * there is no existing packed ref whose name begins with our
@@ -1952,11 +1958,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lflags = 0;
-	if (flags & REF_NODEREF) {
-		refname = orig_refname;
-		lflags |= LOCK_NO_DEREF;
-	}
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	strbuf_git_path(&ref_file, "%s", refname);
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
index d444d5e..c5501b0 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -25,4 +25,37 @@ test_expect_success 'checkout notices failure to lock HEAD' '
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
+test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
+	reset_to_df &&
+	git checkout master
+'
+
+test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
+	reset_to_df &&
+	git checkout --detach master
+'
+
+test_expect_success 'pack refs' '
+	git pack-refs --all --prune
+'
+
+test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
+	reset_to_df &&
+	git checkout master
+'
+
+test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
+	reset_to_df &&
+	git checkout --detach master
+'
 test_done
-- 
2.7.0.368.g04bc9ee
