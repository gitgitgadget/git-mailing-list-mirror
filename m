Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99DEB64DD
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 02:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGQCho (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGQChn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 22:37:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A17198E
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 19:37:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B302F185A5;
        Sun, 16 Jul 2023 22:36:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZgUp5O5lxmWi
        pKjXNhe/gJhRFVsJ8sqsrGTaozOy2o0=; b=tTedLd0sw3MBfwaye32QKbRzK8Rt
        p/IVnCOT4AYzt3PM3CW2ucAjmVZlkZXYPFC4WVn+IBZsTEjD1few316uqdOg8Ciy
        84JXAQlwfVs3/vhvR9dFPPQcGWFp8pKvNGpBP8ubfLv+CGiKMcOKVhHVeMc1CbAH
        DaoOM7VBmV6Jsf0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABC8C185A4;
        Sun, 16 Jul 2023 22:36:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E07E185A2;
        Sun, 16 Jul 2023 22:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     nick <nick@nicholasjohnson.ch>, git@vger.kernel.org
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
        <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
        <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
        <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
Date:   Sun, 16 Jul 2023 19:36:22 -0700
In-Reply-To: <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 16 Jul 2023 13:47:29 +0200")
Message-ID: <xmqqsf9njmc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B857C9FE-244A-11EE-8810-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> But Git is not a legal entity, it's just a command line program that yo=
u,
> the data subject, control.  You can use the  option --date or the
> environment variable GIT_AUTHOR_DATE to set the author timestamp and th=
e
> variable GIT_COMMITTER_DATE to set the committer timestamp on commit.
> Not sure why there is no command line option for the latter, hmm.

For two reasons.

 * While using the GIT_AUTHOR_DATE environment variable is perfectly
   adequate (after all, we did not have the option before Git 1.7.0,
   released in Feb 2010), overriding the author time with "--date"
   had a good reason to exist, unlike the committer timestamp.

   Imagine you were relayed somebody else's changes, not via a
   format that is kosher and acceptable by "git am", but somehow
   managed to reproduce in your working tree.  If you also have
   learned when and in which timezone the original author made that
   change, you'd want to have a way to record it.

 * Having a system clock that can randomly go backwards and using
   such a system clock to record the committer timestamp, has broken
   "git log" in mergy-bushy histories.  This issue has been somewhat
   mitigated by introduction of generation numbers, but traversing
   the commits in the newer part of the history that are not yet
   covered by commit-graph would be affected if you let your commit
   timestamps go back and force deliberately.

> So I see this more as a usability issue.  Git allows its users to tailo=
r
> commits to suit their needs in many ways.  You can edit file contents,
> history and metadata.  For timestamp and timezone this isn't as
> convenient as it could be.

I think the existing two environment variables are very good place
to draw the line.  When we start talking about "privacy", just like
"security", the exact details of the design and the implementation
would affect the resulting quality of the "privacy enhancing
features", but our primary mission is source code control and we are
not equipped to even measure how good our implementation would be.

Just like we do not pretend to be security engineers and do not
invent our own implementations of the hash functions and secure
network transports (instead we let third-parties to implement them
and just use them), we should NOT be adding a "--privacy" option
that picks rand(24)*60 as UTC offset and pretends that it the
timezone of the author, and picks some random timestamp between the
timestamp of the latest commit in the repository and the actual
wallclock timestamp and pretends that is the author time.  After
all, our project is not about coming up with a quality time
obfusucation.

But the good thing is that privacy-minded folks can write a quality
implementation of a much better design to lie about the timezone and
the current time, preferrably (but not absolutely necessary) within
the constraints that the time should not go backwards, which would
help Git.  Once such an external program is written, the users can
arrange that the program is called every time the shell gives the
control back to the user to set its output to GIT_AUTHOR_DATE.  Zsh
has precmd mechansim that you can use to invoke such a mechanism
before each prompt; bash has PROMPT_COMMAND that can used in a
similar way.

Needless to say, such a "privacy enhancing `date` command" can be
used outside the context of Git, too.  My point is that it is not
within the scope of this project to add an internal implementation
of such a command and drive that from a command line option or a
configuration variable.

Thanks.
