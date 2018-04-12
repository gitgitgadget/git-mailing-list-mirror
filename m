Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6D91F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDLWUF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 12 Apr 2018 18:20:05 -0400
Received: from mail.1eanda.com ([50.241.99.154]:34313 "EHLO mail.1eanda.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeDLWUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:20:05 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 18:20:04 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.1eanda.com (Postfix) with ESMTP id EBE4F40242;
        Thu, 12 Apr 2018 18:12:44 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at mail.1eanda.com
Received: from mail.1eanda.com ([127.0.0.1])
        by localhost (mail.1eanda.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HtxFbcGvJ_sY; Thu, 12 Apr 2018 18:12:20 -0400 (EDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net [50.241.99.157])
        (Authenticated sender: matt@1eanda.com)
        by mail.1eanda.com (Postfix) with ESMTPSA id E5C9340213;
        Thu, 12 Apr 2018 18:12:13 -0400 (EDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] specify encoding for sed command
From:   Matthew Coleman <matt@1eanda.com>
In-Reply-To: <3FE7BFB6-769A-4F11-9C3B-86D681B3502F@gmail.com>
Date:   Thu, 12 Apr 2018 18:12:12 -0400
Cc:     Stephon Harris <theonestep4@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mao-Original-Outgoing-Id: 545263931.866219-29e9a419bad00c5236d6b684ee39d57b
Content-Transfer-Encoding: 8BIT
Message-Id: <CBA1FB4A-C586-48E0-A64E-371CCD2F6AC4@1eanda.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
 <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com>
 <3FE7BFB6-769A-4F11-9C3B-86D681B3502F@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did a little more digging into this issue today.

> On Apr 11, 2018, at 4:42 PM, Matt Coleman <cat.moleman@gmail.com> wrote:
> 
> I found another (possibly better) way to fix this:
> 
>> On Apr 10, 2018, at 3:18 AM, Matt Coleman <cat.moleman@gmail.com> wrote:
>> 
>>> 1) What platform OS / version / sed version is this on?
>> I'm experiencing this on macOS Sierra (10.12.6). The issue occurs with the OS's native sed, which is FreeBSD sed so the version number is kind of ambiguous.
>> 
>> The error goes away if I set LANG=C or LC_ALL=C or change it to use GNU sed (installed via homebrew as gsed).
> 
> If I change it to use awk instead of sed, it works with mawk, gawk, and macOS awk:
> unset $(set | awk -F '=' '/^__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*=/ {print $1}') 2>/dev/null
> 
> I compared sed vs. awk on Linux and Mac and they all take about the same amount of time to run (within 0.002ms).

The issue isn't actually caused by `sed`: it's caused by the way that the `set` builtin outputs characters in the Unicode Private Use Area (PUA) in the build of Bash 3.2.57 that macOS Sierra ships with.

Powerline uses several PUA code points to make some of its pretty text UI elements:

Code point (hex value): description
U+E0A0 (0xEE82A0): Version control branch
U+E0A1 (0xEE82A1): LN (line) symbol
U+E0A2 (0xEE82A2): Closed padlock
U+E0B0 (0xEE82B0): Rightwards black arrowhead
U+E0B1 (0xEE82B1): Rightwards arrowhead
U+E0B2 (0xEE82B2): Leftwards black arrowhead
U+E0B3 (0xEE82B3): Leftwards arrowhead

macOS Bash 3.2.57's `set` builtin has garbled output where Powerline's special symbols should be in the PS1 variable, but Bash 4.4.19 (installed on macOS via homebrew) and Bash 4.3.38 (Ubuntu 16.04) both display it correctly in the output of `set`. `echo $PS1` does display the symbols correctly on these versions of Bash.

So...

> 3) There's other invocations of "sed" in the file, aren't those affected as well?
The short answer: no. Slightly longer: not by the same thing that's affecting the line in the patch, at least.

Long: As described above, the problem isn't actually `sed`: it's the `set` builtin in macOS's build of Bash. The other invocations of `sed` should be safe, because `sed` properly handles the PUA code points on its own:

$ echo $'\xee\x82\xb0' | sed 's/./@/'
@

The way that `set` is displaying the PS1 variable seems to be sending them to `sed` individually or somehow split up:

$ for character in $'\xee' $'\x82' $'\xb0' $'\xee\x82' $'\x82\xb0'; do echo $character | sed 's/./@/'; done
sed: RE error: illegal byte sequence
sed: RE error: illegal byte sequence
sed: RE error: illegal byte sequence
sed: RE error: illegal byte sequence
sed: RE error: illegal byte sequence

Interestingly, Bash 3.2.25's `set` builtin on CentOS 5 correctly displays the octal values for the symbols (prompt edited to keep this email ASCII):

$ PS1=$'\xee\x82\xb0 '
>  set | grep PS1
PS1=$'\356\202\260 '

I haven't started digging through Bash's codebase, but it could either be a bug that was introduced between 3.2.25 and 3.2.57 or Apple used some silly flags when compiling Bash. Ideally, this should be fixed in Bash, but since Apple's using such an old version of Bash for license reasons, I think it's unlikely that they'll fix the issue.

I think the best way to move forward with this is a new patch that uses `awk` instead of `sed`: I tested several `awk` variants and the command was portable without requiring any changes to LANG or LC_ALL.

Does that sound like a good plan?
