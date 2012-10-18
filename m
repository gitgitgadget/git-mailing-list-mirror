From: Jeff King <peff@peff.net>
Subject: [PATCH] strbuf: always return a non-NULL value from strbuf_detach
Date: Thu, 18 Oct 2012 06:00:12 -0400
Message-ID: <20121018100012.GE9999@sigill.intra.peff.net>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-4-git-send-email-gitster@pobox.com>
 <20121018074921.GC9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:00:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmtx-0003QO-4h
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 12:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab2JRKAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 06:00:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab2JRKAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 06:00:15 -0400
Received: (qmail 4199 invoked by uid 107); 18 Oct 2012 10:00:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 06:00:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 06:00:12 -0400
Content-Disposition: inline
In-Reply-To: <20121018074921.GC9999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207990>

On Thu, Oct 18, 2012 at 03:49:21AM -0400, Jeff King wrote:

> This last line seems like it is caused by a bug in the strbuf API.
> Detaching an empty string will sometimes get you NULL and sometimes not.
> For example, this:
> 
>   struct strbuf foo = STRBUF_INIT;
>   strbuf_detach(&foo, NULL);
> 
> will return NULL. But this:
> 
>   struct strbuf foo = STRBUF_INIT;
>   strbuf_addstr(&foo, "bar");
>   strbuf_reset(&foo);
>   strbuf_detach(&foo, NULL);
> 
> will get you a zero-length string. Which just seems insane to me. The
> whole point of strbuf_detach is that you do not have to care about the
> internal representation. It should probably always return a newly
> allocated zero-length string.
> [...]
> It's possible that switching it would create bugs elsewhere (there are
> over 100 uses of strbuf_detach, so maybe somebody really does want this
> NULL behavior), but I tend to think it is just as likely to be fixing
> undiscovered bugs.

So I just read through all 108 grep hits for strbuf_detach. In almost
every case, the NULL return is not triggerable, because we do _some_
strbuf operation. And even if it is empty, like strbuf_read from an
empty source, or strbuf_addstr on an empty string, we still end up
calling `strbuf_grow(sb, 0)`, which will allocate.

There are a few cases where there are code paths where we really might
not add anything to the strbuf, and changing strbuf_detach would have an
impact:

  In log.c:cmd_format_patch, creating the rev.extra_headers string from
  the individual headers currently ends up NULL when you have no such
  headers. But it ends up not mattering if we have NULL or an empty
  string, since all code paths just end up appending it to our headers
  anyway, and the empty string is a noop.

  In commit.c:read_commit_extra_header_lines, a commit without a value
  will get a NULL value instead of the empty string. But we end up not
  dereferencing the NULL, because it just gets fed to add_extra_header
  later, which will only look at the value if its length parameter is
  non-zero. So it is built to expect the current behavior, but would be
  fine with a switch.

  In http-push.c:xml_entities, we will return NULL if fed an empty
  string. You can dereference NULL by doing "git http-push ''", although
  on glibc systems it will not segfault, because we feed the NULL to
  printf, which converts it to "(null)".

  In http-backend.c:get_parameters, we call url_decode_parameter_* to
  look at the contents of $QUERY_STRING.  These functions can return
  NULL via strbuf_detach if fed an empty string. We are ready to handle
  a NULL value like "empty=&other=value". But not an empty name, like
  "one=1&&two=2" (note the bogus double-& which yields an empty
  parameter). You can get a segfault by sending that to a smart-http
  server.

Probably more detail than you wanted, but I'm pretty confident now that
we should switch it, and that it won't cause any regressions. Patch is
below.

-- >8 --
Subject: strbuf: always return a non-NULL value from strbuf_detach

The current behavior is to return NULL when strbuf did not
actually allocate a string. This can be quite surprising to
callers, though, who may feed the strbuf from arbitrary data
and expect to always get a valid value.

In most cases, it does not make a difference because calling
any strbuf function will cause an allocation (even if the
function ends up not inserting any data). But if the code is
structured like:

  struct strbuf buf = STRBUF_INIT;
  if (some_condition)
	  strbuf_addstr(&buf, some_string);
  return strbuf_detach(&buf, NULL);

then you may or may not return NULL, depending on the
condition. This can cause us to segfault in http-push
(when fed an empty URL) and in http-backend (when an empty
parameter like "foo=bar&&" is in the $QUERY_STRING).

This patch forces strbuf_detach to allocate an empty
NUL-terminated string when it is called on a strbuf that has
not been allocated.

I investigated all call-sites of strbuf_detach. The majority
are either not affected by the change (because they call a
strbuf_* function unconditionally), or can handle the empty
string just as easily as NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 0510f76..4b9e30c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -44,7 +44,9 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 
 char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
-	char *res = sb->alloc ? sb->buf : NULL;
+	char *res;
+	strbuf_grow(sb, 0);
+	res = sb->buf;
 	if (sz)
 		*sz = sb->len;
 	strbuf_init(sb, 0);
-- 
1.8.0.rc3.3.gba630e1
