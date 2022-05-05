Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A3C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383371AbiEESuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357871AbiEESuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 14:50:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CAB5F99
        for <git@vger.kernel.org>; Thu,  5 May 2022 11:44:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04FA81ACC73;
        Thu,  5 May 2022 14:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CWz4581uReCw4adZT3iT79NknUOdxCDzHSeUFx
        61W3g=; b=D5ws+TsMtWvIEj2Iuao9wtX62JIutOsVePnjiwvoTdYNqljIUbgoxW
        c6g2paa3mqlZiJxOFcTBf2neXnUhjAUROeRUGuLTLmI35WsPfUSZJp7yUL+NOyF+
        JxENCGS9YrMi5RJ9GpfF6VwGt8ZaNrKEK7+kD5qLeclJcHC6fBtcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F09AC1ACC72;
        Thu,  5 May 2022 14:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D1241ACC70;
        Thu,  5 May 2022 14:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info
 command
References: <20220502170904.2770649-9-calvinwan@google.com>
        <20220504212738.162853-1-jonathantanmy@google.com>
        <CAFySSZCL-ccVK+ZOU5=X4fB3-eu=Cmu-MGpT1cMW+bqmdRcF9w@mail.gmail.com>
Date:   Thu, 05 May 2022 11:44:50 -0700
In-Reply-To: <CAFySSZCL-ccVK+ZOU5=X4fB3-eu=Cmu-MGpT1cMW+bqmdRcF9w@mail.gmail.com>
        (Calvin Wan's message of "Thu, 5 May 2022 11:13:19 -0700")
Message-ID: <xmqqbkwbes4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 728E18E2-CCA3-11EC-810D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> It works with other commands. The idea is that you would enter a line like:
>
> remote-object-info <remote> <oid> <oid> ... <oid>
>
> rather than
>
> remote-object-info <remote> <oid>
> remote-object-info <remote> <oid>
> remote-object-info <remote> <oid>
>
> since each invocation of remote-object-info would cause another round
> trip to the server.

Hmm.  It looks unfortunate, but if we do not care about hitting the
pkt-line length limit, that might be OK.  I dunno.

I would have expected to see something like

	start batch
	request 1
	request 2
	...
	request 2000
	flush batch

during which the other side patiently listens to our requests.  They
(meaning the local process that reads the above and talks to a
remote as needed) can coalesce the requests of the same kind
(e.g. going to the same remote) while buffering and optimize their
operation without having the caller of them to worry about it that
way, no?
