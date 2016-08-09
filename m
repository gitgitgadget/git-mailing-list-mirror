Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A277A1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 21:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbcHIVqE (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 17:46:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932416AbcHIVqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 17:46:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B731343EC;
	Tue,  9 Aug 2016 17:46:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hxuoqkfkhfRd4gziDoGHjZw+atE=; b=uoReTf
	k62bt0+Y/kETbGfOZk+0z4pAsyUJVqLuEaagospyIO1eEZmZMv8859E2Wfg2B/2m
	f0QpQ5kO0o8+qmJ2fBUhERxgWIkQV1Ikzo5AoqXp+hmmgTj+Rxn2UgoYaQa6DFIM
	dP+0JGW0CFksjqNsEo3+MqHLFiGGecTP6RLOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sRuqd6oDV0YDEH4PV5+ASsosLS+eNRH2
	KzmUAHkl1ASVWTlOLERJLkpOR8oGmgaGHzl3T2uRkH34Z+6K8jWL0I8Pj2PpnXr3
	MwutcbK7VmZVphJ1CzHtYo9GX7ZWvAo/gB2JyyFyiqNLrn+OH4qDZ91UubjfqPjw
	AHkIK6xI6RY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7359F343EB;
	Tue,  9 Aug 2016 17:46:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D976343EA;
	Tue,  9 Aug 2016 17:46:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
	<xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
	<xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
	<xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbPvj6dU1DMaCh7ieJbs0qWimdHSD8xFfUyV98md2pywQ@mail.gmail.com>
Date:	Tue, 09 Aug 2016 14:45:59 -0700
In-Reply-To: <CAGZ79kbPvj6dU1DMaCh7ieJbs0qWimdHSD8xFfUyV98md2pywQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 13:31:31 -0700")
Message-ID: <xmqqeg5x8vl4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA7BFB72-5E7A-11E6-857C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> At the time of cloning you may run
>
>   git clone --recursive --reference <other-super-project-location>
> or
>   git clone --recursive --reference-if-able <other-super-project-location>
> or
>   git clone --recursive

That's an interesting tangent.  I never meant "if-able" to be an
end-user visible option [*1*], but now you mention it, I do not see
a reason why "clone --reference-if-able" of the top-level project
cannot be used together with "--recursive".

> Then later when we run
>     git submodule update
> we have this option to know if a submodule alternate should be treated
> as optional or required referenced as the existence
> of the superprojects alternate (as a boolean indicator) is not enough of
> an indicator what the user later wants.

A tangent that comes to my mind after reading this is if letting
"if-able" just skip (with or without warning) and forget about it
once a clone is made is what we really want.

Suppose the "other-super-project-location" repository did not have a
clone of a submodule when you create a new clone of the superproject
using it as a reference.  The submodule will be made a full clone,
but after that happens, other-super-project-location can get
interested in the submodule and can acquire its own clone.

At that point, our clone of the submodule _could_ add the submodule
in the other-super-project-location as its alternate and lose the
duplicate objects that it could borrow from there by repacking, but
the suggested "clone with if-able, and forget about it after a clone
is made" would not allow us to do this.  I do not know if a
real-world use of submodules want the ability to do so, or it is
unnecessary.  I suspect with the recording of "you were told that
borrowing from the same location as the superproject is OK", this
becomes easily doable (i.e. subsequent "submodule update" can realize
that the submodule does not have alternates but it could borrow from
the submodule in the other-super-project-location).


[Footnote]

*1* Rather, I meant: clone has a very intimate knowledge on what and
    what cannot be borrowed from and it is not just "is there a
    directory?", so "git submodule update --init" is not in a good
    position to decide if it wants to add --reference to the
    invocation of "git clone" it makes internally, and introducing
    an "if-able" variant to "clone" is one way to relieve it from
    having to make that decision.

    I could have suggested an alternative: because the submodule
    machinery is gettting moved to C the "update --init" code that
    drives the internal invocation of "git clone" could share the
    the logic in "git clone --reference" that determines if a local
    repository can be used as an alternate by small refactoring of
    builtin/clone.c::add_one_reference().
