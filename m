Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69853202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 01:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbdCPBcF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 21:32:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750788AbdCPBcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 21:32:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9273A81E6A;
        Wed, 15 Mar 2017 21:32:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hHIONa50Lz1+HVGkr+7dpPMavwA=; b=yFkoub
        cnjhc1hY3X03sYr8Ww7ML+hH34Dn5DcB1BySRkg7kIU2sp7UP8IlvIPFSP1pvoH1
        hUifF7Ty1lbEkLbbs3YoZsEbDF6HfJn+YshPnzvpEPEA83swgjxvtdP+USfwzTQV
        KlNB9Vi6Xiz+tWYoGqlm/xXvMwBTJyR/bvan8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D4vzEl3l2AIkrETmeHfFXj2Xy4W/w9Yw
        bSx9EChiBiyVBIT06CELT0UPztEVwI6aVnvs2/JnBlBgBPm6MzEv54wqCFHC+iXn
        1g5BJ54RmjYdiphxobhulUttRwgkj31br5uAd6mgxp4bo0OI6CmdKU7IlxUv93cb
        qVoYO49+1fU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B66181E67;
        Wed, 15 Mar 2017 21:32:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB4E581E65;
        Wed, 15 Mar 2017 21:32:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [RFC PATCH] short status: improve reporting for submodule changes
References: <20170316003332.30918-1-sbeller@google.com>
Date:   Wed, 15 Mar 2017 18:31:59 -0700
In-Reply-To: <20170316003332.30918-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Mar 2017 17:33:32 -0700")
Message-ID: <xmqqvarac8hc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AC4434A-09E8-11E7-914F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> While we already have a porcelain2 layer for git-status, that is accurate
> for submodules, users still like the way they are are used to of
> 'status -s'.
>
> As a submodule has more state than a file potentially, we'll look at all
> cases:
>
>    ------ new submodule commits
>  /  ----- modified files
>  | /   -- untracked files
>  | |  /
>  | | |   current / proposed reporting
>  0 0 0     "  "     "  "
>  0 0 1     " M"     " ?"
>  0 1 0     " M"     " m"
>  0 1 1     " M"     " m"
>  1 0 0     " M"     " M"
>  1 0 1     " M"     " M"
>  1 1 0     " M"     " M"
>  1 1 1     " M"     " M"

You are essentialy saying that there are three levels, 1. with
commit level difference, 2. the same commit with local mods, 3. no
mods but with crufts, and instead of wasting 8 letters to express
all combinations, the highest level is reported, right?  That sounds
OK to me.  I am not sure if "?" is a good letter to use (doesn't it
usually mean it is an untracked cruft?), though.

Does the commit level difference really mean "has new commits"?  It
probably is not new problem but an old mistake inherited from the
current code, but I suspect that you're just comparing the commit
bound in the index of the superproject and the HEAD commit in the
submodule, in which case "newness" does not matter a bit---"is it
the same or different?" is the question you are asking, I would
think.


