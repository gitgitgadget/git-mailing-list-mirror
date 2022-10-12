Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A80C4167B
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJLVbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJLVb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:31:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68167120BD4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:31:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3325E1562AA;
        Wed, 12 Oct 2022 17:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLffQYyCRj3JW4JrHzXwprts/DxIjMrkgjWFfH
        gJPcQ=; b=jty/sk64sLPflJ1DwCqojIH2PjAARBjcbwGhADbQoknD3KpVmfz8DT
        EOSoWtI0ZIFVXM/watwZTLwNdnaH8UJhoatUk3Dn+OMtlqUmXX7YacUL7d/4HixD
        yTW0tDiPtwTazmUOvHE9EmeKD9T5kDuC+alGa+E0ifR7d1N29pZuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AE711562A9;
        Wed, 12 Oct 2022 17:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EA161562A8;
        Wed, 12 Oct 2022 17:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ignacio Taranto <ignacio.taranto@eclypsium.com>
Cc:     git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
Date:   Wed, 12 Oct 2022 14:31:18 -0700
In-Reply-To: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
        (Ignacio Taranto's message of "Wed, 12 Oct 2022 18:17:04 -0300")
Message-ID: <xmqq7d14k9uh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36012DF6-4A75-11ED-8B0B-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignacio Taranto <ignacio.taranto@eclypsium.com> writes:

> So, both git diff and git show display "\ No newline at end of file"
> for symlinks.
>
> I think this is related to how Git renders diffs, IMO it shouldn't
> display a warning about newlines for symlinks.
>
> Am I making any sense here?

Yes, but not really.

It is not "warning" at all.  The users want to know when compared
contents do or do not end with an incomplete line at the end, and
the "\ No newline" is the diff's way to give that single bit of
information to us.

And the contents of a symbolic link typically is a single incomplete
line, so it is expected to see "\ No newline" when comparing them.

This is important as "git diff | git -C ../some/where/else apply"
should be able to recreate the change in the current repository
(which may have change to or addition of a symbolic link) in the
other repository, and "git apply" on the receiving end must be able
to tell that the symbolic link it needs to create in the other
repository must not have an extra LF at the end.

