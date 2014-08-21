From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Thu, 21 Aug 2014 15:26:27 -0700
Message-ID: <xmqq1ts9qy24.fsf@gitster.dls.corp.google.com>
References: <1408637110-15669-1-git-send-email-prohaska@zib.de>
	<1408637110-15669-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKaoc-0000UQ-5W
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbaHUW0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 18:26:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59324 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbaHUW0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 18:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BED534431;
	Thu, 21 Aug 2014 18:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M3JaswkGiA8z9mwG2G8Cu3K5tgc=; b=v9Ol+3
	fw/5mPjqkOw8bDIda3/Bdg+5e9aZAIa0JntDgnh+a/0BGf10usyWOT+iR0kfovrx
	42zceYm33qN8Yz62yaNLfrVocYso4xj42LQt2Yf54lpTLpLh+/lxdxXU5tjV7M9m
	CAIVL/H1MzPWHVdujhQmpWh0QK1SxxYU8TIis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtAa4LR1IHpX1C4ecTuO9K6DnouYenwO
	lsPDjeC/48vQxY32hjVAn4oPCrXmhNJ7FdD+Pufza7zdmu6Ux5aP/PQVL9r54sO9
	leq7NnE+2WLpipd28hli7SFs4ZGc6AnummLWGjZzZFKjwHxlL15AY1hOfjVRzbJj
	gSI1oVSFP5g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F404A34430;
	Thu, 21 Aug 2014 18:26:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67B0E34428;
	Thu, 21 Aug 2014 18:26:29 -0400 (EDT)
In-Reply-To: <1408637110-15669-3-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Thu, 21 Aug 2014 18:05:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 324D2BFA-2982-11E4-BAA5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255643>

Steffen Prohaska <prohaska@zib.de> writes:

> Similar to testing expectations about malloc with GIT_ALLOC_LIMIT (see
> commit d41489), it can be useful to test expectations about mmap.
>
> This introduces a new environment variable GIT_MMAP_LIMIT to limit the
> largest allowed mmap length (in KB).  xmmap() is modified to check the
> limit.  Together with GIT_ALLOC_LIMIT tests can now easily confirm
> expectations about memory consumption.
>
> GIT_ALLOC_LIMIT will be used in the next commit to test that data will

I smell the need for s/ALLOC/MMAP/ here, but perhaps you did mean
ALLOC (I won't know until I check 3/3 ;-)

> be streamed to an external filter without mmaping the entire file.
>
> [commit d41489]: d41489a6424308dc9a0409bc2f6845aa08bd4f7d Add more large
>     blob test cases
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  sha1_file.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 00c07f2..88d64c0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -663,10 +663,25 @@ void release_pack_memory(size_t need)
>  		; /* nothing */
>  }
>  
> +static void mmap_limit_check(size_t length)
> +{
> +	static int limit = -1;

Perhaps you want ssize_t here?  I see mmap() as a tool to handle a
lot more data than a single malloc() typically would ;-) so previous
mistakes by other people would not be a good excuse.

> +	if (limit == -1) {
> +		const char *env = getenv("GIT_MMAP_LIMIT");
> +		limit = env ? atoi(env) * 1024 : 0;
> +	}
> +	if (limit && length > limit)
> +		die("attempting to mmap %"PRIuMAX" over limit %d",
> +		    (intmax_t)length, limit);
> +}
> +
>  void *xmmap(void *start, size_t length,
>  	int prot, int flags, int fd, off_t offset)
>  {
> -	void *ret = mmap(start, length, prot, flags, fd, offset);
> +	void *ret;
> +
> +	mmap_limit_check(length);
> +	ret = mmap(start, length, prot, flags, fd, offset);
>  	if (ret == MAP_FAILED) {
>  		if (!length)
>  			return NULL;
