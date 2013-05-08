From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 08 May 2013 11:18:05 -0700
Message-ID: <7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 20:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua8wR-0002YG-8f
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 20:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab3EHSSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 14:18:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757010Ab3EHSSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 14:18:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22DA71D4BB;
	Wed,  8 May 2013 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jAttH/VwCS0HcG0FfxzdiCLwyMs=; b=dWH+72
	yye68MH2u0uCIUxGI5L1O7MhWdsTXCj2Ju/hlmCa82xxD7+DT61LINB5N5Iw7eag
	vI+7zUyBXGMpa5PrVDfYqaCoM41Pv6CcmjjScRD7c9C2oSIRGaAC5owyNB4vw9W9
	iEOUe7jbwWYKTe1fVvRRoxCKhvnvOSRUnWV3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZEOJLBizsEIFOU1vaAsKF6nCY40XYao
	ZdPTQgjhrHT6aO5xw5FnvttPaVIt1cxM7Kbt4eqstalps77am3F5T4ANZLHWn87w
	Ke1ryKuNfO4O6loJs0V2OpQ6VzDLjvbfrU6cJkdabi33eJ/lc7UCvWHePseUZ6FT
	OLriCZ6mMeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAFF1D4B9;
	Wed,  8 May 2013 18:18:08 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6421E1D4B8;
	Wed,  8 May 2013 18:18:07 +0000 (UTC)
In-Reply-To: <1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 7 May 2013 16:55:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1DB45A4-B80B-11E2-A673-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223680>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Through the years the functionality to handle @{-N} and @{u} has moved
> around the code, and as a result, code that once made sense, doesn't any
> more.
>
> There is no need to call this function recursively with the branch of
> @{-N} substituted because dwim_{ref,log} already replaces it.
>
> However, there's one corner-case where @{-N} resolves to a detached
> HEAD, in which case we wouldn't get any ref back.
>
> So we parse the nth-prior manually, and deal with it depending on
> weather it's a SHA-1, or a ref.
> ...

s/weather/whether/;

> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	if (len && str[len-1] == '}') {
>  		for (at = len-4; at >= 0; at--) {
>  			if (str[at] == '@' && str[at+1] == '{') {
> +				if (at == 0 && str[2] == '-') {
> +					nth_prior = 1;
> +					continue;
> +				}

Does this have to be inside the loop?

> @@ -460,19 +465,22 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	if (len && ambiguous_path(str, len))
>  		return -1;
>  
> -	if (!len && reflog_len) {
> +	if (nth_prior) {
>  		struct strbuf buf = STRBUF_INIT;
> -		int ret;
> -		/* try the @{-N} syntax for n-th checkout */
> -		ret = interpret_branch_name(str, &buf);
> -		if (ret > 0)
> -			/* substitute this branch name and restart */
> -			return get_sha1_1(buf.buf, buf.len, sha1, 0);
> -		else if (ret == 0)
> -			return -1;
> +		int detached;
> +
> +		if (interpret_nth_prior_checkout(str, &buf) > 0) {
> +			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
> +			strbuf_release(&buf);
> +			if (detached)
> +				return 0;
> +		}
> +	}

Earlier, if @{-N} resolved to a detached head, we just fed it to
get_sha1_1().  If it resolved to a concrete refname, we also fed it
to get_sha1_1().  We ended up calling ourselves again and did the
right thing either way.

The new code bypasses the recursive call when we get a detached head
back, because we know that calling get_sha1_1() with the 40-hex will
eventually take us back to this codepath, and immediately return
when it sees get_sha1_hex() succeeds.

What happens when str @{-N} leaves a concrete refname in buf.buf?
The branch name is lost with strbuf_release(), and then where do we
go from here?  Continuing down from here would run dwim_ref/log on
str which is still @{-N}, no?

Ahh, OK, the new code will now let dwim_ref/log to process @{-N}
again (the log message hints this but it wasn't all that clear), so
even though we already learned the branch name in buf here and
discard it, we will eventually discover the same information later.

That is somewhat contrived, and I am not so sure if that is a good
reorganization.

Also, a few points this patch highlights in the code before the
change:

 - If we were on a branch with 40-hex name at nth prior checkout,
   would we mistake it as being detached at the commit?

 - If we were on a branch 'foo' at nth prior checkout, would our
   previous get_sha1_1() have made us mistake it as referring to a
   tag 'foo' with the same name if it exists?

The former needs a fix to either writing of reflog or reading by
interpret_nth_prior_checkout() so that we can tell these cases apart
more reliably.  Then the latter can be solved by splicing
refs/heads/ in front of the branch name before recursively calling
get_sha1_1() in the original code (and similar fix can be
forward-ported to this patch).

Incidentally, I think if we prefix refs/heads/ in front and feed
that to dwim_ref/log, we would also avoid running @{-N} twice (which
I suspect might be more expensive than a simple recursion, as it
needs to go through the reflog file), which may be a nice side
effect of such a fix we would get for free.

> +
> +	if (!len && reflog_len)
>  		/* allow "@{...}" to mean the current branch reflog */
>  		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
> -	} else if (reflog_len)
> +	else if (reflog_len)
>  		refs_found = dwim_log(str, len, sha1, &real_ref);
>  	else
>  		refs_found = dwim_ref(str, len, sha1, &real_ref);
