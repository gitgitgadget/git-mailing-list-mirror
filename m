Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E7CA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 15:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIAPxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjIAPxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 11:53:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5202E40
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 08:53:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F306261BC;
        Fri,  1 Sep 2023 11:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7lqf3Whrll1yKQ9kka2sS6KPjg5BTEPfw2F51O
        zVd9g=; b=bt+rW2AxrSgZLvAyoQtpbxKYJOOZPTVK91dyjvy4hgj0KZ5n/Rvn8W
        ouIFoiSlPNh4WPnZXOMkaT+2s7PZTCKr9jSzyS+LvbXjVwZEpSh+Yc9IGw2ePhlQ
        Jd+RrMUoiR6qysK7Z5QR8injCVzk4eGqEx6N0PEJhor2XkITttuKU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 082DD261BB;
        Fri,  1 Sep 2023 11:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A5574261BA;
        Fri,  1 Sep 2023 11:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
In-Reply-To: <ZPHEOYyyX+l3AGP1@ugly> (Oswald Buddenhagen's message of "Fri, 1
        Sep 2023 13:00:09 +0200")
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
        <xmqqo7inw2na.fsf@gitster.g>
        <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
        <ZPHEOYyyX+l3AGP1@ugly>
Date:   Fri, 01 Sep 2023 08:53:14 -0700
Message-ID: <xmqqwmx9ritx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9B14ED4-48DF-11EE-822F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> but i wouldn't be opposed to for example git-mailinfo learning to
> understand the --pretty argument, if the implementation doesn't turn
> out to be completely out of proportion.

Excellent suggestion.  I agree that 'mailinfo' would be the closest
place we have for such a new feature.  It's "info" output (i.e. what
comes out to the standard output of the command) is designed to be
extensible, and I vaguely recall that we indeed have added new
field(s) during its lifetime with existing users already.

We can just invent a new label (e.g. "Filesystem-safe-subject:"),
pass the subject string to pretty.c:format_sanitized_subject() and
emit the result next to the existing "Subject:" with that label, and
we can even do so unconditionally without breaking anybody.


Having it in 'mailinfo' may still not be a good solution to the
issue, given that Vit says

>> But I typically don't have a Git.

though.


On a related not-so-distant tangent, we probably should redo the
support for --message-id to emit it as an extra entry to the "info"
output, instead of contaminating the "message" output.  The option
was added only to support "git am --message-id", and as long as the
calling "am" and "mailinfo" are updated in sync to use the "info"
output to carry the Message-Id: information, we should be able to do
such a clean-up without changing the externally visible behaviour.
