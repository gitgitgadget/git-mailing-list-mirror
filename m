Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9FC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbiCPVWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCPVWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:22:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95196496B2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:21:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D98801205E0;
        Wed, 16 Mar 2022 17:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urrt0rug2UKaquXeuWpVDdHri09Y3ngHJcLyl+
        5wVjw=; b=dvV4SN/bJR0qultUvF8BA21M8NFoKhh9TjVR8uELd3mvPKY37aj9Aa
        tUE9FBzcFj4ffcs+pg6ELWABP2F5e+k0xvWhzvPYOAq5FNzehFCzZ/l76ui7jJx5
        5iOlHMDNDK1zh0S+C0lEqzO2JHCnSrrFGXpZm5wW159ujmDZPgCRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCD651205DF;
        Wed, 16 Mar 2022 17:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 291301205DE;
        Wed, 16 Mar 2022 17:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: crash upon "commit removedfile/newfile removedfile"
References: <YjJECDbAV0DXUTMB@lena.dartmouth.edu>
Date:   Wed, 16 Mar 2022 14:21:11 -0700
In-Reply-To: <YjJECDbAV0DXUTMB@lena.dartmouth.edu> (Yaroslav Halchenko's
        message of "Wed, 16 Mar 2022 16:09:44 -0400")
Message-ID: <xmqqv8wdk308.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 026625D8-A56F-11EC-BDED-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> 	+ rm p1
> 	+ mkdir p1
> 	+ touch p1/p2
> 	+ git add p1/p2
> 	+ git commit -m 2 p1/p2 p1
> 	error: 'p1' does not have a commit checked out
> 	fatal: updating files failed

Interesting.  In this toy example, all the user wants to do is to
remove p1 and add p1/p2, so an obvious workaround is to just say
"git commit" without any pathspec.  But in real life, there may
be cases where the user has already staged more than what the first
commit wants to have in the index, and want to limit it to a subset
by using a pathspec.

I _think_ the response from the command, seeing that the path 'p1'
that was previously a file got turned into a directory, is that it
is guessing that you are trying to replace 'p1' with a submodule,
but because 'p1' is not yet a repository, it cannot 'git add' the
commit from the 'p1' submodule to include it in the commit.  The
guess is wrong and it is a bug that it does not notice it---it knows
the user added 'p1/p2' to the index, so 'p1' clearly is a mere
subdirectory and not a submodule, so it could have known better than
saying "does not have a commit checked out".

By the way, program exit with non-zero status, with "fatal: message",
is a controlled error exit, not a crash.  Please reserve the word
"crash" to describe uncontrolled program death.

Thanks.
