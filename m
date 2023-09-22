Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F791CD484B
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjIVRxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjIVRxL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD84CED
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:52:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19FA51BAAE9;
        Fri, 22 Sep 2023 13:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=kVuPz3hV0kbxY2+G/648Gk2yHS5WhT7p3HwgZo
        PhhEM=; b=iqrnN0QCiiR+rv7BanVrKffQkv5UvxnPpIF/YUQH27jKdGktxRzefN
        aUKO/tHMCmY5nPnq/+c0URgpS9gNNb9/dfOusZ0T9nDVEmt7pvLABDW4loobwwf0
        F6rtEIhnYrTrc6m7yGZDJYcY6psspgPHKQtyrveqXv4F7HKBmpzY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F35911BAAE8;
        Fri, 22 Sep 2023 13:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 872D21BAAE4;
        Fri, 22 Sep 2023 13:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Ben Boeckel'" <ben.boeckel@kitware.com>, <git@vger.kernel.org>
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
In-Reply-To: <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 22 Sep 2023 13:14:30
        -0400")
References: <ZNffWAgldUZdpQcr@farprobe> <ZQ21NsLmp+xQU5g+@farprobe>
        <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
        <ZQ3GAJ/AHsM9e9a6@farprobe>
        <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
Date:   Fri, 22 Sep 2023 10:51:59 -0700
Message-ID: <xmqqediq2j0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBBD4C44-5970-11EE-8687-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> There appears to be a merge at 446120fd88 which brings v9.3.0.rc0 closer to HEAD than v9.3.0.rc1.

I didn't look at the actual graph but let me say I trust you ;-)

I wonder if there should be an obvious "explain why you gave this
name" mode added to the command, though.  The command should be able
to say "The closest path from HEAD to any tag is via this, that, and
that commit, which is N hops to tag T0", and from there, the user
should be able to say "Oh, I thought T1 was closer, let me try again
to describe HEAD, limiting the candidate only to T1" and run the
command in that mode, which should be able to say "The closest path
from HEAD to any tag that is allowed as a candidate is via these
commits, which is M hops to tag T1".  And if M is smaller than N,
then that may deserve to trigger a bug report (but as you said,
there are rules like preferring annotated over unannotated tags
involved, so it may not as straight-forward as comparing the two
integer hop counts).

Thanks for digging.

