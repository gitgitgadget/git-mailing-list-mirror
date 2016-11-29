Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09C01FBB0
	for <e@80x24.org>; Tue, 29 Nov 2016 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbcK2A1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 19:27:39 -0500
Received: from koiru.veekun.com ([173.255.205.177]:50672 "EHLO
        koiru.veekun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbcK2A1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 19:27:38 -0500
Received: from [IPv6:2001:470:d:4ac::133] (perushian.veekun.com [IPv6:2001:470:d:4ac::133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by koiru.veekun.com (Postfix) with ESMTPSA id 534A4EE45A;
        Tue, 29 Nov 2016 00:27:35 +0000 (UTC)
Reply-To: eevee.reply@veekun.com
Subject: Re: cherry-pick -Xrenormalize fails with formerly CRLF files
References: <777ee899-4cfb-e3b4-da0d-793fde35e412@veekun.com>
 <20161128155415.GA9966@tb-raspi>
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
From:   "Eevee (Lexy Munroe)" <eevee@veekun.com>
Cc:     git@vger.kernel.org
Message-ID: <76a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
Date:   Mon, 28 Nov 2016 16:27:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161128155415.GA9966@tb-raspi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2016 07:54 AM, Torsten Bögershausen wrote:
> On Sun, Nov 27, 2016 at 10:19:35PM -0800, Eevee (Lexy Munroe) wrote:
>> I'm working with a repo that used to be all CRLF.  At some point it
>> was changed to all LF, with `text=auto` in .gitattributes for the
>> sake of Windows devs.  I'm on Linux and have never touched any
>> twiddles relating to line endings.  I'm trying to cherry-pick some
>> commits from before the switchover.
>>
>> Straightforward cherry-picking causes entire files at a time to
>> conflict, which I've seen before when switching from tabs to spaces.
>> So I tried -Xrenormalize and got:
>>
>>     fatal: CRLF would be replaced by LF in [path]
>>
>
> Which version of Git are you using, what does
> git --version
> say?

Oh, sorry.  2.10.2, but I also tried building next (c8190e7) with the 
same result.

>> The error comes from check_safe_crlf, which warns if checksafe is
>> CRLF_SAFE_WARN and dies if it's (presumably) CRLF_SAFE_FAIL.  The
>> funny thing is that it's CRLF_SAFE_RENORMALIZE.
>>
>> I don't know what the semantics of this value are, but the caller
>> (crlf_to_git) explicitly checks for CRLF_SAFE_RENORMALIZE and
>> changes it to CRLF_SAFE_FALSE instead.  But that check only happens
>> if crlf_action is CRLF_AUTO*, and for me it's CRLF_TEXT_INPUT.
>>
>> I moved the check to happen regardless of the value of crlf_action,
>> and at least in this case, git appears to happily do the right
>> thing.  So I think this is a bug, but line endings are such a tangle
>> that I'm really not sure.  :)
>>
> I am not sure either.
> Could you send me the diff you made ?
> git diff
>
> I am happy to look into it, (in the amount of time I have).

It's pretty straightforward:

diff --git a/convert.c b/convert.c
index be91358..f9ff6a5 100644
--- a/convert.c
+++ b/convert.c
@@ -275,6 +275,8 @@ static int crlf_to_git(const char *path, const char 
*src, size_t len,
         /* Optimization: No CRLF? Nothing to convert, regardless. */
         convert_crlf_into_lf = !!stats.crlf;

+       if (checksafe == SAFE_CRLF_RENORMALIZE)
+               checksafe = SAFE_CRLF_FALSE;
         if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT 
|| crlf_action == CRLF_AUTO_CRLF) {
                 if (convert_is_binary(len, &stats))
                         return 0;

(The new lines are copied from the block immediately following, just 
past where the context ends.)

>> The repository in question is ZDoom: https://github.com/rheit/zdoom
>> I'm trying to cherry-pick commits from the 3dfloors3 branch (e.g.,
>> 9fb2daf58e9d512170859302a1ac0ea9c2ec5993) onto a slightly outdated
>> master, 6384e81d0f135a2c292ac3e874f6fe26093f45b1.
>
> This is what I tried:
>
> ...
>
> The patch did not apply, but for different reasons.
>
> Could you send us, what exactly you did, to help me out ?

I did notice it works when there's a conflict, but I thought I 
specifically named a commit that applied cleanly.  Apparently not, 
sorry.  Try ddba3dd325054e71d48634cb19708cb7bcd8f20b:

eevee@perushian ~/dev-foreign/zdoom.git/src ⚘ git checkout -b 
git-renormalize-test 6384e81d0f135a2c292ac3e874f6fe26093f45b1
Switched to a new branch 'git-renormalize-test'
eevee@perushian ~/dev-foreign/zdoom.git/src ⚘ git cherry-pick 
-Xrenormalize ddba3dd325054e71d48634cb19708cb7bcd8f20b
fatal: CRLF would be replaced by LF in src/r_plane.cpp.

