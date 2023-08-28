Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363CDC83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjH1PcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjH1Pby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 11:31:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E51129
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 08:31:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78DDE22067;
        Mon, 28 Aug 2023 11:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhjEC83eM7gAQffa8A58UvQd2zDfT6i+z+wmim
        hNjIk=; b=lktyDl1IktMGcPhZEuaPe/+cSuaqju5OJ65yYXoIlPFlEe9s28/X9y
        vrAuD/nN5RVyRDCvLgKVzIVGotSkpsW6lB5BOZyo6EuZw4bqaQlhtQm62Buent30
        xn1tuU3ltUpBfi527YhtJYyUZtwhf0baAbEaBUUk7LA/DI3krTrdw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6514422066;
        Mon, 28 Aug 2023 11:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB65E22063;
        Mon, 28 Aug 2023 11:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
References: <20230828125132.25144-1-sir@cmpwn.com>
Date:   Mon, 28 Aug 2023 08:31:46 -0700
In-Reply-To: <20230828125132.25144-1-sir@cmpwn.com> (Drew DeVault's message of
        "Mon, 28 Aug 2023 14:50:34 +0200")
Message-ID: <xmqqedjnji8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00771D3C-45B8-11EE-B1DD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Rather than replacing the configured subject prefix (either through the
> git config or command line) entirely with "RFC PATCH", this change
> prepends RFC to whatever subject prefix was already in use.
>
> This is useful, for example, when a user is working on a repository that
> has a subject prefix considered to disambiguate patches:
>
> 	git config format.subjectPrefix 'PATCH my-project'
>
> Prior to this change, formatting patches with --rfc would lose the
> 'my-project' information.

OK.  

My initial reaction was that we should just deprecate "--rfc" and
instead use "--subject-prefix" for whatever multi-token string; that
way, we do not need to worry about having to add "--wip" and other
"shorthand" options ;-).  But the combination of the configuration
variable that specifies the tag that is used for everyday operation
and a command line option that allows you to add (not replace) RFC
would be a justifiable behaviour.  It certainly is better than the
current (original) design of "--rfc".  This needs to be advertised
as a backward incompatible change in the release notes, but I doubt
that the fallout would be major.

The implementation below looks like it is quite out of our style,
but I'll read v2 instead.

