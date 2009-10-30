From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Fri, 30 Oct 2009 15:30:30 -0400
Message-ID: <20091030193030.GA10985@coredump.intra.peff.net>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
 <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
 <20091029151152.GX10505@spearce.org>
 <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
 <20091029215829.GD10505@spearce.org>
 <20091030175741.GC18583@coredump.intra.peff.net>
 <20091030191239.GF10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xBN-0000O6-FE
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbZJ3Taf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZJ3Tae
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:30:34 -0400
Received: from peff.net ([208.65.91.99]:58496 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206AbZJ3Tae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:30:34 -0400
Received: (qmail 2489 invoked by uid 107); 30 Oct 2009 19:34:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 15:34:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 15:30:30 -0400
Content-Disposition: inline
In-Reply-To: <20091030191239.GF10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131734>

On Fri, Oct 30, 2009 at 12:12:40PM -0700, Shawn O. Pearce wrote:

> > I am just a bystander, so maybe my opinion is not worth anything, but
> > personally I think you are obfuscating the code to save a single line.
> 
> Yup, me too.  But I'm also willing to do what I need to get my
> patches included in git.git.  Smart HTTP is something a lot of people
> have been waiting for.  If the maintainer wants the bikeshed to be
> a particular shade of red, I'll paint it that way.

Yes, I too want it merged ASAP, so please Junio if you disagree with my
comments, ignore them. But I did want to point out that the proposed
"improvement" was making things worse, IMHO. So I feel like I was at
least bikeshedding his bikeshed, instead of starting my own. ;)

> > If you really just want to initialize to zero, using
> > 
> >   char linelen[5] = { 0 };
> 
> Bleh, I find that has hard to grok as what we have now.  Perhaps my
> understanding of the relevant standards is incomplete, but I'd read
> that as linelen[0] = 0, but the other 4 positions are undefined
> and may be not be initialized.

Your understanding is incomplete. :) C99, 6.7.8, paragraph 19:

  ... all subobjects that are not initialized explicitly shall be
  initialized implicitly the same as objects that have static storage
  duration.

I don't recall offhand whether that was the case in C89 or not.

But that being said, it was an attempt to make the meaning clear. If
it's not to you (who I consider at least reasonably competent ;) ), then
it failed.

> >   die("protocol error: bad line length character: %.4s", linelen);
> 
> I actually considered this one, but again I wasn't clear what would
> happen in the standard C library when we fed a string that wasn't
> actually NUL terminated.  Is the library permitted to call strlen()
> before formatting?  If so strlen() could SIGSEGV if we are unlucky
> and no NUL is present between our string and the end of the assigned
> memory region.

No, using a precision specifier for a string with no NUL is explicitly
allowed by the standard (and we use it elsewhere in git, IIRC).

> To me, my original version was the most clear, to me and anyone
> else who could ever possibly come by to read it.  The "one extra
> line of code" is also only in an error condition which never occurs
> (but did once due to a bug in the HTTP code, which is why I added
> this patch to my series, to help debug it).  Its not like this is
> a performance sensitive section of git that Linus is going to come
> back and overhaul.

Heh. You never know what performance item Linus will complain about. ;)
But yes, I am fine with your initial one, too. The drawback to it (and
my "%.4s") is not that one line of code is so unbearable, but that it is
one extra thing anyone using it as a string must do, and if they forget,
we get a horrible segfault.

Anyway, my complaint has been lodged. Junio is aware of the alternatives
and can pick whichever he wants.

-Peff
