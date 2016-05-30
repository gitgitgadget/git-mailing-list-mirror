From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 17:16:44 +0200 (CEST)
Message-ID: <131406846.207070.1464621404690.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr> <vpqlh2remhy.fsf@anie.imag.fr> <1639412597.204503.1464617754937.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqpos38vi4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 17:09:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Oos-0000u2-HV
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 17:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbcE3PJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 11:09:20 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48290 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736AbcE3PJT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 11:09:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EC56020AA;
	Mon, 30 May 2016 17:09:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wtotsZQy8vS; Mon, 30 May 2016 17:09:16 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DA55920A5;
	Mon, 30 May 2016 17:09:16 +0200 (CEST)
In-Reply-To: <vpqpos38vi4.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: strbuf: allow to use preallocated memory
Thread-Index: ZXIuyvkEISnkjDHdzgF13fgOKFpIrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295905>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> 
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>> +/**
>>>> + * Allow the caller to give a pre-allocated piece of memory for the
>>>> strbuf
>>>> + * to use and indicate that the strbuf must use exclusively this buffer,
>>>> + * never realloc() it or allocate a new one. It means that the string
>>>> can
>>>> + * be manipulated but cannot overflow the pre-allocated buffer. The
>>>> + * pre-allocated buffer will never be freed.
>>>> + */
>>> 
>>> Perhaps say explicitly that although the allocated buffer has a fixed
>>> size, the string itself can grow as long as it does not overflow the
>>> buffer?
>>
>> That's what I meant by "the string can be manipulated but cannot overflow
>> the pre-allocated buffer". I'll try to reformulate
> 
> Maybe "the string can grow, but cannot overflow"?

Seems OK

>>>> @@ -91,6 +116,8 @@ extern void strbuf_release(struct strbuf *);
>>>>   * Detach the string from the strbuf and returns it; you now own the
>>>>   * storage the string occupies and it is your responsibility from then
>>>>   on
>>>>   * to release it with `free(3)` when you are done with it.
>>>> + * Must allocate a copy of the buffer in case of a preallocated/fixed
>>>> buffer.
>>>> + * Performance-critical operations have to be aware of this.
>>> 
>>> Better than just warn about performance, you can give the alternative.
>>
>> I'm not sure what you mean, I don't think there really is an alternative
>> for
>> detaching a string?
> 
> So, is the comment above saying "You're doomed, there's no way you can
> get good performance anyway"?
> 
> The alternative is just that you don't have to call strbuf_release since
> the caller can access the .buf field and is already the one responsible
> for freeing it when needed, and it's safe to just call strbuf_init() if
> one needs to re-initialize the stbuf structure.

Actually, if the user _needs_ to detach(), then yes he's doomed. Or more
realistically, he have to refactor so he'll don't need detach() (by being
sure the strbuf is pre-allocated by himself for example).
The strbuf_release() function is not the problem here, it does nothing
problematic for performances. The problem is strbuf_wrap_preallocated(),
but you're right I can add a comment so the user know when he don't have
to call it.
