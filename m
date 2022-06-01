Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5CC433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 07:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiFAHGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiFAHGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 03:06:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4138BD3D
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 00:06:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E90F31184E1;
        Wed,  1 Jun 2022 03:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=zzRSim35yMfDzKZ5jRN+KnysyBUSi/AglLB/X2C9Z34=; b=cxMF
        8sidQaxzHn19KR2TofY/6VMpG118X7aj3CNS+97Sl4aFcScakDVOIVEKyQZh37jd
        tJznhDHCoyPoRISMnYivonnFjuGzfyG1sZ7ZhJrsVrs8Agheox9ErrApybuwh+tm
        tio7VMF05Wbqxnt//Kd8VWgz1/jsO18oC9Et7Fw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A401184E0;
        Wed,  1 Jun 2022 03:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 735111184DE;
        Wed,  1 Jun 2022 03:06:00 -0400 (EDT)
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
        <20220531144703.jbawf3tkypt7se2i@fs>
Date:   Wed, 01 Jun 2022 00:05:59 -0700
Message-ID: <xmqqa6awvp60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ADD633A-E179-11EC-95C6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>Thanks for replying, Fabian.
>>
>>My main issue is that ecdsa-sha2-* keys currently seem incompatible
>>with `gpg.ssh.defaultKeyCommand = "ssh-add -L"`
>>
>>The git-config documentation of `gpg.ssh.defaultKeyCommand` says:
>>
>>> To automatically use the first available key from your ssh-agent set this to "ssh-add -L".

This is puzzling.  One chooses the key to use when signing, and the
key should go to the gpg.ssh.defaultkey, and also "ssh-add" is told
about the key for convenient access.  Asking "ssh-add -L" about the
keys it knows about and randomly pick the first one it happens to
tell you about sounds totally backwards to me.

I may have a key I use to sign, and one key each to go to various
destinations, all of which "ssh-add -L" may know about.  It alone
cannot fundamentally tell because it does not know what you intend
to use each key for.

Of course, as your own custom script, defaultKeyCommand may know
which keys you intend to use for connecting and which keys you
intend to use for signing.  It may even need to know which key you
intend to use for each project you work with and your .git/config
may have something to tell the script what "trait" the key to be
used that appear in "ssh-add -L" output should have (perhaps the key
is rotated very often so you cannot write the exact key in your
configuration, but perhaps the comment at the end of each line have
sufficient cue to tell them apart).  So, the custom script would
need to go line by line to find the key to use in the first place,
and if it is computationally capable enough to do so, it should be
easy to prefix key:: in front.  IIRC, we designed the system in such
a way that it is not an error to prefix key:: in front of ssh-* keys.

In any case, perhaps we should extend the documentation a bit.  It
generally is not sensible to just use "ssh-add -L" and pick one
random key out of it, so we shouldn't be encouraging such a use, I
suspect.

