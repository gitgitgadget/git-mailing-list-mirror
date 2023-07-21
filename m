Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73AEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 14:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGUOc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGUOcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 10:32:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24D2D71
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 07:32:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E03291A7C93;
        Fri, 21 Jul 2023 10:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RhIxjNRLA0rVaxxxcG07JHEmKj2Dll3GDjvSFY
        +D90k=; b=UQnZfUJwoIjkEkwXiX2xAHTWj0l9ekk89QVtAbWD17B9ukyHlk2VB+
        RvjsTWfkUFpouhyvoSQD4oxfkOnvE8nop00ib/qaurZKFRRfw/QlHQxtztKUAkPP
        9lVwGmEIiDilxS7qfg7HrlYvZ6A9I8rqOehy4FWiq+OG6QqBE0O2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7CD31A7C92;
        Fri, 21 Jul 2023 10:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3558B1A7C91;
        Fri, 21 Jul 2023 10:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Young <hanyang.tony@bytedance.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] blame: allow --contents to work with bare repo
References: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
        <20230721035758.61956-1-hanyang.tony@bytedance.com>
Date:   Fri, 21 Jul 2023 07:32:46 -0700
In-Reply-To: <20230721035758.61956-1-hanyang.tony@bytedance.com> (Han Young's
        message of "Fri, 21 Jul 2023 11:57:58 +0800")
Message-ID: <xmqq8rb9z65t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 765B83B0-27D3-11EE-A743-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Young <hanyang.tony@bytedance.com> writes:

> The --contents option can be used with git blame to blame the file as if
> it had the contents from the specified file. Since 1a3119ed06c8fbb1c00a6aa3615299252575abab ("blame: allow --contents to work with non-HEAD commit"), the --contents option can work with non-HEAD commit. However, if you try to use --contents in a bare repository, you get the following error:

When using the "show -s --pretty=reference --oneline", abbreviate
the commit object name to a reasonable length (like 8 to 12
hexadecimal digits).  Please wrap overlong lines.

I'll fix them up at the receiving end, if there is no other issues
in the patch.  Let's read on.

>  blame.c             | 4 +++-
>  t/annotate-tests.sh | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/blame.c b/blame.c
> index d12bd9f97..141756975 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -2806,7 +2806,9 @@ void setup_scoreboard(struct blame_scoreboard *sb,
>  			parent_oid = &head_oid;
>  		}
>  
> -		setup_work_tree();
> +		if (!sb->contents_from)
> +			setup_work_tree();
> +
>  		sb->final = fake_working_tree_commit(sb->repo,
>  						     &sb->revs->diffopt,
>  						     sb->path, sb->contents_from,

Thanks.

> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 2ef70235b..5e21e84f3 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -83,6 +83,15 @@ test_expect_success 'blame with --contents' '
>  	check_count --contents=file A 2
>  '
>  
> +test_expect_success 'blame with --contents in a bare repo' '
> +	git clone --bare . bare-contents.git &&
> +	(
> +		cd bare-contents.git &&
> +		echo "1A quick brown fox jumps over the" >contents &&
> +		check_count --contents=contents A 1
> +	)
> +'
> +
>  test_expect_success 'blame with --contents changed' '
>  	echo "1A quick brown fox jumps over the" >contents &&
>  	echo "another lazy dog" >>contents &&
