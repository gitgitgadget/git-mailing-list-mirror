Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F63BC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328E620736
	for <git@archiver.kernel.org>; Sun, 10 May 2020 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RbwnmnE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgEJRCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 13:02:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64565 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgEJRCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 13:02:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6B9446D9;
        Sun, 10 May 2020 13:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XCZSn2585bLxobVJuYnHGsFn7JM=; b=Rbwnmn
        E0Zxd3hs4ZjwOKqapkIvjaFwVBTM/lnX32aIv9/oZGj+KMbBgQ8bTlhHT5xx0P4T
        EmDBlchE3sgtjnxxFqhjhwdjuNuP3QkgL+WUevt+cvD93bi05sGs6AunRP5ys55G
        rykSzkRT2knaQ030EansLx8LiRk7gwMev2vBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xUBm3IIKAdxGDr8WGoAjRFxMJ4lUv4y3
        Ca4jjd4OPWEpxyJWtZ/zZuelJZSqdLTGtd8vPFUWEeqHb6jEojggozSM1FGWJAlr
        MzHMSZNC2AUiKBrqW6/uUsEcRPwhaSS/se63NPhXCT+wy6Zi22ifotM/W7anbs67
        V7aZuDP0Kfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 542B7446D8;
        Sun, 10 May 2020 13:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2DC9446D6;
        Sun, 10 May 2020 13:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v3] git-p4: recover from inconsistent perforce history
References: <20200510101650.50583-1-andrew@adoakley.name>
        <CAE5ih793qKyOSE-hkOw7+nFmM3XTRxxrXv0FD2+WWXjGbVHkoQ@mail.gmail.com>
Date:   Sun, 10 May 2020 10:01:59 -0700
In-Reply-To: <CAE5ih793qKyOSE-hkOw7+nFmM3XTRxxrXv0FD2+WWXjGbVHkoQ@mail.gmail.com>
        (Luke Diamand's message of "Sun, 10 May 2020 13:03:11 +0100")
Message-ID: <xmqqsgg7u3js.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6665CF6-92DF-11EA-9EC5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On Sun, 10 May 2020 at 11:17, Andrew Oakley <andrew@adoakley.name> wrote:
>>
>> Perforce allows you commit files and directories with the same name, so
>> you could have files //depot/foo and //depot/foo/bar both checked in.  A
>> p4 sync of a repository in this state fails.  Deleting one of the files
>> recovers the repository.
>>
>> When this happens we want git-p4 to recover in the same way as perforce.
>
> Looks good to me.
>
> Perforce changed their server to reject this kind of thing in the
> 2017.1 version:
>
>     Bugs fixed in 2017.1
>     #1489051 (Job #2170) **
>        Submitting a file with the same name as an existing depot
>        directory path (or vice versa) will now be rejected.
>
> (Of course people will still have damaged repos even today).

Perhaps it is worth describing the above in the log message?  E.g.

    Perforce allows you commit files and directories with the same name,
    so you could have files //depot/foo and //depot/foo/bar both checked
    in.  A p4 sync of a repository in this state fails.  Deleting one of
    the files recovers the repository.

    When this happens we want git-p4 to recover in the same way as
    perforce.

    Note that Perforce has this change in their 2017.1 version:

         Bugs fixed in 2017.1
         #1489051 (Job #2170) **
            Submitting a file with the same name as an existing depot
            directory path (or vice versa) will now be rejected.

    so people hopefully will not creating damaged Perforce repos
    anymore, but "git p4" needs to be able to interact with already
    corrupt ones.

    Signed-off-by: Andrew Oakley <andrew@adoakley.name>
    Reviewed-by: Luke Diamand <luke@diamand.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
