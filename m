Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED6C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BD660F23
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJNSfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:35:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53355 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhJNSfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 14:35:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8822015D1AC;
        Thu, 14 Oct 2021 14:33:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wnih2mj4M8M1LpSQxXUhjUtr+HK3urI8Rw+/yN
        h1W1M=; b=mYX9GMi4NC4Tk2B4ZRD92jNqXn0pTcOUaGmVa/GwpTSrvJ5ubzqDqX
        Lao3qRDGiCn7f0TChpCQlmx0PwrOWxc0YdmpHMGHV36GJigRrwbla2XL5f9ReMiZ
        OGqW3gnzjl6UOLf8hv+gPeENAziU+n9Si1Xz4xdpzQk4syj4IXqI8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 809E615D1AB;
        Thu, 14 Oct 2021 14:33:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E449F15D1AA;
        Thu, 14 Oct 2021 14:33:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] remote: move static variables into
 per-repository struct
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
        <20211013193127.76537-2-chooglen@google.com>
        <xmqqlf2wfzfz.fsf@gitster.g>
        <kl6lk0if1pt3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 14 Oct 2021 11:33:43 -0700
In-Reply-To: <kl6lk0if1pt3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 14 Oct 2021 10:25:44 -0700")
Message-ID: <xmqqr1cnbgmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43631CB4-2D1D-11EC-AB06-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> By "here", I assume you mean "the restructuring doesn't belong in
> this topic" vs "the restructuring belongs in this topic but not this
> patch".

Hmph, it is unclear which one you assumed ;-), but anyway I do not
think it would help to make such a clean-up as a part of this
series.

Adding a pointer to the container to contained types, if done from
the beginning without disrupting the function signature (i.e. a
function that takes a branch instance can now work on a branch that
was taken from any repository, by simply following branch->repo and
using it as a parameter to repo_foo_blah() calls it would make
instead of existing foo_blah() calls), may help reduce the size of
the series greatly, because you wouldn't have to touch may existing
callers.  That would make a great part of this topic.

But if done as a post clean-up step (i.e. first we sprinkle "struct
repo *" pointer as an additional parameter all over the functions
that take an object that clearly belongs to a repository, and then
later shrink the API to remove the extra pointer parameter by
teaching the contained object which repository it belongs to), it
would probably not a good idea to have it as part of this series.
We'd instead stop at "we add a new parameter to functions to tell
in which repository it now should work" in the topic itself.

The "post clean-up" series would be like "the previous series made
it 'working', now let's clean-up the API" follow-up that is done
separately.  One benefit of going that route would be that it would
allow us notice there are cases where contained object may have to
be used in the context of the container that is different from the
container it belongs to, before locking ourselves out of the
possibility by limiting the API.  I personally do not think we'd
reap that benefit as I do not think of a case where it makes sense
to take a branch or a remote from a repository and use it in the
context of another repository (hence my suggestion to teach objects
the repository they belong to), but if others think it is easier to
proceed, then...

Thanks.

