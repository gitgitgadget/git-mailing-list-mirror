Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F2C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79087206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAV9eMYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgAISye (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:54:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55233 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAISye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 13:54:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6788FAAC76;
        Thu,  9 Jan 2020 13:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+GXNkMfsJsF/c68MEC1eo9TDq/4=; b=HAV9eM
        YfSd/COgzEV91Rwh9OpFPBVe7jjEsuQISQPWSsq87dnw0XPGV7SdlTdhsw5Abjih
        Fe8mzWqjl0FEDAv1ItJdD+nnHqLcsz1BYGvtMixF33PbzM6TolDiDgs9bcknZfO7
        GzQBhNvA3KmZhYo6X8KKLoG+pDRlv3nkYAYgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OyB0Uox0omyqvrGsr3GN6VeKLarAmR5x
        k9j7HE+3fLplUrgfsUu9gymak8Vr97gkGs6HKEypfydbgX2afnqOIl+BwkQgRb/n
        j5AXLb92vyp4TE+QhCR4UTgXvn3Av7YY1BBFnZUJXuV2nEZdH2dP6zIeEBVvqy+N
        SJGQJUd/FEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60E59AAC75;
        Thu,  9 Jan 2020 13:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79FD2AAC71;
        Thu,  9 Jan 2020 13:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Wood <carlo@alinoe.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
References: <20200109192040.46aaa01e@hikaru>
Date:   Thu, 09 Jan 2020 10:54:27 -0800
In-Reply-To: <20200109192040.46aaa01e@hikaru> (Carlo Wood's message of "Thu, 9
        Jan 2020 19:20:40 +0100")
Message-ID: <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 772D7588-3311-11EA-80B8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Wood <carlo@alinoe.com> writes:

> In a project containing submodules, one of the submodules
> contains a submodule itself, which in turn also contains
> a submodule.
>
> Overview:
>
> project/foobar  [submodule]
> project/cwm4    [submodule]
> project/evio    [submodule]
> project/evio/protocol/matrixssl       [submodule]
> project/evio/protocol/matrixssl/cwm4  [submodule]
>
> ('protocol' is a normal subdirectory)
>
> Running (with or without the --quiet),
>
> $ git submodule --quiet update --init --recursive --remote
> Fetching submodule protocol/matrixssl
> Fetching submodule protocol/matrixssl/cwm4
> Fetching submodule cwm4
>
> This is odd (a bug imho) because
>
> 1) it seems to only print this fetching information for submodules inside submodules,
> not for the top-level submodules.
> 2) it even prints this when using --quiet
> 3) it prints this every time (also when there is nothing more to fetch).


Sounds like a symptom of (a) the top-level "git submodule update"
knowing how to react to "--quiet" but (b) it forgets to pass down
the "--quiet" when it recursively runs "git submodule update" in its
submodules?

