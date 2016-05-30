From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 15:20:53 +0200 (CEST)
Message-ID: <953965621.202433.1464614453377.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr> <alpine.DEB.2.20.1605301326530.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 30 15:13:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7N0f-0000W2-FN
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 15:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbcE3NNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 09:13:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:43880 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161029AbcE3NN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 09:13:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5A64920B1;
	Mon, 30 May 2016 15:13:26 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ts2yqa8SWTsy; Mon, 30 May 2016 15:13:26 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 468B420AE;
	Mon, 30 May 2016 15:13:26 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1605301326530.4449@virtualbox>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: strbuf: allow to use preallocated memory
Thread-Index: nBwHV0UoAsW3WHzN67DggED8Sibcpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295892>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Mon, 30 May 2016, William Duclot wrote:
> 
>> It is unfortunate that it is currently impossible to use a strbuf
>> without doing a memory allocation. So code like
>> 
>> void f()
>> {
>>     char path[PATH_MAX];
>>     ...
>> }
>> 
>> typically gets turned into either
>> 
>> void f()
>> {
>>     struct strbuf path;
>>     strbuf_add(&path, ...); <-- does a malloc
>>     ...
>>     strbuf_release(&path);  <-- does a free
>> }
>> 
>> which costs extra memory allocations, or
>> 
>> void f()
>> {
>>     static struct strbuf path;
>>     strbuf_add(&path, ...);
>>     ...
>>     strbuf_setlen(&path, 0);
>> }
>> 
>> which, by using a static variable, avoids most of the malloc/free
>> overhead, but makes the function unsafe to use recursively or from
>> multiple threads. Those limitations prevent strbuf to be used in
>> performance-critical operations.
> 
> This description is nice and verbose, but maybe something like this would
> introduce the subject in a quicker manner?
> 
> 	When working e.g. with file paths or with dates, strbuf's
> 	malloc()/free() dance of strbufs can be easily avoided: as
> 	a sensible initial buffer size is already known, it can be
> 	allocated on the heap.

strbuf already allow to indicate a sensible initial buffer size thanks
to strbuf_init() second parameter. The main perk of pre-allocation
is to use stack-allocated memory, and not heap-allocated :)
Unless I misunderstood your message?

>> diff --git a/strbuf.c b/strbuf.c
>> index 1ba600b..527b986 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -1,6 +1,14 @@
>>  #include "cache.h"
>>  #include "refs.h"
>>  #include "utf8.h"
>> +#include <sys/param.h>
> 
> Why?

For the MAX macro. It may be a teeny tiny overkill

>> +/**
>> + * Flags
>> + * --------------
>> + */
>> +#define STRBUF_OWNS_MEMORY 1
>> +#define STRBUF_FIXED_MEMORY (1 << 1)
> 
> From reading the commit message, I expected STRBUF_OWNS_MEMORY.
> STRBUF_FIXED_MEMORY still needs to be explained.

Yes, that seems right

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
>> +
>> +	strbuf_init(sb, 0);
>> +	strbuf_attach(sb, path_buf, path_buf_len, alloc_len);
>> +	sb->flags &= ~STRBUF_OWNS_MEMORY;
>> +	sb->flags &= ~STRBUF_FIXED_MEMORY;
> 
> Shorter: sb->flags &= ~(STRBUF_OWNS_MEMORY | STRBUF_FIXED_MEMORY);

Okay with me

>> +}
>> +
>> +void strbuf_wrap_fixed(struct strbuf *sb, char *path_buf,
>> +		       size_t path_buf_len, size_t alloc_len)
>> +{
>> +	strbuf_wrap_preallocated(sb, path_buf, path_buf_len, alloc_len);
>> +	sb->flags |= STRBUF_FIXED_MEMORY;
>> +}
> 
> Rather than letting strbuf_wrap_preallocated() set sb->flags &=
> ~FIXED_MEMORY only to revert that decision right away, a static function
> could be called by both strbuf_wrap_preallocated() and
> strbuf_wrap_fixed().

Makes sense

>>  void strbuf_release(struct strbuf *sb)
>>  {
>>  	if (sb->alloc) {
>> -		free(sb->buf);
>> +		if (sb->flags & STRBUF_OWNS_MEMORY)
>> +			free(sb->buf);
>>  		strbuf_init(sb, 0);
>>  	}
> 
> Should we not reset the flags here, too?

Well, strbuf_init() reset the flags. The only way to have !sb->alloc
is that strbuf has been initialized and never used (even alloc_grow(0)
set sb->alloc=1), so sb==STRBUF_INIT, so the flags don't have to be reset 

>> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
>>  {
>>  	char *res;
>>  	strbuf_grow(sb, 0);
>> -	res = sb->buf;
>> +	if (sb->flags & STRBUF_OWNS_MEMORY)
>> +		res = sb->buf;
>> +	else
>> +		res = xmemdupz(sb->buf, sb->alloc - 1);
> 
> This looks like a usage to be avoided: if we plan to detach the buffer,
> anyway, there is no good reason to allocate it on the heap first. I would
> at least issue a warning here.

strbuf_detach() guarantees to return heap-allocated memory, that the caller
can use however he want and that he'll have to free. If the strbuf doesn't
own the memory, it cannot return the buf attribute directly because:
- The memory belong to someone else (so the caller can't use it however
he want)
- The caller can't have the responsibility to free (because the memory
belong to someone else)
- The memory may not even be heap-allocated

>> @@ -51,6 +84,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t
>> len, size_t alloc)
>>  	sb->buf   = buf;
>>  	sb->len   = len;
>>  	sb->alloc = alloc;
>> +	sb->flags |= STRBUF_OWNS_MEMORY;
>> +	sb->flags &= ~STRBUF_FIXED_MEMORY;
>>  	strbuf_grow(sb, 0);
>>  	sb->buf[sb->len] = '\0';
>>  }
>> @@ -61,9 +96,32 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>>  	if (unsigned_add_overflows(extra, 1) ||
>>  	    unsigned_add_overflows(sb->len, extra + 1))
>>  		die("you want to use way too much memory");
>> -	if (new_buf)
>> -		sb->buf = NULL;
>> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>> +	if ((sb->flags & STRBUF_FIXED_MEMORY) && sb->len + extra + 1 > sb->alloc)
>> +		die("you try to make a string overflow the buffer of a fixed strbuf");
> 
> We try to avoid running over 80 columns/row. This message could be
> more to the point: cannot grow fixed string

What is fixed is the buffer, not the string. I'll shrink that under 80 columns
   
>>  extern char strbuf_slopbuf[];
>> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
>> +#define STRBUF_INIT  { 0, 0, 0, strbuf_slopbuf }
> 
> If I am not mistaken, to preserve the existing behavior the initial flags
> should be 1 (own memory).

strbuf_slopbuf is a buffer that doesn't belong to any strbuf (because it's
shared between all just-initialized strbufs). If STRBUF_OWNS_MEMORY was
set, strbuf_slopbuf could be freed (which is impossible because it is
shared AND even more because it is stack-allocated) 

> BTW this demonstrates that it may not be a good idea to declare the
> "flags" field globally but then make the actual flags private.

I'm not sure what you mean here?

> Also: similar use cases in Git used :1 flags (see e.g. the "configured"
> field in credential.h).

I think that keeping an obscure `flags` attribute may be better, as they
should only be useful for internal operations and the user shouldn't mess
with it. Keeping it a `private` attribute, in a way
