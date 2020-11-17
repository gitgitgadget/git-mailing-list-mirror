Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADEC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 07:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3475246C5
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 07:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oAxL7Qfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKQHGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 02:06:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52586 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgKQHGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 02:06:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 629E999FCB;
        Tue, 17 Nov 2020 02:06:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OE2kTiNkTOiTyznpk0MAl7jgIa0=; b=oAxL7Q
        fgp4D1F01j2bCbXjBZ996eStSviSOBp7gpvmHVu/+WLgRqJ6TE8EE/DcYTDeHIav
        s/b6fp2rEDM8raZhPkOFjUm/z97vVmWEhqIKcSc6ZklzB7d9uIiR+pBgUA/jOCLc
        gN6qpHfbBihSKuHQoOzIekHwxtRMeoasN9lOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CtykDp14/3RkS3xEoeU2X/NGnrawJZul
        wWFNo+v/xDOxbCNqiF/zLHxsjzwI9MeST0btgqvkawi0XkSLy0gKgIayJ5eFbBn+
        WdyCIGH+6QSoGjDF8g3g94GW/ckhgKbIxlTOaFot9avJT6/np1SyLaxNMPjcFI+d
        FtTYcQKFpMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B43399FCA;
        Tue, 17 Nov 2020 02:06:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E490B99FC9;
        Tue, 17 Nov 2020 02:06:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
References: <cover.1605269465.git.ps@pks.im>
        <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
        <87mtzlflw7.fsf@evledraar.gmail.com>
        <xmqqy2j1851k.fsf@gitster.c.googlers.com> <X7NtovvfE7IjWzie@ncase>
Date:   Mon, 16 Nov 2020 23:06:17 -0800
In-Reply-To: <X7NtovvfE7IjWzie@ncase> (Patrick Steinhardt's message of "Tue,
        17 Nov 2020 07:28:50 +0100")
Message-ID: <xmqq4klo7992.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 638712F4-28A3-11EB-9E4C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> I especially do not think we want to read from unbounded number of
>> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
>> script cleanse its environment to protect itself from stray such
>> environment variable pair?  Count up from 1 to forever?  Run "env"
>> and grep for "GIT_CONFIG_KEY_[0-9]*=" (the answer is No.  What if
>> some environment variables have newline in its values?)
>
> You only have to unset `GIT_CONFIG_KEY_1` as the parser will stop
> iterating on the first missing key. More generally, if you set `n` keys,
> it's sufficient to unset key `n+1`.

Yes, but those who want to set N keys would likely to be content
with setting 1..N and happily forget unsetting N+1, and that is
where "how would one cleanse the environment to give a clean slate?"
comes from.
