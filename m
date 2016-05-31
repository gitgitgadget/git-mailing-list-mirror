From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 18:08:56 +0200
Message-ID: <20160531160856.GC24895@Messiaen>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqbn3m7n25.fsf@gitster.mtv.corp.google.com>
 <20160531154503.GA24895@Messiaen>
 <vpq4m9eql2k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 18:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7mE4-0005IQ-DO
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbcEaQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 12:09:00 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52069 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbcEaQI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 12:08:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7AACA2415;
	Tue, 31 May 2016 18:08:57 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnGBKFNrpToS; Tue, 31 May 2016 18:08:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 697A7222F;
	Tue, 31 May 2016 18:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 639482077;
	Tue, 31 May 2016 18:08:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0w8FmpVw3aY; Tue, 31 May 2016 18:08:57 +0200 (CEST)
Received: from Messiaen (eduroam-033091.grenet.fr [130.190.33.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 47BA32064;
	Tue, 31 May 2016 18:08:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpq4m9eql2k.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295992>

On Tue, May 31, 2016 at 05:54:59PM +0200, Matthieu Moy wrote:
> William <william.duclot@ensimag.grenoble-inp.fr> writes:
> 
> > On Mon, May 30, 2016 at 11:34:42PM -0700, Junio C Hamano wrote:
> >
> >> As long as your "on stack strbuf" allows lengthening the string
> >> beyond the initial allocation (i.e. .alloc, not .len), the user of
> >> the API (i.e. the one that placed the strbuf on its stack) would not
> >> know when the implementation (i.e. the code in this patch) decides
> >> to switch to allocated memory, so it must call strbuf_release()
> >> before it leaves.  Which in turn means that your implementation of
> >> strbuf_release() must be prepared to be take a strbuf that still has
> >> its string on the stack.
> >
> > Well, my implementation does handle a strbuf that still has its
> > string on the stack: the buffer won't be freed in this case (only a
> > reset to STRBUF_INIT).
> > Unless I misunderstood you?
> 
> I think Junio meant:
> 
> void f()
> {
> 	struct strbuf sb;
> 	char buf[N];
> 	strbuf_wrap_preallocated(&sb, buf, ...);
> 	strbuf_add(&sb, ...);
> 
> 	// is it safe to just let sb reach the end of its scope?
> }
> 
> To answer the last question, the user would need to know too much about
> the allocation policy, so in this case the user should call
> strbuf_release(), and let it chose whether to call "free()"
> (OWNS_MEMORY) or not. This is OK with your implementation, but the doc
> needs to reflect this.

Okay, I understand. The idea was that the only change in the API is the
initialization: the API user can then use the strbuf like they could
before this patch, with the same responsabilities (having to release the
strbuf when they don't need it anymore).
Maybe a clearer documentation about the life and death of a strbuf
(initialization, use and release) would be useful, yes
