Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9964C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D520725
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Va14IVvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLAQWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:22:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55278 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfLAQWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 11:22:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD5C1C45F;
        Sun,  1 Dec 2019 11:22:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a29P+0QwPJa7lu+ijtIOaDa6jw=; b=Va14IV
        vNVLMR5sdXxAZ3wNaMfR+VyoZDZmw9bGMl+xrMepWtCjlU9NseC+76XxSniYT8O7
        RdvuZTVrcr+WY0LyhvXMUSOy0kz84a7KjgO/yJuFU+49NRUWz7vWEuUX8k58fxBo
        RMiO0+Y/gaVpCwhkh9RwNn9vA5SUFmOEImLfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f/eCOOpSIupy8G3Uoozi/FG3LtCbW5uS
        2uDisaeCHJPPxk90ly9N64gLRPX7EEjwr3ZmEewTn5+8pzn2ZyhHgB3DZPR4UFxs
        BH0fOeJ8wucMWcfqkaiYIMPCL/3UPwRjEL9OdBo9E+TDYs6E4/dTt69xImbzRBV0
        9AQzjSDesRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02BBA1C45D;
        Sun,  1 Dec 2019 11:22:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 665391C45C;
        Sun,  1 Dec 2019 11:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] revision: free topo_walk_info before creating a new one in init_topo_walk
References: <20191122083704.29267-1-mh@glandium.org>
        <20191122083704.29267-2-mh@glandium.org>
        <46c47a21-d0e1-296f-5563-ae29597f995c@gmail.com>
Date:   Sun, 01 Dec 2019 08:22:33 -0800
In-Reply-To: <46c47a21-d0e1-296f-5563-ae29597f995c@gmail.com> (Derrick
        Stolee's message of "Wed, 27 Nov 2019 09:25:09 -0500")
Message-ID: <xmqqsgm4yq0m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C80E1C84-1456-11EA-B768-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> In general I like this change. I'm happy that this was split into a
> method instead of crammed into the block of the "if" below.
>
>> +	clear_author_date_slab(&info->author_date);
>
> The only issue I have is that the author_date slab should not be
> cleared. That is used by more than the topo-walk AND the values for
> author dates will not change between subsequent revision walks. Just
> drop that line and we should be good to go!

Hmph, isn't this merely a performance thing, or would a slab that
was once cleared never repopulate upon its second use (i.e.
affecting correctness)?

Thanks.
