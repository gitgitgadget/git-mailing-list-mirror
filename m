Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6602C74A4B
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCHTDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCHTDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:03:14 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537ECEFBF
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:02:28 -0800 (PST)
Received: from [192.168.42.163] (28-49-142-46.pool.kielnet.net [46.142.49.28])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 3DEBC3C3BCA;
        Wed,  8 Mar 2023 20:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678302147;
        bh=RcaVCl0JCa5eS2dFi6qV0CI6lhf4iZ1pdPyNdR0EJNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fg73arLJeTW6QiZ2fcc1X7sJTabIzksudspFCsWv5cuxJ4CDV3YM/tOmLhc55BmhG
         4mA11VZbBugpyFRY5Bw+ruGtUXaOl+9y4YbOrfJcySW0p2hOpg9/xb8y/rWmSIQ19t
         V2t31tpNh7Tnr01w5EUS6w4kykWUdZKBo/r9UVivXYg7B9Zz2DNhVK6SZF+ziMQWT8
         0/6q8QMotNvjgG4lNT1D/mvL7E0Q0WwhjhzNHNbn7eNytAvzs46T8Nu3MONgcT+uXu
         u3z5HmaRt5t7oLqKo9SpMTfzcpA4oXrKDOzK8yAd7zFXvqYlSWCeszmpNKbUisZ3x2
         BCfPH5m+IZQOQ==
Message-ID: <28b78355-e3db-d33a-c576-653740a4a1f3@haller-berlin.de>
Date:   Wed, 8 Mar 2023 20:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <xmqqo7p4zb8d.fsf@gitster.g>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqo7p4zb8d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.03.23 19:07, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> The reason why I am asking this is: I'm using lazygit, which, during
>> interactive rebases, shows a combined view of the real commits that were
>> already applied, and the remaining commits that are yet to be applied
>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>> this, when I set the 2nd commit to "edit":
>>
>>   pick   4th commit
>>   pick   3rd commit
>>          2nd commit  <-- YOU ARE HERE
>>          1st commit
>>
>> This is great, but ...
> 
> Stepping a bit, how does our "git status" fare here?  It shows what
> step in a sequence "rebase -i" the user who got control back (due to
> "break", "exec sh", "edit" or a conflicted "pick") is in.  Or at
> least it tries to.  Does it suffer from the same "great, but ..."?
> 
> If it works better than how lazygit shows, perhaps how it computes
> the current state can be reproduced, or better yet, the current
> state it computed can be exposed, and it can be prototyped by
> parsing "LC_ALL=C git status -uno" output, perhaps?

It fares a little better, but not much, and it doesn't look like I can
use its information to implement the behavior I want.

The difference to lazygit is that git status shows both the last few
entries of the "done" file and the first few entries of the
"git-rebase-todo" file, so at least I have a complete picture of which
commits are involved. Lazygit doesn't show the "done" file, only the
commits that are on the branch now, so the currently conflicting commit
is missing.

In addition, git status shows the message "(fix conflicts and then run
"git rebase --continue")", but only if there are unmerged files; once I
resolve all conflicts and stage the changes, that message is no longer
shown, and at that point I don't see any way to tell whether the last
commit was applied successfully or not.

-Stefan
