From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 13:40:33 -0700
Message-ID: <20090430204033.GV23604@spearce.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzd3h-0008CV-LA
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 22:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZD3Ukf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZD3Ukd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 16:40:33 -0400
Received: from george.spearce.org ([209.20.77.23]:57144 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZD3Ukd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 16:40:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A53E638075; Thu, 30 Apr 2009 20:40:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <86iqkllw0c.fsf@broadpark.no>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118046>

Kjetil Barvik <barvik@broadpark.no> wrote:
> * "Shawn O. Pearce" <spearce@spearce.org> writes:
>  <snipp>
> | - Avoid allocating byte[] for SHA-1s, instead we convert to 5 ints,
> |   which can be inlined into an object allocation.
> 
>   What to pepole think about doing something simmilar in C GIT?
> 
>   That is, convert the current internal representation of the SHA-1 from
>   "unsigned char sha1[20]" to "unsigned long sha1[5]"?

Its not worth the code churn.
 
>   Ok, I currently see 2 problems with it:
> 
>      1) Will the type "unsigned long" always be unsigned 32 bit on all
>         platforms on all computers?  do we need an "unit_32_t" thing?

Yea, "unsigned long" isn't always 32 bits.  So we'd need to use
uint32_t.  Which we already use elsewhere, but still.
 
>      2) Can we get in truble because of differences between litle- and
>         big-endian machines?

Yes, especially if compare was implemented using native uint32_t
compare and the processor was little-endian.

>      4) The "static inline void hashcpy(....)" in cache.h could then
>         maybe be written like this:

Its already done as "memcpy(a, b, 20)" which most compilers will
inline and probably reduce to 5 word moves anyway.  That's why
hashcpy() itself is inline.
 
-- 
Shawn.
