Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF4EC433EA
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64531207E8
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4vZ0XeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgG2AwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:52:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbgG2AwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:52:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2272979B7C;
        Tue, 28 Jul 2020 20:52:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UcFugZXe1fRKsvbAJVtmz5+hiGI=; b=A4vZ0X
        eSeTIEK6zEXqRn3CmznG3QGeEl4uyFIgmI/BWFhw/iJlAsaLr1PvEIDpyUh9hG61
        ebwAGPNovf3v75mnKEI7dHminkubh/P1tsCbiuSndsA3CwFZHS+bvu+NUAwebMHS
        IYS2iqWisahptMikstCEDOMAkq0ZNYenYAzEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JeRufEoW/zzEZtojC08kXW4I8iohvYg8
        tiATODx53J10bqZ9uEtB7MnVZ0c5WehSq7PQbdDSpi8xMMHNpMlhWkzArz3kYQzZ
        m1x58GnsF84r6jLW2WqsOwX066qOniTm6Zao2z0yRC5Wno/2Q/9VnSb847niA0LP
        BGZAORYT9QY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19AA079B7B;
        Tue, 28 Jul 2020 20:52:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CA2E79B7A;
        Tue, 28 Jul 2020 20:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: I have gone and done a bad thing - malformed tree objects
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us>
Date:   Tue, 28 Jul 2020 17:52:04 -0700
In-Reply-To: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us> (Jason Pyeron's
        message of "Tue, 28 Jul 2020 20:47:18 -0400")
Message-ID: <xmqqh7trb0sr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8CAB380-D135-11EA-AC7C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> I was trying to "do stuff" using hash-object -t tree --stdin -w,
> but I accidentally created trees where other trees were marked as
> blobs. They were dangling and not connected to any actual commits
> on my branches.
>
> After gc and fsck clean ups, everything reports well...
>
> Except:
>
> $ GIT_TRACE=1 git cat-file --batch-all-objects --batch=objecttype

gc and fsck may not have pruned the dangling object yet, but
--batch-all-objects is a request to enumerate objects that exist in
the repository, regardless of their reachability from any ref.

Perhaps "git prune --expire=now" would get rid of it?
