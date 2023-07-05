Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169BDEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGEUPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGEUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:15:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA8173B
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:15:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01EBE332B4;
        Wed,  5 Jul 2023 16:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tJM0D8pCl6H6
        I0p1PfGp/Sg6Pp3OZxqNiWA5XuQMnEQ=; b=AzDvPSVUiJ1Y+KqVh1UGH2s44un+
        o1JZ6w0+o0pe+9IdfTM+d/4+WkUPRsC4DCV+NG8897dqnaBRti+DuZw+LmbaLj2E
        PepDY2ybt/tKJ8m+yvgToULSIv8WXVKzLqi9ydlsy5ndvJdvGC1kEjuva+uIMSTk
        oN4o3CFXuMgtHfo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEAE9332AB;
        Wed,  5 Jul 2023 16:15:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F38B332A7;
        Wed,  5 Jul 2023 16:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
References: <20230701205703.1172505-1-jan@kloetzke.net>
        <20230702125611.GA1036686@coredump.intra.peff.net>
        <xmqqmt0a3n2w.fsf@gitster.g>
        <20230705124107.GA3932508@coredump.intra.peff.net>
        <xmqqedlm2s9q.fsf@gitster.g> <ZKW7bjVHeEOnza62@thinkpad.fritz.box>
Date:   Wed, 05 Jul 2023 13:15:35 -0700
In-Reply-To: <ZKW7bjVHeEOnza62@thinkpad.fritz.box> ("Jan =?utf-8?Q?Kl?=
 =?utf-8?Q?=C3=B6tzke=22's?= message of
        "Wed, 5 Jul 2023 20:50:22 +0200")
Message-ID: <xmqq8rbuyv14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4021888-1B70-11EE-BCD7-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Kl=C3=B6tzke <jan@kloetzke.net> writes:

> Am Wed, Jul 05, 2023 at 10:16:17AM -0700 schrieb Junio C Hamano:
>> Interesting.  Right now, if I create a 'direct' tag that points
>> directly at HEAD, and then create an 'indirect' tag that points at
>> 'direct', i.e.
>>=20
>>     $ git tag -a -m 'a direct tag to HEAD' direct HEAD
>>     $ git tag -a -m 'an indirect tag' indirect direct
>>=20
>> I would get a piece of advice message that encourages to correct the
>> mistake with "git tag -f indirect direct^{}".
> ...
> But as most git commands can handle nested tags they should better be
> supported consistently IMHO.

Do they?  Most git commands handle nested tags in only one way: by
fully peeling.  "git checkout --detach indirect" in the above
scenario would handle nested tag "indirect" well, but it is done by
making "direct" tag inaccessible when the only thing you have is the
"indirect" tag.  For example, you cannot create another "indirect"
tag that points at "direct" tag with "git tag", with

    $ git tag -a -m 'another indirect' indirect-2 indirect^{}

The resulting tag will be another direct tag to the underlying
commit, and not a tag of the "direct" tag.

In that sense, --points-at we currently have that only peels once is
inconsistent with the others, but --points-at that peels repeatedly
and allows the intermediate steps to match is also behaving
inconsistently relative to most git commands.

Combined with the fact that we seem to discourage such an indirect
tag, we should either:

 (1) declare that indirect tags are not useful, turn the warning
     advice.nestedTag into a stronger error, devise appropriate
     transition plan to get rid of nested tag (e.g. eventually
     making it impossible to use "git tag" to create such a tag and
     let "git fsck" complain about them), and perhaps change
     "--points-at" to take only the fully peeled object into account
     so that optimization based on packed-refs becomes possible.  Or

 (2) declare that indirect tags are useful thing to support, tone
     down the advice.nestedTag message, and enhance the support of
     indirect tags, starting with this "--points-at" enhancement.

I am inclined to support (2), but then a consistent support would
need to eventually include a "peel only a single level" primitive as
well.  That would be the first step to allow "most git commands" to
support nested tags well, as they currently do not.

Thanks for working on this.  Let's queue it, together will Peff's
patches (which I haven't studied fully yet).

