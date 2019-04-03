Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0F120248
	for <e@80x24.org>; Wed,  3 Apr 2019 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDCWZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:25:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62034 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDCWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:25:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C43D614B6DF;
        Wed,  3 Apr 2019 18:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:date:message-id:mime-version:content-type;
         s=sasl; bh=WQS1izMcXWH+n1aHC8jNA8Ww87Y=; b=rmMh1yuXhunujzo7LsJL
        V3SkKvtY8Pize5s1zS2Dcexn6ZVWadm3Jd2txKD5vZXjVEcN1O44RXgCsbt6YVnU
        7x2Xyvu8CAPH2GjyCFCO0iifjSfXzjXp9YfHQ7TrxQuO/XZSrLhSQqY+bPKl5oBW
        mYsZ/3CVV6jTBuQ6vGS7xNk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB5E714B6DE;
        Wed,  3 Apr 2019 18:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:date:message-id:mime-version:content-type;
 s=mesmtp; bh=7zlskZg9NIK4nwvwYbTSLWI+JXMZompdSdaibp3smpk=;
 b=icAIZG6+4461KkkOMDHni5B2jdTM03qrZJhWx4fJLY6f4EHwkr2ixnyl8U9x0Yiz6bEFGtgrmARiOo5/rvLsRjuXVCIXhE12sVmbcXSEvpCS/PthauBmXA6WHmuZg/Z4P7WWgBLkz1PqSqR1aA48PknYHFcfgkG4mK85xdAZROs=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D23E14B6DD;
        Wed,  3 Apr 2019 18:25:56 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v2 4/4] dir: do not traverse repositories with no commits
In-Reply-To: <xmqqef6jsedj.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 03 Apr 2019 18:25:55 -0400
Message-ID: <87bm1mbua4.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72FEF386-565F-11E9-A6BD-DF19F34BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Kyle Meyer <kyle@kyleam.com> writes:

>> As the required update to t3700-add shows, being looser with the check
>> means that we're stricter when adding empty repositories to the index:
>>
>>   % git add repo
>>   warning: adding embedded git repository: repo
>>   hint: You've added another git repository inside your current repository.
>>   hint: [...]
>>   error: unable to index file 'repo/'
>>   fatal: adding files failed
>
> Hmph, why should we have the initial "warning" with hint?  Shouldn't
> the above result in an outright error?  Something like:
>
>     $ git add repo ;# or git add repo/
>     error: repo does not have a commit checked out
>     fatal: adding files failed
>
> because the entire purpose of "git add repo" (or "git add repo/") when
> "repo" is a repository is to register the commit that is checked out
> in that sub-repository to the index of the top-level repository, as
> part of updating (or starting) a submodule.

Right, the hint makes no sense here.  I'll look into adjusting the
output to be appropriate.

As a minor note: I believe your "git add repo/" comments above describe
what should be and not what currently is.  The trailing slash results in
adding the content from the specified repository to the current
repository rather than registering the repository as a submodule:

  $ git --version
  git version 2.21.0
  $ git init
  $ git init a
  $ git -C a commit --allow-empty -mmsg
  $ touch a/f
  $ git add a/
  $ git status -s
  A  a/f

This behavior (and fixing it) was discussed at
https://public-inbox.org/git/20180618111919.GA10085@book.hvoigt.net
