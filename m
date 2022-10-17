Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FBFC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 15:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJQPjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQPjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 11:39:51 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B44255A9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:39:48 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF086CA1252;
        Mon, 17 Oct 2022 11:39:47 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 25CE9CC8325;
        Mon, 17 Oct 2022 11:39:47 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com>
Date:   Mon, 17 Oct 2022 11:39:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/15/22 9:04 AM, Rudy Rigot via GitGitGadget wrote:
> From: Rudy Rigot <rudy.rigot@gmail.com>
> 
> Currently, if git-status takes more than 2 seconds for enumerating
> untracked files, a piece of advice is given to the user to consider
> ignoring untracked files. This is somewhat at odds with the UX
> upsides from having fsmonitor enabled, since fsmonitor will be
> here to take care of mitigating the performance downsides from
> those untracked files.

Yes, the original advice needs some updating.  Thanks!


We should be careful here, FSMonitor only helps with untracked
files if the untracked cache (UC) is also turned on.  They do work
well together and they greatly speed up things, but if either is
turned off, `git status` will still need to scan.  (Small nerd
detail: the UC by itself does speed things up -- it only needs
to lstat known directories most of the time, rather than actually
readdir them.  When both are on, we don't even need to do that.)

The original message suggested turning off the untracked file (UF)
scan completely.  Perhaps, we could have advice say to turn off
UF scan -or- turn on FSM & UC ?


> 
> I considered just suppressing that piece of advice entirely for
> repositories with fsmonitor disabled, but I decided to replace
> it with another piece of advice instead, letting the user know
> that this run may have been slow, but the next ones should be faster.
> Of course, please let me know if the phrasing can be improved. To
> keep consistent with other pieces of advice, this new one can be
> hidden with a new advice.statusFsmonitor config.
> 
> If the repository does not have fsmonitor enabled, or if the new
> piece of advice is hidden by config, the behavior falls back to
> today's behavior: show the message advising to ignore untracked
> files, as long as it wasn't disabled with the existing advice.statusUoption
> config.


We also need to be careful here.  With FSMonitor the "first one is
slow, the second one is fast" happens because `git status` is secretly
updating the index (despite looking like a read-only command).  That
causes the index to have an updated FSM token (so that subsequent
FSM responses are relative to a more recent checkpoint).  See [1].
So it isn't always correct that the second status will be faster.
It usually is, but it just depends on the threshold -- and more
importantly, that the UC is turned on.  (So I guess what I'm saying
is that again, we should advise to turn UF or turn on both FSM & UC.)


[1] 26b9f34ab3 (fsmonitor: force update index after large responses, 
2022-03-25)

> 
> Test-wise, I tried to figure out ways to mock the behavior of a
> slow git-status, but I couldn't figure it out, so I could use some
> advice. I tracked down Commit 6a38ef2ced (status: advise to consider
> use of -u when read_directory takes too long, 2013-03-13), and it
> also didn't have tests, so I'm questioning whether it can in fact
> be reasonably done. Thanks in advance for any guidance.
[...]

WRT testing, you might do something like:

	#define UF_DELAY_WARNING_IN_MS (2 * 1000)

	static inline int uf_was_slow(uint32_t untracked_in_ms)
	{
	#ifdef GIT_TEST_UF_DELAY_WARNING // or maybe use getenv() here
		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
	#endif

		return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
	}

And then you can set the GIT_TEST_ symbol (or env var) during the
test scripts and confirm that we get the messages that you expect.

Hope this helps,
Jeff
