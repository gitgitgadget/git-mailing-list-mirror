Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E837A20281
	for <e@80x24.org>; Thu,  7 Sep 2017 00:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdIGAz3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 20:55:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751543AbdIGAz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 20:55:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D66A7593;
        Wed,  6 Sep 2017 20:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FBY47SIW6X4cfgPr936LWSCawXc=; b=kM996+w2oLc4fkKtRNy2
        nZzcQnv9s2ow6dk+90juQZQuepa8exyFsojYkMbhxTgUT3NLgyYmA9EHQOsGVGyH
        qT7bALvz/sXlw5otRMAO0t5+0aYEY4qon42jDofP9EamVplx2raM7PzOOMczuRvF
        R9DI7eLGlZ9sFNu5hk0lwAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Vz2Icb85UzZZeeo95Z5flniXvNQGRg+t2EBzZJFH+PhRPg
        ONoqTWyoTp1ILKoZ/oWRM7wPCAP14KVDwbyFbqhO0EWWu99Xv0HBL5fOv+COVNSj
        VUpYLdO424HW3ydC5zfgA/mG0l40z5uy8swU74HfiffKUFTLeclscwy7z+zio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E011A7592;
        Wed,  6 Sep 2017 20:55:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB62FA7591;
        Wed,  6 Sep 2017 20:55:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Shikher Verma <root@shikherverma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
References: <20170906093913.21485-1-root@shikherverma.com>
        <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
Date:   Thu, 07 Sep 2017 09:55:25 +0900
Message-ID: <xmqq4lsf2upu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CD81510-9367-11E7-90A1-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On the ref to store the push certs:
> (a) Currently the ref points at the blob, I wonder if we'd rather want to
>     point at a commit? (Then we can build up a history of
>     push certs, instead of relying on the reflog to show all
>     push certs. Also the gc issue might be easier to solve using this)
> (b) When going with (a), we might want to change the name. Most
>     refs are 3 directories deep:
>       refs/heads/<branch name>
>       refs/pr/<pull request nr> # at github IIUC
>       refs/changes/<id> # Gerrit
>       refs/meta/config # Gerrit to e.g. configure ACLs of the repo
>     "refs" indicates it is a ref, whereas the second part can be seen
>     as a "namespace". Currently Git only uses the "heads" and "tags"
>     namespace, "meta" is used by more than just Gerrit, so maybe it is
>     not wise to use "refs/meta/push_cert", but go with refs/gitmeta/pushcert
>     instead?

You also need to worry about concurrent pushes.  The resulting
"history" may not have to be sequencial, but two pushes that affect
the same ref must be serialized in the resulting push-cert store.

The original design deliberately punts all the complexity to hook
exactly because we do not want to have a half-baked "built-in"
implementation that would only get in the way of those who wants to
do high-performance servers.  It is very likely that they want to
have a long-running daemon that listens to a port or a named pipe,
where the only thing the hook would do is to write the value of
GIT_PUSH_CERT to that daemon process, which acts as a serialization
point, can read from the object store that is used as a short-term
temporary area, and write the push cert to a more permanent store.

Having said all that, I am sympathetic to a wish to have an
easy-to-enable-without-thinking example that is not so involved
(e.g. no portability concern, does not have to perform very well but
must be correct).  If Shikher wants to add one, I think the right
approach to do so would be to add and ship a sample hook.

Thanks.
