Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0A1C83F35
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbjHaR0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjHaR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:26:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F91B2
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:25:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DC7220CC0;
        Thu, 31 Aug 2023 13:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Ry5mb4G3+dfAfKy2m3W937VncXfK+KTuT+7aLw
        RMvBI=; b=agpZIesfrUNQoEUzG1kWTfBzmR0LXmFfTMQ+dBPnyrUiNFNXuXHMUm
        1+TGPNEFVLK0s7xquXKaNo//NQGyWsUCAEmbz6d8XkXE1W/R+ld7987Jfzd7eaYj
        aMUKirIxbxM214cv/A1gVeelkl4AYVV90QF/ey+AeMc8j8wb6/bbI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06B1120CBF;
        Thu, 31 Aug 2023 13:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 975B820CBE;
        Thu, 31 Aug 2023 13:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Gareth Hayes" <gareth.hayes@bitcoin.org.hk>
Cc:     git@vger.kernel.org
Subject: Re: Problem: `fatal: too-short tree object` when executing
 hash-object on tree
In-Reply-To: <0de414f8-f409-467f-a504-06a78f088981@app.fastmail.com> (Gareth
        Hayes's message of "Thu, 31 Aug 2023 18:58:30 +0800")
References: <0de414f8-f409-467f-a504-06a78f088981@app.fastmail.com>
Date:   Thu, 31 Aug 2023 10:25:52 -0700
Message-ID: <xmqqjztbw2cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7011DE30-4823-11EE-84F8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Gareth Hayes" <gareth.hayes@bitcoin.org.hk> writes:

> Problem: I'm trying to reproduce the identifier of a tree object using `git cat-file -p <tree object identifier> | git hash-object -t tree --stdin`
>
> This results in an error:
> `fatal: too-short tree object`
>
> To replicate: 
> `git cat-file -p HEAD`
> `git cat-file -p <tree object identifier from output of above> | git hash-object -t tree --stdin`
>
> This works for other object types but not trees. What am I doing wrong?

It would work *ONLY* for blob, and not commit or tag object types,
no?

The "-p" option is to present the object in a human-friendly format,
as opposed to giving the raw stream of bytes that is suitable for
machine consumption and required by hash-object.  It so happens that
for "blob", the raw stream of bytes is just as human-friendly as the
tool can make, without having a deep knowledge of the content type
(e.g. it may be possible to make "cat-file -p <blob>" to somehow
apply an appropriate textconv filter if the path to <blob> is known
as a future enhancement, but such a code does not exist yet, and
when it happens, even "cat-file -p <blob> | hash-object --stdin"
would not round-trip).

So, that is what you are doing wrong, I think.
