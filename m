From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Sat, 1 Mar 2014 00:43:50 -0500
Message-ID: <20140301054350.GA20397@sigill.intra.peff.net>
References: <20140128060954.GA26401@sigill.intra.peff.net>
 <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
 <20140224082459.GA32594@sigill.intra.peff.net>
 <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
 <20140226101353.GA25711@sigill.intra.peff.net>
 <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
 <20140227112734.GC29668@sigill.intra.peff.net>
 <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
 <20140228085546.GA11709@sigill.intra.peff.net>
 <xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:44:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJciM-0002a4-Mj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 06:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbaCAFnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 00:43:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:59180 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbaCAFnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 00:43:52 -0500
Received: (qmail 20238 invoked by uid 102); 1 Mar 2014 05:43:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 23:43:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 00:43:50 -0500
Content-Disposition: inline
In-Reply-To: <xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243042>

On Fri, Feb 28, 2014 at 10:45:39AM -0800, Junio C Hamano wrote:

> > Exactly. The two features (bitmaps and .keep) are not compatible with
> > each other, so you have to prioritize one. If you are using static .keep
> > files, you might want them to continue being respected at the expense of
> > using bitmaps for that repo. So I think you want a separate option from
> > --write-bitmap-index to allow the appropriate flexibility.
> 
> What is "the appropriate flexibility", though?  If the user wants to
> use bitmap, we would need to drop .keep, no?

Or the flip side: if the user wants to use .keep, we should drop
bitmaps. My point is that we do not know which way the user wants to
go, so we should not tie the options together.

> Doesn't always having two copies in two packs degrade performance
> unnecessarily (without even talking about wasted diskspace)?  An
> explicit .keep exists in the repository because it is expensive and
> undesirable to duplicate what is in there in the first place, so it
> feels to me that either

The benefits of static .keep files are (I think):

  1. less I/O during repacks, as you do not rewrite a static set of
     objects

  2. less turnover of packfiles, which can make dumb access more
     efficient (both for dumb clients, but also for things like
     non-git-aware backups).

I think the existence of smart-http more or less nullifies (2). For (1),
it helps at first, but you get diminishing returns as your non-keep
packfile grows. I think it only helps in pathological cases (e.g., you
mark 10GB worth of giant blobs in a .keep pack, and then pack the other
10MB of trees, commits, and normal-sized blobs as usual).

>  - Disable with warning, or outright refuse, the "-b" option if
>    there is .keep (if we want to give precedence to .keep); or
> 
>  - Remove .keep with warning when "-b" option is given (if we want
>    to give precedence to "-b").
> 
> and nothing else would be a reasonable option.  Unfortunately, we
> can do neither automatically because there could be a transient .keep
> file in an active repository.

Right, the transient ones complicate the issue. But I think even for
static .keep versus bitmaps, there is question. See below...

> > The default is another matter.  I think most people using .bitmaps on a
> > server would probably want to set repack.packKeptObjects.  They would
> > want to repack often to take advantage of the .bitmaps anyway, so they
> > probably don't care about .keep files (any they see are due to races
> > with incoming pushes).
> 
> ... which makes me think that repack.packKeptObjects is merely a
> distraction---it should be enough to just pass "--pack-kept-objects"
> when "-b" is asked, without giving any extra configurability, no?

But you do not necessarily ask for "-b" explicitly; it might come from
the config, too. Imagine you have a server with many repos. You want to
use bitmaps when you can, so you set pack.writeBitmaps in
/etc/gitconfig. But in a few repos, you want to use .keep files, and
it's more important for you to use it than bitmaps (e.g., because it is
one of the pathological cases above). So you set repack.packKeptObjects
to false in /etc/gitconfig, to prefer .keep to bitmaps where
appropriate.

If you did not have that config option, your alternative would be to
turn off pack.writeBitmaps in the repositories with .keep files. But
then you need to per-repo keep that flag in sync with whether or not the
repo has .keep files.

To be clear, at GitHub we do not plan on ever having
repack.packKeptObjects off (for now we have it on explicitly, but if it
were connected to pack.writeBitmaps, then we would be happy with that
default). I am mostly trying to give an escape hatch to let people use
different optimization strategies if they want.

If we are going to have --pack-kept-objects (and I think we should),
I think we also should have a matching config option. Because it is
useful when matched with the bitmap code, and that can be turned on both
from the command-line or from the config. Wherever you are doing that,
you would want to be able to make the matching .keep decision.

And I don't think it hurts much.  With the fallback-to-on behavior, you
do not have to even care that it is there unless you are doing something
clever.

> > So we could do something like falling back to turning the option on if
> > --write-bitmap-index is on _and_ the user didn't specify
> > --pack-kept-objects.
> 
> If you mean "didn't specify --no-pack-kept-objects", then I think
> that is sensible.  I still do not know why we would want the
> configuration variable, though.

Right, I meant "if the pack-kept-objects variable is set, either on or
off, either via the command line or in the config".

As far as what the config is good for, see above.

-Peff
