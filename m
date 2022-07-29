Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD087C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiG2O5r convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Jul 2022 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiG2O5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:57:45 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23092B279
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:57:44 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26TEvhP0057323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 10:57:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'ZheNing Hu'" <adlternative@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Git List'" <git@vger.kernel.org>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <christian.couder@gmail.com>,
        "'Jeff King'" <peff@peff.net>
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com> <220727.86mtculxnz.gmgdl@evledraar.gmail.com> <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com> <220728.861qu5kz2c.gmgdl@evledraar.gmail.com> <CABPp-BH8BYMaG=VK_OpfX3QKBLAOiLH9sTDdTWq5=4C6-663HA@mail.gmail.com> <CAOLTT8R1WQyqLNfymJgxTgCuoOKEe0Vu+7k9D+85u-x53FYJiQ@mail.gmail.com>
In-Reply-To: <CAOLTT8R1WQyqLNfymJgxTgCuoOKEe0Vu+7k9D+85u-x53FYJiQ@mail.gmail.com>
Subject: RE: Question: What's the best way to implement directory permission control in git?
Date:   Fri, 29 Jul 2022 10:57:38 -0400
Organization: Nexbridge Inc.
Message-ID: <00b901d8a35b$8ebbe6a0$ac33b3e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHwsnQ5h+uNjtF6705rlmsKxn4MbwH7sRZWAqfyrtgCr9mJqgLZMwWPAbVvPXCtBj5QcA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 29, 2022 10:22 AM, ZheNing Hu wrote:
>Elijah Newren <newren@gmail.com> 于2022年7月29日周五 09:48写道：
>
>> > But due to git's commits referring to a Merkle tree I can tell you
>> > that a subdirectory "secret" has a current tree SHA-1 of XYZ,
>> > without giving you any of that content.
>> >
>> > You *could* then manually construct a commit like:
>> >
>> >         tree <NEW_TREE>
>> >         ...
>> >
>> > Where the "<NEW_TREE>" would be a tree like:
>> >
>> >         100644 blob <NEW-BLOB-SHA1>     UPDATED.md
>> >         040000 tree <XYZ>       secret-stuff
>> >
>> > And send you a PACK with my new two three new objects (commit, blob
>> > & new top-level NEW_TREE). To the remote end & protocol it wouldn't
>> > be distinguishable from a "normal" push.
>> >
>> > But nothing supports this already, as a practical matter most of git
>> > either hard dies if content is missing, or has other odd edge-case
>> > semantics (and I'm not up-to-date on the state of the art).
>>
>> Actually, this is what sparse-index (as a sub-option in
>> sparse-checkout) already basically does.  See
>> Documentation/technical/sparse-index.txt for details, and note that
>> we're basically in Phase IV of that document.  In short, the
>> sparse-index makes it so that common operations based on the index do
>> not need and do not use information about some subtrees, so if someone
>> has a partial clone starting with no blobs, they will only have to
>> download a small subset of the repository blobs in order to handle
>> most Git operations, and many operations become much faster since the
>> index is so much smaller.
>>
>
>I think this is mainly due to sparse-checkout instead of sparse-index.
>Without the sparse-index, we also can do git add, git commit without fetching
>other blob objects.
>
>But sparse-index can help reduce the size of indexes.
>
>> However:
>>
>> * Users can run `git sparse-checkout reapply --no-sparse-index` at any
>> time to force the index to be full again.  This is documented, and
>> even suggested that users remember in case they attempt to use
>> external tools (jgit? libgit2? others?) that don't understand sparse
>> directory entries.  So, removing this ability would be problematic.
>>
>
>Or `git sparse-checkout disable`? Whatever, when git finds other objects missing,
>it will fetch the objects from remote, and we may do ACL check here.
>Just let jgit/libgit2/others fail to fetch objects (in this special case?)
>
>> * It makes no guarantee whatsoever that the sparse directory entries
>> are not expanded by less frequently used Git commands.  Notice the
>> "ensure_full_index()" calls sprinkled throughout the code.  Some have
>> been removed, one by one, as commands have been modified to better
>> operate with a sparse index.  The odds they'll all be removed in the
>> future may well be close to 0%.
>>
>
>That's good...
>
>> * The `ort` merge strategy ignores the index altogether during
>> operation.  If it needs to walk into a tree to complete a
>> merge/rebase/revert/cherry-pick/etc., it will.  Further, it doesn't
>> just look into those paths, it intentionally de-sparsifies paths
>> involved in conflicts, so it can display it to the user.
>>
>
>So the user has to care and deal with a merge conflict in a directory that he
>"doesn't have access to"...
>
>It would be nice to have the user only care about conflicts in directories/files to
>which he has permissions. I don't know if it would be very difficult to design.
>
>> * Just because the index is sparse does not mean other commands can't
>> walk into those directories.  So `git grep` (when given a revision),
>> `git diff`, `git log`, etc. will look in (old versions of) those
>> paths.
>>
>
>Agree.
>
>> > Anyway, just saying that for the longer term I'm not aware of an
>> > *intrinsic* reason for why we couldn't support this sort of thing,
>> > in case anyone's interested in putting in a *lot* of leg work to
>> > make it happen.
>>
>> And on top of the technical leg work required, they would also need to
>> somehow convince everyone else that it's worth accepting the increased
>> maintenance effort.  Right now, even if someone had already done the
>> work to implement it, I'd say it's not worth the maintenance costs.
>>
>> However, there are two alternative choices I can think of here: You
>> can use submodules if you want a fixed part of the repository to only
>> be available to a subset of folks, or use josh
>> (https://github.com/josh-project/josh) if you need it to be more
>> dynamic.
>
>Thanks, I will take a look.

As a completely side perspective on this, I had to integrate security management with five separate security subsystems/mechanisms (not joking) on the NonStop platform that included Unix-style Access Control Lists (ACLs), non-inode ACLs on the NonStop side of the platform, and some recent new thing called XOS - I don't know it yet but provisioned for it. The solution I ended up with was writing a full Workflow wrapper around git that does things similar to GitHub Actions, so after an operation like checkout/switch, merge, pull, etc., specific rules specified in YAML in the repo (if enabled by the user) are run that apply the ACLs. It is a very heavy-weight solution to the problem but works pretty well on this "exotic" platform - Workflows were needed for other reasons as well, so I just piggybacked the security handling into my Workflow structure. Again, not built into git but wrapped around it. I could have used hooks for some of it but needed support for more operations than hooks had.
--Randall

