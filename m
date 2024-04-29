Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6C14A98
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379608; cv=none; b=qDqep8oHkfehtJ+dGGyX1NXYr13v0ZIUAIjgZy4mlVWnmrtGGWppLTRGCTyC3FBrQGd+xk185bnG0JP51JsdBEgF6vrzlPa8LbduWPrscrUoFbtIFpD0jUpaq6HUCxwKSw/Tpt4jcmJnAledw4JXsKcBhL6E//bdBLTHI1Cb7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379608; c=relaxed/simple;
	bh=yIwv39/wllnm4b7M+R/AQD40sCBlEk4g3ide0F9tzOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N5S6DpOcMcEy/u+mawvNdGNX8026KUWNbF1yN9SjD1LtXJbUKgOxpmRShZ0JLUCmHYU/Kz2d7pK92upH/0+jg50VkXdL7DcW/MoU6vmRbywmvnlIjxX0bHrdvmCnd9rYKB7UiC38NXWdcIMxbn08d9PqAayUA3fI0+JTz555YO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20241 invoked by uid 109); 29 Apr 2024 08:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26930 invoked by uid 111); 29 Apr 2024 08:33:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:33:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:33:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <20240429083325.GE233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Before operating on a refname we get from a user, we usually check that
it's syntactically valid. As a general rule, refs should be in the
"refs/" namespace, the exception being HEAD and pseudorefs like
FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
dash. But the syntactic rules are not enforced by check_refname_format().
So for example we will happily operate on a ref "foo/bar" that will use
the file ".git/foo/bar" under the hood (when using the files backend, of
course).

Making things even more complicated, refname_is_safe() does enforce
these syntax restrictions! When that function was added in 2014, we
would have refused to work with such refs entirely. But we stopped being
so picky in 03afcbee9b (read_packed_refs: avoid double-checking sane
refs, 2015-04-16). That rationale there is that check_refname_format()
is supposed to contain a superset of the checks of refname_is_safe().
The idea being that we usually would rely on the more-strict
check_refname_format(), but for certain operations (e.g., deleting a
ref) we want to allow invalid names as long as they are not unsafe
(e.g., not escaping the on-disk "refs/" hierarchy).

But the pseudoref handling flips this logic; check_refname_format() is
more lenient than refname_is_safe(). So you can create "foo/bar" and
read it, but you cannot delete it:

  $ git update-ref foo/bar HEAD
  $ git rev-parse foo/bar
  747a29934757b7e695781e13e2511c43b951da2
  $ git update-ref -d foo/bar
  error: refusing to update ref with bad name 'foo/bar'

So we probably want check_ref_format() to learn the same syntactic
restrictions that refname_is_safe() uses (namely insisting that anything
outside of "refs/" matches the pseudoref syntax). The most obvious way
to do that is simply to call refname_is_safe(). But the point of
03afcbee9b is that doing so is expensive. Without the syntactic
restrictions of check_refname_format(), refname_is_safe() has to
actually normalize the pathname to make sure it does not escape "refs/".
That's redundant for us in check_refname_format(); we just need to make
sure it either starts with "refs/" or is a pseudoref.

But wait, it gets more complicated! We also allow "worktrees/foo/$X"
and "main-worktree/$X". In that case we should only be checking "$X"
(which should be either a pseudoref or start with "refs/"). We can
use parse_worktree_ref(), which fairly efficiently gives us the "bare"
refname (even for a non-worktree ref, where it returns the original
name).

And now when should this new logic kick in? Unfortunately we can't just
do it all the time, because many callers pass in partial ref components.
E.g., if they are thinking about making "refs/heads/foo", they'll pass
us "foo". This is usually accompanied by the ALLOW_ONELEVEL flag. But we
likewise can't take the absence of ALLOW_ONELEVEL as a hint that the
name is fully qualified, because that flag is also used to indicate that
pseudorefs should be allowed!

We need a new flag to tell these two situations apart. So let's add a
FULLY_QUALIFIED flag that callers can use to ask us to enforce these
syntactic rules. There are no callers yet, but we should be able to
examine users of ALLOW_ONELEVEL, figure out which semantics they
wanted, and convert as needed.

Signed-off-by: Jeff King <peff@peff.net>
---
The whole ALLOW_ONELEVEL thing is a long-standing confusion, and
unfortunately has made it into the hands of users via "git
check-ref-format --allow-onelevel". So I think it is there to stay.
Possibly we should expose this new feature as --fully-qualified or
similar.

 refs.c | 14 +++++++++++++-
 refs.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 8cac7e7e59..44b4419050 100644
--- a/refs.c
+++ b/refs.c
@@ -288,6 +288,15 @@ static int check_or_sanitize_refname(const char *refname, int flags,
 {
 	int component_len, component_count = 0;
 
+	if ((flags & REFNAME_FULLY_QUALIFIED)) {
+		const char *bare_ref;
+
+		parse_worktree_ref(refname, NULL, NULL, &bare_ref);
+		if (!starts_with(bare_ref, "refs/") &&
+		    !is_pseudoref_syntax(bare_ref))
+			return -1;
+	}
+
 	if (!strcmp(refname, "@")) {
 		/* Refname is a single character '@'. */
 		if (sanitized)
@@ -322,8 +331,11 @@ static int check_or_sanitize_refname(const char *refname, int flags,
 		else
 			return -1;
 	}
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+
+	if (!(flags & (REFNAME_ALLOW_ONELEVEL | REFNAME_FULLY_QUALIFIED)) &&
+	    component_count < 2)
 		return -1; /* Refname has only one component. */
+
 	return 0;
 }
 
diff --git a/refs.h b/refs.h
index d278775e08..cdd859c8b7 100644
--- a/refs.h
+++ b/refs.h
@@ -571,6 +571,7 @@ int for_each_reflog(each_reflog_fn fn, void *cb_data);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
+#define REFNAME_FULLY_QUALIFIED 4
 
 /*
  * Return 0 iff refname has the correct format for a refname according
-- 
2.45.0.rc1.416.gbe2a76c799

