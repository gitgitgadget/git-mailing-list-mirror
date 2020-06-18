Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A9C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F08206F1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D72ubM+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFRWkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:40:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54500 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRWkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 18:40:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BF52DD60B;
        Thu, 18 Jun 2020 18:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9PDrvD60cF2z6UPJ+5huu9IOqQ=; b=D72ubM
        +NekaVMBMnJhIp3qXajjailkB+1oBpyD0CYdKX16zZK9kc2eS5LDU0AM9hldQDsx
        xNXRlQ2jPiHSmrdMCn8qtAASsW6U/zvWGdxbunGE2y83BTk6EAc8Dk1tiPUUb6vz
        5emggsj6lwJtbxvwFFnfgajhSboWLn8ADsOfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1hrHdJEGOOpOKMlALm6Xu3YvsSl/+uu
        8jY/gUHDds50B2Bc/MJORAfj7IfLJ0Mv7kbPvkPk1LoVWmgwtB3BZbTWl/oXW8XP
        m2VZbxNrHIhJTZTab48nohEJgJ7V6GoD0+o7lyJv9yzdWWDdVGT4JIBaq2yDUVN2
        g64k2I9M70I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44B7BDD60A;
        Thu, 18 Jun 2020 18:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 897C3DD608;
        Thu, 18 Jun 2020 18:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
        <xmqqk104knrs.fsf@gitster.c.googlers.com>
Date:   Thu, 18 Jun 2020 15:40:38 -0700
In-Reply-To: <xmqqk104knrs.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 18 Jun 2020 15:33:11 -0700")
Message-ID: <xmqqbllgknfd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCAB30EC-B1B4-11EA-B1E2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	touch empty &&
>
> Use of "touch" gives a wrong impression that you care about the file
> timestamp; use something like ": >empty &&" instead when you care
> about the presence of the file and do not care about its timestamp.

I just realized that this is even more important in this case not to
use "touch".

The test that uses this file cares not just the presence, but it
deeply cares that its contents is empty.  The thing it least cares
about is its timestamp.

The purpose of using "touch" is to update the timestamp, to keep the
current contents if it exists, and to ensure it exists (as a side
effect), in the decreasing order of importance.  Use of the command
here misleads the readers.

Thanks.
