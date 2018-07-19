Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE31E1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeGSWeb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Jul 2018 18:34:31 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:37131 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeGSWeb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:34:31 -0400
Received: by mail-yw0-f170.google.com with SMTP id w76-v6so3646429ywg.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LMZ+EPSiPKreJvd1xF9o9XdYG4ET7WZS245q0MCOvDM=;
        b=UiI+m8g4wmJS4Ls/Kv0DgtsC3rFiCBfqc3lPi4IjW9CaB9S5HxXEPmWxmW8RATLLR0
         uU3j27dpm057AbtHgBnDuyEAvIwPLKDtn4kS4ENGZ8nFM6H0IERjW4eWY18hW+EqGh7o
         KdEMRoq4mEo+3s5PuzohUYSWSTj5mlFzizRIhtzoAFfe3ECJjZ+63AimVtsUPprX55Mf
         GSCfENKEeRYIrT2AiYy6d3BcSJ56dUyZ/icoZjWRl6N2Xe482UW0En5E9hEz1nwZCPvj
         F4fTGPpllyQV3uJRKVv51EAYjnHQuUXTRX1m/N7NVi3UfGpt+GQZGD+AumjXiv96rnyZ
         NiuA==
X-Gm-Message-State: AOUpUlHb+5z0rRUskoUrmI4QmVcpXaeB3j2XebvQp+ja7kTAdbo1SZS+
        Vrbdg0XtdjNtmdMg7cuGfXvCGH9Pg/vuJCA8B3je/hWj
X-Google-Smtp-Source: AAOMgpc3ZgEM7S3tuMBmJWYJj3TUV3suDVah5yBi7qL+oJ5RPy9hYMNJyzYNle7arHZ6E/YbfbXbCsmBjWnu1sw0ntk=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr6294276ywk.74.1532036969751;
 Thu, 19 Jul 2018 14:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com> <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
 <1569C0A9-7C44-4F28-9C9B-AF2489E021AB@me.com>
In-Reply-To: <1569C0A9-7C44-4F28-9C9B-AF2489E021AB@me.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Jul 2018 17:49:17 -0400
Message-ID: <CAPig+cRYVwsMxUQGWHWyfC1gpVgEtt0VH-CmQoGizEAp-B_7WQ@mail.gmail.com>
Subject: Re: Gitk doesn't work on macOS Mojave
To:     cherpake@me.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[please reply inline rather than top-posting]

On Thu, Jul 19, 2018 at 5:11 PM Evgeny Cherpak <cherpake@me.com> wrote:
> It seems this code placed at the end of the file, after getcommits() does the trick:
>
> if {[tk windowingsystem] eq "aqua"} {
>         set openscript [format {
>                 open -a \"$(ps -p %d -o comm=)\"
>         } [pid] ]
>     exec osascript -e [format {
>                 do shell script "%s"
>     } "$openscript” ]
> }

Interesting idea. A shortcoming of this approach is that it's
non-deterministic. It will bring _any_ running gitk to the foreground,
rather than the one mentioned by PID, which would be a potentially
confusing regression. Such confusion _might_ be worse than simply not
foregrounding the application at all (though that's a matter of
opinion). Unfortunately, the 'open' command doesn't let you do so by
PID, and Googling shows only answers which predate Mojave (that is,
they all suggest Apple Events).

To avoid such a regression on older MacOS's, it would be nice to
retain the Apple Events code, but that would mean gitk would need to
do a version check or something to avoid executing the Apple Events
code on Mojave.

By the way, the same problem presumably afflicts "git gui", which has
identical code in it for foregrounding the application. Does that
match with your experience?
