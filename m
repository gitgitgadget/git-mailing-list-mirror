Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEAFC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2D32074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KO1kKb3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIWpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:45:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61042 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDIWpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:45:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B729BCF1F;
        Thu,  9 Apr 2020 18:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qYH92QgYHB2m
        KajONVZ9e6Qo6TI=; b=KO1kKb3K0TqteD3Jivj0JyPMnXxTUxznTf8Fqh796BG8
        TNaxIjz5YsABaRLSRKCpF7bCO6zLnhTTo19hYCwH1z634tnWBaATG7n1l79Qbbas
        i9NYJlZd+BqN2isCQwew/3Zd+Esb/7xm+ULpePCjhSELt9oqiIWB6N8RLexLBvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yBbNgw
        vcN3fc7yrytOuWgEMmyB0ade8pcqYnbdqkJZYM7tycz+KXgmWSLLacFMKt+dJOXf
        FpGMBAM8H5zM1DXpu8ke52IyYj5Cjll+XZ3B5IKkFhuhkpBCkb+GW3mlzUOFy2U7
        91ZJcQxvjyiOPRTwG1U4SoBCK64McLn7zY9ZU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83767BCF1E;
        Thu,  9 Apr 2020 18:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1CB1BCF1D;
        Thu,  9 Apr 2020 18:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
Date:   Thu, 09 Apr 2020 15:45:04 -0700
In-Reply-To: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        (=?utf-8?Q?=22=C3=89rico?= Rolim"'s message of "Thu, 9 Apr 2020 19:22:34
 -0300")
Message-ID: <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1D778CE-7AB3-11EA-925C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=89rico Rolim <erico.erc@gmail.com> writes:

> I have found a bug in the git-diff utility, which is reproducible in
> the next branch. In any repository, if I run
>
>     git diff :/any/path/
>
> (The important part is the trailing forward slash. No slash will
> generate either a valid diff or an error message about the path not
> being known. ":/" also works without issue)

This is 'next' running for me:

    $ git diff :/any/path
    fatal: ambiguous argument ':/any/path': unknown revision or path not =
in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

If looking for a commit that has a string "any/path" in its commit
message may be consuming stack resources that are proportional to
the depth of the history, however, I can imagine that it might run
out of the memory and die, though.  Another thing that may be
interesting to try is to use "git rev-parse :/any/path" in the same
repository you are having trouble with.  If the "string :/any/path to
a revision" logic is where it is dying, it would die the same way.

Thanks.



