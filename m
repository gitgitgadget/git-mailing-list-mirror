Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9422C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DA120657
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GH2Z0NMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgEQPGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:06:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65469 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEQPGt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:06:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E773056F78;
        Sun, 17 May 2020 11:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wNHYuh/ZhPzNzZpaj/Wphmxocww=; b=GH2Z0N
        MBhiNENLYEA097R9ROvOLFYV2n72c33DKzWuzk+MqRIDD6e9qERNUnQH3GOmYNAz
        890fN0BjVsGT65aRUB2Bk33SWiB8tfbTDCbf96oez4mEWuNz3BsQ+KDyruUVBUZI
        q6IqMITI1WaVNslcgURNZFWbt+FOZkGofOb+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VtG2eVWYo02sZD/Pb6grOo+ndJ62mI+i
        qQG1qtFRb2mhE9PLJu5DVx5lQtOIVKjDhd1dRz1NMoUHQi6Y0os33KHsjt700joG
        fttylSMKfbAfGRJmZiQPZ+qsVmb06l3XsOeebYvZ90H1o5trbuJW/rZW7Hb8QPp2
        +6TD7rKmjxM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE87956F77;
        Sun, 17 May 2020 11:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C1AB56F75;
        Sun, 17 May 2020 11:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell to C
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
        <4e36c8a0-4f43-79f8-137f-5fd080066af6@gmail.com>
Date:   Sun, 17 May 2020 08:06:45 -0700
In-Reply-To: <4e36c8a0-4f43-79f8-137f-5fd080066af6@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 14 May 2020 14:37:37 +0530")
Message-ID: <xmqqtv0e7g8q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06930FA0-9850-11EA-BDAC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> For those who lack the context, during the conversion of the script
> Shourya faced an issue where the '--branch' argument did not work as
> expected. He described the issue in a private e-mail where Christian
> pointed out the following (quoting his reply hoping he doesn't mind):
>
>> On Tue, May 12, 2020 at 5:55 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>>
>>> In your commit (in submodule.sh line 781) there is:
>>>
>>>         `git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix
>>> "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet}
>>> ${branch:+--branch} ${default:+--default} -- "$@"`
>>
>> Actually the issue might come from the above. I think it should use 
> ${branch:+--branch $branch} instead of ${branch:+--branch}.
>>
>> See: https://www.tldp.org/LDP/abs/html/parameter-substitution.html
>
> That's why Shourya mentions the '$branch' as extra. Of course, that's
> how it is supposed to be in the first place :)

Perhaps all of that should be removed from the log message and
instead go after the three-dash line then.

Thanks.

