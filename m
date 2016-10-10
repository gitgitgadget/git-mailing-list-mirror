Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055D520989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbcJJWnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:43:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59054 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752232AbcJJWnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:43:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7806446CE;
        Mon, 10 Oct 2016 18:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=39XIOU6wapoREwCW4oQ7J8rClBY=; b=CvE9+u
        PpIxivq7lKJnGeR56NQtkvt0eZrFVol8GfVlFplj90dVJtHnWr9clcMXA8kxiCYM
        s4ebl/qbS0iCXnaCpwxYkGTGDhq2AA9QORBgCRF4mKfxIQdXmFlVcA3cjYC/ZK8J
        ICFVmuZqkiXv+AVbT0rsZsm0VwETfKAuHccq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sHTE1EPCPpLJbXr0TrKbpLo0Bl9SMzd+
        dTjZsnrEQAi08YnoZ+jbYiV4bivnR3XXsDf3m143O+korHBNtGBHB9Lv19k/Iycw
        idnP/M1Hsld6aYQRUSUDisAHe8wgiowG+xNhAstXGe5p+wCCpYiKdRtoWkzzD+og
        T3PH48ywbLU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD9CA446CC;
        Mon, 10 Oct 2016 18:43:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C961446CB;
        Mon, 10 Oct 2016 18:43:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
References: <cover.1475851621.git.hvoigt@hvoigt.net>
        <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
        <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
Date:   Mon, 10 Oct 2016 15:43:13 -0700
In-Reply-To: <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
        (Stefan Beller's message of "Fri, 7 Oct 2016 10:59:29 -0700")
Message-ID: <xmqqvawzbzb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE7AE7FC-8F3A-11E6-9CC1-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
>> +               const char *path)
>
> So this will take the stringlist `submodules` and insert the path into it,
> if it wasn't already in there. In case it is newly inserted, add a sha1_array
> as util, so each inserted path has it's own empty array.
>
> So it is both init of the data structures as well as retrieving them. I was
> initially confused by the name as I assumed it would give you sha1s out
> of a string list (e.g. transform strings to internal sha1 things).
> Maybe it's just
> me having a hard time to understand that, but I feel like the name could be
> improved.
>
>     lookup_sha1_list_by_path,
>     insert_path_and_return_sha1_list ?

I do not think either the name or the "find if exists otherwise
initialize one" behaviour is particularly confusing, but I do not
think "maintain a set of sha1_arrays keyed with a string" is a so
widely reusable general concept/construct.  As can be seen easily in
the names of parameters, this function is about maintaining a set of
sha1_arrays keyed by paths to submodules, and I also assume that the
array indexed by path is not meant to be a general purpose "we can
use it to store any 40-hex thing" but to store something specific.

What is that specific thing?  The names of commit objects in the
submodule repository?

I'd prefer to see that exact thing used to construct the function
name for a helper function with specific usage in mind, i.e.
get_commit_object_names_for_submodule_path() or something along that
line.
