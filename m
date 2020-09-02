Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75485C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C6320767
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mr7OMtB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBTws (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:52:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53992 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBTwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:52:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C8D2E3427;
        Wed,  2 Sep 2020 15:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8zvlzwXcwjZmG4XtaQIlcntUe+E=; b=Mr7OMt
        B41H8gHtdS1moSnRA6nUFm9DdwyK6d609A99Zfk/Z4cCR9rypddM9GSabk5A3ci9
        bBxbQtFiSbpviz4AyDPhGqPqKVDj9aCyFmT3dppe8sx4ZJQB/c3fP6YYUtN1veVQ
        xp+jsC3E/ISysvTzG07tuHAElbHp1IoH3Nkc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s73Op6az6c+3gt6LSE6TwQl44/N4Odx9
        WOIYtalOuAHcHfrvFHyo25MsNr37QenNJnYKMAzEYZIZBpbM9oo/4LtKV/i8Crry
        ziMBe+ywv3KzUuzOD5F9WQHhHgtCmFuapo3RvsVPzMjnHLgiYMzuMGDF1ZI2OijB
        ef+FWnnsUKE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2742EE3426;
        Wed,  2 Sep 2020 15:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E8DEE3423;
        Wed,  2 Sep 2020 15:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anish R Athalye <aathalye@mit.edu>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: git cat-file -e / rev-list disagree with git fsck on empty tree
References: <1006A7F3-8C48-46E3-8F7C-3F82181E3619@mit.edu>
Date:   Wed, 02 Sep 2020 12:52:38 -0700
In-Reply-To: <1006A7F3-8C48-46E3-8F7C-3F82181E3619@mit.edu> (Anish
        R. Athalye's message of "Wed, 2 Sep 2020 00:27:30 +0000")
Message-ID: <xmqqblioarcp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBC53338-ED55-11EA-BA29-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anish R Athalye <aathalye@mit.edu> writes:

> This is related to the change made in f06ab027efd2 (rev-list: allow cached
> objects in existence check).
>
> That patch seemed designed to allow the workflow where the empty tree is
> missing from the object store, so
> `git cat-file -e 4b825dc642cb6eb9a060e54bf8d69288fbee4904` and
> `git rev-list --objects 4b825dc642cb6eb9a060e54bf8d69288fbee4904`
> both return success even when the object is not physically present.

That sounds buggy.  I know git knows about both empty tree and empty
blob, but replacing the empty tree object name with the empty blob
object name in the above in a freshly-created empty repository gives
me errors from both of them, which is what I'd expect.

> However, in the same situation:
>
>     $ git fsck
>     [...]
>     missing tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

... and if some other tree references to the empty tree (which is
unusual---I do not think we record such a tree, but some third-party
tools might), it is understandable fsck would complain.

> I'm not sure if this is the intended behavior (the tree is indeed missing, so
> in some sense, this is reasonable). But it seems somewhat confusing that it
> disagrees with the interrogation commands.

