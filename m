From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pathspec: apply "*.c" optimization from exclude
Date: Mon, 19 Nov 2012 13:20:09 -0800
Message-ID: <7vtxsluw3k.fsf@alter.siamese.dyndns.org>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaYnX-0001xO-V1
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab2KSVWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2012 16:22:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab2KSVWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2012 16:22:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F9619F0E;
	Mon, 19 Nov 2012 16:22:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=UHnqYAFOyef6AS4eEXuJjQObY
	0M=; b=K5yK3fThADqegTgEXdVoiW/OqaBT4XepMF4/ea8fdAnnJeIVpXIw3tp11
	zqFeKsqwyvCPabDPVdqB0DvQ7dNUE1aGfS8XQ++dLkPAdyCwv0SRfwDUpIgv07TZ
	rKbIhgx/BxLueSbVyJW1CVv0yPaVuGfL0Z0mmvA4KVOcBLkD/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=DAMC9GsV/AyJK/m+mY8
	iYchwNfuZrWHmJDaV/O9qWfynUrHIglXuePAlOT20u38zbDv+KQGWCoecMmrVwE/
	N6DYF9XSLynhfuTtuAKXl/sFEKZRnplMvYe8tx+tirgbhwaWzBQck2DwN6Q2B8Rf
	/URnzDW4D73sldQ78mlNT7I0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E13B9F0D;
	Mon, 19 Nov 2012 16:22:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 990A09F0C; Mon, 19 Nov 2012
 16:22:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CB57A3A-328F-11E2-A425-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210057>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -O2 build on linux-2.6, without the patch:

Before the result, can you briefly explain what '"*.c" optimization
from exclude' the title talks about is?

    When a pattern contains only a single asterisk, e.g. "foo*bar",
    after literally comparing the leading part "foo" with the
    string, we can compare the tail of the string and make sure it
    matches "bar", instead of running fnmatch() on "*bar" against
    the remainder of the string.

The funny thing was that trying to explain what the logic should do
makes one realize potential issues in the implementation of that
logic ;-)  See below.

> $ time git rev-list --quiet HEAD -- '*.c'
>
> real    0m40.770s
> user    0m40.290s
> sys     0m0.256s
>
> With the patch
>
> $ time ~/w/git/git rev-list --quiet HEAD -- '*.c'
>
> real    0m34.288s
> user    0m33.997s
> sys     0m0.205s
>
> The above command is not supposed to be widely popular.

Hrm, perhaps.  I use "git grep <pattern> -- \*.c" quite a lot, but
haven't seen use case for \*.c in the context of the "log" family.

> diff --git a/cache.h b/cache.h
> index bf031f1..d18f584 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -473,6 +473,8 @@ extern int index_name_is_other(const struct index=
_state *, const char *, int);
>  extern int ie_match_stat(const struct index_state *, struct cache_en=
try *, struct stat *, unsigned int);
>  extern int ie_modified(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
> =20
> +#define PSF_ONESTAR 1

Together with the GF_ prefix in the previous, PSF_ prefix needs a
bit of in-code explanation.  Is it just an RC3L (random combination
of 3 letters?)

> @@ -46,6 +46,12 @@ inline int git_fnmatch(const char *pattern, const =
char *string,
>  		pattern +=3D prefix;
>  		string +=3D prefix;
>  	}
> +	if (flags & GF_ONESTAR) {
> +		int pattern_len =3D strlen(++pattern);
> +		int string_len =3D strlen(string);
> +		return strcmp(pattern,
> +			      string + string_len - pattern_len);
> +	}

What happens when pattern=3D"foo*oob" and string=3D"foob"?

The prefix match before this code determines that the literal prefix
in the pattern matches with the early part of the string, and makes
pattern=3D"*oob" and string=3D"b".

When you come to strcmp(), you see that string_len is 1, pattern_len
is 3, and pattern is "oob".  string+string_len-pattern_len =3D "oob",
one past the beginning of the original string "foob".  They match.

Oops?

	return (string_len < pattern_len) ||
        	strcmp(pattern, string + string_len - pattern_len);

perhaps?
