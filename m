Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA561FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 01:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbdCHBUe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 20:20:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65367 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933425AbdCHBUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 20:20:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA6B680C46;
        Tue,  7 Mar 2017 20:14:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6VXQJckF03kWZMOeufqiQt07y5M=; b=s19Yjt
        VIH2Ww2qZn975cQwuNrX5bHKg6+6Poh/sHLN1AdadEKZbw4KhwQ1ato7BQvA2hh8
        7I8S3GpYLcJGnOtTcmdnyFczL27fMmU17twEh1u0fKA6MCgM/VC/WFT2khnH7Rid
        OqT6iI9KVrMxC2wlQ3pvxYQTa8k/QxTvKT9oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jNt4osADKsMrKbQpdmOqlFDSSSOamR9n
        tCS/pzmvVAKYwItIrIp4tWTjDqv4CiPGvNI3XfBUbS9+Xl9YJVLHAvqP9oL50msk
        lKQVdDhPt8YvnoZ5m89eIzKXX7jqrR7QDn7elqutNZM0gTSRYtJGLsH+EdIMVsGp
        hZaAW5G/USQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D0380C45;
        Tue,  7 Mar 2017 20:14:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1E4780C44;
        Tue,  7 Mar 2017 20:14:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe selected submodules.
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-16-sbeller@google.com>
        <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbdJa54YyKPHR9ycuJBVtyNY_2yaD7_5RPPu++Awiz5cA@mail.gmail.com>
Date:   Tue, 07 Mar 2017 17:14:39 -0800
In-Reply-To: <CAGZ79kbdJa54YyKPHR9ycuJBVtyNY_2yaD7_5RPPu++Awiz5cA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 7 Mar 2017 15:37:28 -0800")
Message-ID: <xmqqlgsg4lj4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B236418-039C-11E7-87C5-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> submodule_from_ce returns always NULL, when such flag is not given.
> From 10/18:
>
> +const struct submodule *submodule_from_ce(const struct cache_entry *ce)
> +{
> +       if (!S_ISGITLINK(ce->ce_mode))
> +               return NULL;
> +
> +       if (!should_update_submodules())
> +               return NULL;
> +
> +       return submodule_from_path(null_sha1, ce->name);
> +}
>
> should_update_submodules is always false if such a flag is not set,
> such that we end up in the else case which is literally the same as
> the removed lines (they are just indented).

I see.  

I didn't think a function this deep in the callchain that does not
take any parameter could possibly change the behaviour based on the
end-user input.  I was expecting that such a state (i.e. are we
recursive?  are we allowed to forcibly update the working tree
files?) would be kept part of something like "struct checkout" and
passed around the callchain.

That was why I didn't look at how that function answers "should
update?" question, and got puzzled.  Because it would imply there is
some hidden state that is accessible by everybody--a global variable
or something--which would point at a deeper design issue.
