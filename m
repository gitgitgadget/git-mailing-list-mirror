From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] add strip_suffix function
Date: Wed, 02 Jul 2014 08:54:44 -0700
Message-ID: <xmqqlhsbiwmz.fsf@gitster.dls.corp.google.com>
References: <20140630165526.GA15690@sigill.intra.peff.net>
	<20140630165751.GB16637@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 17:55:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2MsA-0005FN-95
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 17:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbaGBPy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 11:54:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52969 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbaGBPy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 11:54:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37B352185F;
	Wed,  2 Jul 2014 11:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Fibx9BNaeBF0lP3BUnwWuIBVR0=; b=QrkTCl
	UZR+7TAvVheLKgRlvXzbimY1ehgx/ODvXiA7vwDCqm9sb9iK9tWLisEdH7NhTIZG
	QVi0tk4B7rfpMEJOgwRt5ZULwlLiXKvlRKaO8HGk1iJdez+MLamUwe8AIN/by1ac
	NDYaJQ9DmT1DgaK5NzB6frtAU7WS2uJgryc6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yOPlfr2xlpVkbCWu1Q0BiBpxrUFdDOOG
	AyWAdsO9c3meMJXJLE4caenyBx2aR6L291MnTugqxzthB7/qJP9KXlvXYJUCWUvB
	C5a9YDWNWn7j0/oOW5f/3f5gO65NBfxEspf3vEq5pTP8QpyXuuuzP8wP/kMfjSGL
	5nFmPs6C8Dc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A8652185E;
	Wed,  2 Jul 2014 11:54:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39AA521858;
	Wed,  2 Jul 2014 11:54:36 -0400 (EDT)
In-Reply-To: <20140630165751.GB16637@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 30 Jun 2014 12:57:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2AB23398-0201-11E4-A4FC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252788>

Jeff King <peff@peff.net> writes:

> For that reason, the "mem" form puts its length parameter
> next to the buffer (since they are a pair), and the string
> form puts it at the end (since it is an out-parameter). The
> compiler can notice when you get the order wrong, which
> should help prevent writing one when you meant the other.

Very sensible consideration.  I like commits that careful thinking
behind them shows through them.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I hope the word "strip" is OK, as it does not actually NUL-terminate
> (doing so would make it unusable for many cases). Between the comment
> below and the "const" in the parameter, I think it should be pretty
> clear that it does not touch the string. And I could not think of a
> better word.

All other words I can think of offhand, trim, chomp, etc., hint
shortening of the input string, and by definition shortening of a
string implies NUL-termination.

The "mem" variant deals with a counted string, however, so its
shortening implies NUL-termination a lot less [*1*] and should be
fine.

If we want to avoid implying NUL-termination, the only way to do so
would be to use wording that does not hint shortening.  At least for
the C-string variant, which is measuring the length of the basename
part (i.e. `basename $str $suffix`) without touching anything else,
e.g. basename_length("hello.c", ".c", &len), but at the same time
you want to make it a boolean to signal if the string ends with the
suffix, so perhaps has_suffix("hello.c", ".c", &len)?

[Footnote]

 *1* ... but not entirely, because we often NUL-terminate even
     counted strings (the buffer returned from read_sha1_file() and
     the payload of strbuf are two examples).

>  git-compat-util.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b6f03b3..d044c42 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -358,6 +358,33 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
>  	return NULL;
>  }
>  
> +/*
> + * If buf ends with suffix, return 1 and subtract the length of the suffix
> + * from *len. Otherwise, return 0 and leave *len untouched.
> + */
> +static inline int strip_suffix_mem(const char *buf, size_t *len,
> +				   const char *suffix)
> +{
> +	size_t suflen = strlen(suffix);
> +	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
> +		return 0;
> +	*len -= suflen;
> +	return 1;
> +}
> +
> +/*
> + * If str ends with suffix, return 1 and set *len to the size of the string
> + * without the suffix. Otherwise, return 0 and set *len to the size of the
> + * string.
> + *
> + * Note that we do _not_ NUL-terminate str to the new length.
> + */
> +static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
> +{
> +	*len = strlen(str);
> +	return strip_suffix_mem(str, len, suffix);
> +}
> +
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
>  
>  #ifndef PROT_READ
