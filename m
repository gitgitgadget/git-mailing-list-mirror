From: Jeff King <peff@peff.net>
Subject: Re: struct hashmap_entry packing
Date: Tue, 5 Aug 2014 14:51:37 -0400
Message-ID: <20140805185137.GB10369@peff.net>
References: <20140728171743.GA1927@peff.net>
 <53D806AC.3070806@gmail.com>
 <20140801223739.GA15649@peff.net>
 <53DFDCE2.9060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:51:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjpu-0005V1-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbaHESvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:51:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:46497 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754222AbaHESvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:51:41 -0400
Received: (qmail 30472 invoked by uid 102); 5 Aug 2014 18:51:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Aug 2014 13:51:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Aug 2014 14:51:37 -0400
Content-Disposition: inline
In-Reply-To: <53DFDCE2.9060406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254822>

On Mon, Aug 04, 2014 at 09:20:02PM +0200, Karsten Blees wrote:

> > I don't see any reason to avoid the packed attribute, if it helps us. As
> > you noted, anything using __attribute__ probably supports it, and if
> > not, we can conditionally #define PACKED_STRUCT or something, like we do
> > for NORETURN. Since it's purely an optimization, if another compiler
> > doesn't use it, no big deal.
> > 
> > That being said, I don't know if those padding bytes are actually
> > causing a measurable slowdown. It may not even be worth the trouble.
> > 
> 
> Its not about performance (or correctness, in case of platforms that don't
> support unaligned read), just about saving memory (e.g. mapping int to int
> requires 24 bytes per entry, vs. 16 with packed structs).

The biggest things we might map are probably one entry per-object. So in
a repository like linux.git, we're talking about 32MB in the worst case.
That's not nothing, but it's also not the end of the world. I'd be more
concerned with how that trashes the cache (and consequently causes
slowdown) than somebody running out of memory.

So my general opinion is that if it's easy to get the space back, great.
But if it creates a maintenance hassle, it's not worth the effort.

That said, I really don't think it would be much maintenance hassle to
mark the hashmap_entry as packed, and compilers can either handle it or
not.

-Peff
