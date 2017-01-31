Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55ECE1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 14:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbdAaOAi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 31 Jan 2017 09:00:38 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:16458 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdAaOAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 09:00:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id E40841E2F16;
        Tue, 31 Jan 2017 15:00:33 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Yo9Z731kh0Pw; Tue, 31 Jan 2017 15:00:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 7C6C91E306F;
        Tue, 31 Jan 2017 15:00:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KKNHDbRbTv2Q; Tue, 31 Jan 2017 15:00:33 +0100 (CET)
Received: from [192.168.178.72] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 38B311E2F16;
        Tue, 31 Jan 2017 15:00:33 +0100 (CET)
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
 <20170127100948.29408-2-cornelius.weig@tngtech.com>
 <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
 <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <1e341485-6fb6-243a-0b27-4035789a6f2a@tngtech.com>
Date:   Tue, 31 Jan 2017 15:00:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/31/2017 12:37 AM, Jeff King wrote:
> On Mon, Jan 30, 2017 at 01:58:10PM -0800, Junio C Hamano wrote:
> 
>>>     When writing the test for git-tag, I realized that the option
>>>     --no-create-reflog to git-tag does not take precedence over
>>>     logAllRefUpdate=always. IOW the setting cannot be overridden on the command
>>>     line. Do you think this is a defect or would it not be desirable to have this
>>>     feature anyway?
>>
>> "--no-create-reflog" should override the configuration set to "true"
>> or "always".  Also "--create-reflog" should override the
>> configuration set to "false".
>>
>> If the problem was inherited from the original code before your
>> change (e.g. you set logAllRefUpdates to true and then did
>> "update-ref --no-create-reflog refs/heads/foo".

I was actually not referring to update-ref, for which the
--no-create-reflog option works fine. I was referring to git-tag which
also has the --create-reflog option. For git-tag, the current code does
not allow to override logAllRefUpdates=always with --no-create-reflog.
On the other hand logAllRefUpdates=false is overridden by "git tag
--create-reflog". The reason is that the file-backend does allow to
force reflog creation, but it does not allow to force reflog
non-creation. I have a patch that amends this, but it's not pretty and I
don't think it will be useful (see last paragraph).

> I hadn't thought about that. I think "git branch --no-create-reflog" has
> the same problem in the existing code.

You are right, git-branch also ignores --no-create-reflog.

> I suspect nobody cares much in practice. Even if you say "don't create a
> reflog now", if you have core.logAllRefUpdates turned on, then it's
> likely that some _other_ operation will create the reflog later
> accidentally (e.g., as soon as you "git checkout foo && git commit",
> you'll get a reflog). I think you're fighting an uphill battle to turn
> logAllRefUpdates on and then try to disable some reflogs selectively.
> 
> So I agree the current behavior is quietly broken, which is not good.
> But I wonder if "--no-create-reflog" is really sane in the first place,
> and whether we might be better off to simply disallow it.

Concerning branches, I fully agree. For git-branch, the
"--no-create-reflog" option does not make sense at all and should
produce an error.

On the other hand, for tags it may make sense to override
logAllRefUpdates=always. As tag updates come exclusively from
force-creating the same tag on another revision, a reflog will actually
not be created by accident.


Nevertheless, I don't think it is very useful to have the
"--no-create-reflog" argument to any of git-branch or git-tag. It only
takes effect if a user has configured logAllRefUpdates=always, and he
probably has done that for a reason. Given that the overhead from a
reflog is minuscule, IMHO no-one will ever bother about
"--no-create-reflog".
