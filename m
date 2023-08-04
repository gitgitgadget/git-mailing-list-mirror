Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E58C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 16:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHDQow (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjHDQov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 12:44:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFAB2
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 09:44:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4180E19EDC;
        Fri,  4 Aug 2023 12:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s7FS9YxNcZq+
        CXk9/HSbZted0F+IfVRkN8+eAhR7umU=; b=DHCW2Y8CN7uf4w6UJwQKQV3KLDoQ
        sk5U6gIv85o0x/6Baggk5uzQJKehATBrhrvvguP0TkYY2piH+0iB2ae0CSPM1Tk/
        LFQAL5wUZimfDBQTgkh5oZlvBmbPCWdBHKQhAhCO5EE1MB7o4ljLbbgERmZC7u04
        GAe9KuKJyFDRpGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3907719EDB;
        Fri,  4 Aug 2023 12:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C108619EDA;
        Fri,  4 Aug 2023 12:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v2 1/3] run-command: conditionally define locate_in_PATH()
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
        <dc9c0812d203a4eb777659bb54fda60022bf9650.1691122124.git.gitgitgadget@gmail.com>
        <xmqqo7jn3073.fsf@gitster.g>
        <AS1P250MB0701991FBCA2E37BD5238497A509A@AS1P250MB0701.EURP250.PROD.OUTLOOK.COM>
Date:   Fri, 04 Aug 2023 09:44:44 -0700
In-Reply-To: <AS1P250MB0701991FBCA2E37BD5238497A509A@AS1P250MB0701.EURP250.PROD.OUTLOOK.COM>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 4 Aug 2023
 07:27:28 +0200
        (CEST)")
Message-ID: <xmqq5y5u3gg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37FA6A28-32E6-11EE-A4D2-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> On Thu, 3 Aug 2023, Junio C Hamano wrote:
>
>> "Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
>> writes:
>>
>>> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>>>
>>> This commit doesn't change any behaviour by itself, but allows us to =
easily
>>> define compat replacements for locate_in_PATH(). It prepares us for t=
he next
>>> commit that adds a native Windows implementation of locate_in_PATH().
>>>
>>> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
>>> ---
>>>  run-command.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/run-command.c b/run-command.c
>>> index 60c94198664..85fc1507288 100644
>>> --- a/run-command.c
>>> +++ b/run-command.c
>>> @@ -170,6 +170,7 @@ int is_executable(const char *name)
>>>  	return st.st_mode & S_IXUSR;
>>>  }
>>>
>>> +#ifndef locate_in_PATH
>>>  /*
>>>   * Search $PATH for a command.  This emulates the path search that
>>>   * execvp would perform, without actually executing the command so i=
t
>>
>> Micronit.  The comment should be shared across different platform
>> implementations of this interface, so "#ifndef" would want to come
>> immediately after this comment, not before, I would think.
>
> I can see the first part applying to all implementations, but the last
> part about it not working on windows is specific to this
> implementation.
>
> I guess we could split the comment, if we wanted to make that clear.
>
>> It does not affect the correctness, of course ;-)

Let's not bother immediately before -rc0; letting people use "gitk"
during "git bisect" without having to type 5 extra keystrokes in the
upcoming release is a good outcome and we can touch up the in-code
comment later.

Thanks.
