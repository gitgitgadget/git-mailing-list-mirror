Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C5C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjDCVrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCVro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 17:47:44 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49F49DD
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 14:47:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 6EF8C3C097AFC;
        Mon,  3 Apr 2023 14:38:43 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 01c1HguO6g6L; Mon,  3 Apr 2023 14:38:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id F395C3C097AFD;
        Mon,  3 Apr 2023 14:38:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu F395C3C097AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680557923;
        bh=mPk8IoktGpCOFvvbm6FfDFpRZjgCNQY0M93nZRbaYvA=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=Mb6Ob0rNFkTbzDgf/zQA3lF1a3BgMs8pOKjlhZSCYQThLrVMFUCs/n0whkksKwcaV
         qSAmHwcLn7ult6QYNTe1YG9vbwz3iTL857NVLQ95BX7Z0d6WHxmdz1n725C5qXqCma
         zupJnWHHeOsnhbsLvcAk+jw4t3bzBibhqNqSVnh/UzHFuAnQL/azagvwM9/ioUKgV0
         VXSBvWHBBG/w8S2Jmh44IeCL+Z+zfF0GpRtk/kZKJhKPF2M59RcPg57bw3Y3323p+k
         mttcUF6Ldx3Wq85uGKFURxqrziDdWVpw21RgBTbuy8HeUMRAAkJvGb2hVUWudxbHRN
         Ti9q5U/oqGzQw==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GXWQ8CbnROrO; Mon,  3 Apr 2023 14:38:42 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id D2C2F3C097AFC;
        Mon,  3 Apr 2023 14:38:42 -0700 (PDT)
Message-ID: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
Date:   Mon, 3 Apr 2023 14:38:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     60690@debbugs.gnu.org
From:   Paul Eggert <eggert@cs.ucla.edu>
Subject: -P '\d' in GNU and git grep
Organization: UCLA Computer Science Department
Cc:     =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mega lith01 <megalith01@gmail.com>, demerphq@gmail.com,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        pcre-dev@exim.org, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've recently done some bug-report maintenance about a set of GNU grep 
bug reports related to whether whether "grep -P '\d'" should match 
non-ASCII digits, and have some thoughts about coordinating GNU grep 
with git grep in this department.

GNU Bug#62605[1] "`[\d]` does not work with PCRE" has been fixed on 
Savannah's copy of GNU grep, and some sort of fix should appear in the 
next grep release. However, I'm leaving the GNU grep bug report open for 
now because it's related to Bug#60690[2] "[PATCH v2] grep: correctly 
identify utf-8 characters with \{b,w} in -P" and to Bug#62552[3] "Bug 
found in latest stable release v3.10 of grep". I merged these related 
bug reports, and the oldest one, Bug#60690, is now the representative 
displayed in the GNU grep bug list[4].

For this set of grep bug reports there's still a pending issue discussed 
in my recent email[5], which proposes a patch so I've tagged Bug#60690 
with "patch". The proposal is that GNU grep -P '\d' should revert to the 
grep 3.9 behavior, i.e., that in a UTF-8 locale, \d should also match 
non-ASCII decimal digits.

In researching this a bit further, I found that on March 23 Git disabled 
the use of PCRE2_UCP in PCRE2 10.34 or earlier[6], due to a PCRE2 bug 
that can cause a crash when PCRE2_UCP is used[7]. A bug fix[8] should 
appear in the next PCRE2 release.

When PCRE2 10.35 comes out, it appears that 'git grep -P' will behave 
like 'grep -P' only if GNU grep adopts something like the solution 
proposed in [5].

[1]: https://bugs.gnu.org/62605
[2]: https://bugs.gnu.org/60690
[3]: https://bugs.gnu.org/62552
[4]: https://debbugs.gnu.org/cgi/pkgreport.cgi?package=grep
[5]: https://lists.gnu.org/archive/html/grep-devel/2023-04/msg00004.html
[6]: 
https://github.com/git/git/commit/14b9a044798ebb3858a1f1a1377309a3d6054ac8
[7]: 
https://lore.kernel.org/git/7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com/
[8]: 
https://github.com/git/git/commit/14b9a044798ebb3858a1f1a1377309a3d6054ac8
