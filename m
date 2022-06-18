Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991AC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383709AbiFRApm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiFRApk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:45:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED669B6F
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:45:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C32319AE06;
        Fri, 17 Jun 2022 20:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZpEmiCsWql1nWSeO1qN+vOkWN7J9tkx/fj10VcsVnhg=; b=OahY
        R2HyiDqFPZdHdZcf+b1w2f+DhUdzzXV5kbQr0OwHVbtfzZ2vruI0VW/95yihJquR
        w4RzVfABvHgfg+piIqN7SfKXYi3+jx4jjm322mu2ttakgdRDVqeoe+XY1F4mPF7C
        gwUUvHqsVqC2lndmcnqZHJ2POGLroVOB7yYTpkE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4411919AE05;
        Fri, 17 Jun 2022 20:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CCA9619AE02;
        Fri, 17 Jun 2022 20:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
        <xmqqleu3au2n.fsf@gitster.g>
        <CAPMMpojdnAMnczJAevqL8GSOb8gvddcSiYfbz0c51oPpn4U0wA@mail.gmail.com>
Date:   Fri, 17 Jun 2022 17:45:34 -0700
Message-ID: <xmqqiloyn6j5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F756D384-EE9F-11EC-A3CD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> We need a new test or two to see if a straight creation or deletion
>> patch does work correctly with icase set, before we even dream of
>> handling rename patches.  Not having tests for such basic cases is
>> quite surprising, but apparently the above line passed the CI.
>
> This is where I made some very bad assumptions: I only manually ran
> the new "t4141-apply-case-insensitive-rename.sh" test, and assumed
> that the test suite ran against linux, windows, and OSX, with the
> latter two running on case-insensitive filesystems. I assumed that
> both case-sensitive and case-insensitive code paths would be tested by
> the complete CI suite.

Apparently we were surprised the same way ;-)

> *Do* we expect to run the full test suite on case-insensitive systems
> in gitlab, or do we expect to need to add explicit "-C
> core.ignorecase" tests as you have done here?

Running all tests on case-insensitive systems and expect them to
pass is reasonable; we need to sprinkle !CASE_INSENSITIVE_FS
prerequiste to skip certain tests that exercise functionalities that
case insensitive filesystem will never be able to support (e.g. you
cannot by their design have file1.txt and File1.txt at the same time
on the filesystem, so any test with "test_cmp file1.txt FIle1.txt"
must be marked with !CASE_INSENSITIVE_FS prerequisite).

When the system I am primary owrking on is case sensitive, it is
always nice to be able to discover that I broke something on case
INsensitive system before I conclude my WIP into a commit and throw
it at CI.  We may have to case-insensitively treat the paths in the
index in order to match what the working tree would do to make "git
checkout -- <path>" work case-insentively, and doing in-index-only
mode of operation with core.ignorecase=yes on case-sensitive system
may be a way to "emulate" some of the requirement case-insentive
systems have with these "-c core.ignorecase" trick, but of course
not all scenarios can be tested without being on case-insensitive
systems.

So we need both, I think.

