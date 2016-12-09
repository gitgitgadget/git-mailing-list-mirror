Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395201FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbcLITHa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:07:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51398 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752635AbcLITH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:07:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7B9E56443;
        Fri,  9 Dec 2016 14:07:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5nqBr5i95IyLUKZZC4NkZjWld/E=; b=TqaK8S
        GoLjJBJ/UD8D9fwzXW+rRZLoWgWf8ICGRAlymBYuTZ9GF9bOw3XXn8HbAcvm2eG7
        ovuPaSNB/7JSP7VL6IHAFRf5sfOQKcJIqAR4whh0lL5Tv6EBdYY+131rIGCrL0ju
        thAeEf5g7qXcLixxCr/bJp11KG8zqzCLYuNe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g5Bnmj6COsGwqoTOGIblhtwRsFpB5+tN
        4PoFEn2SNOLJASdBhIvdPKy10EJL9WcxTvuTpHQJVteaD8SB6l5dOLA15IhUkiJ8
        D6o+VSdIaqek4Br8k7phYDeO3pMyLpSveyu/eR+g3tiowY4yxi5aVdhhU0Q6r3wY
        8+jNa65Uzpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DDC556442;
        Fri,  9 Dec 2016 14:07:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 201C756440;
        Fri,  9 Dec 2016 14:07:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Klaus Ethgen <Klaus@Ethgen.ch>, git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
        <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
Date:   Fri, 09 Dec 2016 11:07:25 -0800
In-Reply-To: <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Dec 2016 10:22:19 -0500")
Message-ID: <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B98BEAD2-BE42-11E6-9F33-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> (One other option is to just declare that the quarantine feature doesn't
> work with colons in the pathname, but stop turning it on by default. I'm
> not sure I like that, though).

I think we long time ago in 2005 have declared that a colon in a
directory name would not work for Git repositories because of things
like GIT_CEILING_DIRECTORIES, GIT_ALTERNATE_OBJECT_DIRECTORIES; so I
do not think we terribly mind that direction.

> Here's a rough idea of what the quoting solution could look like. It
> should make your case work, but I'm not sure what we want to do about
> backwards-compatibility, if anything.

Yes, obviously it robs from those with backslash in their pathnames
to please those with colons; we've never catered to the latter, so I
am not sure if the trade-off is worth it.

I can see how adding a new environment variable could work, though.
A naive way would be to add GIT_ALT_OBJ_DIRS that uses your quoting
when splitting its elements, give it precedence over the existing
one (or allow to use both and take union as the set of alternate
object stores) and make sure that the codepaths we use internally
uses the new variable.  But if the quarantine codepath will stay to
be the only user of this mechanism (and I strongly suspect that will
be the case), the new environment could just be pointing at a single
directory, i.e. GIT_OBJECT_QUARANTINE_DIRECTORY, whose value is
added without splitting to the list of alternate object stores, and
the quarantine codepath can export that instead.
