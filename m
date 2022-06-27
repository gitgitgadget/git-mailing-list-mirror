Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC94C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiF0MWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiF0MWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 08:22:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CABCB5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 05:22:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21AC2139FDC;
        Mon, 27 Jun 2022 08:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WeNL76XOD7xW+BQ1KlgZqD1OZ9UAnwN4AlLJcszCMPs=; b=rjdI
        gzaDQZxJQALC31gMqASpMcQLN0sPfFi42k7VzmvAZsWDBM3UFwbVl21cWLrFi8iO
        56CWj/vI0lt2RMBchI+3vh8MQVOTMUx8AY7ZJ1PVte7EJTePaVkV1fQhPvudJANM
        ddwmtw3evaFYx0EBHcrGBHQlh8P7nCz/RGaj3ZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18307139FDB;
        Mon, 27 Jun 2022 08:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58DF2139FD8;
        Mon, 27 Jun 2022 08:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/2] test-lib.sh: add limited processes to test-lib
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
        <cover.1656044659.git.hanxin.hx@bytedance.com>
        <442a4c351dea603e226bae89eddc2b3496d93262.1656044659.git.hanxin.hx@bytedance.com>
        <xmqqfsjuvyjz.fsf@gitster.g>
        <CAKgqsWVAy8RTSCwG=LVHPoeF5ECSzeNfK4mPacLo=dTeUkc6SA@mail.gmail.com>
Date:   Mon, 27 Jun 2022 05:22:07 -0700
Message-ID: <xmqqpmiuqosw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3F1393C-F613-11EC-99A0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

> Maybe I should use "lib-bash.sh" instead of "test-lib.sh" just like t9902
> and t9903?
> The different meanings of "-p" in bash and dash really make this tricky.

I do not think lib-bash.sh is appropriate for this.

t9902/9903 are about command line prompt and completion support
_FOR_ bash users.  By including lib-bash.sh, even if your "usual"
shell is not bash, you can run these two scripts under bash, as long
as you have it installed.

For the purpose of testing these bash specific features, that
framework makes quite a lot of sense.  Those who are happy to have
dash on their system without having to install bash would have no
reason to see these two tests to pass, as they do not care about
bash at all.

What the test under discussion is doing is quite different.  Instead
of forcing to re-spawn bash when the user's shell is not bash, you'd
want to adjust how you invoke "ulimit" if it is not bash, something
like

run_with_limited_processes () {
	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
}

test_lazy_prereq ULIMIT_PROCESSES '
	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
	if test -n "$BASH_VERSION"
	then
		ulimit_max_process="-u"
	elif test -n "$KSH_VERSION"
	then
		ulimit_max_process="-u"
	fi
        run_with_limited_processes true
'

perhaps?
