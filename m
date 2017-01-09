Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E4D20756
	for <e@80x24.org>; Mon,  9 Jan 2017 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbdAIJ2I (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 04:28:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57593 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932627AbdAIJ2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 04:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EC07560F5;
        Mon,  9 Jan 2017 04:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mIMd3kvCrHxfYfpjN+b0Sd1TUic=; b=fSYNHo
        WW7JqgEOlirJukfgA4usiPrtE0eKat+fEhr08BR/chRQVPZBaBOHzWZPiToa7/ks
        /JisKkeBVq0oSv7tWNH8ASqNThD30LVsF9pDfXLIqhFWqq7X2r5Psna0TVNVP1ud
        nDucElB9o3RVrPlVt/8Q2MfDqxinKDfvUYHeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBe3OpxfHkNJ5EorTch1oRGHNSKU3lKg
        4MMPsXSJcvD0HJ9/u0B5urGuvzMCXUUSwmRPtTwoNqiXAUZDlehkoT/eePZ8ijOn
        FLNbdM3EsQm3UEM0yjxh/XzsoiMkkgDBCgdW9Au+PoGhNmfN1GTw+uCoDpRtbV+f
        oPf7IpqtfJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5573B560F4;
        Mon,  9 Jan 2017 04:28:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B480C560F3;
        Mon,  9 Jan 2017 04:28:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
Date:   Mon, 09 Jan 2017 01:28:03 -0800
In-Reply-To: <alpine.DEB.2.20.1701090825510.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 08:46:19 +0100 (CET)")
Message-ID: <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC5A4576-D64D-11E6-8143-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you feel strongly about your contrived examples possibly being
> affected by this patch, we could easily make this conditional on
>
> 1) no '&&' or '||' being found on the command-line, and
> 2) argv[0] not containing an '='
>
> Another approach would be to verify that argv[i] starts with '-' for
> non-zero i.
>
> But do we really need to do that?

No.  An explicit way to override an incorrect guess is sufficient
and necessary.  The above two-item list you gave will be just part
of the machinery to make an incorrect guess.  The auto-detection in
the posted patch should cover many users' use case and I do not
think it needs to be extended further to make it more brittle, as by
definition its guess cannot be perfect.  Just keep it simple and
give a separate escape hatch.

> That means that the user has to specify something like
>
> 	HAHAHA_IT_IS_NOT=/plink.exe ssh
>
> as GIT_SSH_COMMAND.

My second message was to clarify that "VAR1=VAL2 command" is NOT a
contrived example, and this response indicates that I somehow failed
to convey that to you.  The "if tortoiseplink exists (and the end
user can override the location with an environment), use that, and
if PuTTY plink exists (ditto), use that instead" in a "myssh"
script, and use it as core.sshcommand with the environment to
override my custom installation location to these two programs,
would be what I would do when I get two Windows machines, with these
variants of SSH on each.  So take the second message as a bug report
against the version of Git for Windows you ship with the patch in
question.

The auto-detection may work for many people and that is a great
thing.  I failed to say that in my message, as I thought that was
obvious.  But it is important to plan to cope with the case where it
does not work.  The usual practice around here is to say "the it may
not necessarily work for everybody, so lets be prepared to add an
explicit override if it turns out to be necessary".  

The second message, which you are responding to, was meant to be a
bug report from the future, telling us that an override is needed,
showing that we do not have to wait for a bug report to act on.

