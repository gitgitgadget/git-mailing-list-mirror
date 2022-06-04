Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAEDCCA47D
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 09:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiFDJpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiFDJpY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 05:45:24 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10251C92C
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 02:45:21 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39492329"
Received: from unknown (HELO [10.28.4.153]) ([109.190.253.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 11:45:12 +0200
Message-ID: <4808601e-d05e-0bfc-177f-bfa46154fe22@univ-lyon1.fr>
Date:   Sat, 4 Jun 2022 11:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] merge with untracked file that are the same
 without failure
Content-Language: en-US
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     "cogoni.guillaume@gmail.com" <cogoni.guillaume@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
 <be2297bdcd724c3f8abfde2d5d74fb18@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <be2297bdcd724c3f8abfde2d5d74fb18@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/22 21:55, Jonathan Bressat wrote:
> Keep the old behavior as default.
> 
> Add the option --overwrite-same-content, when this option is used merge
> will overwrite untracked file that have the same content.
> 
> It make the merge nicer to the user, usefull for a simple utilisation,

make_s_

usefull -> useful

utilisation -> use

> for exemple if you copy and paste files from another project and then

ex_a_mple.

> you decide to pull this project, git will not proceed even if you didn't
> modify those files.

I'd avoid saying "you" in a commit message. "the user" seems clearer to me.

Also, don't use the future to talk about the behavior before the patch, 
it's really confusing. Actually, the commit message talks about the 
previous behavior, but doesn't really document the new one.

> +--overwrite-same-content::
> +       Silently overwrite untracked files that have the same content
> +       and name than files in the merged commit from the merge result.

I don't understand what "in the merged commit from the merge result" means.

Perhaps "overwrite" is not the best name. We actually re-use the file 
without touching it.

> --- /dev/null
> +++ b/t/t7615-merge-untracked.sh

Why a new file? These are minor variants of the ones you just added in 
the previous commit, and would deserve being written next to them.

> +test_expect_success 'fastforward overwrite untracked file that has the same content' '
> +test_expect_success 'fastforward fail when untracked file has different content' '
> +test_expect_success 'normal merge overwrite untracked file that has the same content' '
> +test_expect_success 'normal merge fail when untracked file has different content' '
> +test_expect_success 'merge fail when tracked file modification is unstaged' '

We're making a lot of tests, very similar to each other and very similar 
to other existing ones. I think we've reached the point where we need to 
refactor a bit and write one generic function that covers

- index state : same / different
- worktree state : same / different
- --overwrite-untracked : present / absent
- kind of merge : fast-forward / real merge

and then call this function with the appropriate set of parameters. 
Either the function can be called within tests (each test becoming a 
one-liner), or perhaps the function can call test_expect_success and 
then we can write stg like

for index in same different
do
	for worktree in same different
	do
	...
		run_test_merge $index $worktree ....
	done
done

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2257,6 +2257,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
>   	if (result) {
>   		if (result->ce_flags & CE_REMOVE)
>   			return 0;
> +	} else if (ce && !ie_modified(o->src_index, ce, st, 0)) {
> +		if(o->overwrite_same_content) {
> +			return 0;
> +		}

This looks good, but honestly I'm a bit lost between o->src_index, 
o->dst_index and o.result, so the review of someone more familiar with 
this part of the codebase would be welcome.

> + * is not tracked, unless it is ignored or it has the same content
> + * than the merged file with the option --overwrite_same_content.

"same content _as_".

-- 
Matthieu Moy
https://matthieu-moy.fr/
