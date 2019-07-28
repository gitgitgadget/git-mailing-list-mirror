Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC26B1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 21:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfG1Vot (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 17:44:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60475 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1Vos (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 17:44:48 -0400
X-Originating-IP: 157.49.182.108
Received: from [192.168.43.207] (unknown [157.49.182.108])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 61CE940004;
        Sun, 28 Jul 2019 21:44:44 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <c3cdbaba-ed57-ce6c-6c07-1e4fe8cc533f@yadavpratyush.com>
Date:   Mon, 29 Jul 2019 03:14:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728151726.9188-1-me@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Playing with it for some time, I see some problems with the patch.

Firstly, "bind ." binds that event for the root window and all 
subwindows. This means we rescan multiple times on a single FocusIn 
event, once for every window. This can be fixed easily with a check for 
the root window (aka "."). I'll send a v2 patch with this change.

Secondly, when the context menu is opened via right click, and then 
closed, it is recorded as a FocusIn event for our root window, even 
though the context menu is a child of the root window. This triggers a 
rescan. Unfortunately, I could not find a way to go around this behaviour.

This means some unnecessary rescans, but the rescan looks like a pretty 
fast operation even on my slow hard disk, so it should probably not be a 
problem.

If someone knows a way around the second issue, please let me know.

On 28/07/19 8:47 PM, Pratyush Yadav wrote:
> If any changes are made to the tree while git-gui is open, the user has
> to manually rescan to see those changes in the gui. With this change, a
> rescan will be performed whenever the window comes in focus, removing
> the need for manual rescans in most cases. A manual rescan will still be
> needed when something makes changes to the tree while git-gui is still
> in focus.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>   git-gui/git-gui.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 6de74ce639..8ca2033dc8 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3849,6 +3849,7 @@ if {[is_enabled transport]} {
>   }
>   
>   bind .   <Key-F5>     ui_do_rescan
> +bind .   <FocusIn>    do_rescan
>   bind .   <$M1B-Key-r> ui_do_rescan
>   bind .   <$M1B-Key-R> ui_do_rescan
>   bind .   <$M1B-Key-s> do_signoff
> 


-- 
Regards,
Pratyush Yadav
