Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDAC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 00:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7D160E54
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJOAY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 20:24:28 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:53192 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhJOAY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 20:24:26 -0400
Received: from [94.228.207.246] (helo=[192.168.2.206])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1mb7Gj-0000Jl-CM; Thu, 14 Oct 2021 22:24:01 +0200
Subject: Re: Suggestion: "verify/repair" option for 'git gc'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
 <87h7dkh04o.fsf@evledraar.gmail.com>
 <96bf2eff-f4c8-cae8-76cb-6eeb233cd1d3@syntevo.com>
 <87czo7haha.fsf@evledraar.gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <437b170b-d366-ce3b-b34f-e56429a21b5a@syntevo.com>
Date:   Thu, 14 Oct 2021 23:23:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87czo7haha.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for such a detailed reply!

On 14.10.2021 18:17, Ævar Arnfjörð Bjarmason wrote:
 > Was this created with git itself, or some tool that's manually
 > crafting trees?

I have spent... a while... to figure what exactly happened with the
repo. It was in fact my fault. Git could have done better to filter
wrong user input, but it didn't and allowed my mistake to go into
objects.

So, here's what I did:
1) I had two repos with completely disjoint history, but matching
    (at some point) sources. With different paths, though.
2) I wanted to copy a set of patches from repo SRC to repo DST
3) I didn't expect that patch can apply on its own, so I decided to
    edit the generated patch before applying it. Yeah, I did it wrong
    in the end, but frankly moving patches between such different repos
    is something I never done before.
4) I fixed file paths in patch (didn't know about 'git apply -p')
5) I identified commit in repo DST (0189425c, this might ring a bell)
    which had the same sources as the base of my patches in repo SRC.
6) I patched all 'index sha..sha' to 'index 0189425c..sha'
    What I hoped to achieve is to convince git that patch was created
    on repo DST commit 0189425c, instead of where it was really created.
    From 'sha..sha' notation I thought that it's 'commit..commit', but
    it was in fact 'blob..blob', I didn't expect that.
    If you're interested, the patch can still be found in file
    '.git\rebase-apply\patch' of the repo I sent you, and I tried to
    apply it on top of 4e74e0897.
7) Patch applied partially, because the sources weren't as identical
    as I thought. I understand that it created trees in the process,
    which contained the hacked 0189425c as if it was a blob, while it
    was in fact a commit.

Now I already know that I didn't need to change any sha's, git applies
the patch just fine if the previous file content matches. I also know
that I could just use '-p' to fix paths, so in the end no patch edits
were needed.

Conclusion: my fault, but git could error on the wrong 'index sha..sha'
instead of creating wrong blobs.

 > the "gc" command actually does do exactly what you're suggesting

Right, I didn't notice that. My UI runs 'git gc' sometimes and I
assumed that corruption occurred long ago. Back then, I just deleted
and re-cloned a repo and continued my work, that's why I didn't really
tried to investigate back then.

Still, the other two stories, the blob was genuinely corrupt (in one
case I made a program to brute force correct contents, in other
downloading blob by sha from remote fixed it).

I have now tried corrupting a single bit in loose objects and packs,
and both `git gc` and `git fsck` correctly notice the problem. They
don't offer any solutions such as re-downloading from remote, though.

So it seems that the first part of my suggestion (to verify on gc) is
already there. Yeah, it's foolish that I posted before testing things
carefully, I was convinced by a combination of stories I encountered :(

 > Hypothetically, but these blobs aren't corrupted, and no amount of
 > fetching something from other places is going to fix a bad DAG.

Right, the corruption in specific repo I sent is a different case. Now
that we know what happened, let's forget about this case in light of
auto-repair idea.

 > But even without that you'll find that e.g. if a recent object is bad,
 > and we'd like to fetch it from upstream, that we're just going to die
 > pretty early, as none of the code involved in say incremental fetching
 > is prepared to run across a bad/corrupt object.

I understand that fixing a genuinely corrupt object involves two cases:
1) Loose object - just delete it, then promisor will treat it as missing
2) Packed object - I understand that in current implementation,
    replacing the object will involve repacking anyway. So, I'm thinking,
    the corrupt pack can be extracted into loose objects, then read (1)
    about fixing loose object.

In both cases, make sure that remote has the non-corrupt object before
going further.
