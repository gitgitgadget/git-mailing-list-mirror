Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9231C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D85420715
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoQlXG2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfLBGuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:50:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62289 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBGuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 01:50:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 899BD97C3F;
        Mon,  2 Dec 2019 01:50:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tmW57z4nEbnabMg1vpvRDFZ1UKo=; b=WoQlXG
        2OlsJBoDJifdZu59OCd4sDpr7cDU5bv5bLG1Wuej0tG9xf/D5mcAoMcQ4lvG3XpW
        /uCv7RGU91tjD3c7OCVKm52LtDk2vpKwVSAf9RYfc6hdfYq8cQTolff7dn38QxpX
        zlZSwtzpMFIOlEzAw1mM5INsCh8LMqU8GLNco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GoO9HzsZ5HxETqKwOiuzkEsPc8LTSnds
        cu1KXxBXJvsQ0tyr88nDT4/B1rZ1tMsEv1kNZebTi2zvmFGI6qiS6dtT+qJuHrkv
        Uo4tPc7sf3yKoInmufK6RI4xfke7VEF5rqZBBuhzBBlKBFl8pftVvMqy1cFmbego
        2ZceTp3ku2o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81BA497C3E;
        Mon,  2 Dec 2019 01:50:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC28B97C3D;
        Mon,  2 Dec 2019 01:50:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-status performance with submodules
References: <CALnO6CCoXOZTsfag6yN_Ffn+H7KE-KTzm+P-GqLKnDMg8j_Qmg@mail.gmail.com>
Date:   Sun, 01 Dec 2019 22:50:29 -0800
In-Reply-To: <CALnO6CCoXOZTsfag6yN_Ffn+H7KE-KTzm+P-GqLKnDMg8j_Qmg@mail.gmail.com>
        (D. Ben Knoble's message of "Mon, 2 Dec 2019 01:19:49 -0500")
Message-ID: <xmqq5zizz0ei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09223CB8-14D0-11EA-8DEA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> ### What I am curious about
>
> From the traces (attached), it appears that git-status suffers from a lack of
> (possibly embarrassing) parallelism: I would expect each submodule to be
> independently check-able, ...
> ...
> What can we do to fix this? Is there a reason for this (really terribly slow)
> serial execution? Is this something developers haven't bothered to optimize
> ("unexpected use case")? If so, I would like to discuss taking a crack at it,
> because I do have at least one repository with this many submodules, and I
> care about its performance.

Nice to hear from somebody who cares about improving submodule
support.  I offhand do not think of a reason why we inherently have
to process them serially.

But the way "git status" code is structured, it probably takes a bit
of preparatory refactoring.  If I recall correctly, it walks each
path in the index in the superproject and notes how the file in the
working tree is different from that of the index and the HEAD, under
the assumption that inspection of each path is relatively cheap and
at the same cost.  You'd first need to restructure that part so that
inspecting groups of index entries can be sharded to separate
subprocesses while the parent process waits, and have them report to
the parent process, and let the parent process continue with the
aggregated result, or something like that.

Thanks.

