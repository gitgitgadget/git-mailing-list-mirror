From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 09:41:57 -0700
Message-ID: <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
References: <20130822231215.GA16978@sigill.intra.peff.net>
	<20130822231404.GB17060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 23 18:42:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCuR5-0000ES-E6
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 18:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab3HWQmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 12:42:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579Ab3HWQmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 12:42:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3883BEE2;
	Fri, 23 Aug 2013 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9D61/sLyBqXL6Edtp82ni9xNWwg=; b=AUNrJI
	1f6EBMFQIvltW+YYF23rbpxQVp51LnAIYjP4HCJTMsx1yN8F2wJ9fEoMYBNh4+Ng
	SIDN6YuSof3qBFXxYjTT8RuFFHIgvMZYM1s27vlR4+XB8Q3yLeeo4kAnYd8GbkPH
	SpH41SiqJULuUxbTTParMi8uFqRfaiL6WOLIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDlmqO+fpK5Ck3I7vwXU9+dSpWJf5xEY
	4hm9dSn1/QiOh2NVgYmsOksJF3BDk0FSnfTSPtP7Yx9NqXBJDXV3Wa8WJMieSlox
	V/dYBTO/wok8AdexZc/ky4C7XtTylkwjcujiT5u5wa3D7tkAm7R5e81+sC6qPcNt
	XRh2KIlunU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 106973BEE1;
	Fri, 23 Aug 2013 16:42:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AED33BEDE;
	Fri, 23 Aug 2013 16:41:59 +0000 (UTC)
In-Reply-To: <20130822231404.GB17060@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 Aug 2013 19:14:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE09D458-0C12-11E3-A931-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232812>

Jeff King <peff@peff.net> writes:

> Furthermore, we know that one of our endpoints must be
> the edge of the run of duplicates. For example, given this
> sequence:
>
>  idx 0 1 2 3 4 5
>  key A C C C C D
>
> If we are searching for "B", we might hit the duplicate run
> at lo=1, hi=3 (e.g., by first mi=3, then mi=0). But we can
> never have lo > 1, because B < C. That is, if our key is
> less than the run, we know that "lo" is the edge, but we can
> say nothing of "hi". Similarly, if our key is greater than
> the run, we know that "hi" is the edge, but we can say
> nothing of "lo". But that is enough for us to return not
> only "not found", but show the position at which we would
> insert the new item.

This is somewhat tricky and may deserve an in-code comment.

> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index c4dc55d..614cbb6 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -204,7 +204,30 @@ int sha1_entry_pos(const void *table,
>  			 * byte 0 thru (ofs-1) are the same between
>  			 * lo and hi; ofs is the first byte that is
>  			 * different.
> +			 *
> +			 * If ofs==20, then no bytes are different,
> +			 * meaning we have entries with duplicate
> +			 * keys. We know that we are in a solid run
> +			 * of this entry (because the entries are
> +			 * sorted, and our lo and hi are the same,
> +			 * there can be nothing but this single key
> +			 * in between). So we can stop the search.
> +			 * Either one of these entries is it (and
> +			 * we do not care which), or we do not have
> +			 * it.
>  			 */
> +			if (ofs == 20) {
> +				mi = lo;
> +				mi_key = base + elem_size * mi + key_offset;
> +				cmp = memcmp(mi_key, key, 20);

It think we already know that mi_key[0:ofs_0] and key[0:ofs_0] are
the same at this point and we do not have to compare full 20 bytes
again, but this is done only once and a better readablity of the
above trumps micro-optimization possibility, I think.

> +				if (!cmp)
> +					return mi;
> +				if (cmp < 0)
> +					return -1 - hi;
> +				else
> +					return -1 - lo;
> +			}
> +
>  			hiv = hi_key[ofs_0];
>  			if (ofs_0 < 19)
>  				hiv = (hiv << 8) | hi_key[ofs_0+1];
> diff --git a/t/lib-pack.sh b/t/lib-pack.sh
> new file mode 100644
> index 0000000..61c5d19
> --- /dev/null
> +++ b/t/lib-pack.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +#
> +# Support routines for hand-crafting weird or malicious packs.
> +#
> +# You can make a complete pack like:
> +#
> +#   pack_header 2 >foo.pack &&
> +#   pack_obj e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 >>foo.pack &&
> +#   pack_obj e68fe8129b546b101aee9510c5328e7f21ca1d18 >>foo.pack &&
> +#   pack_trailer foo.pack
> +
> +# Print the big-endian 4-byte octal representation of $1
> +uint32_octal() {

micronit (style):

	uint32_octal () {

> +	n=$1
> +	printf '\%o' $(($n / 16777216)); n=$((n % 16777216))
> +	printf '\%o' $(($n /    65536)); n=$((n %    65536))
> +	printf '\%o' $(($n /      256)); n=$((n %      256))
> +	printf '\%o' $(($n           ));
> +}
> +
> +# Print the big-endian 4-byte binary representation of $1
> +uint32_binary() {
> +	printf "$(uint32_octal "$1")"
> +}
> +
> +# Print a pack header, version 2, for a pack with $1 objects
> +pack_header() {
> +	printf 'PACK' &&
> +	printf '\0\0\0\2' &&
> +	uint32_binary "$1"
> +}
> +
> +# Print the pack data for object $1, as a delta against object $2 (or as a full
> +# object if $2 is missing or empty). The output is suitable for including
> +# directly in the packfile, and represents the entirety of the object entry.
> +# Doing this on the fly (especially picking your deltas) is quite tricky, so we
> +# have hardcoded some well-known objects. See the case statements below for the
> +# complete list.

Cute ;-) I like the idea of having this function with a right API in
place, and cheating by limiting its implementation to what is
necessary.

Thanks.
