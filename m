Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100C91F462
	for <e@80x24.org>; Mon, 29 Jul 2019 08:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfG2IP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 04:15:56 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33195 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfG2IP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 04:15:56 -0400
X-Originating-IP: 157.49.185.144
Received: from [192.168.43.207] (unknown [157.49.185.144])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6113AFF803;
        Mon, 29 Jul 2019 08:15:48 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
Date:   Mon, 29 Jul 2019 13:45:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/19 7:58 AM, Mark Levedahl wrote:
> On 7/28/19 6:49 PM, brian m. carlson wrote:> On 2019-07-28 at 22:10:29, 
> Pratyush Yadav wrote:
>  >> The function is not documented, and I only started spelunking the 
> code a
>  >> couple days back, so I'll try to answer with what I know. It might 
> not be
>  >> the full picture.
>  >>
>  >> Running git-gui --trace, these commands are executed during a rescan:
>  >>
>  >> /usr/lib/git-core/git-rev-parse --verify HEAD
>  >> /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing 
> --refresh
>  >>
>  >
>  > Great. This sounds like a well-reasoned change. I'll let other folks who
>  > use git-gui more chime in to see what they think as well.
>  >
> 
> I'm assuming this does what is currently done by F5.
> A simple rescan from git-gui in the git repository takes about 8 seconds 
> on my corporate laptop running Windows, making this happen on change of 
> window focus is definitely not a friendly change from my view point.
> 

This is a Windows problem maybe? On my Linux machine with an almost dead 
hard drive, it takes under 10ms to do a refresh on the git repository 
(which has about 56,000 commits).

Can you check what takes so long? I don't use Windows or I'd do this myself.

Go to git-gui.sh and add some prints to the rescan procedure (line 1450) 
to trace which operation takes time. It is not a shell script, but a tcl 
script, so you'd need to add "puts <your_string_here>" just to have an 
approximate idea of what takes so long.

Can someone else who uses git-gui comment on the time taken to rescan on 
the git repo (on Windows, Linux, or Mac)?

You can use this to see how long it takes to do a rescan. It will print 
the time taken to stdout:

-- >8 --
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 8ca2033dc8..7f2962f060 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2360,7 +2360,11 @@ proc do_rescan {} {
  }

  proc ui_do_rescan {} {
+	set t [clock milliseconds]
  	rescan {force_first_diff ui_ready}
+	set t2 [clock milliseconds]
+
+	puts "Time elapsed in ui_do_rescan = [expr $t2 - $t]ms"
  }

  proc do_commit {} {
-- >8 --

-- 
Regards,
Pratyush Yadav
