Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8122220958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdDASdJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:33:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdDASdI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB6E78BC0F;
        Sat,  1 Apr 2017 14:33:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYu5XDm815vIYjAsfIYaj5JXbkU=; b=ZfVw2X
        PL7EmOJd6jZgsuF6Hrr3gYIpwWe3/z4T46d0YWJf3capp59onN9dhZKmaQ8P/OLk
        vlpPQpaQle8OWf9uwuh/Tmq9QsYFBG4QskRqHoSOAiFr0PW68NXW/6k28irXH6ip
        szYTvwbwSU5IXw5EqmJkHxCPwQS+G8oPO4vyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZsDZ7gtDFT58nnBjENVsch9hrhNS/Vm
        TViAztWPPLy3EaPCh/l0jijzDNyXGsRGeDgNOK8N95346QVWtQCTKYdD9z8qifns
        y7/1fjhdsCS2nz5FDNWN7vVWvEpetji6Dt62Ymrnc8AZ+lMcsiZehqzOxJtiyLRe
        bl4LjbmX3+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E499A8BC0E;
        Sat,  1 Apr 2017 14:33:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BD7A8BC0D;
        Sat,  1 Apr 2017 14:33:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [GSOC] prune_worktrees(): reimplement with dir_iterator
References: <1491009687-10419-1-git-send-email-robert.stanca7@gmail.com>
        <xmqqlgrkx3l5.fsf@gitster.mtv.corp.google.com>
        <CAJYcaSOMkoAnW82g=moQxz0H9t7C+F++V4Ob1-UiTLiw=gm_0g@mail.gmail.com>
Date:   Sat, 01 Apr 2017 11:33:05 -0700
In-Reply-To: <CAJYcaSOMkoAnW82g=moQxz0H9t7C+F++V4Ob1-UiTLiw=gm_0g@mail.gmail.com>
        (Robert Stanca's message of "Sat, 1 Apr 2017 16:29:29 +0300")
Message-ID: <xmqq7f34ugf2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A65B95FA-1709-11E7-A0B6-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

> On Sat, Apr 1, 2017 at 5:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Using dir_iterator() to make it recursive is not just overkill but
>> is a positively wrong change, isn't it?
>
> Thanks for the review, and yes the commit message is misleading (my
> bad there). I understood that remove_temp_files has no recursion
> component to it and it removes all ".tmp-id-pack-" files from
> /objects/pack , but shouldn't dir-iterator work even if there's no
> recursion level?

The point is what should happen when somebody (perhaps a newer
version of Git, or a third-party add-on that works with Git) adds a
subdirectory in .git/objects/pack/ or .git/worktrees/.  The answer
is that files and directories in such a subdirectory must not be
touched, because prune_worktrees() or remove_temporary_files() do
not know what these files and directories are.

The dir-iterator API does not allow you to say "only scan the
directory without recursing into the subdirectories" so your code
ends up recursing into them, without knowing what the files and
directories inside are (or are not).  As Peff mentioned in his
review on the other one, if we add a knob to dir-iterator API to
allow you to tell it not to recurse, then it would make it possible
to do a faithful conversion from the original, but without such a
change, you are changing the behaviour.
