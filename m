Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D651FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbcGSSTQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:19:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752868AbcGSSTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 084D12BAB6;
	Tue, 19 Jul 2016 14:19:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LM07EOTaUqelu/4ngDBt4KLErA0=; b=LAQnTX
	sXsCS5ZzrqnYiey8BWbPb5H4G2Pob1cwz3X9y8facTXJ0CuZkX/zp6rG3lwhzhKX
	I9hUQ3lEsRv/5I8Jm7XDRE/CVL34UY8mwOBb50dOLwmLSdwwpYb82m6yQZjV+F9c
	BupvRkvx+9q6glT5CqJwEqu6MNEcodA60qqig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3TOyBnkZSlXYIAWPe2H7REmscAtSdlj
	/kAoFp0yldwnU1UQzDdpmXVzRUjRtNgKdADoCU+YaAMhS9qNzD5ejZBA+TmxXiU3
	3F0lT0MvylcHGbc1uVxUMxU2BdNhKEHAiADEFd9OSzM95l6q57qxHIlxLUAf1JmA
	vX2SqWap63s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 00E912BAB3;
	Tue, 19 Jul 2016 14:19:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A6612BAB2;
	Tue, 19 Jul 2016 14:19:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] difftool: avoid $GIT_DIR and $GIT_WORK_TREE
References: <20160719035756.24961-1-davvid@gmail.com>
	<20160719035756.24961-2-davvid@gmail.com>
Date:	Tue, 19 Jul 2016 11:19:08 -0700
In-Reply-To: <20160719035756.24961-2-davvid@gmail.com> (David Aguilar's
	message of "Mon, 18 Jul 2016 20:57:55 -0700")
Message-ID: <xmqqy44xfq3n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49F2BB86-4DDD-11E6-95B3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Environment variables are global and hard to reason about.
> Use the `--git-dir` and `--work-tree` arguments when invoking `git`
> instead of relying on the environment.
>
> Add a test to ensure that difftool's dir-diff feature works when these
> variables are present in the environment.

Yes, that is a very good idea.  I was wondering what would happen
with that "must-not-unset-nor-smudge if it already is set" thing.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 42a2929..fa43c24 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -412,6 +412,22 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
>  	)
>  '
>  
> +run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
> +	(
> +		GIT_DIR=$(pwd)/.git &&
> +		export GIT_DIR &&
> +		GIT_WORK_TREE=$(pwd) &&
> +		export GIT_WORK_TREE &&
> +		cd sub &&
> +		git difftool --dir-diff $symlinks --extcmd ls \
> +			branch -- sub >output &&
> +		sane_unset GIT_WORK_TREE &&
> +		sane_unset GIT_DIR &&

It is not wrong per-se, but as you are in a subshell, you do not
have to unset these, I would think.  Not worth a reroll, but unless
I am overlooking something (in which case please holler) I'm
inclined to remove these two lines myself while queuing the series.

Thanks.

> +		grep sub output &&
> +		! grep file output
> +	)
> +'
