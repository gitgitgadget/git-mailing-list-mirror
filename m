From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 15 Apr 2015 13:21:15 -0700
Message-ID: <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 22:21:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiToI-0003RJ-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 22:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbbDOUVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 16:21:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752022AbbDOUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 16:21:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A265448FE3;
	Wed, 15 Apr 2015 16:21:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=okZ1OYm4zd4di6ICkMLgzAV509s=; b=AlLbSVCgLWOPkyy1zA5J
	/6HPWO/r4k/BOhVLg6t6MDs5hwHy1oh57ToVcilW2DGB3dJLSBfCLQDXFBE82Rux
	95matfkRw4y6l7OThe2AgqSoz2fPztdrNs8vJ4m4Td/UJlkPF+TeoFnT06Fp5jy3
	srBtCtNeoeKN1vMO6JR7Nxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vWcngLVnQScIZ9ZQaCZwMimUnStkqB0hapn4WHJVXOs9e7
	Wpw8sX07jV0qTBs+COEBTZhkcGOoeGH7sZmAhXHjcPGHFL1n6J6sbatjM5bR7u4T
	MOjgnsCZFUipNwocPi7uA7HTuwO+Cg8ivxnpn9UiPMncpC5+fRBPYMGwh1jvY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AF8A48FE1;
	Wed, 15 Apr 2015 16:21:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2352C48FE0;
	Wed, 15 Apr 2015 16:21:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F889B5A6-E3AC-11E4-A21E-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267236>

Karthik Nayak <karthik.188@gmail.com> writes:

> Update sha1_loose_object_info() to optionally allow it to read
> from a loose object file of unknown/bogus type; as the function
> usually returns the type of the object it read in the form of enum
> for known types, add an optional "typename" field to receive the
> name of the type in textual form and a flag to indicate the reading
> of a loose object file of unknown/bogus type.
>
> Add parse_sha1_header_extended() which acts as a wrapper around
> parse_sha1_header() allowing more information to be obtained.
>
> Add unpack_sha1_header_to_strbuf() to unpack sha1 headers of
> unknown/corrupt objects which have a unknown sha1 header size to
> a strbuf structure. This was written by Junio C Hamano but tested
> by me.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

I see that you made the type parsing to happen earlier than the
previous round (which used to do the size first and then type).

Not a problem, though.  Just something I noticed...

> @@ -1614,27 +1642,40 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
>   * too permissive for what we want to check. So do an anal
>   * object header parse by hand.
>   */
> -int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
> +			       unsigned int flags)
>  {
> -	char type[10];
> -	int i;
> +	struct strbuf typename = STRBUF_INIT;
>  	unsigned long size;
> +	int type;
>  
>  	/*
>  	 * The type can be at most ten bytes (including the
>  	 * terminating '\0' that we add), and is followed by
>  	 * a space.
>  	 */
> -	i = 0;
>  	for (;;) {
>  		char c = *hdr++;
>  		if (c == ' ')
>  			break;
> -		type[i++] = c;
> -		if (i >= sizeof(type))
> -			return -1;
> +		strbuf_addch(&typename, c);
>  	}
> -	type[i] = 0;

This _might_ have some performance impact in that strbuf_addch()
involves strbuf_grow(*, 1), which does "does it overflow to
increment sb->len by one?"; I would say it should be unmeasurable
because the function is expected to be used only on loose objects
and you shouldn't have very many of them without packing in your
repository in the first place.

I guess Peff's c1822d4f (strbuf: add an optimized 1-character
strbuf_grow, 2015-04-04) may want to teach strbuf_addch() to use his
new strbuf_grow_ch(), and once that happens the performance worry
would disappear without this code to be changed at all.

> @@ -2541,7 +2596,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	 * return value implicitly indicates whether the
>  	 * object even exists.
>  	 */
> -	if (!oi->typep && !oi->sizep) {
> +	if (!oi->typep && !oi->typename && !oi->sizep) {

You didn't have this check in the earlier round, and this new one is
correct, I think.  Good eyes to spot this potential problem.

Thanks.
