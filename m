Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4E020A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLIB5t (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:57:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59745 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLIB5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:57:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1733B2E835;
        Sat,  8 Dec 2018 20:57:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+TdilhoB47q46YmQ9LtY1JkUvk=; b=pYJTSS
        W9aG/pad7mPaNZwEmkkFFLtkNF1fa5ZO4L0d7lV8/rNjTUZwF/hhBmiF9FKz3zgQ
        tOjm70kWoi4Fnkr8zMfygUEfLhVim+X2okQNXwXim8platYNzJRd+9afNf2Rps4n
        aahb9yYd0EmAe3IVyqgd67p4IHm9N12bpqEaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X9A+sU1BjJsvguySN4yBLFeVZW4Xh3pF
        nFEM7bzvle8vXns7J+GQGF6/d2yyFYQba0RO57epuxPLy7CD6A+yFcP59PGgKuG+
        lvqRRAKtAOVrhlJGw0qxOXJrdrX/faQc4UlRFUhG1zSVboPRssj0u+ox4kH13VtR
        3XsLH6Y1G+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F5BF2E834;
        Sat,  8 Dec 2018 20:57:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 294F42E833;
        Sat,  8 Dec 2018 20:57:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Subject: Re: [PATCH] fetch: ensure submodule objects fetched
References: <20181205010704.84790-1-jonathantanmy@google.com>
        <20181206212655.145586-1-sbeller@google.com>
Date:   Sun, 09 Dec 2018 10:57:44 +0900
In-Reply-To: <20181206212655.145586-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 6 Dec 2018 13:26:55 -0800")
Message-ID: <xmqq1s6r5unb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2C6B0DE-FB55-11E8-BDAD-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently when git-fetch is asked to recurse into submodules, it dispatches
> a plain "git-fetch -C <submodule-dir>" (with some submodule related options
> such as prefix and recusing strategy, but) without any information of the
> remote or the tip that should be fetched.
>
> But this default fetch is not sufficient, as a newly fetched commit in
> the superproject could point to a commit in the submodule that is not
> in the default refspec. This is common in workflows like Gerrit's.
> When fetching a Gerrit change under review (from refs/changes/??), the
> commits in that change likely point to submodule commits that have not
> been merged to a branch yet.
>
> Fetch a submodule object by id if the object that the superproject
> points to, cannot be found. For now this object is fetched from the
> 'origin' remote as we defer getting the default remote to a later patch.
>
> A list of new submodule commits are already generated in certain
> conditions (by check_for_new_submodule_commits()); this new feature
> invokes that function in more situations.
>
> The submodule checks were done only when a ref in the superproject
> changed, these checks were extended to also be performed when fetching
> into FETCH_HEAD for completeness, and add a test for that too.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Thanks Jonathan for the review!
> So it looks like only the last patch needs some improvements,
> which is why I'd only resend the last patch here.
> Also note the test with interious superproject commits.

Sorry, can't parse the last sentence.

Anyway, will replace the last step with this.  Thanks.

