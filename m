Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5ACCA47E
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiFGRUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiFGRUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:20:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD231053DD
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:20:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEB46198706;
        Tue,  7 Jun 2022 13:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r0lCPIT5Z0Ir9meg55+SyLIXMSVnoWl9KuDcPm
        wv0lI=; b=Y/WPqGs13lhJaZrfj5VntpPms7yy4xWNrvrUPNL28O2jv08J7kaoX5
        pU5qDHba5Mpq9gJtZIjARy+cXgnwUiedBqOAZBTL6oSfonPQd5DFUBGScO7rcQLq
        fHuUZi9K4ub1sFFVDSMSJx48VfoRtM95bYZg9dT5gis/Nx2J7mAVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5DA5198705;
        Tue,  7 Jun 2022 13:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A271198704;
        Tue,  7 Jun 2022 13:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Andy Lindeman <andy@lindeman.io>,
        Andy Lindeman via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: Support ECDSA as literal SSH keys
References: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
        <20220531073445.iuovy634ufp5xims@fs>
        <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
        <20220531144703.jbawf3tkypt7se2i@fs> <xmqqa6awvp60.fsf@gitster.g>
        <20220607085226.g6sjcmoiimcvqknx@fs>
Date:   Tue, 07 Jun 2022 10:20:31 -0700
In-Reply-To: <20220607085226.g6sjcmoiimcvqknx@fs> (Fabian Stelzer's message of
        "Tue, 7 Jun 2022 10:52:26 +0200")
Message-ID: <xmqqtu8wxue8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22A96050-E686-11EC-8912-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 01.06.2022 00:05, Junio C Hamano wrote:
>>Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>>>Thanks for replying, Fabian.
>>>>
>>>>My main issue is that ecdsa-sha2-* keys currently seem incompatible
>>>>with `gpg.ssh.defaultKeyCommand = "ssh-add -L"`
>>>>
>>>>The git-config documentation of `gpg.ssh.defaultKeyCommand` says:
>>>>
>>>>> To automatically use the first available key from your ssh-agent set this to "ssh-add -L".
>>
>>This is puzzling.  One chooses the key to use when signing, and the
>>key should go to the gpg.ssh.defaultkey, and also "ssh-add" is told
>>about the key for convenient access.
>
> I think you mean `user.siningKey` but yes, this is the best way to do this.

Thanks for seeing my intention through my mistake.

>> Asking "ssh-add -L" about the
>>keys it knows about and randomly pick the first one it happens to
>>tell you about sounds totally backwards to me.
>>
>>I may have a key I use to sign, and one key each to go to various
>>destinations, all of which "ssh-add -L" may know about.  It alone
>>cannot fundamentally tell because it does not know what you intend
>>to use each key for.
>> ...
>>In any case, perhaps we should extend the documentation a bit.  It
>>generally is not sensible to just use "ssh-add -L" and pick one
>>random key out of it, so we shouldn't be encouraging such a use, I
>>suspect.
>
> Yes, I think that reasonable. The script can do some advanced decision
> making / key lookup if needed.

OK.

> The use-case for me was to enforce/encourage use of the correct
> users keys on a shared development server in a corporate
> environment (i have a global directory of all the users keys and
> want to make sure everyone uses their correct one when signing).

I actually wanted to hear more about the reasoning along that line.

IOW, "sure, theoretically, you should start from 'this is the key I
want to use' and you shouldn't be asking 'ssh-add -L' about it, but
here is a real-world workflow that makes it cumbersome" was what I
wanted to see, both in the discussion *and* in the documentation
update.

For example, there may be corporate environment where key is
frequently rotated, e.g. every morning an employee may have to "corp
login" to talk to a central key server and get the ssh key stored in
their hardware token refreshed.  In such an environment, it would
not be surprising if the employee does not even know what the
fingerprint or the public part of the key looks like before asking
'ssh-add -L' to query the hardware token, so it may be impractical
to follow the "set your key to user.signingKey and add that to the
agent".  Asking the agent about the key may make perfect sense (but
you'd probably need to find which key among its output lines) in
such a case.





