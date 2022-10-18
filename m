Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD69C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 04:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJRERR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 00:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRERP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 00:17:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F7795E6A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 21:17:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 837A11B651A;
        Tue, 18 Oct 2022 00:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9hdJAtcTETkM5vPsSYGzJ5Z91VbnmQC7nJ8WNq
        wcSF4=; b=BvVUuDt4CuD+0xuOLnjgsTjRngXkGu2TjmYSpyVMUOryS55/SH22X9
        SJuB1i7taJnTkRvoGYoNAZTrlg+1JTaLT9ITH0d0xQTLD3swNIerk/V5CmZYUiBY
        bc0Qp7oXUZKPC3Lx8LmUqPve5k6MoXgXs9eBsHRVbloABW8A4yJBE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BC011B6518;
        Tue, 18 Oct 2022 00:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA0601B6515;
        Tue, 18 Oct 2022 00:17:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 17 Oct 2022 21:17:08 -0700
In-Reply-To: <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 17 Oct 2022 15:14:04 -0700")
Message-ID: <xmqqo7u9wyt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBDDF452-4E9B-11ED-9BDB-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc:

Thanks for a report.

How dissapointing.  The thing is that the topic has been in 'next'
since the 11th (i.e. early last week), and I know that you guys rely
on the tip of 'next' in working order to cut your internal releases,
but we did not hear about this until now.  What makes it taste even
worse is that nobody else caught this, even though we seem to have a
couple of macOS jobs at GitHub Actions CI, there we didn't see any
breakage related to this.

Possible action items:

 * See what configurations our two macOS jobs are using.  If neither
   is using sha1dc, I would say that is criminal [*] and at least
   one of them should be updated to do so right away.

 * The "two macOS CI jobs sharing too many configuration knobs" may
   not be limited to just SHA-1 implementation, but unlike Linux
   builds and tests, we may have similar "monoculture" issue in our
   macOS CI builds.  Those users, who depend on macOS port being
   healthy, should help identify unnecessary overlaps between the
   two, and more importantly, make sure we have CI builds with
   configuration similar to what they actually use.

 * Adding a few build-only-without-tests CI jobs also might help.

 * Those who depend on working macOS port, especially those with
   corporate backing who choose to use configurations that are
   different from what we have CI builds for, are requested to
   arrange a more frequent build test to catch a problem like this
   much earlier.

Anything else I forgot that we can do to improve the situation?  I
personally do not use macOS, I am not interested in using one, but
I do value those who choose to use macOS have happy git working on
their platform, so the stakeholders need to chip in.

Thanks.


[Footnote]

 * Until the world migrates over to SHA-256, the collision detecting
   SHA-1 implementation is what we must use unless there is a strong
   reason not to.  If we are not testing something that ought to be
   the default, we are not doing a very good job.

