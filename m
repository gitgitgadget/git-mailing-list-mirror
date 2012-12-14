From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/3] compiling git with gcc -O3 -Wuninitialized
Date: Fri, 14 Dec 2012 17:09:04 -0500
Message-ID: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjdRf-00046r-3x
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab2LNWJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:09:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55051 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435Ab2LNWJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:09:07 -0500
Received: (qmail 16115 invoked by uid 107); 14 Dec 2012 22:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Dec 2012 17:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2012 17:09:04 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211505>

I always compile git with "gcc -Wall -Werror", because it catches a lot
of dubious constructs, and we usually keep the code warning-free.
However, I also typically compile with "-O0" because I end up debugging
a fair bit.

Sometimes, though, I compile with -O3, which yields a bunch of new
"variable might be used uninitialized" warnings. What's happening is
that as functions get inlined, the compiler can do more static analysis
of the variables. So given two functions like:

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

If get_foo() is not inlined, then when compiling some_fun, gcc sees only
that a pointer to the local variable is passed, and must assume that it
is an out parameter that is initialized after get_foo returns.

However, when get_foo() is inlined, the compiler may look at all of the
code together and see that some code paths in get_foo() do not
initialize the variable. And we get the extra warnings.

In some cases, this can actually reveal real bugs. The first patch fixes
such a bug:

  [1/3]: remote-testsvn: fix unitialized variable

In most cases, though (including the example above), it's a false
positive. We know something the compiler does not: that error() always
returns -1, and therefore we will either exit early from some_fun, or
"foo" will be properly initialized.

The second two patches:

  [2/3]: inline error functions with constant returns
  [3/3]: silence some -Wuninitialized warnings around errors

try to expose that return value more clearly to the calling code. After
applying both, git compiles cleanly with "-Wall -O3". But the patches
themselves are kind of ugly.

Patch 2/3 tries inlining error() and a few other functions, which lets
the caller see the return value.  Unfortunately, this doesn't actually
work in all cases. I think what is happening is that because error() is
a variadic function, gcc refuses to inline it (and if you give it the
"always_inline" attribute, it complains loudly). So it works for some
functions, but not for error(), which is the most common one.

Patch 3/3 takes a more heavy-handed approach, and replaces some
instances of "return error(...)" with "error(...); return -1". This
works, but it's kind of ugly. The whole point of error()'s return code
is to allow the "return error(...)" shorthand, and it basically means we
cannot use it in some instances.

I really like keeping us -Wall clean (because it means when warnings do
come up, it's easy to pay attention to them). But I feel like patch 3 is
making the code less readable just to silence the false positives. We
can always use the "int foo = foo" trick, but I'd like to avoid that
where we can. Not only is it ugly in itself, but it means that we've
shut off the warnings if a problem is ever introduced to that spot.

Can anybody think of a clever way to expose the constant return value of
error() to the compiler? We could do it with a macro, but that is also
out for error(), as we do not assume the compiler has variadic macros. I
guess we could hide it behind "#ifdef __GNUC__", since it is after all
only there to give gcc's analyzer more information. But I'm not sure
there is a way to make a macro that is syntactically identical. I.e.,
you cannot just replace "error(...)" in "return error(...);" with a
function call plus a value for the return statement. You'd need
something more like:

  #define RETURN_ERROR(fmt, ...) \
  do { \
    error(fmt, __VA_ARGS__); \
    return -1; \
  } while(0) \

which is awfully ugly.

Thoughts?

-Peff
