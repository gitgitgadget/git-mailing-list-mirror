From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] refactor dir_add_name
Date: Mon, 11 Jun 2007 15:46:51 -0400
Message-ID: <20070611194651.GA15309@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133944.GA7008@coredump.intra.peff.net> <7vk5uaqx3q.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxpqz-0007Na-0F
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbXFKTqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbXFKTqy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:46:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1162 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbXFKTqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:46:54 -0400
Received: (qmail 5832 invoked from network); 11 Jun 2007 19:47:05 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 19:47:05 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 15:46:51 -0400
Content-Disposition: inline
In-Reply-To: <7vk5uaqx3q.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49877>

On Mon, Jun 11, 2007 at 09:23:05AM -0700, Junio C Hamano wrote:

> > +#define alloc_grow(x, nr, alloc) do { \
> > +	if(nr >= alloc) { \
> > +		alloc = alloc_nr(alloc); \
> > +		x = xrealloc((x), alloc * sizeof(*(x))); \
> > +	} \
> > +} while(0)
> 
> worry a bit about macro safety.  I think the presence of an

Agreed. The multiple evaluation of 'x' means that growing foo[i++] will
cause quite a confusing bug. I would prefer it as an inline, but at
least the sizeof requires macro magic. Not to mention the ugliness of
moving all those lvalues as pointers. But we could do something like
(totally untested):

#define alloc_grow(x, nr, alloc) \
  alloc_grow_helper(&(x), nr, &(alloc), sizeof(*(x)))

inline
void alloc_grow_helper(void **x, int nr, int *alloc, int size)
{
  if (nr >= *alloc) {
    *alloc = alloc_nr(*alloc);
    *x = xrealloc(*x, *alloc * size);
  }
}

Horribly ugly (I'm seeing stars!) but probably a bit safer in the long
run, and nobody needs to look at it most of the time. :)

What do you think?

> assignment to alloc and x would make sure we would catch an
> error to pass non lvalue as 'alloc' and 'x', so it may be Ok as

Even lvalues can have side effects, so multiple evaluation is still a
problem.

> is.  A comment before the macro, and a space between 'if' and
> opening parenthesis, would be good things to have.

Yes, sorry, my fingers are always forgetting the git whitespace
conventions. I (or Jonas) will submit a better commented version, but do
let us know which version you like.

-Peff
