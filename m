Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2435C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F0E61051
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhKIDqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhKIDqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 22:46:18 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Nov 2021 19:43:32 PST
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A1C061764
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 19:43:32 -0800 (PST)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4HpDCd3GRqz115B;
        Tue,  9 Nov 2021 03:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onenetbeyond.org;
        s=stigmate; t=1636428957;
        bh=6kMBFtv08ag4sCh4VFrWeVTp+2wvkqLl67oo+EY15Oc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PDagBz1waWNj2pbUNtby79G5fZdJyFobMFTeJRfDIxYMdvJBdLoVUsz67xFKL1YCs
         13FdlMXGCGi4/wqiXthvLxv1ct57zd7gy5xXwv1KlPTTEP6BjJgFHsTixFTVyGaL9+
         ylaQKiyrIbV/Svjv5oskjBfbE2gtvSRFrJ8iXdvA=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: kumar@onenetbeyond.org) by localhost (Postfix) with ESMTPSA id 4HpDCc5ZNMz112Z;
        Tue,  9 Nov 2021 03:35:56 +0000 (UTC)
Message-ID: <182017f6-5dcd-70f0-e0bc-98721c433bf3@onenetbeyond.org>
Date:   Tue, 9 Nov 2021 03:35:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0
Subject: Re: List all commits of a specified file in oldest to newest order
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
 <211105.86a6ijhujg.gmgdl@evledraar.gmail.com>
From:   Vipul Kumar <kumar@onenetbeyond.org>
In-Reply-To: <211105.86a6ijhujg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/21 8:13 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> The key thing being the "traversal", i.e. as we walk history we'll
> encounter a tree entry where b.txt was deleted, and see that it was
> moved from a.txt.

Thanks, I didn't know "reverse" would change the traversal order. When I 
looked for "--reverse" option in git-log(1), this what I found:

   --reverse
       Output the commits chosen to be shown (see Commit Limiting 
section above) in reverse order. Cannot be combined with --walk-reflogs.

 From this, I inferred that "--follow" would choose the commits and 
"--reverse" reverses those commits order. Can we improve the wording 
here? Especially, about "reverse" changes the traversing order.

> However, if we walk history from the beginning we have no idea of the
> relationship of a->b.txt, since we didn't encounter that commit yet,
> that's only something we see while walking the history.

Not showing commits before rename is expected, but I didn't understand 
why combination "--follow" and "--reverse" option showing me only one 
commit? And it always points to the rename of the file. Shouldn't it 
also list other commits which changes that file? For example, just after 
"rename of a.txt to b.txt", do some changes in b.txt file and then run 
"git log --follow --reverse -- b.txt" command.

$ for i in {1..2}; do echo "$i" >> b.txt; git add b.txt; git commit -m 
"Update$i b.txt"; done
$ git log --follow --reverse -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt

Here I expect output to be:

$ git log --follow --reverse -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Reacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt

commit 57aac6d1af2d869557991e714932847f37035d19
Author: Redacted <Redacted>
Date:   Sun Nov 7 20:30:32 2021 +0530

     Update1 b.txt

commit ea76a8e8af903dc1522626aa058b8058afbe11f4
Author: Redacted <Redacted>
Date:   Sun Nov 7 20:30:32 2021 +0530

     Update2 b.txt

I know, here using "--follow" along with "--reverse" doesn't make any 
sense. Instead we should use "git log --reverse -- b.txt". But I'm just 
curious, is this also an expected caveats of using "--follow" along with 
"--reverse"?

> This caveat doesn't only apply to reverse, try to apply a move of b.txt
> on top of your history:
> 
>      b.txt -> c.txt
> 
> And now do:
> 
>      git log [--follow] -- b.txt
> 
> What should we output there? If we're arguing that we should first
> traverse the history to "look forward" that'll also apply to a
> non-reverse walk, since we're asking to follow b.txt.
> 
> But we haven't encountered the b->c.txt relationship yet (well, we run
> into the rename commit, but once you add a c->d.txt on top...). So maybe
> instead of --buffer-then-reverse we'd need a hypothetical --two-pass,
> which would also impact options other than --reverse whose behavior
> relies on traversal order.

"--two-pass" option sounds like a good idea, but not sure how useful it 
would be for others. In my case, I could read the log's command output 
in bottom to top fashion, and now I also know two other approaches to 
get what I wanted. And I usually don't track deleted file.


-v
