Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE6C1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbcKQWFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:05:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752355AbcKQWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BBBE51512;
        Thu, 17 Nov 2016 17:05:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xf2D5UL2TlnFNg20BKQmlOL7U80=; b=eJdNmm
        zontfcZVFMbLZpNvjFcq+AE2i1LQqxsppL3hAphgFbW+mA/U+UgXtBDiNXTeOWBD
        TG4noh9dWDBQu+65we1pKAIHVPYztsyedJVxTrcpb5WIJjRdAt9zwBOL9ABr7N+5
        U884m8cyMZfTJRpLp9Qm9MdKCIOOpRnPfPNcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I5XqJEHgcjZYzwqTYDeqbXJFe966e5xq
        0fXODYJ1vrDIG3qyRTOekBIgSfq6noAxtRfU2LROU7+KjIA7pCiDAOX6g//3DU2G
        wkH7XU11EhNdbvTD5ghzg5Eh8slQtHnNRDciUH06tVjVqkg1EdjOwoqXpMfQWlyd
        2er1yRAQz6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21B6F51511;
        Thu, 17 Nov 2016 17:05:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 846B351510;
        Thu, 17 Nov 2016 17:05:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-17-Karthik.188@gmail.com>
        <xmqqinrlopge.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 17 Nov 2016 14:05:51 -0800
In-Reply-To: <xmqqinrlopge.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 17 Nov 2016 11:50:57 -0800")
Message-ID: <xmqqa8cxoj7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0161B086-AD12-11E6-9BC3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One worry that I have is if the strings embedded in this function to
> the final format are safe.  As far as I can tell, the pieces of
> strings that are literally inserted into the resulting format string
> by this function are maxwidth, remote_prefix, and return values from
> branch_get_color() calls.
>
> The maxwidth is inserted via "%d" and made into decimal constant,
> and there is no risk for it being in the resulting format.  Are
> the return values of branch_get_color() calls safe?  I do not think
> they can have '%' in them, but if they do, they need to be quoted.
> The same worry exists for remote_prefix.  Currently it can either be
> an empty string or "remotes/", and is safe to be embedded in a
> format string.

In case it was not clear, in short, I do not think there is anything
broken in the code, but it is a longer-term improvement to introduce
a helper that takes a string and returns a version of the string
that is safely quoted to be used in the for-each-ref format string
use it like so:

    strbuf_addf(&remote,
		"%s"
		"%%(align:%d,left)%s%%(refname:strip=2)%%(end)"
		...
                "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
	        quote_literal_for_format(branch_get_color(BRANCH_COLOR_REMOTE)),
		...);

and the implementation of the helper may look like:

    const char *quote_literal_for_format(const char *s)
    {
        static strbuf buf = STRBUF_INIT;

        strbuf_reset(&buf);
        while (*s) {
            const char *ep = strchrnul(s, '%');
            if (s < ep)
                strbuf_add(&buf, s, ep - s);
            if (*ep == '%') {
                strbuf_addstr(&buf, "%%");
                s = ep + 1;
            } else {
                s = ep;
            }
        }
        return buf.buf;
    }

