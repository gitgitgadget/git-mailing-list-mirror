From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the temporary buffer
Date: Wed, 18 Dec 2013 11:35:34 -0800
Message-ID: <xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
	<20131217232231.GA14807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtMuI-00064A-2k
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab3LRTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:35:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab3LRTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:35:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A43C5ACF8;
	Wed, 18 Dec 2013 14:35:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RY5TYepBCqtgExImZ21W6kwc3iE=; b=HF/bbC
	3o1bGxvx3EqwNebnznRRkaF8eFH/PqZ7RnrgvtGeavUuMge/iqhBjuT1TYbvz91a
	a8wjw30pwUBzT1z82zjk6qEwMeTc2VAiCtb0xzs7a/1VJt1/Xhtu+sA8L1vqZ3iZ
	8xEcW035oDyu1kCjbP81zKbhNYRJDRYYhsmwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kUnWz8sLxX76YrZN74WXm2NLtBKJ+rjW
	5wz642bliFA3p80JYjBQbDnplkhWUXVlANuyXe+/9zwmxiqdFtLfVeCnk7IAUYIk
	oUxr336O1XQuOs0uylzX8IbKPulm7pM1o5dO504bktqv9kVay/sQ+O/NUU7kFuVY
	GqHVHFOl+54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4382B5ACF7;
	Wed, 18 Dec 2013 14:35:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F8995ACF5;
	Wed, 18 Dec 2013 14:35:38 -0500 (EST)
In-Reply-To: <20131217232231.GA14807@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Dec 2013 18:22:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9278FA28-681B-11E3-A627-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239472>

Jeff King <peff@peff.net> writes:

> Converting it to use strbuf looks like it will actually let us drop a
> bunch of copying, too, as we just end up in mkpath at the very lowest
> level. I.e., something like below.

Thanks; I may have a few minor comments, but overall, I like the
placement of mkpath() in the resulting callchain a lot better than
the original.

> As an aside, I have noticed us using this "push/pop" approach to treating a
> strbuf as a stack of paths elsewhere, too. I.e:
>
>   size_t baselen = base->len;
>   strbuf_addf(base, "/%s", some_thing);
>   some_call(base);
>   base->len = baselen;
>
> I wondered if there was any kind of helper we could add to make it look
> nicer. But I don't think so; the hairy part is that you must remember to
> reset base->len after the call, and there is no easy way around that in
> C. If you had object destructors that ran as the stack unwound, or
> dynamic scoping, it would be easy to manipulate the object. Wrapping
> won't work because strbuf isn't just a length wrapping an immutable
> buffer; it actually has to move the NUL in the buffer.
>
> Anyway, not important, but perhaps somebody is more clever than I am.

Hmph... interesting but we would need a lot more thought than the
time necessary to respond to one piece of e-mail for this ;-)
Perhaps later...

> diff --git a/builtin/prune.c b/builtin/prune.c
> index 6366917..4ca8ec1 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -17,9 +17,8 @@ static int verbose;
>  static unsigned long expire;
>  static int show_progress = -1;
>  
> -static int prune_tmp_object(const char *path, const char *filename)
> +static int prune_tmp_object(const char *fullpath)
>  {
> -	const char *fullpath = mkpath("%s/%s", path, filename);
>  	struct stat st;
>  	if (lstat(fullpath, &st))
>  		return error("Could not stat '%s'", fullpath);

This function is called to remove

 * Any tmp_* found directly in .git/objects/
 * Any tmp_* found directly in .git/objects/pack/
 * Any tmp_obj_* found directly in .git/objects/??/

and shares the same expiration logic with prune_object().  The only
difference from the other function is what the file is called in
dry-run or verbose report ("stale temporary file" vs "<sha-1> <typename>").

We may want to rename it to prune_tmp_file(); its usage may have
been limited to an unborn loose object file at some point in the
history, but it does not look that way in today's code.

> -static int prune_dir(int i, char *path)
> +static int prune_dir(int i, struct strbuf *path)
>  {
> -	DIR *dir = opendir(path);
> +	size_t baselen = path->len;
> +	DIR *dir = opendir(path->buf);
>  	struct dirent *de;
>  
>  	if (!dir)
> @@ -77,28 +76,39 @@ static int prune_dir(int i, char *path)
>  			if (lookup_object(sha1))
>  				continue;
>  
> -			prune_object(path, de->d_name, sha1);
> +			strbuf_addf(path, "/%s", de->d_name);
> +			prune_object(path->buf, sha1);
> +			path->len = baselen;

This is minor, but I prefer using strbuf_setlen() for this.

Thanks.
