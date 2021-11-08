Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB9C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B906117A
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhKHXef (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:34:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43461 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231268AbhKHXee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:34:34 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A8NVZlV009164
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 8 Nov 2021 18:31:36 -0500
Message-ID: <8709db5c-8ac0-b327-09ba-087e392c297b@mit.edu>
Date:   Mon, 8 Nov 2021 15:31:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 1/2] fetch: Protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
References: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
 <xmqqa6ie5k3u.fsf@gitster.g>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <xmqqa6ie5k3u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/21 15:00, Junio C Hamano wrote:
> I would sleep better if we were one bit more careful, perhaps like
> so:
> 
> +	if (!update_head_ok &&
> +	    (wt = find_shared_symref(...)) &&
> +	    !wt->is_bare &&
> 	    !is_null_oid(...)) {
> 
> to make sure we do not rely on that particular aspect of how
> find_shared_symref() works.  The function asks "please find a
> worktree, if any, whose HEAD points at this ref", and it feels
> unnatural for the answer to the question is affected by the
> bare-ness of the worktree.

Not unreasonable to be explicit at the call site.  Will update.

I note that branch.c already relies on this aspect of find_shared_symref().

And, now that I’m reading branch.c again, I see that it also has a 
worktree-awareness bug in its safety check, deserving of a third patch 
in this series.

$ git init
$ git commit --allow-empty -am foo
$ git worktree add wt
$ git branch -M wt main
   # correctly disallowed
fatal: Cannot force update the current branch.

$ git branch -M wt  # incorrectly allowed
$ git worktree list

/tmp/test     6de7a5d [wt]

/tmp/test/wt  6de7a5d [wt]


> OK, the former is about this worktree, and the latter is about
> worktree somewhere else.  It may clarify if we phrased the latter a
> bit differently, e.g. "checked out in another worktree".

Alright.  (Of course, as noted in previous discussion, this error path 
is currently reachable.)

> I cannot shake the feeling that this single test step is testing way
> too many things and burden future developers who break one of the
> steps to understand which step was broken, but these three are good
> things to test.

I can split the bare repository part into a separate test_expect_success 
step?  This duplicates some commands but maybe helps readability overall.

Anders
