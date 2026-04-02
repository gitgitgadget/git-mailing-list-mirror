Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48F3612F0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103311; cv=none; b=nw5QTaQxgvI3H/gEd7g0G2ormvWI3UYPjDRfO3tzQC6Ki4CX//zbXtHmtW2SuxF/ssdxZ1xoBcsxfH2WgTM4bczVxBQgdwKBuQF7Fus66AGoZeIUA7hPeoIUxzxJGYuoA8Uou02RJ/FvjcgAaYYfJpCCSJf7uTzoj+pdhtpePi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103311; c=relaxed/simple;
	bh=xTf144SLmgFz5g0pXbVWK/DsYLPDfizHrriS20wYj7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6KEpkhrsvS2jVEdAUJaGXlUAd/jmMuFxHYFWMZ7/s27P4poH9LNSOtrzy4leVSV2uVUOBg6J24HUsCforSupo49srI9lVFi6SwQtWwgygIs2TzSTUSlKvt40VcEYv2YTEjB1vlpv8Lthhsl5RVoNC+Mci0I4u4fsop2IeJasVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e1iRUecD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e1iRUecD"
Received: (qmail 218881 invoked by uid 106); 2 Apr 2026 04:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=xTf144SLmgFz5g0pXbVWK/DsYLPDfizHrriS20wYj7Q=; b=e1iRUecDtHhyBx8fBdUctM9h7wliTIgs6OkVk8twDrntqW2ZREBvVtiB0WsFisSWw0z4WtLnIsBNe+l483F0zhciZ+O7SZa126tGxi8jEVrP+ePlntZOs1vk9PuWGKDeMS9GtZO9ZJGKcHJlBdha9Jz9fcnrI0ji4Ft5YeHyGP2DVOmck0Je77ulMw2Owk3gHnn2ZEOdFx0cqxCWZdpMyf4zWWPxDDh0f1hG85mbs2ihk0NUc1VSnBNVSmZ12lMvox+xIqQohyZVVHk6H0KWXv1JIoJSYbAUOd3J1OeZJzAoBfJGPtV6zv9xYGbIyg+0p166jA7JQ+z1m9f718Xhkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349767 invoked by uid 111); 2 Apr 2026 04:15:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 08/12] skip_prefix(): check const match between in and out
 params
Message-ID: <20260402041507.GH3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

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

Note that we rename skip_prefix() to skip_prefix_impl() here, to avoid
expanding the macro when defining the function. That's not strictly
necessary since we could just define the macro after defining the inline
function. But that would not be the case for a non-inline function (and
we will apply this technique to them later, and should be consistent).
It also gives us more freedom about where to define the macro. I did so
right above the definition here, which I think keeps the relevant bits
together.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4bb59b3101..e9629b2a9d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -463,6 +463,21 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
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
+
 /*
  * If the string "str" begins with the string found in "prefix", return true.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
@@ -479,8 +494,10 @@ void set_die_is_recursing_routine(int (*routine)(void));
  *   [skip prefix if present, otherwise use whole string]
  *   skip_prefix(name, "refs/heads/", &name);
  */
-static inline bool skip_prefix(const char *str, const char *prefix,
-			       const char **out)
+#define skip_prefix(str, prefix, out) \
+	skip_prefix_impl((str), (prefix), CONST_OUTPARAM((str), (out)))
+static inline bool skip_prefix_impl(const char *str, const char *prefix,
+				    const char **out)
 {
 	do {
 		if (!*prefix) {
-- 
2.53.0.1172.ge9e20b5838

