Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874ACC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356174AbiDZXoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356173AbiDZXoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 19:44:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8527DE2E
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 16:41:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 248BE188F2D;
        Tue, 26 Apr 2022 19:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gwEdAogjD4qHJCZOC9SeV54nsKDNTwsSl+fLTT
        sIQIU=; b=g1ClxKS6Tg8Luytu8gdjLK/D8jy3tMQ219gszPb8cIErOpiiCDLysI
        9TuS+A/ACrQ7ycH0qg+kB7RbWm785swmpPYfopb+v5EObzpVOxoJFYFS/wqKrbtU
        NcCkOzhzUfVQyYO9M9RB9Pr8GR0x1yLwaRAOR5pO+BSqBE+bhh5SU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D10B188F2C;
        Tue, 26 Apr 2022 19:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0E38188F2A;
        Tue, 26 Apr 2022 19:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Calkins <david.s.calkins@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: use core.fsmonitor instead
References: <CAMTWFOGU1ojFLE0v6cyyOh3tRRNmT8Nc9aWW=RLS4aHwJ5QDmw@mail.gmail.com>
Date:   Tue, 26 Apr 2022 16:40:55 -0700
In-Reply-To: <CAMTWFOGU1ojFLE0v6cyyOh3tRRNmT8Nc9aWW=RLS4aHwJ5QDmw@mail.gmail.com>
        (David Calkins's message of "Tue, 26 Apr 2022 18:43:39 -0400")
Message-ID: <xmqqtuafo1ko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51B0621E-C5BA-11EC-86D2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Calkins <david.s.calkins@gmail.com> writes:

> I installed Git v2.36.0 for Windows (64-bit) and when running commands
> I get the following output.
>
> hint: core.useBuiltinFSMonitor will be deprecated soon; use
> core.fsmonitor instead
> hint: Disable this message with "git config advice.useCoreFSMonitorConfig false"
>
> I opened the system Git config file and updated it to have the below.
>
>  useBuiltinFSMonitor = false
>
> After this change I no longer get that output.  However, the hint
> indicated that I should "use core.fsmonitor instead".  Is there
> something else I should be doing besides just telling it not to
> useBuildtinFSMonitor?  How do I tell it to "use core.fsmonitor
> instead"?

I do not do Windows, and I believe this is one area their codebase
deviates from what I have in my tree (read: Git for Windows is a bit
ahead of the real Git), so I have to speak with some speculation,
but the above does look a poor end-user experience.  If the code
detected core.useBuildtinFSMonitor is set to true, it should have
suggested to set core.fsmonitor to true instead, not just leaving at
"use X instead" without telling how to use X.

I am speculating that the old way (on Windows) to use the built-in
fsmonitor code was

    git config core.useBuiltinFSMonitor true

(this is something existed only in Git for Windows).  But the latest
incantation to ask for the built-in fsmonitor is to say

    git config core.fsmonitor true

on platforms that support builtin fsmonitor.  I think that is what
the message is trying to tell you.

It looks also like a very poor design to give hint tied to an advice
variable in this case.  They used to use core.usebuiltinfsmonitor
and they are trying to migrate their users away to use
core.fsmonitor variable instead, so they could just have tied the
advice messages to core.fsmonitor variable.  If they see that
core.usebuiltinfsmonitor is still used, and if they see
core.fsmonitor also is set (even to 'false'), then they know the
user has migrated, so they can stay quiet without forcing the user
to set advice.* configuration variable.  If they do not see
core.fsmonitor set to anything but core.usebuiltinfsmonitor used,
then they can complain.  There shouldn't be a need to use the
advice.usecorefsmonitorconfig variable at all, as far as I see, and
that makes this end-user experience doubly bad.
