From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 15:57:06 -0700
Message-ID: <7v8vqhhzgd.fsf@alter.siamese.dyndns.org>
References: <20110825200001.GA6165@sigill.intra.peff.net>
 <20110825204047.GA9948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:57:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwirM-0001Ys-V8
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab1HYW5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:57:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab1HYW5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:57:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD5958F1;
	Thu, 25 Aug 2011 18:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+5jPbKzeGCrvOp2/NHtT2n/ijE=; b=Iq7sl+
	B/qgwmyL12RlTD5bLpqnvFHovJWUYFQoxu2Z2zgzS8+JpPmlDzNUP07IxBGbRx6N
	Epxdoo9iWaiVAX0LLyYC56lxdQl/YMapzPQ5P3fQvEGC8JSuOLHVODX3i2O6QFjB
	cM1ES7no5e+ErorcBsGH7BPn04lX68emjq3bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxI6D/Gm0+66PjXRUaQYFcNupQucUNbI
	aCjMG3uZgvpoQCuhbnB3w2rd9rjt8Z2y/amNJAqaDx2vd+/IfYwLP8Hodv2VOT8/
	XMOKt6uYynp/nrqgGaoUVapvlXGHTnPfvJxAItdlPE7OvjmVv0l4G2/zv3o4aC7w
	GguV9agI+kE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B694558F0;
	Thu, 25 Aug 2011 18:57:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AD3058EF; Thu, 25 Aug 2011
 18:57:08 -0400 (EDT)
In-Reply-To: <20110825204047.GA9948@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 25 Aug 2011 16:40:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F3B2244-CF6D-11E0-8C57-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180134>

Jeff King <peff@peff.net> writes:

> If you have any matching attribute line in your own files, it should
> override. So:
>
>   foo/* -diff
>
> will still mark foo/bar.c as binary, even with this change.
>
> Can anyone think of other possible side effects?
>
> Also, any other extensions that would go into such a list? I have no
> idea what the common extension is for something like pascal or csharp.

As long as the builtin ones are the lowest priority fallback, we should be
Ok.

Do we say anywhere that "Ah, this has 'diff' attribute defined, so it must
be text"? If so, we should fix _that_. In other words, having this one
extra entry

	"* diff=default"

in the builtin_attr[] array should be a no-op, I think.

>
>  attr.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index da29c8e..5118a14 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -294,6 +294,18 @@ static void free_attr_elem(struct attr_stack *e)
>  
>  static const char *builtin_attr[] = {
>  	"[attr]binary -diff -text",
> +	"*.html diff=html",
> +	"*.java diff=java",
> +	"*.perl diff=perl",
> +	"*.pl diff=perl",
> +	"*.php diff=php",
> +	"*.py diff=python",
> +	"*.rb diff=ruby",
> +	"*.bib diff=bibtex",
> +	"*.tex diff=tex",
> +	"*.c diff=cpp",
> +	"*.cc diff=cpp",
> +	"*.cxx diff=cpp",
>  	NULL,
>  };
