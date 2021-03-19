Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDCC43603
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EA364DE4
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCSAxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 20:53:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62173 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhCSAxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 20:53:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FE83B51DE;
        Thu, 18 Mar 2021 20:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5uFZUwDGhAdnwc4s68cdhCU7CAs=; b=KLcwJ+
        itJEX780KZymmfVeGbxX9riAzYeVJ22SmmO+86o/8Aj422vGuk5ILL6Hhdgec6KF
        PSCq0JsPiS8TBqUjDvG4vd/DMz3uNCLacLYJEL+rdVd4FmcCPgrs0jzuquMFNbAE
        af0yRYjvnLIGsI4SwQTUZp0DDLMJBZz+jqdtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l3kIw/4b26pcHRGcj4lZDzXNJrQSw7c+
        wBLLHxwlEbVy1wuI9XIoFTlOcCVQypIzRcm+65BQ3lYXK2PftU2mbOl4sjT3Tyzt
        5tGjQRFGMvYPxNE21Y2/6+8Q8IDiR8RPaLEyGsBvPhUqAG/+XbIxafsI0XUlpgHf
        gPkvSByhPUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A39EB51DD;
        Thu, 18 Mar 2021 20:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F00C6B51DC;
        Thu, 18 Mar 2021 20:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v6 0/6][Outreachy] commit: Implementation of "amend!"
 commit
References: <20210310194306.32565-1-charvi077@gmail.com>
        <20210315075435.18229-1-charvi077@gmail.com>
Date:   Thu, 18 Mar 2021 17:52:59 -0700
In-Reply-To: <20210315075435.18229-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Mon, 15 Mar 2021 13:24:30 +0530")
Message-ID: <xmqqft0sotg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73B455CE-884D-11EB-B4C4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> This patch series teaches `git commit --fixup` to create "amend!" commit
> as an alternative that works with `git rebase --autosquash`. It allows to
> fixup both the content and the commit message of the specified commit.
> Here we add two suboptions to the `--fixup`, first `amend` suboption that
> creates an "amend!" commit. It takes the staged changes and also allows to
> edit the commit message of the commit we are fixing.
> Example usuage:
> git commit --fixup=amend:<commit>
>
> Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
> ignores the staged changes and only allows to reword/edit the commit message
> of the commit we are fixing. `--fixup=reword:<commit>` is a short-hand of
> `--fixup=amend:<commit> --only`.
> Example usuage:
> git commit --fixup=reword:<commit>
>
> ** This work is rebased on the top of cm/rebase-i-updates.

Are people happy with this round?  I gave an extra round of
eyeballing and didn't see anything suspicious, so I am planning to
merge it to 'next' soonish once the dust settles post release.

Thanks.
