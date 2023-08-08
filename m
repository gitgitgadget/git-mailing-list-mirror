Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61911C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjHHSxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHHSwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2D157903
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:07:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B75D61AEDAC;
        Tue,  8 Aug 2023 13:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Y+olMLKM04894Qqec4ZOd6eR5qp8RKcreOblq
        h17mY=; b=CBrBuTTlvjojitYbHwixxlMdXM/qu/366oiwdaOOloJk9Pf/DY3TX8
        8Dq7fFLxIzYl5E1zDpJD/MigQj5Wso2MzMzunksJG/u3+rrTTOnMzLIa1CyhFzmx
        pIYeAhUitwvYjINShQVmAzog1U9PDzcu0Ldvp9aY67stvUa2DIhDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF9D61AEDAB;
        Tue,  8 Aug 2023 13:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23DE91AEDAA;
        Tue,  8 Aug 2023 13:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Watson <pwatson2@wellmed.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git bug report
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
Date:   Tue, 08 Aug 2023 10:07:32 -0700
In-Reply-To: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
        (Paul Watson's message of "Fri, 4 Aug 2023 16:46:23 +0000")
Message-ID: <xmqqbkfh8nu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10A2F938-360E-11EE-9D23-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Watson <pwatson2@wellmed.net> writes:

> 9:43:55.45 2023-08-04  C:\src\t\scripts>TYPE .\t1.txt
> this is t1.txt

> 9:43:57.92 2023-08-04  C:\src\t\scripts>TYPE .\t2.txt
> this is t2.txt
>
> 9:43:58.04 2023-08-04  C:\src\t\scripts>"C:\Program Files\Git\cmd\git.exe" diff --exit-code --no-index  --ignore-all-space  --shortstat  .\t1.txt .\t2.txt
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> 9:43:58.14 2023-08-04  C:\src\t\scripts>ECHO %ERRORLEVEL%
> 0

This is not specific to Windows port and it can be reproduced on a
random Linux box.

    $ echo one >1
    $ echo two >2
    $ git diff --no-index --shortstat 1 2; echo "<<$?>>"
     1 file changed, 1 insertion(+), 1 deletion(-)
    <<1>>
    $ git diff --no-index --shortstat -w 1 2; echo "<<$?>>"
     1 file changed, 1 insertion(+), 1 deletion(-)
    <<0>>

Note that I omitted "--exit-code" in the above reproduction, as it
is always used in the no-index mode.  There seems to be interaction
with "-w" and not using "-p", as this is not limited to "--shortstat".

    $ git diff --no-index -w --stat 1 2; echo "<<$?>>"
     1 => 2 | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    <<0>>

    $ git diff --no-index -w --numstat 1 2; echo "<<$?>>"
    1	1	1 => 2
    <<0>>

All of the above that exits with 0 status will exit with 1 when -p
is added to the command line.

Also, this is not limited to the no-index mode.

    $ echo one >1
    $ git add 1
    $ echo two >1
    $ git diff --exit-code --numstat 1; echo "<<$?>>"
    1	1	1
    <<1>>
    $ git diff --exit-code --numstat -w 1; echo "<<$?>>"
    1	1	1
    <<0>>

So the minimum reproduction seems to be

  * the diff machinery is asked to do --exit-code (no-index
    implicitly does it)
  * -w is used
  * -p is *not* used
  * to compare two different files.

Thanks for a bug report.

Patches welcome ;-)
