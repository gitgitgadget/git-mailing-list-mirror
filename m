Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B88CC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6415822D6D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbhALA0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60910 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404029AbhAKXWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 18:22:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8E1A94AB5;
        Mon, 11 Jan 2021 18:21:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NvXjv3JS31/igLCEHvXs9KWz7VU=; b=Rf6/Hc
        gbdNe5nunPbtlzYrEIsmXDYIe7ylwL1D9bFH0mhpPsjqDsSbI1OkLHbZSTA/FYPJ
        bjjJeAO6gW5PQeLc0wg/KU3bD6R04BGkiJbQJA8OhU80kSdhKbUK+yzCQhUTqL7N
        fBXbTOBb7SsMd1xZM/o/VWhEBwmnFieGpMbgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p7GS/w1mzwEzFBGQXKwY+qJAF8KBuc/+
        +8Y2UTuapTF9rtssVmczfHuOD7RQLyAx1QeZYkEOGM+g1NATyiKsdwkwzewKA2Ch
        xuNl3G80jf/i2sl1bBTlXLEH5vTT1YFwrFLUH0oHJHGQAkv1zmeZUcuQsgPkj0w3
        P4C4ttpLANQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A085D94AB4;
        Mon, 11 Jan 2021 18:21:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2888794AB3;
        Mon, 11 Jan 2021 18:21:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/5] fetch: use strbuf to format FETCH_HEAD updates
References: <cover.1610027375.git.ps@pks.im> <cover.1610362744.git.ps@pks.im>
        <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
Date:   Mon, 11 Jan 2021 15:21:35 -0800
In-Reply-To: <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 11 Jan 2021 12:05:20 +0100")
Message-ID: <xmqqsg775abk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFD486C2-5463-11EB-A694-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -909,6 +910,7 @@ static int open_fetch_head(struct fetch_head *fetch_head)
>  		fetch_head->fp = fopen(filename, "a");
>  		if (!fetch_head->fp)
>  			return error_errno(_("cannot open %s"), filename);
> +		strbuf_init(&fetch_head->buf, 0);
>  	} else {
>  		fetch_head->fp = NULL;
>  	}

Leaving fetch_head->buf uninitialized is probably OK as the caller
of open_fetch_head() would (or at least should) immediately barf
upon seeing an error return?

Ah, no.  Under dry-run mode, we will return success but leave buf
uninitializesd.  It is safe because we do not use the strbuf when fp
is NULL.  OK.

> @@ -941,14 +943,17 @@ static void append_fetch_head(struct fetch_head *fetch_head,
>  			return;
>  	}
>  
> -	fprintf(fetch_head->fp, "%s\t%s\t%s",
> -		oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
> +	strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
> +		    oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
>  	for (i = 0; i < url_len; ++i)
>  		if ('\n' == url[i])
> -			fputs("\\n", fetch_head->fp);
> +			strbuf_addstr(&fetch_head->buf, "\\n");
>  		else
> -			fputc(url[i], fetch_head->fp);
> -	fputc('\n', fetch_head->fp);
> +			strbuf_addch(&fetch_head->buf, url[i]);
> +	strbuf_addch(&fetch_head->buf, '\n');
> +
> +	strbuf_write(&fetch_head->buf, fetch_head->fp);
> +	strbuf_reset(&fetch_head->buf);

This gets us closer to fixing the "one record can be written out
with multiple write(2) calls, allowing parallel fetches to corrupt
FETCH_HEAD file by intermixed records" problem (even though this
change alone would not solve it---for that we need to do write
ourselves, not letting stdio do the flushing).

>  }
>  
>  static void commit_fetch_head(struct fetch_head *fetch_head)
> @@ -962,6 +967,7 @@ static void close_fetch_head(struct fetch_head *fetch_head)
>  		return;
>  
>  	fclose(fetch_head->fp);
> +	strbuf_release(&fetch_head->buf);
>  }
>  
>  static const char warn_show_forced_updates[] =
