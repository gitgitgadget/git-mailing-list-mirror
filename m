From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
	debug
Date: Fri, 30 Oct 2009 12:12:40 -0700
Message-ID: <20091030191239.GF10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-4-git-send-email-spearce@spearce.org> <7vhbtidgmp.fsf@alter.siamese.dyndns.org> <20091029151152.GX10505@spearce.org> <7v1vkm6id9.fsf@alter.siamese.dyndns.org> <20091029215829.GD10505@spearce.org> <20091030175741.GC18583@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wtx-0001Jd-PH
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbZJ3TMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbZJ3TMf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:12:35 -0400
Received: from george.spearce.org ([209.20.77.23]:57219 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbZJ3TMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:12:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 174D5381FF; Fri, 30 Oct 2009 19:12:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091030175741.GC18583@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131732>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 29, 2009 at 02:58:29PM -0700, Shawn O. Pearce wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > I knew and understood all of what you just said.  static linelen[] is not
> > > about stack allocation.  It's about letting the compiler initialize it to
> > > five NULs so that you do not have to assign NUL to its fifth place before
> > > you die.  This removes one added line from your patch.
> 
> I am just a bystander, so maybe my opinion is not worth anything, but
> personally I think you are obfuscating the code to save a single line.

Yup, me too.  But I'm also willing to do what I need to get my
patches included in git.git.  Smart HTTP is something a lot of people
have been waiting for.  If the maintainer wants the bikeshed to be
a particular shade of red, I'll paint it that way.

> When I see a static variable, I assume it is because the value should be
> saved from invocation to invocation, and now I will spend time wondering
> why that would be the case here.

Me too.  I also can't grok the code I just wrote, for the same
reason, it just reads wrong.  But who am I to argue with the guy
who is most likely going to be the one who needs to deal with it
in the future?
 
> If you really just want to initialize to zero, using
> 
>   char linelen[5] = { 0 };

Bleh, I find that has hard to grok as what we have now.  Perhaps my
understanding of the relevant standards is incomplete, but I'd read
that as linelen[0] = 0, but the other 4 positions are undefined
and may be not be initialized.
 
> I think it would be even more clear to leave it as
> 
>   die("protocol error: bad line length character: %.4s", linelen);

I actually considered this one, but again I wasn't clear what would
happen in the standard C library when we fed a string that wasn't
actually NUL terminated.  Is the library permitted to call strlen()
before formatting?  If so strlen() could SIGSEGV if we are unlucky
and no NUL is present between our string and the end of the assigned
memory region.

To me, my original version was the most clear, to me and anyone
else who could ever possibly come by to read it.  The "one extra
line of code" is also only in an error condition which never occurs
(but did once due to a bug in the HTTP code, which is why I added
this patch to my series, to help debug it).  Its not like this is
a performance sensitive section of git that Linus is going to come
back and overhaul.

-- 
Shawn.
