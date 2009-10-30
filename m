From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Fri, 30 Oct 2009 13:57:41 -0400
Message-ID: <20091030175741.GC18583@coredump.intra.peff.net>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
 <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
 <20091029151152.GX10505@spearce.org>
 <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
 <20091029215829.GD10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3vkR-0001Qf-W4
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbZJ3R5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbZJ3R5q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:57:46 -0400
Received: from peff.net ([208.65.91.99]:51830 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932730AbZJ3R5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 13:57:46 -0400
Received: (qmail 1903 invoked by uid 107); 30 Oct 2009 18:01:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 14:01:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 13:57:41 -0400
Content-Disposition: inline
In-Reply-To: <20091029215829.GD10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131721>

On Thu, Oct 29, 2009 at 02:58:29PM -0700, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > > The NUL assignment isn't about safe_read(), its about making the
> > > block of 4 bytes read a proper C-style string so we can safely pass
> > > it down into the snprintf that is within die().
> > 
> > I knew and understood all of what you just said.  static linelen[] is not
> > about stack allocation.  It's about letting the compiler initialize it to
> > five NULs so that you do not have to assign NUL to its fifth place before
> > you die.  This removes one added line from your patch.
> 
> Thanks, I get it now.  Patch amended.

I am just a bystander, so maybe my opinion is not worth anything, but
personally I think you are obfuscating the code to save a single line.
When I see a static variable, I assume it is because the value should be
saved from invocation to invocation, and now I will spend time wondering
why that would be the case here.

If you really just want to initialize to zero, using

  char linelen[5] = { 0 };

should be sufficient (I think all of the compilers we care about support
such incomplete array assignments, right?).

I think it would be even more clear to leave it as

  char linelen[4];

which declares how the data is _actually_ expected to be used, and then
do:

  die("protocol error: bad line length character: %.4s", linelen);

-Peff

PS All of the proposals also suffer from the fact that die will truncate
broken output at a NUL sent by the remote. Probably OK, since we are
expecting ascii hex or some variant, and if we don't correctly print
what the remote said in a totally broken NUL-filled case, it is not that
big a deal.
