Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB06C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B774664E2A
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBAWFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:05:09 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:7302 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhBAWE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:57 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4DV2660lLDz5tlB;
        Mon,  1 Feb 2021 23:04:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3D4934B9D;
        Mon,  1 Feb 2021 23:04:12 +0100 (CET)
Subject: Re: git fails with a broken pipe when one quits the pager
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2f750bc9-e739-6b98-25a1-6f035123e0e0@kdbg.org>
Date:   Mon, 1 Feb 2021 23:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87o8h4omqa.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.01.21 um 21:49 schrieb Ævar Arnfjörð Bjarmason:
> On Sun, Jan 31 2021, Vincent Lefevre wrote:
>> On 2021-01-31 02:47:59 +0100, Ævar Arnfjörð Bjarmason wrote:
>>> On Fri, Jan 15 2021, Vincent Lefevre wrote:
>>>> And of course, I don't want to hide error messages by default, because
>>>> this would hide *real* errors.
>>>
>>> Isn't the solution to this that your shell stops reporting failures due
>>> to SIGPIPE in such a prominent way then?
>>
>> No! I want to be warned about real SIGPIPEs.
> 
> Not being able to write "git log" output is a real SIGPIPE.

When Git is talking to a pager *and* it knows about it because has
started it itself, SIGPIPE is just a nuisance, not a useful behavior.

Guess why `git log` works on Windows when the pager is quit early, where
we do not have SIGPIPE? Because write errors are checked in sufficiently
many places.

I propose to do just this:

diff --git a/pager.c b/pager.c
index ee435de675..9fcc36425f 100644
--- a/pager.c
+++ b/pager.c
@@ -138,6 +138,7 @@ void setup_pager(void)
 
 	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
+	sigchain_push(SIGPIPE, SIG_IGN);
 	atexit(wait_for_pager_atexit);
 }
 
diff --git a/run-command.c b/run-command.c
index ea4d0fb4b1..c0041413b5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1165,10 +1165,6 @@ void check_pipe(int err)
 	if (err == EPIPE) {
 		if (in_async())
 			async_exit(141);
-
-		signal(SIGPIPE, SIG_DFL);
-		raise(SIGPIPE);
-		/* Should never happen, but just in case... */
 		exit(141);
 	}
 }
