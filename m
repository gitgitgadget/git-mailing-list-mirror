Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B1C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 14:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0120848
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFO6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:58:05 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:17948 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCFO6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 09:58:05 -0500
X-Greylist: delayed 805 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 09:58:04 EST
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1jAEDM-0000QR-Rs; Fri, 06 Mar 2020 15:44:36 +0100
Subject: Re: git-core: try_to_follow_renames(): git killed by SIGSEGV
To:     Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
References: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
Date:   Fri, 6 Mar 2020 15:44:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since I like studying crashes and noone else replied, I decided to have 
a look.

The problem is easy to reproduce with this (replace 1.c with any file):
   git log --follow -L 1,1:1.c -- 1.c

It occurs because `opt->pathspec.items` gets cleaned here:
     clear_pathspec
     queue_diffs
         /* must look at the full tree diff to detect renames */
         clear_pathspec(&opt->pathspec);
         DIFF_QUEUE_CLEAR(&diff_queued_diff);
     process_ranges_ordinary_commit
     process_ranges_arbitrary_commit
     line_log_filter
     prepare_revision_walk
     cmd_log_walk
     cmd_log

And on next iteration it crashes in 'try_to_follow_renames' on this line:
     diff_opts.single_follow = opt->pathspec.items[0].match;

I think that bug comes from commit:
     a2bb801f by SZEDER Gábor, 2019-08-21 13:04:24
     line-log: avoid unnecessary full tree diffs

@szeder could you please look into that?

On 27.02.2020 13:56, Ondrej Pohorelsky wrote:
> Hi,
> 
> there is a SIGSEGV appearing in Fedora[0] with Git 2.24.1
> 
> This bug started to appear after update to Git 2.24.1.
> Bug reporter said that Git crashed on him while running VS Code with
> Git Lens extension[1]
> I have tried to reproduce this bug with my own compiled Git with debug
> flags, but sadly SIGSEGV never appeared.
> 
> To me it seems like there is a problem in commit a2bb801f6a[2] which
> changes move_diff_queue() function. This function calls
> diff_tree_oid() that calls try_to_follow_renames(). In the last two
> functions there are no arguments checks.
> 
> Best regards,
> Ondřej Pohořelský
> 
> [0] https://retrace.fedoraproject.org/faf/problems/bthash/?bth=25aa7d7267ab5de548ffca337115cb68f7b65105
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1791810
> [2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2bb801f6a430f6049e5c9729a8f3bf9097d9b34
> 

