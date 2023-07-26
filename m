Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F272C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGZQ77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGZQ75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 12:59:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AA9C
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:59:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1680C1801B;
        Wed, 26 Jul 2023 12:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ChahStGQ3qeL2HWFcseqT6f0FORxHQDYCMGNYo
        RzAwA=; b=N+ocBSkHlpvu3Y22xtGLDTah/09XIM8PLjilv89LbjBJOLBNA2ll3J
        4XfhrnJLoXzyEhaZ9huweQFIEJViiji8KmBLTb8ygo5PWwCZXEuCwhI7R4q6JVC1
        blSvsw87fjsdrdqige6sf0MajvmqpasBVJlpP68gwSp7lZI695/ro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E9EF1801A;
        Wed, 26 Jul 2023 12:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8472B18018;
        Wed, 26 Jul 2023 12:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Louis Strous <Louis.Strous@intellimagic.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How to make "git bisect visualize" use gitk on Windows?
References: <VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM>
Date:   Wed, 26 Jul 2023 09:59:51 -0700
In-Reply-To: <VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM>
        (Louis Strous's message of "Wed, 26 Jul 2023 09:53:01 +0000")
Message-ID: <xmqq4jlqehh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6B9E35E-2BD5-11EE-9588-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Louis Strous <Louis.Strous@intellimagic.com> writes:

> I use git version 2.41.0.windows.3 on Microsoft Windows 11.  I
> would like to have "git bisect visualize" use gitk instead of git
> log, but cannot figure out how to do that.  The documentation at
> https://git-scm.com/docs/git-bisect says that gitk is the default
> but "If the DISPLAY environment variable is not set, git log is
> used instead".  I haven't found a description of what I should set
> the DISPLAY environment variable to on Windows to get gitk to be
> used.  I've tried setting it to "whatever" and ":0" but then still
> got git log instead of gitk.  How do I arrange for "git bisect
> visualize" to use gitk on Windows?

There are others who do Windows, but unfortunately I do not.  I hope
some of them may be able to offer more directly useful suggestions.

But I see the following is in builtin/bisect.c:bisect_visualize():

	if (!argc) {
		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") ||
		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk")) {
			strvec_push(&cmd.args, "gitk");
		} else {
			strvec_push(&cmd.args, "log");
			cmd.git_cmd = 1;
		}
	} else {
		if (argv[0][0] == '-') {
			strvec_push(&cmd.args, "log");
			cmd.git_cmd = 1;
		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
			cmd.git_cmd = 1;

		strvec_pushv(&cmd.args, argv);
	}

So presumably "git bisect visualize" (without any other parameter)
would invoke "gitk" as long as (1) one of these environment
variables are set, regardless of their values, and (2) "gitk" is
available on $PATH.  

I see on a random stackoverflow page that MSYSTEM is set and
exported on MSYS2 default shell, so presumably Git for Windows
environment has it already, so whether you have DISPLAY set or
unset, the first half of the condition should already be met.

The above code also says that "git bisect visualize -3" would always
invoke "log", not "gitk", regardless of the environment settings (I
mention this only because from your problem description, I cannot
read what exact command line invocation you are having trouble
with).





