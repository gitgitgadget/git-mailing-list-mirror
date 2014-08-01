From: Jeff King <peff@peff.net>
Subject: Re: struct hashmap_entry packing
Date: Fri, 1 Aug 2014 18:37:39 -0400
Message-ID: <20140801223739.GA15649@peff.net>
References: <20140728171743.GA1927@peff.net>
 <53D806AC.3070806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLSQ-0006WL-NR
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbaHAWhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:37:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:44507 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbaHAWhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 18:37:46 -0400
Received: (qmail 14392 invoked by uid 102); 1 Aug 2014 22:37:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 17:37:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 18:37:39 -0400
Content-Disposition: inline
In-Reply-To: <53D806AC.3070806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254678>

On Tue, Jul 29, 2014 at 10:40:12PM +0200, Karsten Blees wrote:

> > The sizeof() has to be the same regardless of whether the hashmap_entry
> > is standalone or in another struct, and therefore must be padded up to
> > 16 bytes. If we stored "x" in that padding in the combined struct, it
> > would be overwritten by our memset.
> > 
> 
> The struct-packing patch was ultimately dropped because there was no way
> to reliably make it work on all platforms. See [1] for discussion, [2] for
> the final, 'most compatible' version.

Thanks for the pointers; I should have guessed there was more to it and
searched the archive myself.

> Hmmm. Now that we have "__attribute__((packed))" in pack-bitmap.h, perhaps
> we should do the same for stuct hashmap_entry? (Which was the original
> proposal anyway...). Only works for GCC, but that should cover most builds
> / platforms.

I don't see any reason to avoid the packed attribute, if it helps us. As
you noted, anything using __attribute__ probably supports it, and if
not, we can conditionally #define PACKED_STRUCT or something, like we do
for NORETURN. Since it's purely an optimization, if another compiler
doesn't use it, no big deal.

That being said, I don't know if those padding bytes are actually
causing a measurable slowdown. It may not even be worth the trouble.

> Btw.: Using struct-packing on 'struct bitmap_disk_entry' means that the
> binary format of .bitmap files is incompatible between GCC and other
> builds, correct?

The on-disk format is defined by JGit; if there are differences between
the builds, that's a bug (and I would not be too surprised if there is
one, as bitmaps have gotten very extensive testing on 32- and 64-bit
gcc, but probably not much elsewhere).

We do use structs to represent disk structures in other bits of the
packfile code (e.g., struct pack_idx_header), but the struct is vanilla
enough that we assume every compiler gives us two tightly-packed 32-bit
integers without having to bother with the "packed" attribute (and it
seems to have worked in practice).

We should probably be more careful with that bitmap code. It looks like
it wouldn't be too bad to drop it. I'll see if I can come up with a
patch.

-Peff
