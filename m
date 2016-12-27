Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E47C200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbcL0R1f (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:27:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755530AbcL0R1d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 12:27:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 522F05853F;
        Tue, 27 Dec 2016 12:27:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AmDIxoKfBZKrzpADd6A775R48Wk=; b=wRpX6N
        LctrflMjru3ZJub9qIlJas5XmTLvXPIztMJ9vV7vaqt6m796NuztbevsS4IhK9pd
        +hp4pT3ppKIAE8JKS/m+s5wr8hstbyhp9TSnOCWWz7AvzoA1UFwyeyy5efh2qYGV
        BV6jOcMZUA17CUfCsVbIJ0uUZH8L1U/Z1PCn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XknND/2Ac7vv5/aE3I3bx7HURp7ODDNb
        zMyuEajTgwR6+uhosAKMvRJPcBJsP3GOFRm07U7jH1qQlPzBPMcVcdEdQyA6MXjm
        //al1nC3Ibk2fd/MDl5c7zOAu4YKNkTT4zFtVfpzq/FqNnJXEpyqhF10g66DUTgV
        sGH5mahDdp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA1E5853D;
        Tue, 27 Dec 2016 12:27:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C68FC5853C;
        Tue, 27 Dec 2016 12:27:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-apply: warn/fail on *changed* end of line (eol) *only*?
References: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
        <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Dec 2016 09:27:22 -0800
In-Reply-To: <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 25 Dec 2016 19:25:10 -0800")
Message-ID: <xmqq8tr1cmf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAB9CB3E-CC59-11E6-B334-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Imagine that the project wants LF line endings, i.e. it considers
> that a line with CRLF ending has an unwanted "whitespace" at the
> end.  Now, you start from this source file:
>
>     1 <CRLF>
>     3 <CRLF>
>     5 <CRLF>
>
> and a patch like this comes in:
>
>      1 <CRLF>
>     -3 <CRLF>
>     +three <CRLF>
>      5 <CRLF>
>
> You think that "3 <CRLF>" was replaced by "three <CRLF>", and the
> claim is "the 'previous' contents already had <CRLF> ending, so the
> change is not making things worse".

To see the problem with "check existing lines", it probably is
easier to extend the above example to start from a file with one
more line, like this:

    1 <CRLF>
    3 <CRLF>
    4 <LF>
    5 <CRLF>

and extend all the example patches to remove "4 <LF>" line as well,
where they remove "3 <CRLF>", making the first example patch like
so:

     1 <CRLF>
    -3 <CRLF>
    -4 <LF>
    +three <CRLF>
     5 <CRLF>

Now, if you take "three <CRLF>" to be replacing "3 <CRLF>", then you
may feel that not warning on the CRLF would be the right thing, but
there is no reason (other than the fact you, a human, understand
what 'three' means) to choose "3 <CRLF>" over "4 <LF>" as the
original.  If you take "three <CRLF>" to be replacing "4 <LF>", you
would need to warn.

A totally uninteresting special case is when the original is all
<CRLF>, but in that case, as you already said in the original
message, the project wants <CRLF> and you can configure it as such.
Then <CR> in the line-end <CRLF> won't be mistaken as if it is a
whitespace character <CR> at the end of a line terminated with <LF>.
