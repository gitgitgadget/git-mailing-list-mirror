Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D9C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2BE20878
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392831AbgJZWSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:18:24 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:27456 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392812AbgJZWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:18:23 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kXAok-000A5L-CJ; Mon, 26 Oct 2020 22:18:19 +0000
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
 <20201023081711.GB4012156@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
Date:   Mon, 26 Oct 2020 22:18:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201023081711.GB4012156@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/10/2020 09:17, Jeff King wrote:
> On Wed, Oct 21, 2020 at 12:19:25AM +0100, Philip Oakley wrote:
>
>> On 05/10/2020 13:16, Jeff King wrote:
>>> On Mon, Oct 05, 2020 at 03:17:51AM -0400, Jeff King wrote:
>>>
>>>> About 2 years ago as part of a security release we made it illegal to
>>>> have a symlinked .gitmodules file (refusing it both in the index and via
>>>> fsck). At the time we discussed (on the security list) outlawing
>>>> symlinks for other .git files in the same way, but we decided not to do
>>>> so as part of the security release, as it wasn't strictly necessary.
>> Is this something that should be recorded in the documentation, either as a
>> simple (sensible) limitation, or explicitly as a security related safety
>> measure?
>>
>> I didn't see any changes to the .txt docs in the change list below.
> Yeah, that's a good point.
>
> How about this (on top of jk/symlinked-dotgitx-files)?
>
> -- >8 --
> Subject: [PATCH] documentation symlink restrictions for .git* files
>
> We outlawed symbolic link versions of various .git files in 10ecfa7649
> (verify_path: disallow symlinks in .gitmodules, 2018-05-04) and
> dd4c2fe66b (verify_path(): disallow symlinks in .gitattributes and
> .gitignore, 2020-10-05). The reasons are discussed in detail there, but
> we never adjusted the documentation to let users know.
>
> This hasn't been a big deal since the point is that such setups were
> mildly broken and thought to be unusual anyway. But it certainly doesn't
> hurt to be clear and explicit about it.
>
> Suggested-by: Philip Oakley <philipoakley@iee.email>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/gitattributes.txt | 7 +++++++
>  Documentation/gitignore.txt     | 5 +++++
>  Documentation/gitmodules.txt    | 8 ++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 2d0a03715b..9a2ce4f1ea 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1241,6 +1241,13 @@ to:
>  [attr]binary -diff -merge -text
>  ------------
>  
> +NOTES
> +-----
> +
> +Note that Git does not allow a `.gitattributes` file within the working
> +tree to be a symbolic link, and will refuse to check out such a tree
> +entry.  This keeps behavior consistent when the file is accessed from
> +the index or a tree versus from the filesystem.
>  
>  EXAMPLES
>  --------
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index d47b1ae296..7e9a1d49d6 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -149,6 +149,11 @@ not tracked by Git remain untracked.
>  To stop tracking a file that is currently tracked, use
>  'git rm --cached'.
>  
> +Note that Git does not allow a `.gitignore` file within the working tree
> +to be a symbolic link, and will refuse to check out such a tree entry.
> +This keeps behavior consistent when the file is accessed from the index
> +or a tree versus from the filesystem.
> +
>  EXAMPLES
>  --------
>  
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 539b4e1997..2b884be3c7 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -98,6 +98,14 @@ submodule.<name>.shallow::
>  	shallow clone (with a history depth of 1) unless the user explicitly
>  	asks for a non-shallow clone.
>  
> +NOTES
> +-----
> +
> +Note that Git does not allow the `.gitmodules` file within a working
> +tree to be a symbolic link, and will refuse to check out such a tree
> +entry. This keeps behavior consistent when the file is accessed from the
> +index or a tree versus from the filesystem, and helps Git reliably
> +enforce security checks of the file contents.
>  
>  EXAMPLES
>  --------
The text looks good to me, with security point explicitly mentioned just
for .gitmodules file.

However, is placing the Note so far down appropriate (.gitattributes and
.gitignore), given that there is within the descriptions a discussion of
the priority order for finding those files?

Philip
