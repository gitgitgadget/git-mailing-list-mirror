Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F728C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiEYPqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiEYPqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:46:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374A2E0A1
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:46:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED21A1886E6;
        Wed, 25 May 2022 11:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sh5QFncwnPbnOm10br8NvrYq/8iwdW5FReoKck
        bR3zA=; b=ImdzfowAQeAmVfrKeXIp7RrO5CcIBsTOH0mw7876avd42hwFH7HHIZ
        ZYwVYYiG17yblOmIvdNYejUPALeKegetkhuWBblqJ1I25Uw0DVRYbmYRxSqajrms
        cd1rhvnbgsURqdXrCbywdgAJoudtHuOf5m/j2cWfVcEVlcEOz1MJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5D101886E5;
        Wed, 25 May 2022 11:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98AEB1886E4;
        Wed, 25 May 2022 11:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Error handling when giving empty command line
 arguments
References: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
        <xmqq35gyee7r.fsf@gitster.g>
        <8767dbe0c22540a4ab3e18684aa7e030@saabgroup.com>
Date:   Wed, 25 May 2022 08:46:10 -0700
In-Reply-To: <8767dbe0c22540a4ab3e18684aa7e030@saabgroup.com> (Olsson John's
        message of "Wed, 25 May 2022 07:32:18 +0000")
Message-ID: <xmqqy1ypaa4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD439584-DC41-11EC-8ECF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olsson John <john.olsson@saabgroup.com> writes:

> The git checkout command actually complains about the case when
> you give it an empty string
>
> $ git checkout "" feature/foobar
> fatal: empty string is not a valid pathspec. please use . instead if you want to match all paths

I actually knew that somebody new will bring up the message from
"checkout", which special cases an empty parameter.

The reason why it gives an extra piece of guidance in this case is
not because an empty string is something that can often come from a
common mistake, like the "unset-variable-in-double-quotes" example
that started this thread.

An empty string as a pathspec element used to mean "everything in
the directory", but we deprecated that interpretation of an empty
string, and then turned it into an error when somebody tried to use
it.  And that is why there is such a special case message.  The
purpose of it is primarily to help those who learned Git in older
days and thought we still took "" as if it were ".".  

So we do not give the same error message if you say

    $ git checkout "no-such-file" feature/foobar

when there is no "no-such-file".  "" _is_ special in that case, and
that is why we special case.  For most other commands, it is not a
good model to follow.

"git fetch", "git pull", "git ls-remote" never took an initial empty
argument as something special that we later robbed its meaning and
turned into an error.

Thanks.
