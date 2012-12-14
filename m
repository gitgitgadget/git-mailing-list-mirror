From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 3/3] silence some -Wuninitialized warnings around errors
Date: Fri, 14 Dec 2012 17:13:18 -0500
Message-ID: <20121214221317.GC19677@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:13:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjdVh-0007UH-0L
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab2LNWNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:13:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab2LNWNU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:13:20 -0500
Received: (qmail 16242 invoked by uid 107); 14 Dec 2012 22:14:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Dec 2012 17:14:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2012 17:13:18 -0500
Content-Disposition: inline
In-Reply-To: <20121214220903.GA18418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211508>

When git is compiled with "gcc -Wuninitialized -O3", some
inlined calls provide an additional opportunity for the
compiler to do static analysis on variable initialization.
For example, with two functions like this:

  int get_foo(int *foo)
  {
	if (something_that_might_fail() < 0)
		return error("unable to get foo");
	*foo = 0;
	return 0;
  }

  void some_fun(void)
  {
	  int foo;
	  if (get_foo(&foo) < 0)
		  return -1;
	  printf("foo is %d\n", foo);
  }

If get_foo() is not inlined, then when compiling some_fun,
gcc sees only that a pointer to the local variable is
passed, and must assume that it is an out parameter that
is initialized after get_foo returns.

However, when get_foo() is inlined, the compiler may look at
all of the code together and see that some code paths in
get_foo() do not initialize the variable. As a result, it
prints a warning. But what the compiler can't see is that
error() always returns -1, and therefore we know that either
we return early from some_fun, or foo ends up initialized,
and the code is safe.  The warning is a false positive.

By converting the error() call to:

  error("unable to get foo");
  return -1;

we explicitly make the compiler aware of the constant return
value, and it silences the warning.

Signed-off-by: Jeff King <peff@peff.net>
---
Not sure if we should do this or not. This does silence the warnings,
but it's kind of ugly.

 builtin/reflog.c  | 6 ++++--
 vcs-svn/svndiff.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..c2ea9d3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -494,8 +494,10 @@ static int parse_expire_cfg_value(const char *var, const char *value, unsigned l
 
 static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
 {
-	if (!value)
-		return config_error_nonbool(var);
+	if (!value) {
+		config_error_nonbool(var);
+		return -1;
+	}
 	if (!strcmp(value, "never") || !strcmp(value, "false")) {
 		*expire = 0;
 		return 0;
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 74c97c4..46e96f6 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -121,7 +121,8 @@ static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
 		*len = sz - 1;
 		return 0;
 	}
-	return error_short_read(in);
+	error_short_read(in);
+	return -1;
 }
 
 static int parse_int(const char **buf, size_t *result, const char *end)
@@ -140,7 +141,8 @@ static int parse_int(const char **buf, size_t *result, const char *end)
 		*buf = pos + 1;
 		return 0;
 	}
-	return error("invalid delta: unexpected end of instructions section");
+	error("invalid delta: unexpected end of instructions section");
+	return -1;
 }
 
 static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
-- 
1.8.0.2.4.g59402aa
