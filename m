Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F4520954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdKZDqQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:46:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752028AbdKZDqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:46:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B97FFAE4C2;
        Sat, 25 Nov 2017 22:46:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HGhJG7Tq0fmbKbW6Y6iHDs3fqmI=; b=Yqbc9r
        CR6XcTE2MlLr2AaGCzQqYkNYTTDT67tVhFgcPSwfI2s9j3z+h+VX5wILecCiCHHd
        mPSDLSBMIT7MwHgFBKF3v8HFy/qmL4/5YmyyHbFImYDgTQ8LMwp6MHxvTDmHYWJF
        2KJ/N0gdkkK44XaEX+BubBx88cDiBW/VFYC1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DHTxOoCN95TSmHLEYODQ8p9Zmo8Ns0zR
        YqdqHOmqa7BDa/0l7t8V15m9weLDdoTUjW/O/Omku6dnA3+zyCPUYRANzbQZ/AYH
        pEbjgSbe5/FvPyxd9zYmy5P8DnwkPr0ijwnDZx70mwV5RxP5OqR6DmgvKJTMc9Ao
        EdoaBcn3OuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1EA1AE4C1;
        Sat, 25 Nov 2017 22:46:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E181AE4C0;
        Sat, 25 Nov 2017 22:46:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126015448.24111-1-max@max630.net>
        <20171126015448.24111-2-max@max630.net>
Date:   Sun, 26 Nov 2017 12:46:12 +0900
In-Reply-To: <20171126015448.24111-2-max@max630.net> (Max Kirillov's message
        of "Sun, 26 Nov 2017 03:54:47 +0200")
Message-ID: <xmqqo9npitx7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59B63B60-D25C-11E7-9F00-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> Author: Florian Manschwetus <manschwetus@cs-software-gmbh.de>

This should read "From: ...";

> Date: Wed, 30 Mar 2016 09:08:56 +0000
>
> http-backend reads whole input until EOF. However, the RFC 3875 specifies
> that a script must read only as many bytes as specified by CONTENT_LENGTH
> environment variable. Web server may exercise the specification by not closing
> the script's standard input after writing content. In that case http-backend
> would hang waiting for the input. The issue is known to happen with
> IIS/Windows, for example.
>
> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the variable is not defined, keep older behavior
> of reading until EOF because it is used to support chunked transfer-encoding.
>
> Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> [mk: fixed trivial build failures and polished style issues]
>
> Signed-off-by: Max Kirillov <max@max630.net>

There shouldn't be a blank line before your sign-off.

The above are only for future reference; I can fix them up before
queuing if there isn't any other issues in this patch.


> +ssize_t git_env_ssize_t(const char *k, ssize_t val)
> +{
> +	const char *v = getenv(k);
> +	if (v && !git_parse_ssize_t(v, &val))
> +		die("failed to parse %s", k);
> +	return val;
> +}
> +

If this were passing "v" that is a string the caller obtains from
any source (and the callee does not care about where it came from),
that would be a different story, but as a public interface that is
part of the config.c layer, "k" that has to be the name of the
environment variable sticks out like a sore thumb.

If we were to add one more public function to the interface, I
suspect that exposing the existing git_parse_ssize_t() and have the
caller implement the above function for its use would be a much
better way to go.
