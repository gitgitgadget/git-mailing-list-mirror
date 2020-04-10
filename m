Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C41C2BB86
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA462137B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5ZBJ5aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDJQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:44:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62893 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 12:44:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A2A760151;
        Fri, 10 Apr 2020 12:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pUjAUBpBn1lsFr+SgGQnK+FmDLw=; b=i5ZBJ5
        aMUt6Vs2fq6TnQVT+IZJjvGOF/7skxlYRzt9WOyIGb4kiNVbOISVkY4F4O9VARek
        wW5yUoVkolieFaEzv4NXFpre+dUdee2DdCCcuTbc9PFzfHw6g+gVM+QwRxJD5EnS
        KZtV7AqqZcVs2dAbziWtV6FAmDv/9hpLxg380=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ztb/RVLNpV+EVN9QiYnnuAfMIn1MCYjK
        7GBr6G+OitjmQkfYRK1UPhayJhRCxtMfsiwafkJp2jLHIVM0leoy31/Ke2nK3v06
        ydKRirL60wYSDMt5g2aGWd9wnQu+2+JK2QxBK3V5N83kPaqhP16aCOF+eE79O8lV
        TGo1MS5E/FA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E8E60150;
        Fri, 10 Apr 2020 12:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FD3E6014F;
        Fri, 10 Apr 2020 12:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge: use skip_prefix to parse config key
References: <20200410151032.23198-1-martin.agren@gmail.com>
        <20200410155827.GA71011@coredump.intra.peff.net>
Date:   Fri, 10 Apr 2020 09:44:56 -0700
In-Reply-To: <20200410155827.GA71011@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Apr 2020 11:58:27 -0400")
Message-ID: <xmqqo8rzjnnb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C346856-7B4A-11EA-ABD0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In general, parsing subsections accurately involves looking from both
> the start and the end of the string, pulling out the section and key and
> leaving the rest in the middle. But I think we can get away with this
> left-to-right parsing because we're only interested in matching a
> _specific_ subsection name, and a specific key. So there are no cases it
> will handle incorrectly.

In other words, if k were "branch.A.B.mergeoptions", it can only be
the 'branch.*.mergeoptions' variable attached to branch "A.B", but
when checking for branch=="A", the first two skip_prefix() would
pass and the only thing that protects us from misparsing is that
"B.mergeoptions" is not what we are looking for.

> The more general form would be:
>
>   const char *subsection, *key;
>   int subsection_len;
>
>   if (!parse_config_key("branch", &subsection, &subsection_len, &key) &&
>       subsection_len == strlen(branch) && !strncmp(subsection, branch) &&
>       !strcmp(key, "mergeoptions"))
>          ...
>
> but that's a bit more awkward (it would be less so if we had a helper
> function for comparing a NUL-terminated string against a ptr/len pair).

Yes, but even with such a helper, i.e.

	if (branch &&
	    !parse_config_key("branch", &sub, &sublen, &key) &&
	    !spanstrcmp(sub, sublen, branch) &&
	    !strcmp(key, "mergeoptions"))

what Martin wrote, especially if it is reflowed to match the above, i.e.

	if (branch &&
	    skip_prefix(key, "branch.", &sub) &&
	    skip_prefix(sub, branch, &sub) &&
	    !strcmp(sub, ".mergeoptions")

I find it just as, if not more, easy to read.

Where the parse_config_key() helper shines, I think, is when we do
not have the middle level to compare against, and in that case, we
must work only from the given key, scanning from both ends for dot.

Thanks.


