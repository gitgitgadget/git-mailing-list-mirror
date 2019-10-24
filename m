Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC671F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 04:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfJXEah (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 00:30:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56751 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfJXEah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 00:30:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 026591DA8C;
        Thu, 24 Oct 2019 00:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xnfYwb8uEJlI1IuzhIBV7KD4fKA=; b=EMkVR2
        xGza/cly70Rr9URcr/PPhjmA2+TtSNJoggUyqnUXC0HMZn2XXQbKJMnKOLw2rXue
        VAL+Xy8ZzhLWSHTgg16mClEHZIHBWtZkJeF18YrOaOvCvCPF/6TAMB1kFzHyqxs2
        UR3abh7/35k+hUFDkSkdthi0QonsIl8Fh2Xes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rmtH7s9AKidpyKao2Q+UuIHIncaP4We5
        UnQ9dz91I3QHy4A+KGO2DRnRqO7Dpv3P2bGaFMX+SV+27FEx8g66k3irgIqDW0qd
        TxzXtwJa2xW8dFhk6FWEz+f8jaZShNs20I3d8aE9ph2lrtAlNAVcA4QiV/yJg/94
        +HsGs2nvwpA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF5201DA8B;
        Thu, 24 Oct 2019 00:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67AF81DA8A;
        Thu, 24 Oct 2019 00:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
References: <20191007181825.13463-1-jonathantanmy@google.com>
        <20191023233403.145457-1-jonathantanmy@google.com>
Date:   Thu, 24 Oct 2019 13:30:33 +0900
In-Reply-To: <20191023233403.145457-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 23 Oct 2019 16:34:03 -0700")
Message-ID: <xmqqo8y6g3yu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0541F9E4-F617-11E9-8F5D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Suppose, from a repository that has ".gitmodules", we clone with
> --filter=blob:none:
>
>   git clone --filter=blob:none --no-checkout \
>     https://kernel.googlesource.com/pub/scm/git/git
>
> Then we fetch:
>
>   git -C git fetch
>
> This will cause a "unable to load config blob object", because the
> fetch_config_from_gitmodules() invocation in cmd_fetch() will attempt to
> load ".gitmodules" (which Git knows to exist because the client has the
> tree of HEAD) while fetch_if_missing is set to 0.
>
> fetch_if_missing is set to 0 too early - ".gitmodules" here should be
> lazily fetched.  Git must set fetch_if_missing to 0 before the fetch
> because as part of the fetch, packfile negotiation happens (and we do
> not want to fetch any missing objects when checking existence of
> objects)...

Is it only me to feel that this is piling band-aids on top of
band-aids?

Perhaps the addition (and enabling) of lazy-fetch should have been
done after "checking existence" calls are vetted and sifted into two
categories?  Some accesses to objects are "because we need it
now---so let's lazily fetch if that is available as a fallback
option to us", as opposed to "if we do not have it locally right
now, we want to know the fact".  And each callsite should be able to
declare for what reason between the two it is making the access.

The single fetch-if-missing boolean may have been a quick-and-dirty
way to get the ball rolling, but perhaps the codebase grew up enough
so that it is time to wean off of it?
