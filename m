From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 17:59:47 +0200
Message-ID: <20160531155947.GB24895@Messiaen>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <vpqlh2remhy.fsf@anie.imag.fr>
 <574D0D99.6080303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 31 18:00:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7m5J-0007gx-E4
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbcEaP74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:59:56 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:38870 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbcEaP74 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 11:59:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 069E72415;
	Tue, 31 May 2016 17:59:48 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCB0JnKG2okt; Tue, 31 May 2016 17:59:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EAF3C222F;
	Tue, 31 May 2016 17:59:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E51FB2077;
	Tue, 31 May 2016 17:59:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wT2E8U4ntyby; Tue, 31 May 2016 17:59:47 +0200 (CEST)
Received: from Messiaen (eduroam-033091.grenet.fr [130.190.33.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C2A752064;
	Tue, 31 May 2016 17:59:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <574D0D99.6080303@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295990>

On Tue, May 31, 2016 at 06:05:45AM +0200, Michael Haggerty wrote:
> On 05/30/2016 02:52 PM, Matthieu Moy wrote:
> > [...]
> 
> I feel bad bikeshedding about names, especially since you took some of
> the original names from my RFC. But names are very important, so I think
> it's worth considering whether the current names could be improved upon.
> 
> When reading this patch series, I found I had trouble remembering
> whether "preallocated" meant "preallocated and movable" or "preallocated
> and immovable". So maybe we should brainstorm alternatives to
> "preallocated" and "fixed". For example,
> 
> * "growable"/"fixed"? Seems OK, though all strbufs are growable at least
> to the size of their initial allocation, so maybe "growable" is misleading.
> 
> * "movable"/"fixed"? This maybe better captures the essence of the
> distinction. I'll use those names below for concreteness, without
> claiming that they are the best.

Yes, the names are debatable

> > * strbuf_attach() calls strbuf_release(), which allows reusing an
> >   existing strbuf. strbuf_wrap_preallocated() calls strbuf_init which
> >   would override silently any previous content. I think strbuf_attach()
> >   does the right thing here.
> 
> Hmmm....
> 
> I think the best way to answer these questions is to think about use
> cases and make them as easy/consistent as possible.
> 
> I expect that a very common use of strbuf_wrap_fixed() will be to wrap a
> stack-allocated string, like
> 
>     char pathbuf[PATH_MAX];
>     struct strbuf path;
> 
>     strbuf_wrap_fixed(&path, pathbuf, 0, sizeof(pathbuf));
> 
> In this use case, it would be a shame if `path` had to be initialized to
> STRBUF_INIT just because `strbuf_wrap_fixed()` calls `strbuf_release()`
> internally.
> 
> But maybe we could make this use case easier still. If there were a macro
> 
>     #define STRBUF_FIXED_WRAPPER(sb, buf, len) { STRBUF_FIXED_MEMORY,
> sizeof(buf), (len), (buf) }
> 
> then we could write
> 
>     char pathbuf[PATH_MAX];
>     struct strbuf path = STRBUF_FIXED_WRAPPER(pathbuf, 0);
> 
> I think that would be pretty usable. One would have to be careful only
> to wrap arrays and not `char *` pointers, because `sizeof` wouldn't work
> on the latter. The BARF_UNLESS_AN_ARRAY macro could be used here to add
> a little safety.

That sounds like a good idea to me

> [...]
> If you provide macro forms like these for initializing strbufs, then I
> agree with Matthieu that the analogous functional forms should probably
> call strbuf_release() before wrapping the array. The functions might be
> named more like `strbuf_attach()` to emphasize their similarity to that
> existing function. Maybe
> 
>     strbuf_attach_fixed(struct strbuf *sb, void *s, size_t len, size_t
> alloc);
>     strbuf_attach_movable(struct strbuf *sb, void *s, size_t len, size_t
> alloc);

I'm not a big fan of the idea that the macro and the function don't have
the same behavior. Using "attach" instead of "wrap" or "init" may
justify that
