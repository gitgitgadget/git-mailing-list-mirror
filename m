From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Wed, 12 Mar 2014 17:14:15 -0400
Message-ID: <20140312211415.GA10305@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net>
 <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:14:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqTn-00059R-1j
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaCLVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:14:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:38367 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753163AbaCLVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:14:18 -0400
Received: (qmail 5008 invoked by uid 102); 12 Mar 2014 21:14:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 16:14:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 17:14:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243993>

On Wed, Mar 12, 2014 at 01:08:03PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Blindly replacing starts_with() with !memcmp() in the above part is
> >> a readability regression otherwise.
> >
> > I actually think the right solution is:
> >
> >   static inline int standard_header_field(const char *field, size_t len)
> >   {
> >           return mem_equals(field, len, "tree ") ||
> >                  mem_equals(field, len, "parent ") ||
> >                  ...;
> >   }
> >
> > and the caller should tell us it's OK to look at field[len]:
> >
> >   standard_header_field(line, eof - line + 1)
> >
> > We could also omit the space from the standard_header_field.
> 
> Yes, that was what I had in mind.  The only reason why the callee
> (over-)optimizes the "SP must follow these know keywords" part by
> using the extra "len" parameter is because the caller has to do a
> single strchr() to skip an arbitrary field name anyway so computing
> "len" is essentially free.

One thing that bugs me about the current code is that the sub-function
looks one past the end of the length given to it by the caller.
Switching it to pass "eof - line + 1" resolves that, but is it right?

The character pointed at by "eof" is either:

  1. space, if our strchr(line, ' ') found something

  2. the first character of the next line, if our
     memchr(line, '\n', eob - line) found something

  3. Whatever is at eob (end-of-buffer)

There are two questionable things here. In (1), we use strchr on a
sized buffer.  And in (3), we look one past the size that was passed in.

In both cases, we are saved by the fact that the buffer is actually NUL
terminated at the end of "size" (because it comes from read_sha1_file).
But we may find a space much further than the line ending which is
supposed to be our boundary, and end up having to do a comparison to
cover this case.

So I think the current code is correct, but we could make it more
obvious by:

  1. Restricting our search for the field separator to the current line.

  2. Explicitly avoid looking for headers when we did not find a space,
     since we cannot match anything anyway.

Like:

diff --git a/commit.c b/commit.c
index 6bf4fe0..9383cc1 100644
--- a/commit.c
+++ b/commit.c
@@ -1325,14 +1325,14 @@ static struct commit_extra_header *read_commit_extra_header_lines(
 		strbuf_reset(&buf);
 		it = NULL;
 
-		eof = strchr(line, ' ');
-		if (next <= eof)
+		eof = memchr(line, ' ', next - line);
+		if (eof) {
+			if (standard_header_field(line, eof - line + 1) ||
+			    excluded_header_field(line, eof - line, exclude))
+				continue;
+		} else
 			eof = next;
 
-		if (standard_header_field(line, eof - line) ||
-		    excluded_header_field(line, eof - line, exclude))
-			continue;
-
 		it = xcalloc(1, sizeof(*it));
 		it->key = xmemdupz(line, eof-line);
 		*tail = it;

I also think that "eof = next" (which I retained here) is off-by-one.
"next" here is not the newline, but the start of the next line. And I'm
guessing the code actually wanted the newline (otherwise "it->key" ends
up with the newline in it). But we cannot just subtract one, because if
we hit "eob", it really is in the right spot.

-Peff
