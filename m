From: Jeff King <peff@peff.net>
Subject: Re: pack corruption post-mortem
Date: Wed, 16 Oct 2013 20:35:47 -0400
Message-ID: <20131017003546.GA12439@sigill.intra.peff.net>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <201310160941.16904.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 02:35:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWbZC-0004y6-8m
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 02:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761405Ab3JQAfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 20:35:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:50689 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760722Ab3JQAft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 20:35:49 -0400
Received: (qmail 1712 invoked by uid 102); 17 Oct 2013 00:35:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Oct 2013 19:35:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Oct 2013 20:35:47 -0400
Content-Disposition: inline
In-Reply-To: <201310160941.16904.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236284>

On Wed, Oct 16, 2013 at 09:41:16AM -0600, Martin Fick wrote:

> I have nightmares about this sort of thing every now and 
> then, and we even experience some corruption here and there 
> that needs to be fixed (mainly missing objects when we toy 
> with different git repack arguments).  I cannot help but 
> wonder, how we can improve git further to either help 
> diagnose or even fix some of these problems?  More inline 
> below...

In general, I don't think we know enough about patterns of recovery
corruption to say which commands would definitely be worth implementing.
Part of the reason I wrote this up is to document this one case. But
this is the first time in 7 years of git usage that I've had to do this.
So I'd feel a little bit better about sinking time into it after seeing
a few more cases and realizing where the patterns are.

One of the major hassles is that the assumptions you can and can't make
depend on what data you have that _isn't_ corrupted. Do you have a pack
index, or a bare pack? Do you have zlib data that fails the crc, or zlib
data that cannot be parsed?

In this case there was no other copy of the repository. But if you know
the broken object (which we did here), and you can copy it from
elsewhere, then git already will try to find other sources of the
object (loose, or in another pack).

> >   dd if=$pack of=object bs=1 skip=51653873 count=10863
> 
> Is there a current plumbing command that should be enhanced 
> to be able to do the 2 steps above directly for people 
> debugging (maybe with some new switch)?  If not, should we 
> create one, git show --zlib, or git cat-file --zlib?

Most of the git plumbing commands deal with data at the object layer.
This is really about going a step below and saying "Give me the on-disk
representation of the object". We recently introduced an
"%(objectsize:disk)" formatter for cat-file. The logical extension would
be to ask for "%(contents:disk)" or something. Though what you get would
depend on how the object is stored, so you would need to figure that out
to do anything useful with it.

Note that this implies you actually have a packfile index that says
"object XXX is at offset YYY". In some corruption cases, you might have
only a packfile. That is generally enough to generate the index, but if
there is corruption, you cannot actually parse the pack to find out the
sha1 of the objects.

So in the worst case, what you really want is something like "dump the
object in packfile X at offset Y". But even then, you don't know the
length of the object. The packfile is a stream, and the length we
calculated is from the index, which depends on the zlib data parsing in
some sane way.

> > and then running "git index-pack tmp.pack" in the
> > debugger (stop at unpack_raw_entry). Doing this, I found
> > that there were 3 bytes of header (and the header itself
> > had a sane type and size). So I stripped those off with:
> > 
> >   dd if=object of=zlib bs=1 skip=3
> 
> This too feels like something we should be able to do with a 
> plumbing command eventually?
> 
> git zlib-extract

Perhaps. I think if you had some "extract object at offset X from the
packfile" command, it would be optional to give you the whole thing, or
just the zlib data.

> > So I took a different approach. Working under the guess
> > that the corruption was limited to a single byte, I
> > wrote a program to munge each byte individually, and try
> > inflating the result. Since the object was only 10K
> > compressed, that worked out to about 2.5M attempts,
> > which took a few minutes.
> 
> Awesome!  Would this make a good new plumbing command, git 
> zlib-fix?

I'd like to see it actually work more than once first. This relies on
there being single-byte corruption. Even double-byte corruption starts
to get expensive to brute-force like this. SHA1, by its nature, requires
brute-forcing. But it's possible that the crc, not being
cryptographically secure, could be reverse-engineered to find likely
spots of corruption. I don't know enough about it to say.

> > I fixed the packfile itself with:
> > 
> >   chmod +w $pack
> >   printf '\xc7' | dd of=$pack bs=1 seek=51659518
> > conv=notrunc chmod -w $pack
> > 
> > The '\xc7' comes from the replacement byte our "munge"
> > program found. The offset 51659518 is derived by taking
> > the original object offset (51653873), adding the
> > replacement offset found by "munge" (5642), and then
> > adding back in the 3 bytes of git header we stripped.
> 
> Another plumbing command needed?  git pack-put --zlib?

I think in this case that dd does a nice job of solving the problem.
Some of the stuff I did was very git-specific and required knowledge of
the formats. But this one is really just "replace byte X at offset Y",
and I don't see any need to avoid a general-purpose tool (except that
dd is itself reasonably arcane :) ).

-Peff
