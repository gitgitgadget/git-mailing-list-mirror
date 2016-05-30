From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 16:34:43 +0200
Message-ID: <vpqpos38vi4.fsf@anie.imag.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
	<vpqlh2remhy.fsf@anie.imag.fr>
	<1639412597.204503.1464617754937.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 16:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7OHS-0000cY-GR
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933406AbcE3Oey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:34:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48576 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933107AbcE3Oex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 10:34:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4UEYfMA017843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 16:34:41 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UEYhGG006058;
	Mon, 30 May 2016 16:34:43 +0200
In-Reply-To: <1639412597.204503.1464617754937.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 30 May 2016 16:15:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 30 May 2016 16:34:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UEYfMA017843
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465223685.85123@bUYFXtVJ28+rO23PQo5Znw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295902>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> void strbuf_grow(struct strbuf *sb, size_t extra)
>> {
>> 	int new_buf = !sb->alloc;
>> ...
>> 	if (sb->flags & STRBUF_OWNS_MEMORY) {
>> 		if (new_buf) // <---------------------------------------- (1)
>> 			sb->buf = NULL;
>> 		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>> 	} else {
>> 		/*
>> 		 * The strbuf doesn't own the buffer: to avoid to realloc it,
>> 		 * the strbuf needs to use a new buffer without freeing the old
>> 		 */
>> 		if (sb->len + extra + 1 > sb->alloc) {
>> 			size_t new_alloc = MAX(sb->len + extra + 1, alloc_nr(sb->alloc));
>> 			char *buf = xmalloc(new_alloc);
>> 			memcpy(buf, sb->buf, sb->alloc);
>> 			sb->buf = buf;
>> 			sb->alloc = new_alloc;
>> 			sb->flags |= STRBUF_OWNS_MEMORY;
>> 		}
>> 	}
>> 
>> 	if (new_buf) // <---------------------------------------- (2)
>> 		sb->buf[0] = '\0';
>> }
>> 
>> I think (1) is now dead code, since sb->alloc == 0 implies that
>> STRBUF_OWNS_MEMORY is set. (2) seems redundant since you've just
>> memcpy-ed the existing '\0' into the buffer.
>
> You're right for (1), I hadn't noticed that.
> For (2), we'll still have to set sb->buf[new_alloc-1]='\0' after the memcpy, if we
> have sb->alloc==0 then the memcpy won't copy it.

That sounds like one more reason to memcpy len + 1 bytes, and you'll get
the '\0' copied.

>> After your patch, there are differences between
>> strbuf_wrap_preallocated() which I think are inconsistencies:
>> 
>> * strbuf_attach() does not check for NULL buffer, but it doesn't accept
>>   them either if I read correctly. It would make sense to add the check
>>   to strbuf_attach(), but it's weird to have the performance-critical
>>   oriented function do the expensive stuff that the
>>   non-performance-critical one doesn't.
>
> I agree that strbuf_attach should do the check (it seems strange that it
> doesn't already do it, as the "buffer never NULL" invariant is not new).
> I don't understand your "but" part, what "expensive stuff" are you talking
> about?

"expensive stuff" was an exageration for "== NULL" test. It's not that
expensive, but costs a tiny bit of CPU time.

> xmemdupz can only allocate the same size it will copy.

Indeed, so forget about it.

>>> +/**
>>> + * Allow the caller to give a pre-allocated piece of memory for the strbuf
>>> + * to use and indicate that the strbuf must use exclusively this buffer,
>>> + * never realloc() it or allocate a new one. It means that the string can
>>> + * be manipulated but cannot overflow the pre-allocated buffer. The
>>> + * pre-allocated buffer will never be freed.
>>> + */
>> 
>> Perhaps say explicitly that although the allocated buffer has a fixed
>> size, the string itself can grow as long as it does not overflow the
>> buffer?
>
> That's what I meant by "the string can be manipulated but cannot overflow
> the pre-allocated buffer". I'll try to reformulate

Maybe "the string can grow, but cannot overflow"?

>>> @@ -91,6 +116,8 @@ extern void strbuf_release(struct strbuf *);
>>>   * Detach the string from the strbuf and returns it; you now own the
>>>   * storage the string occupies and it is your responsibility from then on
>>>   * to release it with `free(3)` when you are done with it.
>>> + * Must allocate a copy of the buffer in case of a preallocated/fixed
>>> buffer.
>>> + * Performance-critical operations have to be aware of this.
>> 
>> Better than just warn about performance, you can give the alternative.
>
> I'm not sure what you mean, I don't think there really is an alternative for
> detaching a string?

So, is the comment above saying "You're doomed, there's no way you can
get good performance anyway"?

The alternative is just that you don't have to call strbuf_release since
the caller can access the .buf field and is already the one responsible
for freeing it when needed, and it's safe to just call strbuf_init() if
one needs to re-initialize the stbuf structure.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
