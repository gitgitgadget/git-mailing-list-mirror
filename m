Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1632203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933515AbcLMT7d (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:59:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52991 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932951AbcLMT7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:59:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BECE657D53;
        Tue, 13 Dec 2016 14:59:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRrku1ILTFDK9b3Tf2wR9YR3Uhc=; b=JPc09j
        4rbgIPGD4qBJvLFmvFiLbYZca9AYMZ4zRypq4TSr7Ol0yEyFUfGEIsUixWxTTj0F
        a/lJ4ZkouMK6777w8RTc6ZWFz/udwI96xdxgvW3KHag4iCfbxpm01DFeB0EVE8TV
        8wiGGUAjRWsBhirB2NjfLtq741jDT0I5U0YGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sps1AMEPtTsHWaFKomFjTcdXnPqfJg9W
        IKbcQxb6kQCCm2qDsT2h+uX7asgSk4K/clGZPCD6cnp3ZzQEUB64h1pEGHxWBHVB
        tlQHXtyTGcoF4s4toFjYFQ1EL9c07EMhOXWsCAWAIa4IBwy87L/MNK8GD7rsUR1j
        DI5p+d6aLko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6C5957D52;
        Tue, 13 Dec 2016 14:59:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1105557D51;
        Tue, 13 Dec 2016 14:59:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Ariel <asgit@dsgml.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: git add -p with unmerged files
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
        <98817141-fa57-7687-09c4-dc96419d8a35@gmx.net>
Date:   Tue, 13 Dec 2016 11:59:25 -0800
In-Reply-To: <98817141-fa57-7687-09c4-dc96419d8a35@gmx.net> (Stephan Beyer's
        message of "Tue, 13 Dec 2016 20:21:59 +0100")
Message-ID: <xmqqwpf31tya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6D45D96-C16E-11E6-B3D1-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> While we're on the topic that "git add -p" should behave like the
> "normal" "git add" (not "git add -u"): what about unmerged changes?
>
>
> When I have merge conflicts, I almost always use my aliases
> "edit-unmerged" and "add-unmerged":
>
> $ git config --global --list | grep unmerged
> alias.list-unmerged=diff --name-only --diff-filter=U
> alias.edit-unmerged=!vim `git list-unmerged`
> alias.add-unmerged=!git add `git list-unmerged`
> alias.reset-unmerged=!uf=`git list-unmerged`; git reset HEAD $uf; git
> checkout -- $uf
>
> The "add-unmerged" alias is always a little scary because I'd rather
> like to check the changes with the "git add -p" workflow I am used to.
>
> Opinions?

For this, you would NEVER want to use "add -p" to pick and choose.
By definition, while you are in conflicted merge, the path that had
conflicts before you started the merge-y operation (be it "pull",
"am -3", or "cherry-pick") did not have any change since HEAD, and
"pick this hunk, drop that hunk" cannot be correct for the conflict
resolution.

"git diff" while conflicted will highlight what conflicted by
showing the three-way diff (similar to "diff --cc" on a merge
result) and after conflict is resolved you can view "diff HEAD"
on the path to see what the merge brought in.
