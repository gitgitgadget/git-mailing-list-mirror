Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11A0202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbdCHRYN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:24:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55321 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750849AbdCHRYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:24:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE42B6AB34;
        Wed,  8 Mar 2017 12:09:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sOGmK6jVdeZzyczf2tiQ1ElgE2E=; b=c2bP8A
        jkbe7Fup4m9cRJXJIk0AiyPHLYLZ80T4KvWN4ff1KKD1inWlA4hSaB5bF2fjOhaB
        7Tczrzt/cLhMp+sb+SUZzvbav4md5u3oPSILHMhF/OjV3dkLhgd7JcM5QEy/W6k3
        J9JJT1kMlCH/YK75nyCq7MQz788O/gsp4Kvqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g7y9QLxKma28BsmlNIDjM2gENQUTj8GB
        6hF/3HC8QP5xeClmHrZw2BqksXoYVn/a1lpkPq13WfqvGV5HRAdx7a/Eox0AyeA+
        go+6Mk+FFes2+UffjXTBfNIAkRZLJOquDtwQ3+ofedWx26HS+1941sebPfyFDzz8
        a7gT/Z/2Qm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7EDA6AB32;
        Wed,  8 Mar 2017 12:09:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 587866AB31;
        Wed,  8 Mar 2017 12:09:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
        <cover.1488562287.git.johannes.schindelin@gmx.de>
        <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
        <alpine.DEB.2.20.1703071314180.3767@virtualbox>
        <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
Date:   Wed, 08 Mar 2017 09:09:31 -0800
In-Reply-To: <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Mar 2017 02:30:35 -0500")
Message-ID: <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF6B9078-0421-11E7-95AB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good catch. Another "non-gentle" thing I noticed here while looking at
> another thread: the repository-format version check uses the config
> parser, which will die() in certain circumstances. So for instance:
>
>   $ git init
>   $ git rev-parse && echo ok
>   ok
>
>   $ echo '[core]repositoryformatversion = 10' >.git/config
>   $ git rev-parse && echo ok
>   fatal: Expected git repo version <= 1, found 10

Just to set my expectation straight.  Do you expect/wish this not to
fail because of this in cmd_rev_parse()?

	/* No options; just report on whether we're in a git repo or not. */
	if (argc == 1) {
		setup_git_directory();
		git_config(git_default_config, NULL);
		return 0;
	}

Because we do not have anything other than yes/no to the question
"Are we in Git repository?", I'd expect that the expected answer to
the question would be "no" (if we could say "Yes, we are in a Git
repository but its version and layout is unknown to us so we are not
supposed to look at or touch it", that is a different matter).

So "fatal:" may be bad, but I think not seeing "ok" is what we
want to happen in this case.

Having said that, I am not sure asking for default-config is what we
wanted to do in the above code.  Perhaps a more modern way to write
the above code would be to do the "gently" version of setup, without
calling git_config() ourselves, and return the resulting value
returned in *nongit_ok?  If we can do so without triggering "fatal:"
and still return "no, we are not in a Git repository we are supposed
to touch", that would be good.

Or are you discussing a more general issue, iow, anything that can
work without repository (i.e. those who do _gently version of the
setup and act on *nongit_ok) should pretend as if there were no
(broken) repository and take the "no we are not in a repository"
codepath?
