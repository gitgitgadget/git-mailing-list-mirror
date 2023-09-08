Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420C7EE801A
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbjIHQ0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjIHQ0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 12:26:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739381FE1
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 09:25:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58F2739015;
        Fri,  8 Sep 2023 12:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4Ty/1nGaRUOFnKUHUwWcvfv4vb+7PXJsPUMzXn
        u0eKI=; b=YLDkCYI/j5TQpIWhbNZsclT9xZTc6dVm4otwpRbIqK71F4FWfuTFHw
        BaQbvcpCnEkEZ2Cgg26FZ/Ghv/D2/Avg0FD3B8WxA76tw/RWeWlsrdnb8da49yJk
        5ncGUXVyRtfYn2aDtOuu7jp6WVkhepb+ZoRMENpi/r9+iBAsQ1JAE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5174739014;
        Fri,  8 Sep 2023 12:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E82A239013;
        Fri,  8 Sep 2023 12:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
In-Reply-To: <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com> (Phillip Wood's
        message of "Fri, 8 Sep 2023 16:53:21 +0100")
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
        <xmqqedj8vfht.fsf@gitster.g>
        <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
Date:   Fri, 08 Sep 2023 09:24:52 -0700
Message-ID: <xmqqmsxwtyy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E0B54CE-4E64-11EE-9BE4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/09/2023 16:42, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> [3] This is really a work-around for not moving the child into its own
>>>      process group and changing the foreground process group of the
>>>      controlling terminal.
>> I am puzzled, as I somehow thought that "does the user conceive a
>> subprocess as external and different-from-git entity, or is it
>> merely an implementation detail?  many use of subprocesses in our
>> codebase, it is the latter." from Peff was a good argument against
>> such isolation between spawning "git" and spawned subprocesses.
>
> It is and in those cases we do not ignore SIGINT and SIGQUIT in the
> parent when we fork the subprocess. What I was trying to say is that
> in the few cases where we do ignore SIGINT and SIGQUIT in the parent
> when we fork a subprocess we're working round the child being in the
> same process group at the parent.

Hmph, but picking a few grep hits for 'sigchain_push.*SIG_IGN' at
random, the typical pattern seem to be (this example was taken from
builtin/receive-pack.c):

	code = start_command(&proc);
	if (code) {
		...
		return code;
	}
	sigchain_push(SIGPIPE, SIG_IGN);
	while (1) {
		...
	}
	close(proc.in);
	sigchain_pop(SIGPIPE);
	return finish_command(&proc);

The way we spawn an editor in editor.c looks the same:

		p.use_shell = 1;
		p.trace2_child_class = "editor";
		if (start_command(&p) < 0) {
			strbuf_release(&realpath);
			return error("unable to start editor '%s'", editor);
		}

		sigchain_push(SIGINT, SIG_IGN);
		sigchain_push(SIGQUIT, SIG_IGN);
		ret = finish_command(&p);

IOW, we do not ignore then spawn.  We spawn and ignore only in the
parent, so there shouldn't be any reason to worry about our child
inheriting the "we the parent git process do not want to be killed
by \C-c" settings, should there?

I have a vague recollection that the "propagate what was already
ignored to be ignored down to the child, too" was not about signals
we ignored, but inherited from the end-user who started git with
certain signals ignored, but it is so old a piece of code that the
details of the rationale escapes me.
