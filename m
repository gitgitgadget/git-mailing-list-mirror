From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Tue, 26 Aug 2014 12:57:21 +0100
Message-ID: <53FC7621.7090102@ramsay1.demon.co.uk>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com> <53FA0054.5060808@gmail.com> <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com> <20140825130732.GD17288@peff.net> <xmqq8umcl0al.fsf@gitster.dls.corp.google.com> <20140826110303.GA25736@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFNY-0006ae-EA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 13:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbaHZL5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 07:57:32 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:58342 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754717AbaHZL5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 07:57:31 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C89F06F89F6;
	Tue, 26 Aug 2014 12:57:02 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 7B17A6F8C2C;
	Tue, 26 Aug 2014 12:57:02 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Tue, 26 Aug 2014 12:57:01 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826110303.GA25736@peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255890>

On 26/08/14 12:03, Jeff King wrote:
[snip]
> 
> Yeah, reading my suggestion again, it should clearly be
> alloc_flex_struct or something.
> 
> Here's a fully-converted sample spot, where I think there's a slight
> benefit:
> 
> diff --git a/remote.c b/remote.c
> index 3d6c86a..ba32d40 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -928,14 +928,30 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
>  	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
>  }
>  
> +static void *alloc_flex_struct(size_t base, size_t offset, const char *fmt, ...)
> +{
> +	va_list ap;
> +	size_t extra;
> +	char *ret;
> +
> +	va_start(ap, fmt);
> +	extra = vsnprintf(NULL, 0, fmt, ap);
> +	extra++; /* for NUL terminator */
> +	va_end(ap);
> +
> +	ret = xcalloc(1, base + extra);
> +	va_start(ap, fmt);
> +	vsnprintf(ret + offset, extra, fmt, ap);

What is the relationship between 'base' and 'offset'?

Let me assume that base is always, depending on your compiler, either
equal to offset or offset+1. Yes? (I'm assuming base is always the
sizeof(struct whatever)). Do you need both base and offset?

> +	va_end(ap);
> +
> +	return ret;
> +}
> +
>  static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
>  		const char *name)
>  {
> -	size_t len = strlen(name);
> -	struct ref *ref = xcalloc(1, sizeof(struct ref) + prefixlen + len + 1);
> -	memcpy(ref->name, prefix, prefixlen);
> -	memcpy(ref->name + prefixlen, name, len);
> -	return ref;
> +	return alloc_flex_struct(sizeof(struct ref), offsetof(struct ref, name),
> +				 "%.*s%s", prefixlen, prefix, name);
>  }
>  
>  struct ref *alloc_ref(const char *name)
> 
> Obviously the helper is much longer than the code it is replacing, but
> it would be used in multiple spots. The main thing I like here is that
> we are dropping the manual length computations, which are easy to get
> wrong (it's easy to forget a +1 for a NUL terminator, etc).
> 
> The offsetof is a little ugly. And the fact that we have a pre-computed
> length for prefixlen makes the format string a little ugly.
> 
> Here's a another example:
> 
> diff --git a/attr.c b/attr.c
> index 734222d..100c423 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -89,8 +89,8 @@ static struct git_attr *git_attr_internal(const char *name, int len)
>  	if (invalid_attr_name(name, len))
>  		return NULL;
>  
> -	a = xmalloc(sizeof(*a) + len + 1);
> -	memcpy(a->name, name, len);
> +	a = alloc_flex_array(sizeof(*a), offsetof(struct git_attr, name),
> +			     "%.*s", len, name);
>  	a->name[len] = 0;
>  	a->h = hval;
>  	a->next = git_attr_hash[pos];
> 
> I think this is strictly worse for reading. The original computation was
> pretty easy in the first place, so we are not getting much benefit
> there. And again we have the precomputed "len" passed into the function,
> so we have to use the less readable "%.*s". And note that offsetof()
> requires us to pass a real typename instead of just "*a", as sizeof()
> allows (I suspect passing "a->name - a" would work on many systems, but
> I also suspect that is a gross violation of the C standard when "a" has
> not yet been initialized).
> 
> So given that the benefit ranges from "a little" to "negative" in these
> two examples, I'm inclined to give up this line of inquiry.

Indeed. :-D

ATB,
Ramsay Jones
