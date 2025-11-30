Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105F1FD4
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508541; cv=none; b=ljhAVGukAUeAv40f+ZRqCtx19e+ol8HuMzguR7mVW+Tr/Q2Nk1Ri4bzYZWSSg81V6OGl5ccSlVG8xr/ILUte+eU5rB5OTgZQaxr4TukxMdCqTA8WKf/K4lRnI4K08YLvPqQFjjX2bs7O4MVXAg1Lk9ruW/a3sJUkSHLyZxC3/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508541; c=relaxed/simple;
	bh=kXzZgTehw3e0V+hK0HQdzOqD/iPRJMHPJyQHz3NZYsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC6CyKcXO2tdh2nmqQmfoixHP6855hqwrn03Ibvu42Gnyfgv1zUZMMne81QDmxeqg3avTCzkWf2S4G0Jt4flyYEsKEuiPlaSHuYp03207k0ZBJhzNWct/znvZgLzGm4xZZy4Mr+Jnv94ZwqSfj5hslQQgVXaEMgYkgimnThz4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EuYXMhFH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EuYXMhFH"
Received: (qmail 170846 invoked by uid 109); 30 Nov 2025 13:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kXzZgTehw3e0V+hK0HQdzOqD/iPRJMHPJyQHz3NZYsw=; b=EuYXMhFHecg3DrKMJCKcCe1yOMQ68TYa9lF4xgi4RSAYo6I/sbSlybljB6hAIKMZAnBveC4K+hGsqexu02fzv9CG5lc2l7Pr5pwYevTxcPerpjtvdFVamLOzp9TX+t8d617t2JSudqjNc8JLIT6FJGTfpCTEaFlrzoJIA/rR1u1kcn4CMxiEX/wrpXhfyZUIEZwF09oxvfLfKNwxl+Mqayq3m00sLQPYtciABQD/PxlIVPVLx4DBPaWeWJ6vWDIddirG0lxcN3nJIlzgXq+FsAwBR3XIzzMGZbpD10i0tMF9PWjYqV5XiVpPASiE1Nug2XVEV/BU/4SN0YV5rup2TA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:15:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 254790 invoked by uid 111); 30 Nov 2025 13:15:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:15:37 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:15:37 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/4] parse: add functions for parsing from non-string buffers
Message-ID: <20251130131537.GB199335@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130131351.GA198697@coredump.intra.peff.net>

If you have a buffer that is not NUL-terminated but want to parse an
integer, there aren't many good options. If you use strtol() and
friends, you risk running off the end of the buffer if there is no
non-digit terminating character. And even if you carefully make sure
that there is such a character, ASan's strict-string-check mode will
still complain.

You can copy bytes into a temporary buffer, terminate it, and then call
strtol(), but doing so adds some pitfalls (like making sure you soak up
whitespace and leading +/- signs, and reporting overflow for overly long
input). Or you can hand-parse the digits, but then you need to take some
care to handle overflow (and again, whitespace and +/- signs).

These things aren't impossible to do right, but it's error-prone to have
to do them in every spot that wants to do such parsing. So let's add
some functions which can be used across the code base.

There are a few choices regarding the interface and the implementation.

First, the implementation:

  - I went with with parsing the digits (rather than buffering and
    passing to libc functions). It ends up being a similar amount of
    code because we have to do some parsing either way. And likewise
    overflow detection depends on the exact type the caller wants, so we
    either have to do it by hand or write a separate wrapper for
    strtol(), strtoumax(), and so on.

  - Unsigned overflow detection is done using the same techniques as in
    unsigned_add_overflows(), etc. We can't use those macros directly
    because our core function is type-agnostic (so the caller passes in
    the max value, rather than us deriving it on the fly). This is
    similar to how git_parse_int(), etc, work.

  - Signed overflow detection assumes that we can express a negative
    value with magnitude one larger than our maximum positive value
    (e.g., -128..127 for a signed 8-bit value). I doubt this is
    guaranteed by the standard, but it should hold in practice, and we
    make the same assumption in git_parse_int(), etc. The nice thing
    about this is that we can derive the range from the number of bits
    in the type. For ints, you obviously could use INT_MIN..INT_MAX, but
    for an arbitrary type, we can use maximum_signed_value_of_type().

  - I didn't bother with handling bases other than 10. It would
    complicate the code, and I suspect it won't be needed. We could
    probably retro-fit it later without too much work, if need be.

For the interface:

  - What do we call it? We have git_parse_int() and friends, which aim
    to make parsing less error-prone. And in some ways, these are just
    buffer (rather than string) versions of those functions. But not
    entirely. Those functions are aimed at parsing a single user-facing
    value. So they accept a unit prefix (e.g., "10k"), which we won't
    always want. And they insist that the whole string is consumed
    (rather than passing back an "end" pointer).

    We also have strtol_i() and strtoul_ui() wrappers, which try to make
    error handling simpler (especially around overflow), but mostly
    behave like their libc counterparts. These also don't pass out an
    end pointer, though.

    So I started a new namespace, "parse_<type>_from_buf".

  - Like those other functions above, we use an out-parameter to store
    the result, which lets us return an error code directly. This avoids
    the complicated errno dance for detecting overflow that you get with
    strtol().

    What should the error code look like? git_parse_int() uses a bool
    for success/failure. But strtol_ui() uses the syscall-like "0 is
    success, -1 is error" convention.

    I went with the bool approach here. Since the names are closest to
    those functions, I thought it would cause the least confusion.

  - Unlike git_parse_signed() and friends, we do not insist that the
    entire buffer be consumed. For parsing a specific standalone string
    that makes sense, but within an unterminated buffer you are much
    more likely to be parsing multiple fields from a larger data set.

    We pass out an "end" pointer the same way strtol() does. Another
    option is to accept the input as an in-out parameter and advance the
    pointer ourselves (and likewise shrink the length pointer). That
    would let you do something like:

       if (!parse_int_from_buf(&p, &len, &out))
               return error(...);
       /* "p" and "len" were adjusted automatically */
       if (!len || *p++ != ' ')
               return error(...);

    That saves a few lines of code in some spots, but requires a few
    more in others (depending on whether the caller has a length in the
    first place or is using an end pointer). Of the two callers I intend
    to immediately convert, we have one of each type!

    I went with the strtol() approach as flexible and time-tested.

  - We could likewise take the input buffer as two pointers (start and
    end) rather than a pointer and a length. That again makes life
    easier for some callers and harder for others. I stuck with pointer
    and length as the more usual interface.

  - What happens when a caller passes in a NULL end pointer? This is
    allowed by strtol(). But I think it's often a sign of a lurking bug,
    because there's no way to know how much was consumed (and even if a
    caller wants to assume everything is consumed, you have no way to
    verify it). So it is simply an error in this interface (you'd get a
    segfault).

    I am tempted to say that if the end pointer is NULL the functions
    could confirm that the entire buffer was consumed, as a convenience.
    But that felt a bit magical and surprising.

Like git_parse_*(), there is a generic signed/unsigned helper, and then
we can add type-specific helpers on top. I've added an int helper here
to start, and we'll add more as we convert callers.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry for the long message, but I tried to lay out my thinking for all
of it, since there were a lot of arbitrary decisions.

 Makefile                   |  1 +
 parse.c                    | 96 +++++++++++++++++++++++++++++++++++++
 parse.h                    | 17 +++++++
 t/meson.build              |  1 +
 t/unit-tests/u-parse-int.c | 98 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+)
 create mode 100644 t/unit-tests/u-parse-int.c

diff --git a/Makefile b/Makefile
index 237b56fc9d..751bd40a9f 100644
--- a/Makefile
+++ b/Makefile
@@ -1510,6 +1510,7 @@ CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
+CLAR_TEST_SUITES += u-parse-int
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
diff --git a/parse.c b/parse.c
index f626846def..1dcbcf64a1 100644
--- a/parse.c
+++ b/parse.c
@@ -209,3 +209,99 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 		die(_("failed to parse %s"), k);
 	return val;
 }
+
+/*
+ * Helper that handles both signed/unsigned cases. If "negate" is NULL,
+ * negative values are disallowed. If not NULL and the input is negative,
+ * the value is range-checked but the caller is responsible for actually doing
+ * the negatiion. You probably don't want to use this! Use one of
+ * parse_signed_from_buf() or parse_unsigned_from_buf() below.
+ */
+static bool parse_from_buf_internal(const char *buf, size_t len,
+				    const char **ep, bool *negate,
+				    uintmax_t *ret, uintmax_t max)
+{
+	const char *end = buf + len;
+	uintmax_t val = 0;
+
+	while (buf < end && isspace(*buf))
+		buf++;
+
+	if (negate)
+		*negate = false;
+	if (buf < end && *buf == '-') {
+		if (!negate) {
+			errno = EINVAL;
+			return false;
+		}
+		buf++;
+		*negate = true;
+		/* Assume negative range is always one larger than positive. */
+		max = max + 1;
+	} else if (buf < end && *buf == '+') {
+		buf++;
+	}
+
+	if (buf == end || !isdigit(*buf)) {
+		errno = EINVAL;
+		return false;
+	}
+
+	while (buf < end && isdigit(*buf)) {
+		int digit = *buf - '0';
+
+		if (val > max / 10) {
+			errno = ERANGE;
+			return false;
+		}
+		val *= 10;
+		if (val > max - digit) {
+			errno = ERANGE;
+			return false;
+		}
+		val += digit;
+
+		buf++;
+	}
+
+	*ep = buf;
+	*ret = val;
+	return true;
+}
+
+bool parse_unsigned_from_buf(const char *buf, size_t len, const char **ep,
+			     uintmax_t *ret, uintmax_t max)
+{
+	return parse_from_buf_internal(buf, len, ep, NULL, ret, max);
+}
+
+bool parse_signed_from_buf(const char *buf, size_t len, const char **ep,
+			   intmax_t *ret, intmax_t max)
+{
+	uintmax_t u_ret;
+	bool negate;
+
+	if (!parse_from_buf_internal(buf, len, ep, &negate, &u_ret, max))
+		return false;
+	/*
+	 * Range already checked internally, but we must apply negation
+	 * ourselves since only we have the signed integer type.
+	 */
+	if (negate) {
+		*ret = u_ret;
+		*ret = -*ret;
+	} else {
+		*ret = u_ret;
+	}
+	return true;
+}
+
+bool parse_int_from_buf(const char *buf, size_t len, const char **ep, int *ret)
+{
+	intmax_t tmp;
+	if (!parse_signed_from_buf(buf, len, ep, &tmp,
+				   maximum_signed_value_of_type(int)))
+		return false;
+	*ret = tmp;
+	return true;
+}
diff --git a/parse.h b/parse.h
index f80cc5b9fd..53663c8939 100644
--- a/parse.h
+++ b/parse.h
@@ -19,4 +19,21 @@ int git_parse_maybe_bool_text(const char *value);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 
+/*
+ * These functions parse an integer from a buffer that does not need to be
+ * NUL-terminated. They return true on success, or false if no integer is found
+ * (in which case errno is set to EINVAL) or if the integer is out of the
+ * allowable range (in which case errno is ERANGE).
+ *
+ * You must pass in a non-NULL value for "ep", which returns a pointer to the
+ * next character in the buf (similar to strtol(), etc).
+ *
+ * These functions always parse in base 10 (and do not allow input like "0xff"
+ * to switch to base 16). They do not allow unit suffixes like git_parse_int(),
+ * above.
+ */
+bool parse_unsigned_from_buf(const char *buf, size_t len, const char **ep, uintmax_t *ret, uintmax_t max);
+bool parse_signed_from_buf(const char *buf, size_t len, const char **ep, intmax_t *ret, intmax_t max);
+bool parse_int_from_buf(const char *buf, size_t len, const char **ep, int *ret);
+
 #endif /* PARSE_H */
diff --git a/t/meson.build b/t/meson.build
index 7c994d4643..1289614545 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -8,6 +8,7 @@ clar_test_suites = [
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
   'unit-tests/u-oidtree.c',
+  'unit-tests/u-parse-int.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-block.c',
diff --git a/t/unit-tests/u-parse-int.c b/t/unit-tests/u-parse-int.c
new file mode 100644
index 0000000000..a1601bb16b
--- /dev/null
+++ b/t/unit-tests/u-parse-int.c
@@ -0,0 +1,98 @@
+#include "unit-test.h"
+#include "parse.h"
+
+static void check_int(const char *buf, size_t len,
+		      size_t expect_ep_ofs, int expect_errno,
+		      int expect_result)
+{
+	const char *ep;
+	int result;
+	bool ok = parse_int_from_buf(buf, len, &ep, &result);
+
+	if (expect_errno) {
+		cl_assert(!ok);
+		cl_assert_equal_i(expect_errno, errno);
+		return;
+	}
+
+	cl_assert(ok);
+	cl_assert_equal_i(expect_result, result);
+	cl_assert_equal_i(expect_ep_ofs, ep - buf);
+}
+
+static void check_int_str(const char *buf, size_t ofs, int err, int res)
+{
+	check_int(buf, strlen(buf), ofs, err, res);
+}
+
+static void check_int_full(const char *buf, int res)
+{
+	check_int_str(buf, strlen(buf), 0, res);
+}
+
+static void check_int_err(const char *buf, int err)
+{
+	check_int(buf, strlen(buf), 0, err, 0);
+}
+
+void test_parse_int__basic(void)
+{
+	cl_invoke(check_int_full("0", 0));
+	cl_invoke(check_int_full("11", 11));
+	cl_invoke(check_int_full("-23", -23));
+	cl_invoke(check_int_full("+23", 23));
+
+	cl_invoke(check_int_str("  31337  ", 7, 0, 31337));
+
+	cl_invoke(check_int_err("  garbage", EINVAL));
+	cl_invoke(check_int_err("", EINVAL));
+	cl_invoke(check_int_err("-", EINVAL));
+
+	cl_invoke(check_int("123", 2, 2, 0, 12));
+}
+
+void test_parse_int__range(void)
+{
+	/*
+	 * These assume a 32-bit int. We could avoid that with some
+	 * conditionals, but it's probably better for the test to
+	 * fail noisily and we can decide how to handle it then.
+	 */
+	cl_invoke(check_int_full("2147483647", 2147483647));
+	cl_invoke(check_int_err("2147483648", ERANGE));
+	cl_invoke(check_int_full("-2147483647", -2147483647));
+	cl_invoke(check_int_full("-2147483648", -2147483648));
+	cl_invoke(check_int_err("-2147483649", ERANGE));
+}
+
+static void check_unsigned(const char *buf, uintmax_t max,
+			   int expect_errno, uintmax_t expect_result)
+{
+	const char *ep;
+	uintmax_t result;
+	bool ok = parse_unsigned_from_buf(buf, strlen(buf), &ep, &result, max);
+
+	if (expect_errno) {
+		cl_assert(!ok);
+		cl_assert_equal_i(expect_errno, errno);
+		return;
+	}
+
+	cl_assert(ok);
+	cl_assert_equal_s(ep, "");
+	/*
+	 * Do not use cl_assert_equal_i_fmt(..., PRIuMAX) here. The macro
+	 * casts to int under the hood, corrupting the values.
+	 */
+	clar__assert_equal(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC,
+			   CLAR_CURRENT_LINE,
+			   "expect_result != result", 1,
+			   "%"PRIuMAX, expect_result, result);
+}
+
+void test_parse_int__unsigned(void)
+{
+	cl_invoke(check_unsigned("4294967295", UINT_MAX, 0, 4294967295U));
+	cl_invoke(check_unsigned("1053", 1000, ERANGE, 0));
+	cl_invoke(check_unsigned("-17", UINT_MAX, EINVAL, 0));
+}
-- 
2.52.0.413.gf695cdb9bd

