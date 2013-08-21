From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 22:34:29 -0400
Message-ID: <20130821023429.GA25296@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <xmqqli3wufmc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 04:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByFr-0003n5-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 04:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab3HUCef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 22:34:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:42563 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab3HUCee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 22:34:34 -0400
Received: (qmail 24851 invoked by uid 102); 21 Aug 2013 02:34:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 21:34:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 22:34:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqli3wufmc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232677>

On Tue, Aug 20, 2013 at 04:06:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I was playing with a hook for file size limits that wanted to store the
> > limit in git-config. It turns out we don't do a very good job of big
> > integers:
> >
> >   $ git config foo.size 2g
> >   $ git config --int foo.size
> >   -2147483648
> >
> > Oops. After this series, we properly notice the error:
> >
> >   $ git config --int foo.size
> >   fatal: bad config value for 'foo.size' in .git/config
> >
> > and even better, provide a way to access large values:
> >
> >   $ git config --ulong foo.size
> >   2147483648
> 
> I may be missing something, but why do we even need a new option for
> the command that is known to always produce textual output?

We could do all math with int64_t (for example) and then print the
stringified representation. But then we would not be matching the same
checks that git is doing internally.

For example, on a 32-bit system, setting core.packedGitLimit to 4G will
produce an error for "git config --int core.packedgitlimit", as we
cannot represent the size internally. We could do the conversion in such
a way that we print the correct size, but it does not represent what
happens when "git pack-objects" is run (you get the same error).

> As you said "Oops", the first example that shows a string of digits
> prefixed by a minus sign for input "2g" is buggy, and I think it is
> perfectly reasonable to fix it to show a stringified representation
> of 2*1024*1024*1024 when asked for "--int".

The negative value is a little bit of a sidetrack. For both "git config
--int" and for internal use, we do not correctly range-check integer
values. And that's why we print the negative value, when we should say
"this is a bogus out-of-range value". The latter is what we have always
done for values outside of range, both internal and external, and it is
only that our range check was bogus (and we fed negative crap to the
code instead of complaining). That is fixed by the first patch.

And that leads to the second patch. The "--int" option provides a range
check of (typically) -2^32 to 2^32-1. But many of our values internally
use a larger range. We can either drop that range check (which means we
will let you inspect values with config that git internally will barf
on, with no clue), or we need to add another option with a different
range to retrieve those values. I chose to add another option because I
think the range check has value.

Does that explain the problem more fully?

-Peff
