Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD6C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFF721927
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BqeZtDF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbgFSVJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:09:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64154 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbgFSVJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 17:09:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E14FECBEEF;
        Fri, 19 Jun 2020 17:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VclTOhZpr0ZMqjiQefNfKOtNpQo=; b=BqeZtD
        F7hA18McWZEmpBJV/A6agjk+HGmPhG5Xj+IE947e3aGAPwTWyriT/uFVTcuDTEr/
        iyvynPW3Ihveu8Tfr/paXem5nkK+PhD2cG9phIcFgQPieNRzMi5Wa8s/mbwLJSIK
        VIvSZbQBvGEdUNun7tsQaWJeHLBjFLXH2JCMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lxtr5mBFHLDLS4r2RjGTXB2+IPtd5kLk
        IJecOt9VYF+mMF4AQ+ySpYt0PRXjT9V+iBlD3RvC29mJ1umPQv5ipmoRDIEWFnDE
        /hnrq3aiZXZVHmAsAwg2EQZSuEM9ll80H0hzhcltMIdT7iDQhE5ATTf0hWWD9aq7
        xCoWZ/V7iqE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8C6ACBEEE;
        Fri, 19 Jun 2020 17:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CD49CBEE3;
        Fri, 19 Jun 2020 17:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 00/44] SHA-256 part 2/3: protocol functionality
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
        <20200619175601.569856-1-sandals@crustytoothpaste.net>
Date:   Fri, 19 Jun 2020 14:09:33 -0700
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 19 Jun 2020 17:55:17 +0000")
Message-ID: <xmqqk102g3ua.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D76359E-B271-11EA-9671-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is part 2 of 3 of the SHA-256 work.  This series adds all of the
> protocol logic to work with SHA-256 repositories.
>
> v3 fixes a bug in patch 34 which prevented cloning an empty repository
> with the dumb HTTP protocol.  We look up the hash algorithm by length of
> the data in the info/refs file and if we have no refs, we have no
> entries.
>
> Previously, we just failed and complained, which isn't really helpful,
> nor is it backward compatible.  So now we use whatever the default is
> for the current repository.  That means we honor GIT_DEFAULT_HASH or git
> clone -c, and default to SHA-1 otherwise.  Users are encouraged to
> switch to the smart protocol if they need to distinguish the remote
> side's hash algorithm when the repository is empty.
>
> There are tests for the default hash behavior, but not for git clone -c,
> because the extensions.objectformat option doesn't exist yet.  I have
> tested that it does indeed work, though.
>
> Otherwise, this series is the same as v2 except for a rebase (for my
> convenience and Junio's).

Not mine, though.  Keeping the same base is easier to see the
incremental difference.

It wasn't too cumbersome to rebase back on the same base as what was
queued (and the making sure the result, when merged to 'master',
matches the result of applying all these patches directly on top of
'master'), though ;-)

In any case, the updated step 34 made sense to me.  Thanks.

