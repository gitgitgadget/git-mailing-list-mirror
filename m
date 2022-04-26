Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F544C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbiDZQvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353275AbiDZQvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:51:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263B483A4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:46:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 912491278E9;
        Tue, 26 Apr 2022 12:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLmlsiAjs7TiMXlsHVFUjZ47EoK0+wm6j6U0vr
        Rg80E=; b=UQEh3K9hiClGbffMIe36ONwg/CYnPd/jqQUqDrfUtLuGkn5sAEzbLE
        eYR/1IHt2vob6Jhfil/lDCIycWC0fdn8lHQiirqqEDFqOYVXW/A8CR3qIGct9WsK
        gfSywzd1XxVpRLSeOqDiddxGVy0hd4nN1LljTsymsSw3dhcaaI4UA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81C1D1278E8;
        Tue, 26 Apr 2022 12:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 627901278E6;
        Tue, 26 Apr 2022 12:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
        <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
        <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g>
        <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
        <xmqqy1zty8dc.fsf@gitster.g>
        <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
        <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
        <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
        <CAPUEspiufPMZOfZFunTFYmX7KwPxsKsAeHnfBjKgosA1ZJWqzw@mail.gmail.com>
Date:   Tue, 26 Apr 2022 09:46:06 -0700
In-Reply-To: <CAPUEspiufPMZOfZFunTFYmX7KwPxsKsAeHnfBjKgosA1ZJWqzw@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 26 Apr 2022 09:35:18 -0700")
Message-ID: <xmqqpml3rdwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F229172-C580-11EC-9D0D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Still think that (since we are already touching this) removing the
> restriction to
> root owned directories might make sense though, ex the following (unrealistic
> example) would work:

I think it is essential to protect unsuspecting "root" user from
wandering into an unfamiliar directory that happens to be a trap,
i.e. I may do something like this as an admin:

    $ sudo sh
    # cd / && find usr bin ... >/var/tmp/mylist.txt
    # cd /var/tmp

with the expectation that I'd then do some text processing on the
mylist.txt file, and going there first would allow me to refer to
the files more easily, instead of having to say:

    # sed -e '... processing ...' </var/tmp/mylist.txt >/var/tmp/out.txt

Alas, you as an attacker have done

    $ cd /var/tmp
    $ git init
    $ edit .git/config

to wait for me.  /var/tmp would be owned by 'root' but allows
anybody to write to it, only forbidding people from removing other
people's stuff.



>   $ mkdir -p r/t
>   $ sudo chown root r
>   $ cd r && sudo git init
>   $ cd t && git status
>
> IMHO any directories above that are owned by root and might have a git
> configuration must be safe, and therefore shouldn't need to be
> explicitly exempted.
>
> I also think that Taylor's suggestion to ignore and warn instead of
> abort might be
> a better solution to the "configuration file shouldn't be trusted"
> issue which is at
> the root of this regression, and obviously doing that would make this
> change less
> critical (users will just get a warning instead of being prevented to
> do what worked
> for them before and is a safe use case)
>
> Carlo
>
> PS. yes hardcoding uid 0 as root would be avoided, not sure where yet though
