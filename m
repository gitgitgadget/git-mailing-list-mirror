Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D6C433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3039564D9C
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 08:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhBTIHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 03:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhBTIGz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 03:06:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0952C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 00:06:14 -0800 (PST)
Received: from [IPv6:2a01:c846:1980:2500:a689:6667:a216:ddf8] (unknown [IPv6:2a01:c846:1980:2500:a689:6667:a216:ddf8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6675F1F46650;
        Sat, 20 Feb 2021 08:06:12 +0000 (GMT)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
 <YDA9WjWOjkqlsALc@camp.crustytoothpaste.net>
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
Organization: Collabora
Subject: Re: [PATCH 0/2] Add --no-filters option to git-add
Message-ID: <a58d8057-9847-ba57-1bf5-5d27c235d210@collabora.co.uk>
Date:   Sat, 20 Feb 2021 09:06:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YDA9WjWOjkqlsALc@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/2021 23:36, brian m. carlson wrote:
> On 2021-02-19 at 18:12:11, Andrej Shadura via GitGitGadget wrote:
>> It is possible for a user to disable attribute-based filtering when
>> committing by doing one of the following:
>>
>>  * Create .git/info/attributes unapplying all possible transforming
>>    attributes.
>>  * Use git hash-object and git update-index to stage files manually.
>>
>> Doing the former requires keeping an up-to-date list of all attributes which
>> can transform files when committing or checking out. Doing the latter is
>> difficult, error-prone and slow when done from scripts.
>>
>> Instead, similarly to git hash-object, --no-filter can be added to git add
>> to enable temporarily disabling filtering in an easy to use way.

> I'm interested in your use cases here.  While I agree that this is an
> interesting feature, it also means that practically, a user who checks
> out a file that's added this way may find that git status marks it as
> perpetually modified until a properly cleaned version is committed.
> Moreover, even "git reset --hard" won't fix this situation.
> 
> We see this problem extremely frequently with Git LFS where people
> change the .gitattributes file but don't run "git add --renormalize ."
> and then end up with this problem.  However, it's not limited to Git LFS
> in particular; anything that uses filters, working tree encodings, or
> end of line attributes can be affected.
> 
> So I think that while this might be a useful escape hatch for users, I
> definitely want to see a compelling rationale for it and a big warning
> in the documentation and an update to the relevant entry in the Git FAQ
> before we accept such a patch.

My use case here is mostly non-interactive use in scripts creating Git
trees that need to exactly correspond to a working directory regardless
of whether or not they have any .gitattributes files.

For example, for git-buildpackage or dgit, which facilitate Git
workflows with Debian packages, want to ensure the contents of the
packages can be exactly reproduced, which is difficult if the upstream’s
tarball has .gitattributes. It is possible to "defuse" the attributes as
demonstrated above, but this will break if the user modifies the
.git/i/a file *or* if Git adds more attribute-based conversions. This is
what dgit currently does, and this is what git-buildpackage will soon do
too.

Of course, this patch set only addresses staging files. While working on
a patch to git-buildpackage to reproducibly import the contents of
tarballs, I realised that the only realistic way seem to do that is to
use hash-object + update-index manually, which is likely to come with a
performance drop compared to git add (which is what gbp currently uses).
A workaround might be to use dulwich (which would allow to do
hash-object without fork/exec) or perhaps GitPython (which I haven’t
really looked into), or maybe to use git fast-import, but all of these
alternatives are quite complex and don’t guarantee the same performance.

Adding a new option to git add allows to keep the performance without
having to ensure attributes are set to the right values. The attributes
will likely have to be adjusted anyway for user’s convenience, but at
least if they modify them afterwards, the tools won’t break.

-- 
Cheers,
  Andrej
