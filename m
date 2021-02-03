Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2177C43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8942F64DE7
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhBCWOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 17:14:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59855 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhBCWOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 17:14:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECED4A05BE;
        Wed,  3 Feb 2021 17:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O23EUVtliNpmA2uPzgIuCjrd4/o=; b=QsDajW
        pn1mqXOcxzbpRL1OS29kTdJ7qpxNS6ByrHRTeZXSlV12Dp9JBcnOrxGU9OMUirUI
        Z3gef3WRD99tbgxtdZPvB2IRqquPeCh+XHUe7AwzZWhcn8E/PzeyetqBM1EIba7e
        F+D8ZPecVTujfGcfAShq0zm68QFfnxUSMUrQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZMH0HVh5czu6fX5RuVBZFs6BROJU3Rb/
        MHdoXg2hWPxdOYbaoclSnjszuSMeZ58QgvHKBHu+C2003H9W+Xeulu4uAFSARoZx
        YfA7tRy/hq35XMTuGDakdfJNulipobF/L+uPVRgVPGDITVnP82EzwnVqtlvo/Zno
        Zy8r9lvWVFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4A0BA05BD;
        Wed,  3 Feb 2021 17:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66517A05BA;
        Wed,  3 Feb 2021 17:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4 1/1] MacOS: precompose_argv_prefix()
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210203162823.15756-1-tboegi@web.de>
        <xmqq35ydc5g3.fsf@gitster.c.googlers.com>
Date:   Wed, 03 Feb 2021 14:13:53 -0800
In-Reply-To: <xmqq35ydc5g3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 03 Feb 2021 11:33:00 -0800")
Message-ID: <xmqqh7msbxzy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A5843C0-666D-11EB-A407-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Just as the prefix-less variant was idempotent and that was the
> reason why cmd_diff_files() had its own precompose() even if the
> incoming argv[] is supposed to be already precomposed because it
> was processed in another call to precompose() in run_builtin(),
> this patch keeps these seemingly redundant calls, because it is not
> meant as a clean-up but as a bugfix for the prefix part.
>
> OK. ... Ah, no, the call in run_builtin() is a new thing.  We didn't
> have it, and the redundant call is what this patch introduced, so
> we need to be a bit more careful about the analysis here.  It is one
> thing to say "we leave the existing iffy code and address only a
> single bug" and do so.  It is entirely different to say so and then
> do "we introduce an iffy code and address only a single bug".  We
> need to admit that what we added _is_ iffy but supposed to be safe.
> Just saying "it is supposed to be safe" without saying why it is
> iffy is dishonest and does not help future developers who may want
> to jump in and clean the code.
>
> Perhaps
>
> 	Now add it into git.c::run_builtin() as well.  Existing
> 	precompose calls in diff-files.c and others would become
> 	redundant but because we do not want to make sure that there
> 	is no way for the control to reach them without passing
> 	run_builtin(), we'll keep them in place just in case.  The
> 	calls to precompose() are idempotent so it should not hurt.
>
> or something?

FYI, I've tweaked the proposed log message like the following before
queuing.  I think that would be explicit enough to remind us that we
may be able to improve the situation fairly easily.

Thanks.


1:  071dfe8793 ! 1:  5c327502db MacOS: precompose_argv_prefix()
    @@ Commit message
     
         The original patch for preocomposed unicode, 76759c7dff53, placed
         precompose_argv() into parse-options.c
    -    Now add it into git.c (as well) for commands that don't use parse-options.
    -    Note that precompose() may be called twice - it is idempotent.
    +
    +    Now add it into git.c::run_builtin() as well.  Existing precompose
    +    calls in diff-files.c and others may become redundant, and if we
    +    audit the callflows that reach these places to make sure that they
    +    can never be reached without going through the new call added to
    +    run_builtin(), we might be able to remove these existing ones.
    +
    +    But in this commit, we do not bother to do so and leave these
    +    precompose callsites as they are.  Because precompose() is
    +    idempotent and can be called on an already precomposed string
    +    safely, this is safer than removing existing calls without fully
    +    vetting the callflows.
     
         There is certainly room for cleanups - this change intends to be a bug fix.
         Cleanups needs more tests in e.g. t/t3910-mac-os-precompose.sh, and should


