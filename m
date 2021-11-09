Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D5C4332F
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F1B6134F
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbhKIBSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:18:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56229 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242562AbhKIBNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 20:13:44 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A91Ah8A005033
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 8 Nov 2021 20:10:45 -0500
Message-ID: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
Date:   Mon, 8 Nov 2021 17:10:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/2] receive-pack: Protect current branch for bare
 repository worktree
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
References: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu>
 <xmqqzgqe448a.fsf@gitster.g>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <xmqqzgqe448a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/21 15:28, Junio C Hamano wrote:
> My reading hiccupped after "at"; perhaps enclose the double-dot
> inside a pair of double quotes would make it easier to follow.

Will update.

>> @@ -1456,11 +1456,11 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
>>   		work_tree = worktree->path;
>>   	else if (git_work_tree_cfg)
>>   		work_tree = git_work_tree_cfg;
> 
> Not a fault of this patch at all, but I am not sure if this existing
> bit of code is correct.
Perhaps this code is unreachable?

The worktree argument of update_worktree() should never be NULL, because 
we’d only have set do_update_worktree = 1 if find_shared_symref() 
returned non-NULL.  And it looks to me like worktree->path should always 
be initialized to non-NULL, in either get_main_worktree() or 
get_linked_worktree()?  I haven’t read enough of the code to be totally 
confident in this though.

> The callsite of the other function this patch modifies is in this
> update() function much later, and I think it should be updated to
> use the variable "worktree" instead of calling find_shared_symref()
> again with the same parameters.

Will update.

> We are not checking if we correctly update the working tree; we are
> only seeing "git push" succeeds.  Which might want to be tightened
> up.

Reasonable.  This is also the case with the existing test.

> It is a bit sad that these two tests are so inter-dependent.
> Depending on an earlier failure of other tests, this may fail in an
> unexpected way.

Yeah, I guess I wasn’t sure how much interdependence was allowed or 
expected.  For example, the existing test already fails when run by 
itself (./t5516-fetch-push.sh --run=103) because the repository starts 
out empty.  I’ll see what I can do, perhaps making use of the 
test_when_finished helper.

Anders
