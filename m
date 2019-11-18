Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56D21F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 05:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfKRFkt (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 00:40:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52940 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfKRFkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 00:40:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9CC82E112;
        Mon, 18 Nov 2019 00:40:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SZ9o1W2wP/vJihrBK7jHdSdGev8=; b=eesNxq
        YwRJwKyHTL5C68pAk0rwAdtFnjUsWeof+5i7TSZ0qewTxxagVEUB94qQkgHdyOP9
        Ruqi/60H4uByadhHSDVyUij8neB9JO3b4U/iNwg6ulP46Vbj+R5Cx8kkWEygjj39
        XBbm7wdaFODhoqjw/oQPDhU8mhcCPzTAF7scU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P37RRyDYAgoDId5BwGkarBjPwiySlWa4
        Ejpd2AUVXeb+abKwDugAo7pbRWcbP6WtfMjApm+v4D6/kgX+4GQf7CWyVyetyvQt
        pQMLJRHQNWy/B7/UfMULiCayKPUn1l31CyjNdp2zWgyxpSbcvlGcoIjuQe8GSrFs
        rcnQ/VTMC2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E26262E110;
        Mon, 18 Nov 2019 00:40:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 579022E10D;
        Mon, 18 Nov 2019 00:40:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
References: <20191116180655.10988-1-hji@dyntopia.com>
        <20191116180655.10988-2-hji@dyntopia.com>
Date:   Mon, 18 Nov 2019 14:40:42 +0900
In-Reply-To: <20191116180655.10988-2-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sat, 16 Nov 2019 18:06:55 +0000")
Message-ID: <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F64D9CAA-09C5-11EA-BBFE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> The VALIDSIG status line from GnuPG with --status-fd has a field that
> specifies the fingerprint of the primary key that made the signature.
> However, that field is only available for OpenPGP signatures; not for
> CMS/X.509.
>
> An unbounded search for a non-existent primary key fingerprint for X509
> signatures results in the following status line being interpreted as the
> fingerprint.

The above two paragraphs give us an excellent explanation of what
happens in today's code.  What needs to follow is a description of
the approach taken to solve the problem in such a way that helps
readers to agree or disagree with the patch.  It needs to convince
them of at least two things:

 - The change is necessary to avoid a wrong line from getting
   mistaken as the fingerprint with CMS/X.509 sigs, and instead we
   say "there is no fingerprint" on X.509 sig (or whatever happens
   with this change---I cannot tell what ramifications lack of the
   fingerprint has to the callers of this function offhand, or how
   the lack of fingerprint is reported back to the callers, but the
   proposed log message must talk about it).

 - The change safely keeps identifying the right fingerprint with
   OpenPGP sigs because the primary fingerprint, if shown, must be
   on the same line (or whatever reason why it makes it safe---I do
   not offhand know if this is guaranteed how and by whom [*1*], but
   you must have researched it before sending this patch, so please
   write it down to help readers).

>  				/* Do we have fingerprint? */
>  				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
> +					const char *limit;
> +

I wonder if it is simpler to define it next to 'next'.  Yes, this
new variable is used only within this block, but it also gets used
only in conjunction with that other variable.

>  					next = strchrnul(line, ' ');
>  					free(sigc->fingerprint);
>  					sigc->fingerprint = xmemdupz(line, next - line);

So, we skipped "VALIDSIG " and grabbed the first field <fingerprint>
in sigc->fingerprint.  Then we used to unconditionally skip 9 SP
separated fields.  But there may only be 8 fields on the line, which
is why this patch is needed.

> -					/* Skip interim fields */
> +					/* Skip interim fields.  The search is
> +					 * limited to the same line since only
> +					 * OpenPGP signatures has a field with
> +					 * the primary fingerprint. */

	/*
	 * A multi-line comment of ours looks like this; the
	 * slash-asterisk that begins it, and the asterisk-slash
	 * that ends it, are on their own lines, without anything
	 * else but the indentation.
	 */

> +					limit = strchrnul(line, '\n');
>  					for (j = 9; j > 0; j--) {
> -						if (!*next)
> +						if (!*next || next >= limit)
>  							break;

This makes sure that a premature exit (i.e. "0 < j") means we ran
out of the fields.  

I'd prefer to write it "limit <= next" to help visualizing the two
values (on a single line, lower values come left, higher ones come
right), by the way.  That is a minor point.

A bigger question is, when this happens, what value do we want to
leave in sigc->primary_key_fingerprint?  As we can see from the
original code that makes sure the old value in the field will not
leak by first free()ing, it seems that it is possible in this code
that the field may not be NULL, but we just saw that on _our_
signature verification system, the primary key is not available.
Shouldn't we be nulling it out, after free()ing possibly leftover
value in the field?

>  						line = next + 1;
>  						next = strchrnul(line, ' ');
>  					}
>  
> -					next = strchrnul(line, '\n');
> -					free(sigc->primary_key_fingerprint);
> -					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
> +					if (j == 0) {
> +						next = strchrnul(line, '\n');
> +						free(sigc->primary_key_fingerprint);
> +						sigc->primary_key_fingerprint =
> +							xmemdupz(line,
> +								 next - line);
> +					}

Avoid such an unnatural line-wrapping that makes the result harder
to read.  A short helper

	static void replace_cstring(const char **field,
				    const char *line, const char *next)
	{
		free(*field);
		if (line && next)
			*field = xmemdupz(line, next - line);
		else
			*field = NULL;
	}

may have quite a lot of uses in this function, not only for this
field.

This is a tangent, but I think "skip 9 fields" loop by itself
deserves to become a small static helper function.

With such a helper, it would become

		if (!j) {
			next = strchrnul(line, '\n');
			replace_cstring(&sigc->primary_key_fingerprint, line, next);
		} else {
			replace_cstring(&sigc->primary_key_fingerprint,	NULL, NULL);
		}

or if you do not like the overlong lines (I don't), perhaps

		field = &sigc->primary_key_fingerprint;
		if (!j)
			replace_cstring(field, line, strchrnul(line, '\n'));
		else
			replace_cstring(field, NULL, NULL);

Note that sigc->key, sigc->signer, sigc->fingerprint fields all
share the same pattern and will benefit from the use of such a
helper function.

Thanks.

[Reference]

*1* Perhaps this one?  https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;h=dea9d426351e043f872007696e841afb22fe9689;hb=591523ec94b6279b8b39a01501d78cf980de8722#l480

