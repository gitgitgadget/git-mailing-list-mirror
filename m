Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18964C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbiC3SPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbiC3SPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:15:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34DE8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:13:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0A11125FB2;
        Wed, 30 Mar 2022 14:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l3b9HYmkXLo7hFhuZ0ww99GAgDRZIrxxY3cv75
        u7pmQ=; b=abQ3O8ExWXjGGuMEZ8TrnxHP6mAhojd1YBmZaHcFpzDZ6vy08aeK0g
        W9K7A19CFyAuKdnkbGd/0lDqzfUGyj1lcXfTk1T+B0AqWJgsvwqCSABObzd8oGLj
        /Oe/G5YQCCMQFPHXVuvbjzNM0gO0ecn3hKnS6Xba+yIZgLxr8MVIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8411125FB1;
        Wed, 30 Mar 2022 14:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37BC3125FB0;
        Wed, 30 Mar 2022 14:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 11/14] core.fsyncmethod: tests for batch mode
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <1a4aff8c350b5ffe3c7760faa4accc88c83ce11c.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 11:13:56 -0700
In-Reply-To: <1a4aff8c350b5ffe3c7760faa4accc88c83ce11c.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:29
        +0000")
Message-ID: <xmqqbkxn8g0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A72C144-B055-11EC-A21E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> new file mode 100644
> index 00000000000..34c01a65256
> --- /dev/null
> +++ b/t/lib-unique-files.sh
> @@ -0,0 +1,34 @@
> +# Helper to create files with unique contents
> +
> +# Create multiple files with unique contents within this test run. Takes the
> +# number of directories, the number of files in each directory, and the base
> +# directory.
> +#
> +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
> +#					 each in my_dir, all with contents
> +#					 different from previous invocations
> +#					 of this command in this run.
> +
> +test_create_unique_files () {
> +	test "$#" -ne 3 && BUG "3 param"
> +
> +	local dirs="$1" &&
> +	local files="$2" &&
> +	local basedir="$3" &&
> +	local counter=0 &&

The cover letter mentioned that in this round, "local var=val" is
avoided?

I've seen instances of local being "curious", e.g.
  https://lore.kernel.org/git/20220125092419.cgtfw32nk2niazfk@carbon/
and the discussion indicates that it may still be relevant.

> +	local i &&
> +	local j &&
> +	test_tick &&
> +	local basedata=$basedir$test_tick &&
> +	rm -rf "$basedir" &&
> +	for i in $(test_seq $dirs)
> +	do
> +		local dir=$basedir/dir$i &&

This, too.

To summarize the findings from the thread is:

 - very old releases of /bin/dash that predates Git, like 0.3.8,
   would not correctly handle assignment on "local" at all.  It may
   not matter to us.

 - semi-old /bin/dash 0.5.10, which is still in use, mishandled
   'local var=$val', but 'local var="$val"' is an acceptable
   workaround for the bug.  "git grep" tells us that we use this
   form in our shell scripts quite a lot, so we may be OK.

 - /bin/dash 0.5.11, which was tagged mid 2020, and newer would glok
   'local var=$val' just fine even $val has $IFS whitespace in it.

So, I'd say the safe practice we should adopt is to use "local" one
per variable, assignment to the variable on the same line of "local"
is OK, but unlike the regular assignment, older dash may mishandle
the right-hand-side unless it is quoted, i.e.

    local var='string literal'
    local var="$variable interpolation"

