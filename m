From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Thu, 11 Jul 2013 16:12:44 -0700
Message-ID: <7voba8pu6r.fsf@alter.siamese.dyndns.org>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 01:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxQ2e-0000MV-PC
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 01:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab3GKXMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 19:12:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983Ab3GKXMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 19:12:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 573EC2F21F;
	Thu, 11 Jul 2013 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5hFxLlZ5iG5hV0c+SczeiVOdKs=; b=rl2AOT
	VyTf6trOIK+IUuJlm7HtuHizkyPA518jphQkEpgTtOMcq8QbOruNaYcQDZlpSuT1
	l7vUvFEBUVqb3OjvlglpPyM1jkDW6CRsWtXUDvoxMzWDENKmZSIJhIvWFPgvZJnt
	RIj6zUev+GbgVmxw0MVqkINkI1S5HnhHF4qls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmFE6IRQFv5PmTfd3VDg1wbpDF2C/5aK
	GkxmZF7lfNuDhEHi22GiWj0EwZE3TwxhjoFuznV1cYx4VFz+o4Bk93QzSKuBAMTJ
	Af982WfDxkkZ4TTxFkiPQu8PLhIIlnVlhxrzx+vab11bvNYQYT/POUAxznaff6x/
	c2S1qv5oOLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49EC72F21E;
	Thu, 11 Jul 2013 23:12:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A9902F21C;
	Thu, 11 Jul 2013 23:12:46 +0000 (UTC)
In-Reply-To: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Thu, 11 Jul 2013 14:50:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65B5DCC8-EA7F-11E2-9DA0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230150>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> +static size_t http_option_max_matched_len[opt_max];
> +
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
> @@ -141,34 +169,122 @@ static void process_curl_messages(void)
>  }
>  #endif
>  
> +static size_t http_options_url_match_prefix(const char *url,
> +					    const char *url_prefix,
> +					    size_t url_prefix_len)
> +{
> +	/*
> +	 * url_prefix matches url if url_prefix is an exact match for url or it
> +	 * is a prefix of url and the match ends on a path component boundary.
> +	 * Both url and url_prefix are considered to have an implicit '/' on the
> +	 * end for matching purposes if they do not already.
> +	 *
> +	 * url must be NUL terminated.  url_prefix_len is the length of
> +	 * url_prefix which need not be NUL terminated.
> +	 *
> +	 * The return value is the length of the match in characters (excluding
> +	 * any final '/') or 0 for no match.  Passing "/" as url_prefix will
> +	 * always cause 0 to be returned.
> +	 */
> +	size_t url_len;
> +	if (url_prefix_len && url_prefix[url_prefix_len - 1] == '/')
> +		url_prefix_len--;
> +	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
> +		return 0;

"URL=http://a.b/c/" vs "URLprefix=http://a.b/c/" would not return
here, because we only check up to the length of the prefix after
stripping the trailing slash from the prefix..

"URL=http://a.b/cd" vs "URLprefix=http://a.b/c/" would not return
here, because we only check up to the length of the prefix after
stripping the trailing slash from the prefix.

The latter needs to be rejected in the next condition.

> +	url_len = strlen(url);
> +	if ( (url_len == url_prefix_len)      ||

I thought your plan was that you wanted to treat "URL=http://a.b/c/"
and "URL=http://a.b/c" the same way; taking strlen(url) and using it
for comparison without adjusting for the trailing slash makes it
smell somewhat fishy...

> +	     (url[url_prefix_len - 1] == '/') ||
> +	     (url[url_prefix_len] == '/')     )

The prefix side no longer has slash at the end, and we know url and
the prefix match up to the length of the prefix at this point.  Can
url[prefix-len - 1] ever be '/'?  The latter (e.g. one past the
prefix length can be '/' so that the prefix "http://a.b/c" can
match against url "http://a.b/c/anything") makes sense, though.

It is not immediately obvious if this function is correct, at
least to me.

> +		return url[url_prefix_len - 1] == '/'
> +		       ? url_prefix_len - 1 : url_prefix_len;
> +	return 0;
> +}
> +
> +static int check_matched_len(enum http_option_type opt, size_t matchlen)
> +{
> +	/*
> +	 * Check the last matched length of option opt against matchlen
> +	 * and return true if the last matched length is larger (meaning
> +	 * the config setting should be ignored).  Otherwise return false
> +	 * and record matchlen as the last matched length of option opt.
> +	 */
> +	if (http_option_max_matched_len[opt] > matchlen)
> +		return 1;

If you had

	http."http://a.b/c".opt = A

in your ~/.gitconfig and then

	http."http://a.b/c".opt = B

to override it for a particular repository's .git/config, then we
read ~/.gitconfig first, remembering "http://a.b/c" has matched, and
then we read .git/config, and encounter the same URLprefix.  As the
comparision is done with ">", not ">=", this allows the latter to
override the former.

Which may deserve to be added to the comment, perhaps

	... length is larger (meaning the config setting should be
	ignored).  Upon seeing the _same_ key (i.e. new key is the
	same length as the longest match so far) is not ignored, but
	overrides the previous settings.

or something.  It also would be nice to have a test to make sure
this will not be broken in any future change.

Other than that, overall the change looks nice.
