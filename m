From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 17:48:08 -0400
Message-ID: <20130827214808.GA26350@sigill.intra.peff.net>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
 <20130827205125.GA23783@sigill.intra.peff.net>
 <xmqqbo4ic0ap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 23:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VER7Y-0006MM-7X
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 23:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab3H0VsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 17:48:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:49771 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3H0VsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 17:48:11 -0400
Received: (qmail 7615 invoked by uid 102); 27 Aug 2013 21:48:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Aug 2013 16:48:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Aug 2013 17:48:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbo4ic0ap.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233165>

[+cc Jonathan]

On Tue, Aug 27, 2013 at 02:05:01PM -0700, Junio C Hamano wrote:

> >> * jk/config-int-range-check (2013-08-21) 2 commits
> [...]
> >
> > I think Jonathan had some concerns about the test in the first one, and
> > there was an open question in the second of whether we wanted to add
> > something like --ulong, call it something more agnostic like
> > --file-size, or simply teach --int to use 64-bit integers everywhere for
> > simplicity.
> 
> Are the scripts that use "git config --<type>" expected to know the
> representation type used by C binaries on the platform?

I think that's an open question. My argument was that you would want to
be able to get the same range errors that git would see internally. So I
know that if "git config --ulong pack.packSizeLimit 10g" does not fail,
then pack-objects itself will be fine when reading the value. So if you
buy the argument that such a thing is useful, then:

  1. We would want to keep the range checks we have for --int.

  2. We would need new types to represent items beyond --int, and they
     should match what git will do internally.  You can call it --ulong,
     or --uint64, or --file-size, or whatever you like, but --int does
     not cut it.

The counterarguments I can see are:

  1. Who cares? If you want to know whether pack-objects will choke on
     your huge config value, then run pack-objects.

  2. Such a check would involve knowing which type we use internally to
     look at packSizeLimit, and that is utterly undocumented (and
     subject to change; e.g., it seems kind of senseless that we have a
     4G pack-size limit on 32-bit platforms, and we may want to fix
     that).

So if you do not buy the argument that communicating git's internal
range checks is useful, then we can simply say "--int is magically long
on every platform, and you can use it for everything numeric". And
implement it with int64_t. You may be able to read or write some values
for certain keys that git will barf on internally, but that is git's
problem.

The one thing it doesn't get you is that you can currently set unsigned
values to "-1" in the config to have them treated as ULONG_MAX. This is
undocumented and as far as I know not used by anyone. But it would be
one place where the interpretation of "git config key" is not the same
as what git does internally, and you do not get a warning or death, but
rather you just get a completely different value.

I don't feel too strongly either way. I mostly kept the range checks for
--int because that is how the code already worked, and I assumed that
was what was desired. But given what I know of the history of the config
code, it is probably a completely random side effect of how it is
implemented. :)

I can try to prepare a series going in that direction (we still need to
fix the internal truncation that currently happens, though).

> >> * jk/mailmap-incomplete-line (2013-08-25) 2 commits
> >>  - mailmap: avoid allocation when reading from blob
> >>  - mailmap: handle mailmap blobs without trailing newlines
> >> 
> >>  Will merge to 'next'.
> >
> > Did you want me to squash these? The second one more or less eradicates
> > the changes made to the first one. I mainly did them separately in case
> > we were going to only do the first half on maint.
> 
> Hmm, perhaps.  Is reading mailmap from a blob commonly done and
> deserves a maint update down for 1.8.3/1.8.2 series?

Yes. The tip of jk/mailmap-from-blob turned on blob reading by default
in bare repositories. So if you have a .mailmap without a terminating
newline, "git shortlog" will segfault by default in a bare version of
your repository.

I do not know if it is so serious a fix that you need to go back to
v1.8.2 series, but I think it is definitely maint-worthy. I was worried
initially that the second part of the patch would involve too much
refactoring for maint, but it actually turned out pretty simple.

I'll prepare a squashed version that I think should be suitable for
maint.

-Peff
