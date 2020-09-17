Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE91C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391DA221F1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqPndhnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQAdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:33:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51677 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQAdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 20:33:51 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:33:49 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B54AAEA19F;
        Wed, 16 Sep 2020 20:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7OHPfobpDwTsZhZIleZoqhDCY4=; b=rqPndh
        nOmXV/yeb84/JnM+Z8Ch06860Fh68ONQdKEoBfAoYGpm5nubfWTPad/ht1Yks+pk
        u7gTWCuEkTbb5cXlUyV0sNl2OSSXXiA+AWSPTDmSDWBcO1VA/CaMiGc0uzOa3cAA
        ksVQQT3ixsIpGDg0Jn0rysGnIiNfVsmRVfwYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F4aINtSnvDzzX7FhOLbv0m0w3DfHofDg
        6o65xM832lOLkAZqN/jJNk/yK78iqxgzHNKBDjfaztUsazEOSfTjC6Xqe3sy2sHN
        bxhpNGneJo7QRe2vSTz7gHc9I1rYHceY37JNkUck5++Ba2cHFF7wwwpbbwmBubKj
        Ae9daEw8eWI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD59AEA19E;
        Wed, 16 Sep 2020 20:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00A8DEA19D;
        Wed, 16 Sep 2020 20:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: cancel useAutoBase if base is invalid
References: <20200916234916.422553-1-jacob.e.keller@intel.com>
Date:   Wed, 16 Sep 2020 17:26:26 -0700
In-Reply-To: <20200916234916.422553-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Wed, 16 Sep 2020 16:49:16 -0700")
Message-ID: <xmqqr1r1tfil.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D37B9EA-F87C-11EA-A151-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Make get_base_commit detect when useAutoBase is set, and avoid failing
> if the base commit is picked up automatically. We still attempt to fail
> if --base=auto is explicitly requested on the command line.

Makes sense.  I also think we should fail in such a broken base is
chosen, when useAutoBase is set by configuration and is not
overriden from the command line with an explicit use of --no-base
option, because the end-user expects an appropriate base to be used
that is computed automatically, but we are failing to find such a
base---going ahead silently in such a case would be wrong.

> Unfortunately, at least with how --base is handled by the option parsing
> now, if useAutoBase is true *and* --base=auto is provided, we'll still
> cancel the base option instead of failing.

If we are doing the usual "prime with configuration variables and
then override from the commnad line option" thing, then you cannot
tell these two cases apart, but I happen to think that it is better
to fail (and not to ignore silently) consistently whether the
"compute an appropriate base automatically" came from config or
command line, so...
