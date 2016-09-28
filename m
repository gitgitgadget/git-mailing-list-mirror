Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418DE1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbcI1S0V (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:26:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754028AbcI1SWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:22:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 822F3424CB;
        Wed, 28 Sep 2016 14:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WIam0YZutsakx1cDDO84geNSgeQ=; b=iiER1T
        DoIr30cNzQUMY59Ph/A/TsUbj2kEE0ppdHvgmGLvaulFIC/REE6lt0/KdR24O3rc
        YMA+0TXqQeokNYademWVmvA2icry2wS2FgczywFzVrszmrJiOzYkxbxjtf0nglim
        GK1vQHYLsbsKSGOqmm4AzOJrjbG9TY8y8GCsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p7Q8Ngle4Nl+F7Y65DifXIsvTA56U8Vo
        v0jfJcvLYt6rMWmcFDnPUdfNen5UQNYJL30nivetO6qvAhC4/LDrOerie04skklH
        IvEptF4qvSEsKGUywkWYohO8XuBSNJ6W3fea5L+flj6N8aBMhIdxrBXrCH4Cz5dQ
        jgrjYml643k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 798C2424C2;
        Wed, 28 Sep 2016 14:22:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E260D424C0;
        Wed, 28 Sep 2016 14:22:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <20160927215143.GA32622@starla>
        <xmqqshslkndk.fsf@gitster.mtv.corp.google.com>
        <xmqqy42cj5g1.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 28 Sep 2016 11:22:04 -0700
In-Reply-To: <xmqqy42cj5g1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 28 Sep 2016 10:32:30 -0700")
Message-ID: <xmqqd1jnkhpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 766F7E30-85A8-11E6-B530-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> What "git clone" should have been was:
>
>     * Parse command line arguments;
>
>     * Create a new repository and go into it; this step would
>       require us to have parsed the command line for --template,
>       <directory>, --separate-git-dir, etc.
>
>     * Talk to the remote and do get_remote_heads() aka ls-remote
>       output;
>
>     * Decide what fetch refspec to use, which alternate object store
>       to borrow from; this step would require us to have parsed the
>       command line for --reference, --mirror, --origin, etc;
>
>     --- we'll insert something new here ---
>
>     * Issue "git fetch" with the refspec determined above; this step
>       would require us to have parsed the command line for --depth, etc.
>
>     * Run "git checkout -b" to create an initial checkout; this step
>       would require us to have parsed the command line for --branch,
>       etc.
>
> Even though the current code conceptually does the above, these
> steps are not cleanly separated as such.  I think our update to gain
> "resumable clone" feature on the client side need to start by
> refactoring the current code, before learning "resumable clone", to
> look like the above.
>
> Once we do that, we can insert an extra step before the step that
> runs "git fetch" to optionally [*1*] grab the extra piece of
> information Kevin's "prime-clone" service produces [*2*], and store
> it in the "new repository" somewhere [*3*].
>
> And then, as you suggested, an updated "git fetch" can be taught to
> notice the priming information left by the previous step, and use it
> to attempt to download the pack until success, and to index that
> pack to learn the tips that can be used as ".have" entries in the
> request.  From the original server's point of view, this fetch
> request would "want" the same set of objects, but would appear as
> an incremental update.

Thinking about this even more, it probably makes even more sense to
move the new "learn prime info and store it in repository somewhere,
so that later re-invocation of 'git fetch' can take advantage of it"
step _into_ "git fetch".  That would allow "git fetch" in a freshly
created empty repository take advantage of this feature for free.

The step that "git clone" internally drives "git fetch" would not
actually be done by spawning a separate process with run_command()
because we would want to reuse the connection we already have with
the server when "git clone" first talked to it to learn "ls-remote"
equivalent (i.e. transport_get_remote_refs()).  I wonder if we can
do without this early "ls-remote"; that would further simplify
things by allowing us to just spawn "git fetch" internally.

