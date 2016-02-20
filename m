From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:34:26 -0500
Message-ID: <20160220083426.GA17171@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112324.GF9319@sigill.intra.peff.net>
 <CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
 <20160220081010.GA16722@sigill.intra.peff.net>
 <CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:34:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX2zp-0006Km-Nz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427301AbcBTIe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:34:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:45980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423122AbcBTIe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:34:28 -0500
Received: (qmail 10949 invoked by uid 102); 20 Feb 2016 08:34:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:34:29 -0500
Received: (qmail 4298 invoked by uid 107); 20 Feb 2016 08:34:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:34:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Feb 2016 03:34:26 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286770>

On Sat, Feb 20, 2016 at 03:29:29AM -0500, Eric Sunshine wrote:

> On Sat, Feb 20, 2016 at 3:10 AM, Jeff King <peff@peff.net> wrote:
> > On Sat, Feb 20, 2016 at 03:07:00AM -0500, Eric Sunshine wrote:
> >> > +               /* argv strings are now owned by pathspec */
> >> > +               paths.argc = 0;
> >> > +               argv_array_clear(&paths);
> >>
> >> This overly intimate knowledge of the internal implementation of
> >> argv_array_clear() is rather ugly.
> >
> > Yep, I agree. Suggestions?
> >
> > We can just leak the array of "char *". This function is called only
> > once per program invocation, and that's unlikely to change.
> >
> > I guess we can make an argv_array_detach_strings() function. Or maybe
> > even just argv_array_detach() would be less gross, and then this
> > function could manually free the array but not the strings themselves.
> 
> The latter is what I was thinking, and I agree that
> argv_array_detach() would be less gross than
> argv_array_detach_strings(), however, it also feels a bit wrong since
> this sort of ownership transfer is kind of out of scope for
> argv_array.
> 
> I wonder if a simple "dup'ing" string_list would be more suitable for
> this case. You'd have to append the NULL item manually with
> string_list_append_nodup(), and string_list_clear() would then be the
> correct way to dispose of the list without intimate knowledge of its
> implementation and no need for an API extension.

A string_list doesn't just store pointers; it's a struct with a util
field. So you can't pass it to things expecting a "const char **".

I think argv_array_detach() is the least-bad thing here. It matches
strbuf_detach() to say "you now own the storage" (as opposed to just
peeking at argv.argv, which we should do only in a read-only way).

-Peff
