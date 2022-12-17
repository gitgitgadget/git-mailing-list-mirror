Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADBC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 07:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLQHuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 02:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQHuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 02:50:10 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C8222A1
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 23:50:06 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 2725 invoked from network); 17 Dec 2022 08:50:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1671263402; bh=JgRSL6WG3qcll1tmyaTcivagHs5mze9gxpHF4aDXZvo=;
          h=Subject:To:Cc:From;
          b=u3zNDLI7bmm4HhNrGoy/2Uw7EbERMoIY1q9icVzI0TlSq7QHUxX6wfqXlj2ydQg0S
           w9otEU4bjsVm/UqEOhgsXsHrV4ZW2CAOTS6UvjveyKwSAAMNY0fN1vStNiRZ421dos
           dGE+vcnElGGTl9vuZSOyvaNt6b/ZlGpqZTH7Usas=
Received: from mail.dtcasino.pl (HELO [192.168.1.5]) (piotrekkr@o2.pl@[212.180.138.13])
          (envelope-sender <piotrekkr@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <l.s.r@web.de>; 17 Dec 2022 08:50:02 +0100
Message-ID: <a1fb9d92-5161-5ba0-54f2-a03cbc45f399@o2.pl>
Date:   Sat, 17 Dec 2022 08:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Issue with git > 2.36.1 and pre-commit hook on macOS M1
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
 <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
 <c07a5ac4-3da6-6fb4-4586-a83373bc05d4@o2.pl>
 <7054faf0-0f5b-e4a8-3166-bf715ed45a32@web.de>
Content-Language: en-GB-large
From:   Piotrek <piotrekkr@o2.pl>
In-Reply-To: <7054faf0-0f5b-e4a8-3166-bf715ed45a32@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 23996040e4f3e1406479e3ab6ec83b2b
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [0ZIl]                               
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.12.2022 23:23, René Scharfe wrote:

> I don't know "docker compose" well enough to say whether it's a bug,
> but it seems it turns on some kind of terminal mode that needs both
> stdin and stdout to be connected to a TTY after only checking that one
> of them actually is.  Why not check both?
> 
> Curious that only macOS should be affected.  Is stdin of a hook script a
> TTY on that platform?  Or can "docker compose" handle stdin not being a
> TTY and stdout being one there?
> 
> René

Well, seems like I somehow tested this wrong. Tried it again from 
scratch and on linux I also get this error. So this looks like not a 
bug. Docker compose CLI options page is a little confusing because of these:

 >--interactive , -i  true  Keep STDIN open even if not attached.
 >--no-TTY , -T 	     true  Disable pseudo-TTY allocation (default: 
auto-detected).
 >--tty , -t          true  Allocate a pseudo-TTY.

Second column with `true` values is titled `Default`, whatever it means.
So `--tty` and `--no-TTY` is set by default? Anyway, seems like it is 
checking if at least one of stdout, stding, stderr is a tty and then 
tries to allocate a tty to all.

You can check docs here 
https://docs.docker.com/engine/reference/commandline/compose_run/#options

As a final solution I used makefile "magic" with `ifeq` and shell 
command like this:

     $(shell test -t 0)
     ifeq ($(.SHELLSTATUS), 1)
     ALLOCATE_TTY = --no-TTY
     endif

     docker compose run $(ALLOCATE_TTY) --rm --entrypoint "" app 
/code/test.sh


Maybe I'll just write to to them to clarify documentation on how those 
TTY options actually works by default.

Thanks for help with this.
Piotr
