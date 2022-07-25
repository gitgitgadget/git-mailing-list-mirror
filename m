Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72134C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 01:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiGYBaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYBav (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 21:30:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E55BCAE
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 18:30:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B84EA1ACA60;
        Sun, 24 Jul 2022 21:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bWw52k5o54dgAqXdOuJl/xva8edxCMaxwbImM2
        8PJb4=; b=jmXsqeGgYK6J0uMqgIhXumW6QO+V7JidBPfUJCEnak9LKmWzDOGVbI
        eRcMhPS13AIUbTsOk+7eM03qnXc6AS3qf7euSQz/wDxc+8pDQjIgcmH5GjTfmAYu
        jbR5yR6PTcxfofMKQEevSTRijBC2Mlm1lObBTQq4daBJXw9YfVsZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B10AA1ACA5F;
        Sun, 24 Jul 2022 21:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65F051ACA5A;
        Sun, 24 Jul 2022 21:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Rouhaud <rjuju123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
Date:   Sun, 24 Jul 2022 18:30:44 -0700
In-Reply-To: <20220724061231.jddhqns7bqx5c2xm@jrouhaud> (Julien Rouhaud's
        message of "Sun, 24 Jul 2022 14:12:31 +0800")
Message-ID: <xmqqfsiq6ksb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67A8A820-0BB9-11ED-A4E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Rouhaud <rjuju123@gmail.com> writes:

> Otherwise, would it be acceptable to disable the whole block (the "remove
> leading stuff of merges to make the interesting part visible") with some new
> configuration option?

I personally find that "shortening" logic way too specific to the
kernel project hosted at kernel.org and would be inappropriate to
use it anywhere else.

	if (length($title) > 50) {
		$title =~ s/^Automatic //;
		$title =~ s/^merge (of|with) /Merge ... /i;
		if (length($title) > 50) {
			$title =~ s/(http|rsync):\/\///;
		}
		if (length($title) > 50) {
			$title =~ s/(master|www|rsync)\.//;
		}
		if (length($title) > 50) {
			$title =~ s/kernel.org:?//;
		}
		if (length($title) > 50) {
			$title =~ s/\/pub\/scm//;
		}
	}
	$co{'title_short'} = chop_str($title, 50, 5);

Of course, http:// and rsync:// are way outdated (https://, ssh://
and git:// are probably reasonable).  Equally outdated is to merge
branches from master.kernel.org, www.kernel.org, or rsync.kernel.org
(many merges are recorded as pulling from git://git.kernel.org/ or
https://git.kernel.org/ these days).

The above code is all from 198066916a8 (Kay Sievers 2005-08-07), so
it is very much understandable that its shortening heuristics no
longer match reality.

Even worse, I somehow thought that kernel.org no longer uses gitweb
but uses something else.  So I suspect that nobody sheds tears if we
remove the whole block unconditionally.  In fact, it would make the
world a better place.

