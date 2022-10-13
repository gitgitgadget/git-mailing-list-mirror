Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740FC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMPbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJMPbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:31:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75AAD9A0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:31:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 235911BC84B;
        Thu, 13 Oct 2022 11:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E/h/icIItqsx
        KeW8TNZYpPeFdU/BsqvkaLiy0XJMY7U=; b=BXuVDZEWJZoA9hRQndV8FnJSVoOm
        +8SkOv584iz0L+8DLDvkI7QKC+12u75qzk+6SZqo7oeaVC5a1amM5B6kigdfkVMo
        GLudHeJoN9d/CK46M8Jg/hZQUkzFrMGUID3A61ba7kID5h9NbI81tKXa4Txo+76I
        T2zp1SqMjsty4v4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AC281BC849;
        Thu, 13 Oct 2022 11:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 498371BC848;
        Thu, 13 Oct 2022 11:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
        <221012.86mta1mmli.gmgdl@evledraar.gmail.com>
        <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
        <221013.865ygomybw.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Oct 2022 08:30:55 -0700
In-Reply-To: <221013.865ygomybw.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Oct 2022 01:09:36 +0200")
Message-ID: <xmqqlepjivv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07EF5130-4B0C-11ED-AA70-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Because your refspec doesn't include refs/tags/*:, try e.g.:
>
> 	git fetch https://github.com/git/git.git 'refs/tags/*:refs/tags/*' --n=
o-tags --dry-run
>
> That's what "--no-tags", i.e. it's per-se (and confusingly) nothing to
> do with whether you get tags or not, it's to do with whether we to tag
> following.

It indeed is confusing and might warrant some clarification, if not
updating.

 * "--tags" is equivalent to giving "refs/tags*:refs/tags*", so it
   might be natural to expect that you can say the same thing as
   above with "fetch $URL --tags --no-tags", but it does not work
   that way.  Command line parser treats "--tags" and "--no-tags" as
   if they follow the "last one wins" semantics.

 * As discussed in this thread, what "--no-tags" really means is "do
   not follow tags"; there is no way to countermand a "--no-tags"
   earlier on the command line to say "earlier we said do not
   follow, but we changed our mind.  Please do follow tags".

It would have been nice if we had from day one

 * "--tags": equivalent to writing "refs/tags/*:refs/tags/*"

 * "--no-tags": "earlier we said --tags, but we changed our
   mind. Please forget we earlier said --tags".

 * "--follow-tags": automatically fetch tags that point at an
   object that were fetched (default).

 * "--no-follow-tags": stop following tags.

but I do not think it is worth the churn and transition pain to
change it after more than 15 years.


