Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E6C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDNTCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNTCF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 15:02:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA39ED0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:02:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F204E1ECDE3;
        Fri, 14 Apr 2023 15:02:01 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=h3QkuWs4UnJlVcYyMJNClbXSiaYEhv3cf69CO8v
        fUrw=; b=EoHEVV/47iwpmsWkgToSKzWasFbW3pJfDH5dit6rl5oo0NgWPF98J5M
        8U1CAufXVOG5adxYelERmiYdV0XAIbSvu83cDICUjtsVGRKyMMPd+ksVL936hLrS
        c7BF68zNohciQ9q5sfKDgkSWEIeUZAwDv1rLQuMW8U/p0cfkj7Qc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB1A61ECDE1;
        Fri, 14 Apr 2023 15:02:01 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FA821ECDDF;
        Fri, 14 Apr 2023 15:01:57 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 14 Apr 2023 15:01:54 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/18] version-gen: remove redundant check
Message-ID: <ZDmjIqNwVMESgHnn@pobox.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
 <20230414121841.373980-7-felipe.contreras@gmail.com>
 <ZDltLSTxBCWRoMjK@pobox.com>
 <643991c58aef_5ecfe29433@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643991c58aef_5ecfe29433@chronos.notmuch>
X-Pobox-Relay-ID: D476891A-DAF6-11ED-A789-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Todd Zullinger wrote:
>> Felipe Contreras wrote:
>>> If we are not in a git repository `git describe` will fail anyway.
>> 
>> The parent directory may be a git repository though.  The
>> current code ensures that we're running `git describe` in
>> the proper repository.
> 
> How exactly does it do that?
> 
> The current code expects the cwd to be the git repo, run it in any other
> directory and it will generate GIT-VERSION-FILE in that directory, which is
> clearly not intended.

Whether it's fool proof isn't really my point.  It did
attempt to check that .git was a file or directory.  Not
checking at all isn't necessarily an improvement, was my
concern.

>> If we drop this, aren't we breaking things for someone
>> building a git tarball which is in a subdirectory of a git
>> repository?
> 
> How exactly would this hypothetical person build such a tarball?
> 
>   git init /tmp/foo
>   mkdir -p /tmp/foo/bar
>   cd /tmp/foo/bar
>   make -C ~/dev/git dist

If I have a git repo, say ~/fedora/git which contains the
fedora packaging (spec file, etc.) and extract a git archive
in this directory, the describe will now pick up the data
from the parent git directory, won't it?

    $ git -C ~/fedora clone https://src.fedoraproject.org/rpms/git.git
    $ cd ~/fedora/git
    $ git -C ~/upstream/git archive --format=tar --prefix=git/ HEAD | tar xf -
    $ cd git
    $ make GIT-VERSION-GEN
    $ cat GIT-VERSION-FILE 
    GIT_VERSION = 

The version file in the tarballs prevents this from
happening in the most common case, but it still feels like
this is loosening things a little more than it should.

-- 
Todd
