From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 03:57:25 -0400
Message-ID: <20071019075725.GA29436@coredump.intra.peff.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IimmS-0001T3-VH
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966828AbXJSH5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 03:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966803AbXJSH5c
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 03:57:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3754 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966795AbXJSH52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 03:57:28 -0400
Received: (qmail 10238 invoked by uid 111); 19 Oct 2007 07:57:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 03:57:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 03:57:25 -0400
Content-Disposition: inline
In-Reply-To: <20071019073938.GN14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61666>

On Fri, Oct 19, 2007 at 03:39:39AM -0400, Shawn O. Pearce wrote:

> What about this on top of Jeff's patch?
> 
> $ git fetch jc
> ...
> ==> git://repo.or.cz/alt-git.git
>  * tag junio-gpg-pub ......................... (new)
>  * tag v1.5.0 .......................... (tag moved)

Honestly, I find it a bit ugly with the dots.

> $ git fetch me
> ...
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> spearce/gitk ............... (new)
>  * branch maint -> spearce/maint
>  * branch master -> spearce/master
>  * branch next -> spearce/next
>  * branch pu -> spearce/pu ......... (forced update)
>  * branch todo -> spearce/todo ............... (new)

More so with the ragged right of the branch names. I think it would
probably look better to line up the columns, but that will eventually
look ugly when somebody tries to fetch sp/totally-annoying-branchname.

I also think having the dots for some lines and others looks awkward.

> The width of the terminal is computed to produce the ... padding.
> I used a very narrow terminal to produce the above so it doesn't
> linewrap badly in email.  If we cannot get the terminal width then
> we just don't produce the padding.

Ugh. I strongly suspect that it would look ugly on anything bigger than
about 80 columns, anyway. You are probably better off just not worrying
about the terminal width, and always using an 80-ish column total. And
then you don't have to worry about the ugly ioctl call.

> We also only show the URL once now, and only if at least one ref
> was somehow changed.  This way we avoid showing the URL on a no-op
> or twice when we are fetching tags too.

Much nicer, and I like the refactoring into a separate show_update
function (especially if somebody ends up adding color later).

> +			show_update("* branch", note, "->", "FETCH_HEAD", NULL);

Hrm, btw, I can't seem to get this one to show (I was curious how ugly
the FETCH_HEAD would look).

>  		if (verbose)
> -			fprintf(stderr, " - %s == %s\n",
> -				note, pretty_ref);
> +			show_update("-", note, "==", pretty_ref, "unchanged");
>  		return 0;

Also, I was unable to generate a test case that showed this one. Did
you?

> -			msg = "storing tag";
> [...]
> +			msg = "storing new tag";

Nice.

> +		show_update("- branch", note, "->", pretty_ref, "non-fast forward, refused");

Line wrap?

> +static void determine_window_size(void)
> +{
> +	struct winsize ws;
> +	if (!ioctl(2, TIOCGWINSZ, &ws))
> +		ws_cols = ws.ws_col;
> +}
> +

Ugh. How portable is this?

-Peff
