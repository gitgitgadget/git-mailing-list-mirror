Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091AFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6060725
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhHXPul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:50:41 -0400
Received: from mail.ispras.ru ([83.149.199.84]:46806 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238287AbhHXPuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:50:40 -0400
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0BC3040D3BFF;
        Tue, 24 Aug 2021 15:49:47 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 24 Aug 2021 18:49:46 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     git@vger.kernel.org
Cc:     bwilliamseng@gmail.com
Subject: Re: [BUG] git commit -a doesn't ignore inactive/ignore-all submodules
In-Reply-To: <1be1e064559578a190f32dddb8ad39a0@ispras.ru>
References: <1be1e064559578a190f32dddb8ad39a0@ispras.ru>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <128d535af65ec58af9a26b9d0e13de8e@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-20 20:02, Alexey Izbyshev wrote:
> Reproduced on 2.33 and 2.17.1. Does not reproduce on 2.7.4 (Ubuntu
> 16.04).

Bisected to:

commit 5556808690ea245708fb80383be5c1afee2fb3eb
Author: Brandon Williams <bmwill@google.com>
Date:   Tue Jul 25 14:39:16 2017 -0700

     add, reset: ensure submodules can be added or reset

     Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
     diff and status) introduced the ignore configuration option for
     submodules so that configured submodules could be omitted from the
     status and diff commands.  Because this flag is respected in the 
diff
     machinery it has the unintended consequence of potentially 
prohibiting
     users from adding or resetting a submodule, even when a path to the
     submodule is explicitly given.

     Ensure that submodules can be added or set, even if they are 
configured
     to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` 
diff
     flag.

Was the change of "git commit -a" behavior intended?

To be clear, I don't understand what problem this patch solves exactly. 
The commit message mentions issues with "adding or resetting a 
submodule", but with git 2.7.4 (older than this patch) I can explicitly 
"git add" and "git commit" a submodule which has "ignore = all" set 
without problems, though "git status" and "git commit -a" ignore it, as 
I would expect.

I've also performed another test uncovering that "submodule.active" 
appears to have never been honored by "git commit -a" at all. Is this 
intended behavior?

 From my perspective, it's surprising that "git status" and "git commit 
-a" take inactive submodules into account. Given that "git help config" 
says that "submodule.active" is a "Boolean value indicating if the 
submodule is of interest to git commands", it would seem to me that 
"active = false" should beat everything else, making git behave as if 
submodule were not initialized. Is there a way to keep a submodule 
checked out but make "git commit -a" ignore it?

Alexey
