Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B980C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 04:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiEYEtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYEtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 00:49:53 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 21:49:51 PDT
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::4a1:400:400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10271D81
        for <git@vger.kernel.org>; Tue, 24 May 2022 21:49:51 -0700 (PDT)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E18D144009E; Wed, 25 May 2022 06:41:35 +0200 (CEST)
Date:   Wed, 25 May 2022 06:41:35 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Error handling when giving empty command line arguments
Message-ID: <Yo2zfxP4hII+iwfb@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Olsson John <john.olsson@saabgroup.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 01:25:43PM +0000, Olsson John wrote:
> I have so far only seen this behavior with 'git fetch' command, but it might be more general depending on how command line parsing is implemented.
> 
> In a Bash script I had something similar to (but more complicated than what I show below)
> 
>   git fetch "${force}"
> 
> where $force is either an empty string or '--force'. Due to that you usually want to expand all variables within double quotes when writing Bash scripts I did not realize that I had made a mistake here. Instead I got this strange error message and spent a couple of hours chasing it
> 
>   fatal: no path specified; see 'git help pull' for valid url syntax
> 
> This problem eventually turned out to be of the trivial kind once I realized why I got it, and also very simple to reproduce. Just do
>   $ git fetch ""
>   fatal: no path specified; see 'git help pull' for valid url syntax
>   $
> 
> That is, 'git fetch' does not check if the given string is an empty string before writing the error message. The empty string is completely unrelated to any path/URI and in this case it was not that helpful.
> 
> What do you say? Wouldn't it be better with a more specific error message when an option value/argument is an empty string? Or should perhaps empty strings be ignored by the git commands?
> 
> 
> /John
> 

Hello John,

You are running into this issue because you use "$(force}" instead of
${force}. In the latter case, if $force is empty, the shell will not
pass an empty string as an argument to git.

This does mean that it is subject to word splitting, but that can be an
advantage as well if you decide you need more arguments than just
'--force'. You should only use that in case you control what $force
contains.

Hope this helps, 
Kevin
