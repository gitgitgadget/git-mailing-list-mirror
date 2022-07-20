Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E7CCA482
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiGTRGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiGTRG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 13:06:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B011A6C106
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 10:06:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEA801A0E03;
        Wed, 20 Jul 2022 13:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mRPkSMR6Y7BS
        pI4B1U0j9V984yN9MzV9YlCfoLyD1Io=; b=NMqYLeGfU8C1a6QoF7tV9hsOxXtm
        0KcreyVAB4tHXEuzKw5VITK65rwzg+qoYzoeDr/X94aBJj6sVvQ3Vk+pKx7SFaAJ
        tpu1D+9ypyUuXqhYtEOTPvSwdd7eDiG3+enLTpxi7lm0Frkw36jaN/8cAUHsxvUt
        4+Ir+LQSDSliE9A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C74471A0E02;
        Wed, 20 Jul 2022 13:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 474CE1A0DFF;
        Wed, 20 Jul 2022 13:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 08/24] submodule--helper: add and use *_release()
 functions
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-08.24-b7582391c91-20220719T204458Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 10:06:21 -0700
In-Reply-To: <patch-v2-08.24-b7582391c91-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:46:59
        +0200")
Message-ID: <xmqqr12f3e9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47C74F52-084E-11ED-AA56-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add release functions for "struct module_list", "struct
> submodule_update_clone" and "struct update_data".

OK, this does a lot of things, but in short, nobody bothered to free
module_list (i.e. list of cache entries borrowed from the index to
represent the paths we are interested in that are gitlinks),
update_data (which has module_list among other things that do not
need to be freed), and submodule_update_clone (which has
update_data, update_clone_data and failed_clones list) in the
original (in other words, these release helpers had to be invented
by this patch, not factored out from some codepaths that free them).

I think the earlier part of the patch that deals with module_list is
correct.  I also think the last one that clears update_data in
module_update() is correct.

I am not sure about the helper that releases suc, especially how
suc->update_data is left alone by update_submodules().  Presumably
the caller is responsible for releasing the resources held by
update_data member alone, but the interaction makes me feel dirty.
Luckily there is only one caller of suc_release(), so we can design
however dirty interface for convenience, but still it feels wrong to
design a release() helper that pretends to be usable by general
public, yet they have to be aware of the fact that some members in
the struct are still their responsibility to release.  I dunno.

