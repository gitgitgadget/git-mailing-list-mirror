From: William <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 17:45:03 +0200
Message-ID: <20160531154503.GA24895@Messiaen>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqbn3m7n25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lr1-0005vj-8J
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbcEaPpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:45:08 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52186 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754528AbcEaPpI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 11:45:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CF3A72073;
	Tue, 31 May 2016 17:45:04 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5p_nAe56uiM; Tue, 31 May 2016 17:45:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B74BA2054;
	Tue, 31 May 2016 17:45:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B0C782077;
	Tue, 31 May 2016 17:45:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUZ2l8-_xNGG; Tue, 31 May 2016 17:45:04 +0200 (CEST)
Received: from Messiaen (eduroam-033091.grenet.fr [130.190.33.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 9266E2064;
	Tue, 31 May 2016 17:45:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqbn3m7n25.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295987>

On Mon, May 30, 2016 at 11:34:42PM -0700, Junio C Hamano wrote:
> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> 
>> The API contract is still respected:
>>
>> - The API users may peek strbuf.buf in-place until they perform an
>>   operation that makes it longer (at which point the .buf pointer
>>   may point at a new piece of memory).
> 
> I think the contract is actually a bit stronger; the API reserves
> the right to free and reallocate a smaller chunk of memory if you
> make the string shorter, so peeked value of .buf will not be relied
> upon even if you didn't make it longer.

Right, anytime the string size change
 
>> - The API users may strbuf_detach() to obtain a piece of memory that
>>   belongs to them (at which point the strbuf becomes empty), hence
>>   needs to be freed by the callers.
> 
> Shouldn't you be honuoring another API contract?
> 
>  - If you allow an instance of strbuf go out of scope without taking
>    the ownership of the string by calling strbuf_detach(), you must
>    release the resource by calling strbuf_release().
> 
> As long as your "on stack strbuf" allows lengthening the string
> beyond the initial allocation (i.e. .alloc, not .len), the user of
> the API (i.e. the one that placed the strbuf on its stack) would not
> know when the implementation (i.e. the code in this patch) decides
> to switch to allocated memory, so it must call strbuf_release()
> before it leaves.  Which in turn means that your implementation of
> strbuf_release() must be prepared to be take a strbuf that still has
> its string on the stack.

Well, my implementation does handle a strbuf that still has its
string on the stack: the buffer won't be freed in this case (only a
reset to STRBUF_INIT).
Unless I misunderstood you?

> On the other hand, if your "on stack strbuf" does not allow
> lengthening, I'd find such a "feature" pretty much useless.  The
> caller must always test the remaining capacity, and switch to a
> dynamic strbuf, which is something the caller would expect the API
> implementation to handle silently.  You obviously do not have to
> release the resource in such a case, but that is being convenient
> in the wrong part of the API.
> 
> It would be wonderful if I can do:
> 
> 	void func (void)
>         {
> 		extern void use(char *[2]);
> 		/*
>                  * strbuf that uses 1024-byte on-stack buffer
>                  * initially, but it may be extended dynamically.
>                  */
> 		struct strbuf buf = STRBUF_INIT_ON_STACK(1024);
> 		char *x[2];
> 
> 		strbuf_add(&buf, ...); /* add a lot of stuff */
>                 x[0] = strbuf_detach(&buf, NULL);
> 		strbuf_add(&buf, ...); /* do some stuff */
>                 x[1] = strbuf_detach(&buf, NULL);
> 		use(x);
> 
>                 strbuf_release(&buf);
> 	}
>
> and add more than 2kb with the first add (hence causing buf to
> switch to dynamic scheme), the first _detach() gives the malloc()ed 
> piece of memory to x[0] _and_ points buf.buf back to the on-stack
> buffer (and buf.alloc back to 1024) while setting buf.len to 0,
> so that the second _add() can still work purely on stack as long as
> it does not go beyond the 1024-byte on-stack buffer. 


I think that it's possible, but extends the API beyond what was
originally intended by Michael. I don't see other use cases than treating
several string sequentially, is it worth avoiding a attach_movable() 
(as suggested by Michael in place of wrap_preallocated())?
You could do:

	void func (void)
    {
		extern void use(char *[2]);
		/*
         * strbuf that uses 1024-byte on-stack buffer
         * initially, but it may be extended dynamically.
         */
        char on_stack[1024];
		struct strbuf buf;
 		char x[2];

        strbuf_attach_movable(&sb, on_stack, 0, sizeof(on_stack));
 		strbuf_add(&buf, ...); /* add a lot of stuff */
        x[0] = strbuf_detach(&buf, NULL);
        strbuf_attach_movable(&sb, on_stack, 0, sizeof(on_stack));
 		strbuf_add(&buf, ...); /* do some stuff */
        x[1] = strbuf_detach(&buf, NULL);
 		use(x);
 
        strbuf_release(&buf);
 	}

Which seems pretty close without needing the strbuf API to remember the
original buffer or to even care about memory being on the stack or the
heap.

>> +/**
>> + * Flags
>> + * --------------
>> + */
>> +#define STRBUF_OWNS_MEMORY 1
>> +#define STRBUF_FIXED_MEMORY (1 << 1)
> 
> This is somewhat a strange way to spell two flag bits.  Either spell
> them as 1 and 2 (perhaps in octal or hexadecimal), or spell them as
> 1 shifted by 0 and 1 to the left.  Don't mix the notation.

Noted

>> @@ -20,16 +28,37 @@ char strbuf_slopbuf[1];
>>  
>>  void strbuf_init(struct strbuf *sb, size_t hint)
>>  {
>> +	sb->flags = 0;
>>  	sb->alloc = sb->len = 0;
>>  	sb->buf = strbuf_slopbuf;
>>  	if (hint)
>>  		strbuf_grow(sb, hint);
>>  }
>>  
>> +void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
>> +			      size_t path_buf_len, size_t alloc_len)
>> +{
>> +	if (!path_buf)
>> +		die("you try to use a NULL buffer to initialize a strbuf");
> 
> What does "path" mean in the context of this function (and its
> "fixed" sibling)?

That should be someting like `str` and `str_len` indeed
