From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Fri, 3 Jun 2016 16:04:44 +0200
Message-ID: <20160603140444.GA3903@Messiaen>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <vpqlh2remhy.fsf@anie.imag.fr>
 <574D0D99.6080303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 03 16:05:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8piY-0002PP-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 16:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbcFCOEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 10:04:50 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:37700 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961AbcFCOEu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 10:04:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D32D22584;
	Fri,  3 Jun 2016 16:04:46 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItwUPJHQNSFf; Fri,  3 Jun 2016 16:04:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C2EF62583;
	Fri,  3 Jun 2016 16:04:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id BCFE72077;
	Fri,  3 Jun 2016 16:04:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JRQ1zZzYQp8B; Fri,  3 Jun 2016 16:04:46 +0200 (CEST)
Received: from Messiaen (eduroam-033140.grenet.fr [130.190.33.140])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 35C812066;
	Fri,  3 Jun 2016 16:04:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <574D0D99.6080303@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296330>

On Tue, May 31, 2016 at 06:05:45AM +0200, Michael Haggerty wrote:
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
> 
> [...]
> 
>                                                 The functions might be
> named more like `strbuf_attach()` to emphasize their similarity to that
> existing function. Maybe
> 
>     strbuf_attach_fixed(struct strbuf *sb, void *s, size_t len, size_t
> alloc);
>     strbuf_attach_movable(struct strbuf *sb, void *s, size_t len, size_t
> alloc);

Now that I am looking in detail into it, I am not so convinced by those
names. Using "attach" suggests the same behavior as strbuf_attach(),
which is _not_ the case to me:
    - The aim of the attach() function is to give ownership of a
      buffer allocated by the caller to the strbuf.
    - The aim of the wrap() functions is to give the right to use a
      buffer allocated by the caller to the strbuf, while keeping
      ownership.
    - For completion: the aim of the init() function is to let the
      strbuf manage its own buffer.

I think that it is important to distinct those 3 use cases for the API user
to be able to understand. And to describe this API extension, "wrap"
seems clear to me.
Another point that would makes me skeptical about using
`strbuf_attach_preallocated()` is that the real difference with
`strbuf_attach()` isn't in the allocation of the buffer parameter, it is
in the ownership. Both takes a buffer allocated by the user as
parameter (so a preallocated buffer), even thought
`strbuf_attach_preallocated()` may use a stack-allocated one.

So I come to the conclusion that even using the word "preallocated" may
not be such a good idea, as even strbuf_attach() use a preallocated
buffer. What I think would be the clearer would be:

    - strbuf_attach()       (unchanged)
    - strbuf_wrap()         (no need for the "preallocated")
    - strbuf_wrap_fixed()
    - STRBUF_WRAP   
    - STRBUF_WRAP_FIXED

The two last ones would be macros, equivalent to the functions except
that they don't release the strbuf before initializing it.

What do you think about this?
