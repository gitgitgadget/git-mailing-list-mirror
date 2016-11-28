Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF83B1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 06:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbcK1G1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 01:27:52 -0500
Received: from koiru.veekun.com ([173.255.205.177]:46900 "EHLO
        koiru.veekun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbcK1G1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 01:27:50 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Nov 2016 01:27:50 EST
Received: from [IPv6:2001:470:d:4ac::133] (perushian.veekun.com [IPv6:2001:470:d:4ac::133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by koiru.veekun.com (Postfix) with ESMTPSA id 4CC52EE45A
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 06:19:36 +0000 (UTC)
Reply-To: eevee.reply@veekun.com
To:     git@vger.kernel.org
From:   "Eevee (Lexy Munroe)" <eevee@veekun.com>
Subject: cherry-pick -Xrenormalize fails with formerly CRLF files
Message-ID: <777ee899-4cfb-e3b4-da0d-793fde35e412@veekun.com>
Date:   Sun, 27 Nov 2016 22:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working with a repo that used to be all CRLF.  At some point it was 
changed to all LF, with `text=auto` in .gitattributes for the sake of 
Windows devs.  I'm on Linux and have never touched any twiddles relating 
to line endings.  I'm trying to cherry-pick some commits from before the 
switchover.

Straightforward cherry-picking causes entire files at a time to 
conflict, which I've seen before when switching from tabs to spaces.  So 
I tried -Xrenormalize and got:

     fatal: CRLF would be replaced by LF in [path]

The error comes from check_safe_crlf, which warns if checksafe is 
CRLF_SAFE_WARN and dies if it's (presumably) CRLF_SAFE_FAIL.  The funny 
thing is that it's CRLF_SAFE_RENORMALIZE.

I don't know what the semantics of this value are, but the caller 
(crlf_to_git) explicitly checks for CRLF_SAFE_RENORMALIZE and changes it 
to CRLF_SAFE_FALSE instead.  But that check only happens if crlf_action 
is CRLF_AUTO*, and for me it's CRLF_TEXT_INPUT.

I moved the check to happen regardless of the value of crlf_action, and 
at least in this case, git appears to happily do the right thing.  So I 
think this is a bug, but line endings are such a tangle that I'm really 
not sure.  :)

The repository in question is ZDoom: https://github.com/rheit/zdoom
I'm trying to cherry-pick commits from the 3dfloors3 branch (e.g., 
9fb2daf58e9d512170859302a1ac0ea9c2ec5993) onto a slightly outdated 
master, 6384e81d0f135a2c292ac3e874f6fe26093f45b1.
