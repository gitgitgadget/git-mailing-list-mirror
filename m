Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB8C5DF9D
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FCD20882
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787623AbgJZRVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:21:11 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:48072 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775598AbgJZRVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:21:10 -0400
Received: from client3368.fritz.box (i5C74449E.versanet.de [92.116.68.158])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 7E4FA3C0333;
        Mon, 26 Oct 2020 18:21:08 +0100 (CET)
Subject: Re: [PATCH] gitk: macOS: ignore osascript errors
To:     Beat Bolli <dev+git@drbeat.li>, paulus@ozlabs.org
Cc:     git@vger.kernel.org
References: <20201025175149.11853-1-dev+git@drbeat.li>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <c4ca1c3b-0563-c35b-5bc0-5accddd0ad3a@haller-berlin.de>
Date:   Mon, 26 Oct 2020 18:21:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201025175149.11853-1-dev+git@drbeat.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.10.20 18:51, Beat Bolli wrote:
> Starting gitk on a macOS 10.14.6 (Mojave) system fails with the error
> 
>      Error in startup script: 2020-10-25 17:16:44.568 osascript[36810:18758270]
>      Error loading /Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support:
>      dlopen(/Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support, 0x0106):
>      code signature in (/Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support)
>      not valid for use in process: mapping process is a platform binary, but mapped file is not
>      [[this same message repeated dozens of times]]

While the code change itself makes sense to me, the justification is a 
bit strange. This error message suggests that something is messed up on 
your system. Your commit message makes it sound as if all people on 
macOS 10.14.6 get this error, which is not the case.

> Ignore errors from the osascript invocation, especially because this macOS
> version seems to correctly place the gitk window in the foreground.

Whether gitk comes to the foreground on start depends on the Tcl/Tk 
version, not the macOS version. With Tk 8.6 it does, so it might 
actually be nice to add a version check here. (I'm not requesting that 
you actually do that as part of this patch; just saying.)

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>   gitk | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 23d9dd1..8551711 100755
> --- a/gitk
> +++ b/gitk
> @@ -12290,11 +12290,11 @@ if {[catch {package require Tk 8.4} err]} {
>   
>   # on OSX bring the current Wish process window to front
>   if {[tk windowingsystem] eq "aqua"} {
> -    exec osascript -e [format {
> +    catch { exec osascript -e [format {
>           tell application "System Events"
>               set frontmost of processes whose unix id is %d to true
>           end tell
> -    } [pid] ]
> +    } [pid] ] }
>   }

Like I said, the change itself looks good to me, especially since the 
corresponding code in git gui is also guarded by a catch.

Best,
Stefan
