From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 06 Jun 2016 10:19:07 -0700
Message-ID: <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:19:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9yBJ-0002X9-1G
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 19:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcFFRTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 13:19:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcFFRTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 13:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B46C2275E;
	Mon,  6 Jun 2016 13:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ugEYAw7ZTNgTJYF7qf/r+oMCgwQ=; b=vzeFkU
	kO5mLl0USgrXSbYtLbleisds+XFbB8Mzjm0PxVSeluIje6RyP28UW1FhzNUmYV+b
	PRYH5604Hs/hTfwSfui429+0y2raLvpPQEvUs+fC94v+iW19eGpEnIjx+D0vn0qG
	AuRLaQQxVARn75q0Mj1oOahIV+Qzf5ho9TX9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QOJcuQL+Ky+J6vlzwT1WwUgIdqDy7egT
	G99uRyJtaX2ZmYKsCj+SxpLV/pjUQHQGJ5TyY5qtuW62869882W+JKb/eSBUzIAD
	mO9nIqhjuKH7f2k/fxky7xF+wFHp236QAcRI8BAQJK/GcVU6jCcKlQ9QiR9yPg4V
	6i5zzDDyTTY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 226782275D;
	Mon,  6 Jun 2016 13:19:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 899DC2275C;
	Mon,  6 Jun 2016 13:19:09 -0400 (EDT)
In-Reply-To: <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 6 Jun 2016 17:13:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7E576C2-2C0A-11E6-B659-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296540>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> +#define MAX_ALLOC(a, b) (((a)>(b))?(a):(b))

I do not see why this macro is called MAX_ALLOC(); is there anything
"alloc" specific to what this does?  You may happen to use it only
for "alloc" related things, but that is not a good reason for such a
name (if the implementation can only be used for "alloc" specific
purpose for some reason, then the name is appropriate).

> @@ -20,16 +23,47 @@ char strbuf_slopbuf[1];
>  
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> +	sb->owns_memory = 0;
> +	sb->fixed_memory = 0;
>  	sb->alloc = sb->len = 0;
>  	sb->buf = strbuf_slopbuf;
>  	if (hint)
>  		strbuf_grow(sb, hint);
>  }

I'll complain about _grow() again later, but if the implementation
is updated to address that complaint, slopbuf-using strbuf could
start it as a special case of "starts as fixed_memory".

> +static void strbuf_wrap_internal(struct strbuf *sb, char *buf,
> +				 size_t buf_len, size_t alloc_len)
> +{
> +	if (!buf)
> +		die("the buffer of a strbuf cannot be NULL");
> +
> +	strbuf_release(sb);
> +	sb->len = buf_len;
> +	sb->alloc = alloc_len;
> +	sb->buf = buf;
> +}
> +
> +void strbuf_wrap(struct strbuf *sb, char *buf,
> +		 size_t buf_len, size_t alloc_len)
> +{
> +	strbuf_wrap_internal(sb, buf, buf_len, alloc_len);
> +	sb->owns_memory = 0;
> +	sb->fixed_memory = 0;
> +}
>
> +void strbuf_wrap_fixed(struct strbuf *sb, char *buf,
> +		       size_t buf_len, size_t alloc_len)
> +{
> +	strbuf_wrap_internal(sb, buf, buf_len, alloc_len);
> +	sb->owns_memory = 0;
> +	sb->fixed_memory = 1;
> +}

After seeing 2/3, I would say that the pretty side deserves the use
of word "wrap" more.  What the above two does is an enhancement of
what strbuf API has called "attach".  You are introducing a few new
and different ways to attach a piece of memory to a strbuf.

> @@ -37,8 +71,13 @@ void strbuf_release(struct strbuf *sb)
>  char *strbuf_detach(struct strbuf *sb, size_t *sz)
>  {
>  	char *res;
> +
>  	strbuf_grow(sb, 0);
> -	res = sb->buf;
> +	if (sb->owns_memory)
> +		res = sb->buf;
> +	else
> +		res = xmemdupz(sb->buf, sb->len);
> +
>  	if (sz)
>  		*sz = sb->len;
>  	strbuf_init(sb, 0);

Note that the user of the API does not have to care if the memory is
held by the strbuf or if the strbuf is merely borrowing it from the
initial allocation made from elsewhere (e.g. via strbuf_wrap_*) when
finalizing its use of the strbuf API to build the contents and
utilize the resulting buffer.  Theoretically, if the caller knows it
let the piece memory _it_ owns (i.e. !owns_memory) and the piece of
memory it originally gave the strbuf hasn't been moved (i.e. your
fixed_memory, which I will complain again soon), the caller
shouldn't have to get a copy via xmemdupz(), which would both save
an allocation here and free() in the caller once it is done.

But that is not done, and as the API it is a good thing.  It frees
the caller from having to worry about _where_ the memory originally
came from.

>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
> -	int new_buf = !sb->alloc;
>  	if (unsigned_add_overflows(extra, 1) ||
>  	    unsigned_add_overflows(sb->len, extra + 1))
>  		die("you want to use way too much memory");
> -	if (new_buf)
> -		sb->buf = NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> -	if (new_buf)
> -		sb->buf[0] = '\0';
> +	if ((sb->fixed_memory) &&
> +	    sb->len + extra + 1 > sb->alloc)
> +		die("you try to overflow the buffer of a fixed strbuf");

Having praised how _detach() frees the user of the API from having
to worry about minute details of allocation, this is an eyesore.  I
really think this "fixed_memory" support MUST GO.  This "die()" here
makes the API useless _unless_ the caller always makes sure that any
operation it performs does not overflow the originally allocated
size, which makes it no better than using xsnprintf() and friends.

A better design would be to get rid of fixed_memory bit and replace
it with "owns_memory" bit.  Its meaning would be "The ->buf pointer
points at something that is not owned by this strbuf, and must not
be freed when resizing or releasing ->buf."

And when you detect that a strbuf with unfreeable memory needs to be
extended (the above condition you call "die()" on), you use the
"strbuf doesn't own the buffer" logic below.

The only difference between your version and an improved one that
gets rid of "fixed_memory" from the API user's point of view is that
they must pre-allocate absolute maximum amount of memory expected to
be consumed with your version in order not to crash, while a "start
with fixed but dynamically allocate from heap if needed" approach
lets the API user preallocate just sufficient amount of memory
expected to be consumed in a typical workload and go without calling
malloc()/free() most of the time.  Oh, and when a rare data comes in
that exceeds your initial estimate, "fixed_memory" version will just
die.

So, as I said in the previous round, I really do not see a point in
this fixed_memory business.  It does not make the implementation of
the API any easier as far as I can tell, either.

> +	/*
> +	 * ALLOC_GROW may do a realloc() if needed, so we must not use it on
> +	 * a buffer the strbuf doesn't own
> +	 */
> +	if (sb->owns_memory) {
> +		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	} else {
> +		/*
> +		 * The strbuf doesn't own the buffer: to avoid to realloc it,
> +		 * the strbuf needs to use a new buffer without freeing the old
> +		 */
> +		if (sb->len + extra + 1 > sb->alloc) {
> +			size_t new_alloc =
> +				MAX_ALLOC(sb->len + extra + 1,
> +					  alloc_nr(sb->alloc));

It is true that the you cannot simply realloc(->buf), but otherwise
the growth pattern of the buffer is the same between ->owns_memory
case and this case.  And I think the above computes it like so, but
do you really need a one-shot macro MAX_ALLOC that is named in a
misleading way?

I'd find it far easier to read if you wrote the core of ALLOC_GROW()
logic, like this:

	size_t new_nr = sb->len + extra + 1;
	if (new_nr > sb->alloc) {
		size_t new_alloc;
		if (alloc_nr(sb->alloc) < new_nr)
                	new_alloc = new_nr;
		else
			new_alloc = alloc_nr(sb->alloc);
		... copy and make it "owned" ...
	}

A better way would be to introduce a new macro ALLOC_GROW_COUNT() to
cache.h immediately before ALLOC_GROW() is defined and use it to
redo ALLOC_GROW(), perhaps like this:

#define ALLOC_GROW_COUNT(nr, alloc) \
        ((alloc_nr(alloc) < (nr)) ? (nr) : alloc_nr(alloc))

#define ALLOC_GROW(x, nr, alloc) \
	do { \
                if ((nr) > alloc) { \
                	alloc = ALLOC_GROW_COUNT(nr, alloc); \
			REALLOC_ARRAY(x, alloc); \
		} \
	} while (0)			

Then you can do

	if (sb->len + extra + 1 > sb->alloc) {
		size_t new_alloc;
                char *new_buf;

        	new_alloc = ALLOC_GROW_COUNT(sb->len + extra + 1, sb->alloc);
		new_buf = xmalloc(new_alloc);
		memcpy(...);
		...
