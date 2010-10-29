From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Fri, 29 Oct 2010 23:18:52 +0200
Message-ID: <20101029211852.GB5695@home.lan>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
 <1288303712-14662-2-git-send-email-ydirson@altern.org>
 <20101029014540.GB28984@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 23:19:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBwLr-0005rq-4N
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964Ab0J2VTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 17:19:01 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:59425 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932921Ab0J2VTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 17:19:00 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5D9E1D48103;
	Fri, 29 Oct 2010 23:18:53 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBwLc-0005RY-5Q; Fri, 29 Oct 2010 23:18:52 +0200
Content-Disposition: inline
In-Reply-To: <20101029014540.GB28984@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160364>

On Thu, Oct 28, 2010 at 08:45:40PM -0500, Jonathan Nieder wrote:
> Yann Dirson wrote:
> 
> > Possible optimisations to this code include:
> > * avoid use of i_am_not_single by using a separate list
> 
> I think that would help code clarity, too. It is tempting to try to
> split this patch into micropatches:

Hm, I fear too much granularity would become meaningless :)

A number of the steps you suggest (notably 8 and 9) would cause the
code to be plain wrong at some points, since those are part of what
makes the algorithm (appear to be) correct.  This would not be a
problem only because that code would not be reachable throught any
means, right ?  If the code needs to be easier to understand, I'd
rather add some more doc, than added commits that are basically
"useless for bisect".

I'm much more tempted to split into fully-functionnal patches that do
adds reachable code paths (eg. bulk removal - although it's much more
than just a split of the patch).

> 1. introduce DETECT_DIRECTORY_RENAMES flag and hidden UI for it.

What do you mean by "hidden UI" ?

[...]
> 8. disqualify directories with stragglers left behind.
> 
> 9. disqualify directories for which the contents are not unanimous
>    about where to go.

[...]

> Trivial comments on the patch:
> 
> [...]
> > +++ b/diffcore-rename.c
> > @@ -6,14 +6,34 @@
> >  #include "diffcore.h"
> >  #include "hash.h"
> >  
> > +#define DEBUG_BULKMOVE 0
> > +
> > +#if DEBUG_BULKMOVE
> > +#define debug_bulkmove(args) __debug_bulkmove args
> > +void __debug_bulkmove(const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	va_start(ap, fmt);
> > +	fprintf(stderr, "[DBG] ");
> > +	vfprintf(stderr, fmt, ap);
> > +	va_end(ap);
> > +}
> > +#else
> > +#define debug_bulkmove(args) do { /*nothing */ } while (0)
> > +#endif
> 
> Is the debugging output infrequent enough to just use a function
> unconditionally?

You mean, keep funccalls even with DEBUG_BULKMOVE is not set ?  No,
there are too many traces for that.

> [...]
> > + * Supports in-place modification of src by passing dst == src.
> > + */
> > +static const char *copy_dirname(char *dst, const char *src)
> [...]
> > +	end = mempcpy(dst, src, slash - src + 1);
> 
> I suppose this should read:
> 
> 	if (dst != src)
> 		memcpy(dst, src, slash - src + 1);
> 	dst[slash - src + 1] = '\0';
> 	return dst;

Ah, sure the dst==src case can be improved.  But I'm not sure
factorizing writing NUL is worth the cost of re-computing where to put
it when using mempcpy would avoid.  Wouldn't the following be more
adequate ?

	if (dst != src) {
		end = mempcpy(dst, src, slash - src + 1);
		*end = '\0';
	} else
		dst[slash - src + 1] = '\0';
	return dst;

> Style: '{' for functions goes in column 0.

> Can get some depth reduction by dropping the else here (since in
> the trivial case we have already returned).

Right, thanks.

> > +static void diffcore_bulk_moves(void)
> > +{
> > +	int i;
> > +	for (i = 0; i < rename_dst_nr; i++)
> > +		check_one_bulk_move(rename_dst[i].pair);
> > +}
> 
> Yay. :)

Isn't that nice and pretty :)
