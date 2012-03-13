From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 17:03:57 -0400
Message-ID: <20120313210357.GC27436@sigill.intra.peff.net>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <4F57D18B.5090506@lsrfire.ath.cx>
 <7vzkbskr71.fsf@alter.siamese.dyndns.org>
 <4F58F06A.1070108@lsrfire.ath.cx>
 <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
 <CABURp0oVn3s27Rtq2JQeLBgcXq1-R-=0qawcXVMxZ8qgOeZGkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:04:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Yt5-0001N8-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab2CMVEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 17:04:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab2CMVEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:04:00 -0400
Received: (qmail 2057 invoked by uid 107); 13 Mar 2012 21:04:11 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 17:04:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 17:03:57 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0oVn3s27Rtq2JQeLBgcXq1-R-=0qawcXVMxZ8qgOeZGkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193068>

On Mon, Mar 12, 2012 at 05:37:57PM -0400, Phil Hord wrote:

> Subject: [PATCH] Appease compiler pedantry with an extra cast
> 
> Recently git repurposed a pointer as an integer to hold some
> counter which git fancies.
> 
> Casting directly from 'pointer' to 'int' ((int)(void*)&x) causes a
> possible size mismatch because pointers can be bigger than ints.
> In such a situation, the compiler complains:
> 
>    warning: cast from pointer to integer of different size
>             [-Wpointer-to-int-cast]

Yeah, I've been seeing the same warning on my x86_64 box, and came up
with the same fix. However...

> Cast the value through intptr_t first to quell compiler complaints
> about how this gun appears to be aimed near our feet.  Then cast this
> value to an int; this path assures the compiler we are smarter than we
> look, or at least that we intend to aim the gun this way for a reason.

This feels so hacky.  One of the callsites does:

    elem->util = (void*)((intptr_t)(util_as_int(elem) + 1));

which will truncate the value down to an int before replacing it back in
the void pointer. And that truncation is ultimately what the compiler is
warning about, and what we are sneaking around with the extra cast
(because casting between integer sizes of different types is OK, even
though it can cause truncation).

I don't think the truncation is a problem in practice, but it just feels
like we are not just silencing an over-zealous compiler, but actually
burying type-size assumption behind a set of four (4!) casts.

I wonder if we would be happier to declare the "util" field of
string_list as a union. Obviously that provides no safety that we read
the correct item out of the union, but that is no worse than the
situation with all of these casts, and I suspect the result would be
much more obvious and readable.

The downside is that all current users of the "util" field would need
s/util/&.ptr/ or similar to dereference the pointer field.

-Peff
