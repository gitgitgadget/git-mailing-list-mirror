Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A441FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbdBNWNR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Feb 2017 17:13:17 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:35675 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdBNWNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:13:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 45A361E2FB1;
        Tue, 14 Feb 2017 23:13:13 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RThYFFlEF9tV; Tue, 14 Feb 2017 23:13:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id CECCD1E305D;
        Tue, 14 Feb 2017 23:13:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lm68WZCCGeLa; Tue, 14 Feb 2017 23:13:12 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-204-143.dynamic.mnet-online.de [185.17.204.143])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 697901E2FB1;
        Tue, 14 Feb 2017 23:13:12 +0100 (CET)
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref
 given
To:     Junio C Hamano <gitster@pobox.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com>
 <20170214212404.31469-2-cornelius.weig@tngtech.com>
 <xmqq8tp88nnj.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        bitte.keine.werbung.einwerfen@googlemail.com, j6t@kdbg.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <9be8b988-f5b3-7365-ae7f-b46888253f4c@tngtech.com>
Date:   Tue, 14 Feb 2017 23:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tp88nnj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/14/2017 10:31 PM, Junio C Hamano wrote:
> cornelius.weig@tngtech.com writes:
> 
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> Git-checkout completes words starting with '--' as options and other
>> words as refs. Even after specifying a ref, further words not starting
>> with '--' are completed as refs, which is invalid for git-checkout.
>>
>> This commit ensures that after specifying a ref, further non-option
>> words are completed as paths. Four cases are considered:
>>
>>  - If the word contains a ':', do not treat it as reference and use
>>    regular revlist completion.
>>  - If no ref is found on the command line, complete non-options as refs
>>    as before.
>>  - If the ref is HEAD or @, complete only with modified files because
>>    checking out unmodified files is a noop.
>>    This case also applies if no ref is given, but '--' is present.
> 
> Please at least do not do this one; a completion that is or pretends
> to be more clever than the end users will confuse them at best and
> annoy them.  Maybe the user does not recall if she touched the path
> or not, and just trying to be extra sure that it matches HEAD or
> index by doing "git checkout [HEAD] path<TAB>".  Leave the "make it
> a noop" to Git, but just allow her do so.

Hmm.. I'm a bit reluctant to let go of this just yet, because it was my
original motivation for the whole patch. I admit that it may be
confusing to not get completion in your example. However, I think that
once acquainted with the new behavior, a user who wants some files
cleaned would start by having a look at the list of files from "git
checkout HEAD <TAB><TAB>". That's probably faster than spelling the
first few characters and hit <TAB> for a file that's already clean.
Let's hear if anybody else has an opinion about this.

> I personally feel that "git checkout <anything>... foo<TAB>" should
> just fall back to the normal "path on the filesystem" without any
> cleverness, instead of opening a tree object or peek into the index.

I was thinking about that as well, but it's not what happens for "git
checkout topic:path<TAB>". And given that "git checkout topic path<TAB>"
refers to the same object, consistency kind of demands that the tree
objects are opened in the latter case as well. However, because the
differences to filesystem path completion are somewhat corner cases, I'm
fine with that as long as I'm not offered ref names any longer...

