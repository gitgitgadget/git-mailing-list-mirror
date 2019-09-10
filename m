Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70341F463
	for <e@80x24.org>; Tue, 10 Sep 2019 06:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbfIJGCM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 02:02:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59276 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfIJGCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 02:02:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DF9D97385;
        Tue, 10 Sep 2019 02:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OAvUWAVnf6iWQYcizPuubAP4cJk=; b=e2ORrD
        P80mUcW8BCejVcZTcinz9MO9k0DLV973EU198/ZOSR2TC4CcFKgOWwaM5Zefzp8P
        0Pjk2Z0TRJv5vVqUHFLlhEaO3E5woKDXSP0t/fHWZbz7S4fw5BVLtPNd7r1XEyDt
        zu7H+aUpsictZ68mihtUdvrDE9wFwHPEmRt3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g75JKV1vey8W/EZeKleaT8yOqOUXM2yq
        JE/zw7RBgsYNcV6VHAEyRabJdNARuZ83ZTwArkFv3aNwP4AiRdN5G0lgmqH7OuOs
        ovn2Jlku+yoHUj+Pf3xeSwqIcPozFc5nuFLcFjwypTF18dkobzvjbEjzr0ztU4y8
        /BxGzEp3CFM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16A0297384;
        Tue, 10 Sep 2019 02:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FA6A97381;
        Tue, 10 Sep 2019 02:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: do not output empty lines
References: <20190910051705.2765-1-ericdfreese@gmail.com>
        <20190910051705.2765-2-ericdfreese@gmail.com>
Date:   Mon, 09 Sep 2019 23:02:07 -0700
In-Reply-To: <20190910051705.2765-2-ericdfreese@gmail.com> (Eric Freese's
        message of "Mon, 9 Sep 2019 23:17:05 -0600")
Message-ID: <xmqqpnk8heow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86427C84-D390-11E9-94C6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Freese <ericdfreese@gmail.com> writes:

> If the format string expands to an empty string for a given ref, do not
> print the empty line.
>
> This is helpful when wanting to print only certain kinds of refs that
> you can't already filter for.

We tend to prefer stating the reason why we want to do so first and
then give a command to the codebase to "become like so".  Here is to
illustrate how you would do it:

    The custom format specifier "--format=<format>" can be used to
    tell the for-each-ref command to say nothing for certain kind of
    refs, e.g.

       --format="%(if)%(symref)%(then)%(else)%(refname)%(end)"

    may be used to show the refname only for refs that are not
    symbolic refs.  Except that the command still would show one
    blank line per each symbolic ref, which is fairly useless.

    Introduce the `--omit-empty-lines` option to squelch these
    useless lines from the output.


> @@ -2395,9 +2395,10 @@ void show_ref_array_item(struct ref_array_item *info,
>  	if (format_ref_array_item(info, format, &final_buf, &error_buf))
>  		die("%s", error_buf.buf);
>  	fwrite(final_buf.buf, 1, final_buf.len, stdout);
> +	if (final_buf.len)
> +		putchar('\n');

While we are introducing a conditional, let's drop the useless
fwrite of 0-byte while we are at it [*1*], i.e.

	if (final_buf.len && !omit_empty_lines) {
		fwrite(final_buf.buf, 1, final_buf.len, stdout);
		putchar('\n');
	}

Thanks.


[Footnote]

*1* "While we are at it", the existing code tempts me to drop fwrite
    and replace it with something along the lines of...

	printf("%*s\n", count, buf)

    but I refrained from doing so.  An enhancement patch like this
    is not a place to "improve" existing code (which should be done
    as a separate patch).
