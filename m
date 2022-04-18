Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF42C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiDRQnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiDRQnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:43:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068A1CFCC
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:41:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E782195702;
        Mon, 18 Apr 2022 12:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Id5jGULuPs+VDhEkxrVQRFKxNR84jo9/L5jSAB
        blX/k=; b=QiPl3BEmG1PlyptM8X2tCgrmKFX7tm2+3ZR9ZF77fExlX3UIIG2s2B
        lwCFGuyIBmnRXjhKvGJyDYP9olPI6lWXKCrtn7436ihrVsbfjfdZI4WhW5ebpXMn
        pE/1xHCP9CwYk2OGqmVcbr6wPfUsI4kHullyaUKGjoZA3e/nTS7Sg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0719E195701;
        Mon, 18 Apr 2022 12:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 843C0195700;
        Mon, 18 Apr 2022 12:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
        <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email>
        <xmqqczhe1jgp.fsf@gitster.g>
        <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email>
Date:   Mon, 18 Apr 2022 09:41:04 -0700
In-Reply-To: <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email> (Philip Oakley's
        message of "Mon, 18 Apr 2022 17:28:35 +0100")
Message-ID: <xmqq35iaz6n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 574EC416-BF36-11EC-AA4D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> So, essentially, it's talking a small part of the rerere-train at each
> step in the replay, so that it's more focussed.

As rerere database is designed to be an O(1) hashtable, having
knowledge of how many other merge conflicts are to be resolved
shouldn't affect the time you need to find the relevant record
to use to help you resulve the conflict you currently see.

That reminds me of one topic.  I often wondered if it were a mistake
that I didn't make the rerere database easily transferrable across
repositories (just like "stash cannot be transport via fetch" which
is being worked on recently).  As long as a mergy history that will
need to be recreated later gets transferred to a new repository, it
can be used to "train" the rerere database in the new repository, so
it probably is a much lower priority.

"git rerere" command on the other hand may be in desperate need to
learn the "train" subcommand to officially support it (and deprecate
the "contrib/rerere-train.sh").  Especially given that we now can do
the necessary "trial merges" in core, without touching the working
tree or the index, thanks to the "ort" merge-backend.

The size of such a project may be appropriate for GSoC (if done the
same way as the script, smudging HEAD, index and the working tree),
or may exceed what is reasonable for GSoC (if done all in-core using
ort machinery).



