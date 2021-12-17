Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhLQQsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhLQQsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:48:40 -0500
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Dec 2021 08:48:40 PST
Received: from tsukuyomi.43-1.org (tsukuyomi.43-1.org [IPv6:2a01:4f8:c2c:1632::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E916C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=43-1.org;
 i=@43-1.org; q=dns/txt; s=2019; t=1639759293; h=from : to : subject :
 in-reply-to : references : cc : date : message-id : mime-version :
 content-type : from; bh=LZzaKUDKrAZLoVNwfvcgNM+767fqT3tUkgwATDuV0P4=;
 b=mdm5cJpWXOrnQpcwMwcV/8HcuS6wKCDw0UovUDrtzkuhVZrbvOqYx3VnrJN6UmvttNSlZ
 BLSnI4gzIDR69rSLBggY5Kd6mFfujxAHFgAvKEF3rfkmIomIspp+Lvi6Kdza7Mm8uDrP9XK
 BdokfG8uRSZpDQ5Z43qfhU6cQ0Gk8jHBJ8c3PGNF2vfoM9m/BzTDfCmexXFwFHkmnfSo5iL
 LLaKyAm9lDGWih5WODG9o4Bo5Uk5WLPoKjS9x3p+83/kA4SYkdE2oLU0ruh/1xeyP0vkHi+
 mg3ugkVucKWRR0re1zT7DWUmE9n5EMF7IvVcF0VCxuxX+6QRubnInN4Zj1YA==
From:   Matthias Maier <tamiko-GITVGER@43-1.org>
To:     git@vger.kernel.org
Subject: Re: Using principal wildcards in gpg.ssh.allowedSignersFile
In-Reply-To: <20211217094235.i2fwildp7rcjcgtz@fs> (Fabian Stelzer's message of
        "Fri, 17 Dec 2021 10:42:35 +0100")
References: <87zgoziwfo.fsf@gentoo.org> <20211217094235.i2fwildp7rcjcgtz@fs>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
CC:     Fabian Stelzer <fs@gigacodes.de>
Date:   Fri, 17 Dec 2021 10:41:31 -0600
Message-ID: <87czlv5glg.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian,

Thanks for doing the bug report to openssh!


On Fri, Dec 17, 2021, at 03:42 CST, Fabian Stelzer <fs@gigacodes.de> wrote:

> [...]

>>  $ ssh-keygen -Y find-principals -f allowed_signers -n file -s test.txt.sig
>>  tamiko@43-1.org
>
> Are you sure the allowed_signers file was exactly what you generated
> before for this command? If I follow your steps this will not produce
> a principal for me with neither openssh-8.8.1, nor master. Can you run
> this with `-vvv` which will show a bit more ssh internal output?
> In the openssh code for find-principals wildcard principals are
> filtered for CA certs. I'm not sure why and have asked them about it.
>
> By the way, find-principals will not consider the namespace parameter.
> This has another bug in the current master producing a segfault for
> which I've already sent a patch. But this should be unrelated to your
> issue.

You're absolutely right - I did confuse myself. The find-principals call
does not work:

    % ssh-keygen -vvv -Y find-principals -f allowed_signers -n file -s test.txt.sig
    debug3: allowed_signers:1: options cert-authority,namespaces="file,git"
    debug1: allowed_signers:1: principal "*@43-1.org" not authorized: contains wildcards
    allowed_signers:1: no valid principals found
    debug1: allowed_signers:1: cert_filter_principals: invalid certificate
    No principal matched.

I agree. It is interesting that they explicitly filter wildcards for the
find-principals call. Let's see what openssh upstream has to say.


> [...]
>
> Just FYI: if you add GIT_TRACE=1 to the git commands you can see the
> executed ssh-keygen commands, which can help to see whats going on.

Ah, that's neat!


Best,
Matthias

