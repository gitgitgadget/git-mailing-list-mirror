Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6F8208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbdIEViS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:38:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752803AbdIEViR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:38:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 504579238D;
        Tue,  5 Sep 2017 17:38:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yz7ycUwqqEKOMT5FO+xMRkLNUPo=; b=j22DwL
        V+92dFqy10a5xAgoBhMS1ris/6XKn6J6MCsPIrvu+/vKQYpyOBE7ayPqihMT59n7
        ZRSLw53sBygqZtTHFt22afqLAULvP0edYanlMD30SPai4fw97oWEjA/oTiVa6lXJ
        TBhSjCwBeEzGLaAUoIzjwIWWRNe8z3M7VNK0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rend8rZQReBwKSOfzRTn+c/Y2Jb+SLhX
        WHJdsHFlqbxpIUAkjDNrnZ3bAM/LQzIVf+o2dnR5KUwcrl5XC7tdMO+kVahp6fQ5
        +/LsrzvmsYZ8pkwrhohvZy2gt2nSuXmBylK8TjcniS6tG8n7ZJaWlTyx5nLiq5X/
        jF7/SQmVbJQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 468429238C;
        Tue,  5 Sep 2017 17:38:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A12D39238B;
        Tue,  5 Sep 2017 17:38:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/merge: honor commit-msg hook for merges
References: <20170905210116.26343-1-sbeller@google.com>
Date:   Wed, 06 Sep 2017 06:38:15 +0900
In-Reply-To: <20170905210116.26343-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 5 Sep 2017 14:01:16 -0700")
Message-ID: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87052C4E-9282-11E7-B17B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Similar to 65969d43d1 (merge: honor prepare-commit-msg hook, 2011-02-14)
> merge should also honor the commit-msg hook; the reason is the same as
> in that commit: When a merge is stopped due to conflicts or --no-commit,
> the subsequent commit calls the commit-msg hook.  However, it is not
> called after a clean merge. Fix this inconsistency by invoking the hook
> after clean merges as well.

The above reads better without "; the reason is the same as in that
commit"---"Similar to", combined with the clean and concise
explanation after the colon you have, sufficiently justifies why
this is a good change.  

Excellent job spotting the precedent and making it consistent ;-).

> This change is motivated by Gerrits commit-msg hook to install a change-id

s/Gerrits/Gerrit's/ perhaps?

> trailer into the commit message. Without such a change id, Gerrit refuses

I do not live in Gerrit land and I do not know which one is the more
preferred one, but be consistent between "change-id" and "change
id".

> to accept (merge) commits by default, such that the inconsistency of
> (not) running commit-msg hook between commit and merge leads to confusion
> and might block people from getting their work done.

Yup.  Nicely explained.

I didn't check how "merge --continue" is implemented, but we need to
behave exactly the same way over there, too.  Making sure that it is
a case in t7504 may be a good idea, in addition to the test you
added.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/merge.c            |  8 ++++++++
>  t/t7504-commit-msg-hook.sh | 45 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7df3fe3927..087efd560d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -73,6 +73,7 @@ static int show_progress = -1;
>  static int default_to_upstream = 1;
>  static int signoff;
>  static const char *sign_commit;
> +static int no_verify;
>  
>  static struct strategy all_strategy[] = {
>  	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> @@ -236,6 +237,7 @@ static struct option builtin_merge_options[] = {
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
>  	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> +	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),

This allows "--no-no-verify", which may want to be eventually
addressed (either by changing the code not to accept, or declaring
that it is an intended behaviour); I do not offhand know for sure but I
strong suspect "commit" shares the same issue, in which case this
patch is perfectly fine and addressing "--no-no-verify" should be
done for both of them in a separate follow-up topic.  #leftoverbits

Thanks.  I'll be online starting today, but please expect slow
responses for a few days as there is significant backlog.

