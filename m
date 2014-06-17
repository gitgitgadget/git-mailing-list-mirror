From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 10:55:18 -0700
Message-ID: <xmqqd2e7mneh.fsf@gitster.dls.corp.google.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
	<50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 19:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwxbX-00088U-PH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbaFQRz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:55:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56173 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992AbaFQRz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C65891FA3F;
	Tue, 17 Jun 2014 13:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FH3BvxDPiV2B3DPTYol9LQYIdYQ=; b=CY1RLq
	dmxGspDwlSyt/7dsD9xaNLZgU2ceCfc4qk2wElbRnjZNBCHUNTbH1cLYu0K4mbeQ
	l2p+5VBVLReXE5OZfrc/og79xuiAiJ76hXD6oAwMlVBa+WQojZCkYcO/Arg8Fqqj
	f8ZAbPgY3UDHLAsnoGpO2PsKLPVVVdXydpRXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UA3+PozfwmjA39pZJ2NHrtrKo0DgJRa0
	nnvpuQ3p6uRjbicQJMrSGIulp/nSz1W/yqIDrJjIdSytehzmyrZGd2XWMvgwlybz
	K1OtLCEaOWvXBijCmtsDcU2yMWBVCdZjNKQSU7Sl0PsTjd0jHMtFwlB8h/W+b6FX
	PKvj3xn6LOk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 894E91FA3E;
	Tue, 17 Jun 2014 13:55:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E69931FA37;
	Tue, 17 Jun 2014 13:55:17 -0400 (EDT)
In-Reply-To: <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
	(Jeremiah Mahler's message of "Tue, 17 Jun 2014 00:34:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8AE4667E-F648-11E3-AA38-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251930>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Add a strnncmp() function which behaves like strncmp() except it takes
> the length of both strings instead of just one.  It behaves the same as
> strncmp() up to the minimum common length between the strings.  When the
> strings are identical up to this minimum common length, the length
> difference is returned.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  strbuf.c | 9 +++++++++
>  strbuf.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..4eb7954 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
>  	result[i] = '\0';
>  	return result;
>  }
> +
> +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> +{
> +	int min_len = (len_a < len_b) ? len_a : len_b;
> +	int cmp = strncmp(a, b, min_len);
> +	if (cmp)
> +		return cmp;
> +	return (len_a - len_b);
> +}

I am not sure if the interface into this function conceptually makes
much sense.  strncmp(entry, string, 14) was invented as the way to
see if a NUL terminated "string" matches with the contents in an
array of char "entry" that is up to 14 bytes long, and because the
"entry" was allowed to fill full 14-byte space without terminated
with a NUL, the maximum possible length is specified separately, but
a NUL termination in "entry", if exists, is still honored.  Is there
any case where such a pair of "maximum N bytes but could be shorter"
strings are compared, especially with different N's defined per
string, in our codebase (or in other people's project for that
matter)?

Further, I do think that the interface into this function and its
implementation are inappropriate for implementing the name_compare()
function in tree-walk.c and unpack-trees.c.  These functions are
designed to take counted strings; in a tuple <a, a_len> they take,
"a_len" is the only thing that determines the length of string "a".
There is no room for a NUL termination inside "a" come into play to
make "a" shorter than "a_len".

In other words, "Two NUL-terminated strings can be compared with
strcmp(a, b), but we use counted strings in many places in our
codebase, and compare_counted_strings(a, a_len, b, b_len) function
would help us, so let's add one and use it in name_compare()" may
make good sense, but if we were to do so, I do not think strncmp()
would be involved in its implementation.
