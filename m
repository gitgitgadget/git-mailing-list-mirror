From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 09:44:32 -0700
Message-ID: <7vli96p34f.fsf@alter.siamese.dyndns.org>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net> <20130329130230.GA25861@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, avila.jn@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 17:45:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULcQJ-0002Su-W6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 17:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218Ab3C2Qog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 12:44:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617Ab3C2Qof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 12:44:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D48CEF13;
	Fri, 29 Mar 2013 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mFSl9u+6gYyrhLj9/oIcYGwlrAo=; b=Vmkbod
	y0sPNmb+Exx6NUjLszqmF3uUQGX54saKLuR6iv+8AHTqC69cy693GgHMkAG7Fq4N
	/3Vezlte/mNvh/2PS85p/jkBU8bBE72VZuRhnqGHbq67Qh7vF+S4H1c0H0Mxt7C5
	PcrJo2pqjf4EpyZU6ESLgaBq3KIjIxJr3PP7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o/eJcKYaSdtWsB1yel9zhm4USkga1wkJ
	rCzBv6j44YyCMdNDVPUsClSPk0pse6KEPvroZ8TmmyfLBYCcIJ4pp3ycnJCKdYmR
	k9UPpy9RaKb26tZ5qt5FFT6RZy3eNqiAHy8JhhKVyQSnoDRmupyoDlwBPaKeProe
	uF0OBC89MVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25475EF12;
	Fri, 29 Mar 2013 16:44:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77B20EF0F; Fri, 29 Mar 2013
 16:44:33 +0000 (UTC)
In-Reply-To: <20130329130230.GA25861@lanh> (Duy Nguyen's message of "Fri, 29
 Mar 2013 20:02:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF2CE100-988F-11E2-8D19-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219506>

Duy Nguyen <pclouds@gmail.com> writes:

>> So we would want to do any adjustment to the fix when we merge up to
>> maint.
>
> OK. Then Junio, you may need to resolve the conflict with something
> like this. Originally match_basename uses fnmatch, not wildmatch. But
> using wildmatch there too should be fine, now that both
> match_{base,path}name share fnmatch_icase_mem().

Thanks.

The result still smells somewhat funny, though.

fnmatch_icase_mem() is meant to be a wrapper of fnmatch_icase() for
counted strings and its matching semantics should be the same as
fnmatch_icase().

With the merge-fix, fnmatch_icase_mem() calls into wildmatch(), but
fnmatch_icase() still calls into fnmatch().

The latter's flags are meant to be taken from FNM_* family, but the
former takes flags from WM_* family of bits, no?

I think you are running with USE_WILDMATCH which may make the
differences harder to notice, but the name fnmatch_icase_mem() that
is not in the same family as fnmatch but is from the wildmatch()
family smells like an accident waiting to happen.

I tend to think in the longer term it may be a good idea to build
with USE_WILDMATCH unconditionally (we can lose compat/fnmatch), so
in the end this may not matter that much, but before that happens,
soon after we merge the regression fix with this merge-fix, we may
want to update the codebase as if we applied a series that were
based on 'maint' as you suggested, i.e. using raw wildmatch()
consistently in the match_{base,path}name() codepath.

Opinions?

>
> -- 8< --
> diff --git a/dir.c b/dir.c
> index 73a08af..84744df 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -81,7 +81,9 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,
>  		use_str = str_buf.buf;
>  	}
>  
> -	match_status = fnmatch_icase(use_pat, use_str, flags);
> +	if (ignore_case)
> +		flags |= WM_CASEFOLD;
> +	match_status = wildmatch(use_pat, use_str, flags, NULL);
>  
>  	strbuf_release(&pat_buf);
>  	strbuf_release(&str_buf);
> @@ -564,7 +566,7 @@ int match_pathname(const char *pathname, int pathlen,
>  
>  	return fnmatch_icase_mem(pattern, patternlen,
>  				 name, namelen,
> -				 FNM_PATHNAME) == 0;
> +				 WM_PATHNAME) == 0;
>  }
>  
>  /*
> -- 8< --
