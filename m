From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] refactor dir_add_name
Date: Mon, 11 Jun 2007 09:23:05 -0700
Message-ID: <7vk5uaqx3q.fsf@assigned-by-dhcp.pobox.com>
References: <20070611123045.GA28814@coredump.intra.peff.net>
	<20070611133944.GA7008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxmg4-00036h-4e
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbXFKQXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbXFKQXJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 12:23:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58817 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbXFKQXI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 12:23:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070611162305.FMMN1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 12:23:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AGP41X00S1kojtg0000000; Mon, 11 Jun 2007 12:23:05 -0400
In-Reply-To: <20070611133944.GA7008@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jun 2007 09:39:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49863>

Jeff King <peff@peff.net> writes:

> If we like the alloc_grow approach, there are a lot of places where we
> can drop a 3-5 line conditional into a single line. I find it much more
> readable, but others may disagree.

I like the readability, but

>  cache.h |    6 ++++++
>  dir.c   |   23 +++++++++++------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 5e7381e..f771519 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -224,6 +224,12 @@ extern void verify_filename(const char *prefix, const char *name);
>  extern void verify_non_filename(const char *prefix, const char *name);
>  
>  #define alloc_nr(x) (((x)+16)*3/2)
> +#define alloc_grow(x, nr, alloc) do { \
> +	if(nr >= alloc) { \
> +		alloc = alloc_nr(alloc); \
> +		x = xrealloc((x), alloc * sizeof(*(x))); \
> +	} \
> +} while(0)

worry a bit about macro safety.  I think the presence of an
assignment to alloc and x would make sure we would catch an
error to pass non lvalue as 'alloc' and 'x', so it may be Ok as
is.  A comment before the macro, and a space between 'if' and
opening parenthesis, would be good things to have.
