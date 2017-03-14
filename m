Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8421F20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdCNVik (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:38:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751707AbdCNVik (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:38:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 757646D0F3;
        Tue, 14 Mar 2017 17:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G9+V1NbwXJWgEaQdA/Cbwv8lAp8=; b=p0CWC8
        GeihjFDHMYSKyRdCmGmv7xpRVibJv0Mr/LswEDOBjsc83/r0d2KQ/gwcu5rWm4MJ
        UqjKvSdWdnucMae/ZwTy36GYYncSce5AzSJkAmTtnXI6tFGeynVKDB67eLEElTzf
        dM5/hfygvRNuvoK2ePYyDajOySEuOtD5eNUYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cq3ZmNFtvAAQ90yAoAe9xQCmKUNgyDgu
        YX84jvlwqTvZG0d5+rrVjYzR1cTv+MYrg6vuIXouJZwXEaGIPtYMto+ThJZHno/5
        A+Dxgn0Ue7ChEe7XdJVq6GKfA3hqoinx0/bUQpTZs608NIpS7qBst3+8mJIEkQmT
        gMN9YDkCD0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D29F6D0F2;
        Tue, 14 Mar 2017 17:38:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DACA06D0F1;
        Tue, 14 Mar 2017 17:38:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 05/10] submodule: decouple url and submodule existence
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-6-bmwill@google.com>
        <xmqqzignittf.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Mar 2017 14:38:36 -0700
In-Reply-To: <xmqqzignittf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 14 Mar 2017 11:42:20 -0700")
Message-ID: <xmqqlgs7h737.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9562F900-08FE-11E7-8B6B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also submodule.active that takes pathspec and not name is an oddball
> (use of "name" not "path" is to prepare for a submodule whose
> location in the superproject changes depending on the commit in the
> superproject), and we need to justify with an explanation.  I think
> you envision two cases.  1. we encourage projects to adopt a
> convention that submodules are grouped with leading directory, so
> that pathspec e.g. lib/, would cover _all_ library-ish modules to
> allow those who are interested in library-ish modules to set
> ".active = lib/" just once to say any and all modules in lib/ are
> interesting.  2. another convention the projects can adopt, when
> pathspec-attribute feature is invented, is to label submodules with
> attribute to group them, so that a broad pathspec with attribute
> requirement, e.g. .:(attr:lib), can be used to say any and all
> modules with 'lib' attribute are interesting.

One addition to the point 2. above is that because .gitattributes,
just like .gitmodules, is tracked by the superproject, and when a
submodule that moves in the superproject tree, the project can
adjust which path gets the attribute in .gitattributes, just like it
can adjust which path has the submodule in .gitmodules.  That makes
a broad pathspec with attribute requirement just as a viable
solution to identify a submodule as having an unchanging "name" for
a submodule in the .gitmodules file.

> The above two points (justifications, intended uses and future
> plans) need to be clarified around here (and possibly in the
> documentation), I would think.
