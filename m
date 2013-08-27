From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/23] pack v4: basic references encoding
Date: Tue, 27 Aug 2013 08:29:35 -0700
Message-ID: <xmqq38pvf8yo.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-9-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELDF-0002jX-Kk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab3H0P3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:29:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab3H0P3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:29:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6323C379;
	Tue, 27 Aug 2013 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EhPo6odGhEw2R6DVO045XoOjTi0=; b=uvqN/t
	s/uKuVVfhrk1PvowyxyytMcZUY86gFw8/FKZ6tGaqngjfK13GJd8AXVhXwHk4tCD
	Mkodj9J9+2BR8ogA5TJRy0Si0GvkJy5mNvi1T82zPiXPZHvpNkNDLMJcWOloBJFU
	ZGtW5maKQmAPcwipbb5Z/8MCG3nVdSewrej38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+uaHP/OK1iXdLVTj8pu/7ntWQinIXaI
	wQkxVCEWBAK7htVd/mvZIdfOom+tE1c1n6MC/WSFofbVEHAfws/rfghSd5Kg0zLC
	hGuvDl9rN3wTgOa8lfBox34xBHShAe1JUuSxmDbfoskgn8T2n01L5Q3CYhf1CEkX
	NEXgZUPdKIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24EDF3C378;
	Tue, 27 Aug 2013 15:29:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BAD13C373;
	Tue, 27 Aug 2013 15:29:37 +0000 (UTC)
In-Reply-To: <1377577567-27655-9-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7BED4C24-0F2D-11E3-B4B4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233102>

Nicolas Pitre <nico@fluxnic.net> writes:

> Add variable length number encoding.  Let's apply the same encoding
> currently used for the offset to base of OBJ_OFS_DELTA objects which
> is the most efficient way to do this, and apply it to everything with
> pack version 4.
>
> Also add SHA1 reference encoding.  This one is either an index into a
> SHA1 table encoded using the variable length number encoding, or the
> literal 20 bytes SHA1 prefixed with a 0.
>
> The index 0 discriminates between an actual index value or the literal
> SHA1.  Therefore when the index is used its value must be increased by 1.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index 012129b..bf33d15 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -245,6 +245,50 @@ static void dict_dump(void)
>  	dump_dict_table(tree_path_table);
>  }
>  
> +/*
> + * Encode a numerical value with variable length into the destination buffer
> + */
> +static unsigned char *add_number(unsigned char *dst, uint64_t value)
> +{
> +	unsigned char buf[20];
> +	unsigned pos = sizeof(buf) - 1;
> +	buf[pos] = value & 127;
> +	while (value >>= 7)
> +		buf[--pos] = 128 | (--value & 127);
> +	do {
> +		*dst++ = buf[pos++];
> +	} while (pos < sizeof(buf));
> +	return dst;
> +}

This may want to reuse (or enhance-then-reuse) varint.[ch].

> +/*
> + * Encode an object SHA1 reference with either an object index into the
> + * pack SHA1 table incremented by 1, or the literal SHA1 value prefixed
> + * with a zero byte if the needed SHA1 is not available in the table.
> + */
> +static struct pack_idx_entry *all_objs;
> +static unsigned all_objs_nr;
> +static unsigned char *add_sha1_ref(unsigned char *dst, const unsigned char *sha1)
> +{
> +	unsigned lo = 0, hi = all_objs_nr;
> +
> +	do {
> +		unsigned mi = (lo + hi) / 2;
> +		int cmp = hashcmp(all_objs[mi].sha1, sha1);
> +
> +		if (cmp == 0)
> +			return add_number(dst, mi + 1);
> +		if (cmp > 0)
> +			hi = mi;
> +		else
> +			lo = mi+1;
> +	} while (lo < hi);
> +
> +	*dst++ = 0;
> +	hashcpy(dst, sha1);
> +	return dst + 20;
> +}
> +
>  static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
>  {
>  	unsigned i, nr_objects = p->num_objects;
