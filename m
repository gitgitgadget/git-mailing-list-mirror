Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9564C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 00:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiGUAuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 20:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGUAuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 20:50:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC318E25
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 17:50:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB49A12793F;
        Wed, 20 Jul 2022 20:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4mjBsXdM2efG
        aK/RkQyUxCX14NAE5JN0GTTan4XGKOk=; b=FIsBNhPaYyXvYB7a+B2fJx+z4rUE
        XjIoBUVQR0ILVkZTo1Mc223GX5XhhyNFsaKUDpby8wtcNblFrheK4nxYEufwGSHV
        V1V42Fm7FsMRcaltxwol8LjEsF6TYPl8lS93Vx76vQZwrxSEqBkfcqY7tKcccRGh
        Qyry7OENX44FlDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2EA812793E;
        Wed, 20 Jul 2022 20:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F7A312793C;
        Wed, 20 Jul 2022 20:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 14/24] submodule--helper: fix "reference" leak is
 "module_clone_data"
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-14.24-c7610088968-20220719T204458Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 17:50:14 -0700
In-Reply-To: <patch-v2-14.24-c7610088968-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:47:05
        +0200")
Message-ID: <xmqqczdz1e7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15857CDA-088F-11ED-984F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Those commits added an xstrdup()'d member of the
> STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
> those, but not the ones we get from argv, let's make use of the "util"
> member, if it has a pointer it's the pointer we'll need to free.

I find this description misleading; do we sometimes put the same 'p'
as the key to the util member, and sometimes leave the util member
NULL?

I have seen some hacky codepaths that add keys with strdup_strings
set to false, and then call string_list_clear after setting it set
to true, to force the keys to be released (cf. bisect_clean_state()
uses the hack to clear refs_fo_removal).  Compared to that, using
the util member is probably less hacky, but it would not extend to
cases where the string_list needs to associate real payload to the
key strings.
