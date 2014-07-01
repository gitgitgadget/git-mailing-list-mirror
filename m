From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Tue, 1 Jul 2014 13:18:00 -0400
Message-ID: <20140701171759.GB7282@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625234000.GD23146@sigill.intra.peff.net>
 <CAPig+cSc=A=+PR7oF43yeLpcd4n=Bd1KU1AHPfMKXEu5wAF4Ug@mail.gmail.com>
 <20140630170732.GA16747@sigill.intra.peff.net>
 <xmqqegy5xbiu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:18:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21h0-0001M0-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbaGARSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:18:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:54299 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757138AbaGARSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:18:00 -0400
Received: (qmail 15288 invoked by uid 102); 1 Jul 2014 17:18:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Jul 2014 12:18:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2014 13:18:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegy5xbiu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252728>

On Tue, Jul 01, 2014 at 09:57:13AM -0700, Junio C Hamano wrote:

> Another thing I noticed was that the definition of and the
> commentary on bitset_equal() and bitset_empty() sounded somewhat
> "undecided".  These functions take "max" that is deliberately named
> differently from "num_bits" (the width of the bitsets involved),
> inviting to use them for testing only earlier bits in the bitset as
> long as the caller understands the caveat, but the caveat requires
> that the partial bitset to test must be byte-aligned, which makes it
> not very useful in practice, which means we probably do not want
> them to be used for any "max" other than "num_bits".

Yeah, I added that comment because I found "max" to be confusing, but
couldn't think of a better name. I'm not sure why "num_bits" did not
occur to me, as that makes it completely obvious.

>  * take "num_bits", not "max", to clarify that callers must use them
>    only on the full bitset.

This seems like the right solution to me. Handling partially aligned
bytes adds to the complexity and may hurt performance (in fact, I think
bitset_equal could actually just call memcmp, which I should fix).
That's fine if callers care about that feature, but I actually don't
anticipate any that do.

By the way, I chose "unsigned char" as the storage format somewhat
arbitrarily. Performance might be better with "unsigned int" or even
"unsigned long". It means potentially wasting more space, but not more
than one word (minus a byte) per commit (so about 3MB on linux.git).
I'll try to do some timings to see if it's worth doing.

> In either case, there needs another item in the "caller's responsibility"
> list at the beginning of bitset.h:
> 
>     4. Ensure that padding bits at the end of the bitset array are
>        initialized to 0.

Agreed. That is definitely a requirement I had in mind, but I didn't
think to write it down.

I'll fix both points in the re-roll.

-Peff
