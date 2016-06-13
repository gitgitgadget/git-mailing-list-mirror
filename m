From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] fix parse-opt string_list leaks
Date: Mon, 13 Jun 2016 01:32:03 -0400
Message-ID: <20160613053203.GB3950@sigill.intra.peff.net>
References: <20160610115726.4805-1-pclouds@gmail.com>
 <20160612220316.GB5428@sigill.intra.peff.net>
 <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 07:32:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCKU7-0008Ci-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 07:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbcFMFcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 01:32:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53618 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750715AbcFMFcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 01:32:07 -0400
Received: (qmail 26059 invoked by uid 102); 13 Jun 2016 05:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:32:06 -0400
Received: (qmail 10323 invoked by uid 107); 13 Jun 2016 05:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:32:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 01:32:03 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297154>

On Mon, Jun 13, 2016 at 07:08:55AM +0700, Duy Nguyen wrote:

> > So if we are doing the conservative thing, then I think the resulting
> > code should either look like:
> >
> >   if (!v->strdup_strings)
> >         die("BUG: OPT_STRING_LIST should always use strdup_strings");
> >   string_list_append(v, arg);
> 
> I agree with the analysis. But this die() would hit all callers
> (except interpret-trailers) because they all initialize with _NODUP
> and setting strdup_strings may require auditing all access to the
> string list in question, e.g. to change string_list_append(v,
> xstrdup(xxx)) to string_list_append(xxx). it may cause side effects if
> we are not careful.

Yep. It is not really fixing anything, so much as alerting us to broken
callers. We'd still have to fix the callers. :)

> So far all callers are in builtin/, I think it will not take much time
> to verify that they all call parse_options() with global argv, then we
> can just lose extra xstrdup() and stick to string_list_append().
> OPTION_STRING already assumes that argument strings are stable because
> they are passed back as-is. Can we go with an easier route, adding a
> comment on top of parse_options() stating that argv[] pointers may be
> passed back as-is and it's up to the caller to xstrdup() appropriately
> before argv[] memory is freed?

Yeah, the two options I laid out were the "conservative" side, where we
didn't make any assumptions about what is in passed into parse_options.
But I agree in practice that it's not likely to be a problem to just
point to the existing strings, and the fact that OPTION_STRING does so
already makes me even more confident.

So I'd suggest these patches:

  [1/3]: parse_opt_string_list: stop allocating new strings
  [2/3]: interpret-trailers: don't duplicate option strings
  [3/3]: blame,shortlog: don't make local option variables static

The first one is what we've been discussing, and the others are just
follow-on cleanups.  I stopped short of a fourth patch to convert more
cases of:

  static struct string_list foo;

to:

  static struct string_list foo = STRING_LIST_INIT_NODUP;

The two are equivalent (mostly due to historical reasons). I tend to
think explicit is better than implicit for something like this (not
because BSS auto-initialization isn't OK, but because there is an
explicit choice of dup/nodup that the writer made, and it is good to
communicate that). But maybe people don't want the extra noise.

-Peff
