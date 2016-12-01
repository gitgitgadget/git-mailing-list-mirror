Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFC71FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758718AbcLASqa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:46:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61106 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758658AbcLASq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:46:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69A7C51F45;
        Thu,  1 Dec 2016 13:46:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5TQsiFFEYz5wWiQFdfOb5tGLOrw=; b=vyAww+
        w8NEJkxNAiKCNhSbOUPXUluhbw2h4bqL4qo66pPa2cNaQf44NqhvzBb2rODHUoZI
        f8EE9z9xu6xE2fOSBYA9Q+GVpWaGE7V78PdrUeG9Sz64noX0nFKJz7FCO/O2T+yy
        zY7yXMDIUX7a8B8oH0HYChweqqHPzotrXisGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ecUPSXKyyWoUHmOt6OGsOhCPu3fIYMMm
        3sOpspHaywuR0gGz/bxJs+ljr1ZsXd4AbSMUwpq5gJXzkOm0zZ+1QUa/PaBxELdD
        a4l9E4+IJ5xOhhoPNB6kZ+HYoMHYSbl1ZS83A2u4OLyBSaY+lSMN3EpY/veCzmuL
        yF24s9rrwkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BEEE51F44;
        Thu,  1 Dec 2016 13:46:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5F3751F41;
        Thu,  1 Dec 2016 13:46:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine presence of submodules
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
        <1480555714-186183-1-git-send-email-bmwill@google.com>
        <1480555714-186183-2-git-send-email-bmwill@google.com>
        <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 10:46:23 -0800
In-Reply-To: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 30 Nov 2016 23:29:27 -0500")
Message-ID: <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7666C4B8-B7F6-11E6-8829-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 30, 2016 at 05:28:29PM -0800, Brandon Williams wrote:
>
>> +/*
>> + * Determine if a submodule has been populated at a given 'path'
>> + */
>> +int is_submodule_populated(const char *path)
>> +{
>> +	int ret = 0;
>> +	struct stat st;
>> +	char *gitdir = xstrfmt("%s/.git", path);
>> +
>> +	if (!stat(gitdir, &st))
>> +		ret = 1;
>> +
>> +	free(gitdir);
>> +	return ret;
>> +}
>
> I don't know if it's worth changing or not, but this could be a bit
> shorter:
>
>   int is_submodule_populated(const char *path)
>   {
> 	return !access(mkpath("%s/.git", path), F_OK);
>   }
>
> There is a file_exists() helper, but it uses lstat(), which I think you
> don't want (because you'd prefer to bail on a broken .git symlink). But
> access(F_OK) does what you want, I think.
>
> mkpath() is generally an unsafe function because it uses a static
> buffer, but it's handy and safe for handing values to syscalls like
> this.

I think your "unsafe" is not about thread-safety but about "the
caller cannot rely on returned value staying valid for long haul".
If this change since v5 is about thread-safety, I am not sure if it
is safe to use mkpath here.

I am a bit wary of making the check too sketchy like this, but this
is not about determining if a random "path" that has ".git" in a
superproject working tree is a submodule or not (that information
primarily comes from the superproject index), so I tend to agree
with the patch that it is sufficient to check presence of ".git"
alone.
