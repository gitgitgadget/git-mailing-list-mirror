Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73122047F
	for <e@80x24.org>; Fri,  4 Aug 2017 17:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbdHDR54 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 13:57:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751208AbdHDR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 13:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 382999FE88;
        Fri,  4 Aug 2017 13:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IQlSkETDzoU4
        xtg0oB2+qaxIw34=; b=cpuKMsYlTPaYDN86Px3TXzP8SEjwiAOny5EDwmcCXKHj
        tNp9Yfhl85VjI4DQJicYBLcaWAgBIXNiCAzB1BcpLBTRs7wv4zJnmwiE4y9/FsHH
        7G7eFgUGuLrSMBM6OcMjL0X96u+jK2xzMk2ERdxe2uCHPxWHLNSapgj78xNBdTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wbq52U
        2sVV1QrWnY8HN75Hf0fRCANACIP8dLC1HLtA40sUZXxsL0dyMXI4U/oYv03Cqvrk
        jBmfqHD34PfkxqJRnmFofJisKOrH7BTUh2A2kTKkfHlVQh9NLK4WqMc9nRHTOric
        C3+o4twLaI3dUfWA40yw/StZfh7msYR3mPoPo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FAC09FE86;
        Fri,  4 Aug 2017 13:57:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0B759FE85;
        Fri,  4 Aug 2017 13:57:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v1 1/1] correct apply for files commited with CRLF
References: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
        <20170802204203.29484-1-tboegi@web.de>
        <xmqqwp6lr7u0.fsf@gitster.mtv.corp.google.com>
        <191dc9ea-6ad3-f754-59da-2075a6fd581e@web.de>
Date:   Fri, 04 Aug 2017 10:57:48 -0700
In-Reply-To: <191dc9ea-6ad3-f754-59da-2075a6fd581e@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 4 Aug 2017 19:31:42
 +0200")
Message-ID: <xmqqini3tdur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DE46F3E-793E-11E7-BC99-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Back to the fix, the read_old_data() from below works on the working tr=
ee,
> yes, but after convert_to_git().
> And that is why we need the index, to fix this very case.

But "git apply" (without "--cached" or "--index") is to work on the
working tree file only.  The target file of the patch that is going
to be modified does not even have to be in the index, i.e. it is
perfectly fine to:

 (1) create a file F, commit, then modify that file;

 (2) take two patches out of that repository you did (1);

 (3) go to a Git repository that does not yet know about file F;

 (4) run "git apply" to process the first patch you took in (2),
     which will create file F; then

 (5) run "git apply" to process the second patch on top, which will
     modify file F.

Step (4) will probably not cause too much issue, as the only thing
we make sure is "Because the patch creates F, F does not exist in
the directory", which would be the case.

Now, when trying to apply the second patch at step (5), we may need
to adjust for the broken line-ending convention, but you do not have
any entry in the index for F to rely on.

That is why I am saying convert_to_git() that checks the index
content is a wrong thing to use in this codepath. =20

It is OK to use it for "git add" and friends, as the intent of the
(I'd say "broken") "safe CRLF" mechanism is to take a hint from the
"previous" state to see if CRLF in the "new" content should be
munged, and the "previous" in the context of running "git add" _is_
what is in the index.

The "previous" in the context of running "git apply" (which does not
look at the index) is _not_ what is in the index, on the other hand.
Instead of "struct index_state *", convert_to_git() needs to be
fixed to take something else that can be queried for the "previous"
version to use as a hint, if "safe CRLF" wants to work correctly.
