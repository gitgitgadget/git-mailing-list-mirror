From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Wed, 04 May 2011 18:09:38 -0700
Message-ID: <7vk4e6c5rh.fsf@alter.siamese.dyndns.org>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 03:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHn58-0002nR-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 03:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909Ab1EEBJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 21:09:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab1EEBJw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 21:09:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9E015D4C;
	Wed,  4 May 2011 21:11:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UDWxyDglG2GD
	vU9Bdkg2SKVHVIM=; b=DZXjbPPHrY1w/6aX0+pMY2PNTIPE0J8LCSuY8ecQM71G
	4Y8ZPqHahRt38EDoggu65d6Z7EJNnamIHSjKCvquihfldJwicNZKqymfgQEq1VIo
	Nww1nj9L+1XLN2VrzWPR7XPCAFgAt3WYBrkMRm2tPA6ZsJDst3b73B/NujsSDx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hrvij5
	3ImJlX5/uV/xvYIfdLjP6FrhqydbNF/A9i3ZDigXDzq+KwsRA/Zq2Bw7E+NZRceJ
	8LT/xexbZgAfcuVvqKQgs3AQQKXXvWiUbBDEK+/YHiPikZSLCfgbjULNpI96I4EV
	CUozeIvWax6Itt7Chd3fl/JmXjMATHf9evhRI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75C155D4A;
	Wed,  4 May 2011 21:11:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 495565D49; Wed,  4 May 2011
 21:11:44 -0400 (EDT)
In-Reply-To: <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Thu, 5 May 2011
 00:00:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6AF197E-76B4-11E0-BD90-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172783>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 3a1fe20..98841dc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -24,6 +24,12 @@ all::
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>  # This also implies BLK_SHA1.
>  #
> +# Define NO_LIBPCRE if you do not have libpcre installed.  git-grep =
cannot use
> +# Perl-compatible regexes.

At least at first, I'd rather want to keep this an optional feature, i.=
e.

+# Define WITH_LIBPCRE if you have and want to use libpcre.

> @@ -33,6 +39,8 @@ struct grep_pat {
>  	size_t patternlen;
>  	enum grep_header_field field;
>  	regex_t regexp;
> +	pcre *pcre_regexp;
> +	pcre_extra *extra;

I don't think pcre will forever stay the _only_ thing that wants to hoo=
k
an extra information to this structure.  That is why I included "pcre_"=
 in
the field name in my earlier "how about doing it this way" suggestion.
