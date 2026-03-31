Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB36311958
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001020; cv=none; b=DdMioAmtwk1iMIAl/BkjgOaxT1k0J3WQRybsu6MtHSVsBhEOZs9H2u1rFzRrgLg0mDLmjZHj9gUR24oaVm3at83d2jrjLWzzGQw/F3aDAC2VUzBlp7f5ntjparuypRb2gi7l8sH1F39yA8CjgXXXa+l/q+9HGG5TqTJYRY6rhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001020; c=relaxed/simple;
	bh=bzm2gmwYcUpUSlp0YkGnJ7VphLn2B9edYYQHfCM+h70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHWyi0SNISZEwpTYi0nkJtKycTFYpdfr5qLmcg7EPkNMhKx7JCYjO6pwHW1OedEKEoSxty5z7bkkWPhj9eK+Cer7DZB8nZtdhhZlxhum0ezwpD813BgQmCJ4K+QRDvEuVsWo1PdxYd5yFOc0W9ZoLOwyBIEvvIBi+m+a9xyFibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SzBW4Dhc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SzBW4Dhc"
Received: (qmail 206691 invoked by uid 106); 31 Mar 2026 23:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=bzm2gmwYcUpUSlp0YkGnJ7VphLn2B9edYYQHfCM+h70=; b=SzBW4DhcuWxd5rao/U41cKFdmkrrzX7oQ1NGdpHX+qBcl1+K/97bFCk4W4Rb173xm5otN+4wIIa1XRC3zvsEfU1PBjs8f1JFbGhGE2qW3V01wVzdEdfMwzWTV4vmmXQJE7wn5AJOgp9GfEXniSuESKAcKT/8VcUsYabo0oXSCICqRXglw7nskjPwlrE/sv26O/hGHwXBJ5P39aaC/iaruXZ2HpGkrPTmh3/sLgOPYkQdIjDT3kajMp/CoGiAf/wiJ7Qv92Xz+8fhUarCSQPpb8VbyUljB7RED4Ds/ZrYrJZUbfX5rXeWo6l09TL7/H+b1vpNep7cnOPn0/riCLQ9uQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326594 invoked by uid 111); 31 Mar 2026 23:50:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:50:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:50:17 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 08/12] skip_prefix(): check const match between in and out
 params
Message-ID: <20260331235017.GH2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

The skip_prefix() function takes in a "const char *" string, and returns
via a "const char **" out-parameter that points somewhere in that
string. This is fine if you are operating on a const string, like:

  const char *in = ...;
  const char *out;
  if (skip_prefix(in, "foo", &out))
	...look at out...

It is also OK if "in" is not const but "out" is, as we add an implicit
const when we pass "in" to the function. But there's another case where
this is limiting. If we want both fields to be non-const, like:

  char *in = ...;
  char *out;
  if (skip_prefix(in, "foo", &out))
	*out = '\0';

it doesn't work. The compiler will complain about the type mismatch in
passing "&out" to a parameter which expects "const char **". So to make
this work, we have to do an explicit cast.

But such a cast is ugly, and also means that we run afoul of making this
mistake:

  const char *in = ...;
  char *out;
  if (skip_prefix(in, "foo", (const char **)&out))
	*out = '\0';

which causes us to write to the memory pointed by "in", which was const.

We can imagine these four cases as:

  (1) const in, const out
  (2) non-const in, const out
  (3) non-const in, non-const out
  (4) const in, non-const out

Cases (1) and (2) work now. We would like case (3) to work but it
doesn't. But we would like to catch case (4) as a compile error.

So ideally the rule is "the out-parameter must be at least as const as
the in-parameter". We can do this with some macro trickery. We wrap
skip_prefix() in a macro so that it has access to the real types of
in/out. And then we pass those parameters through another macro which:

  1. Fails if the "at least as const" rule is not filled.

  2. Casts to match the signature of the real skip_prefix().

There are a lot of ways to implement the "fails" part. You can use
__builtin_types_compatible_p() to check, and then either our
BUILD_ASSERT macros or _Static_assert to fail. But that requires some
conditional compilation based on compiler feature. That's probably OK
(the fallback would be to just cast without catching case 4). But we can
do better.

The macro I have here uses a ternary with a dead branch that tries to
assign "in" to "out", which should work everywhere and lets the compiler
catch the problem in the usual way. With an input like this:

  int foo(const char *x, const char **y);
  #define foo(in,out) foo((in), CONST_OUTPARAM((in), (out)))

  void ok_const(const char *x, const char **y)
  {
          foo(x, y);
  }

  void ok_nonconst(char *x, char **y)
  {
          foo(x, y);
  }

  void ok_add_const(char *x, const char **y)
  {
          foo(x, y);
  }

  void bad_drop_const(const char *x, char **y)
  {
          foo(x, y);
  }

gcc reports:

  foo.c: In function ‘bad_drop_const’:
  foo.c:2:35: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      2 |     ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
        |                                   ^
  foo.c:4:31: note: in expansion of macro ‘CONST_OUTPARAM’
      4 | #define foo(in,out) foo((in), CONST_OUTPARAM((in), (out)))
        |                               ^~~~~~~~~~~~~~
  foo.c:23:9: note: in expansion of macro ‘foo’
     23 |         foo(x, y);
        |         ^~~

It's a bit verbose, but I think makes it reasonably clear what's going
on. Using BUILD_ASSERT_OR_ZERO() ends up much worse. Using
_Static_assert you can be a bit more informative, but that's not
something we use at all yet in our code-base (it's an old gnu-ism later
standardized in C11).

Our generic macro only works for "const char **", which is something we
could improve by using typeof(in). But that introduces more portability
questions, and also some weird corner cases (e.g., around implicit void
conversion).

This patch just introduces the concept. We'll make use of it in future
patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4bb59b3101..58e494e037 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -491,6 +491,23 @@ static inline bool skip_prefix(const char *str, const char *prefix,
 	return false;
 }
 
+/*
+ * Check that an out-parameter that is "at least as const as" a matching
+ * in-parameter. For example, skip_prefix() will return "out" that is a subset
+ * of "str". So:
+ *
+ *  const str, const out: ok
+ *  non-const str, const out: ok
+ *  non-const str, non-const out: ok
+ *  const str, non-const out: compile error
+ *
+ *  See the skip_prefix macro below for an example of use.
+ */
+#define CONST_OUTPARAM(in, out) \
+    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
+#define skip_prefix(str, prefix, out) \
+	skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))
+
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
-- 
2.53.0.1136.gd760fbd4a0

