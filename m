Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31777C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B664215F2
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfK0Wma (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:42:30 -0500
Received: from mailout08.hostingdiscounter.nl ([91.217.57.99]:54243 "EHLO
        mailout08.hostingdiscounter.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbfK0Wm3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Nov 2019 17:42:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTP id 4BDD6BAD;
        Wed, 27 Nov 2019 23:42:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mailout08.hostingdiscounter.nl
Received: from mailout08.hostingdiscounter.nl ([127.0.0.1])
        by localhost (mailout08.hostingdiscounter.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 19Q79WpwZDb9; Wed, 27 Nov 2019 23:42:01 +0100 (CET)
Received: from mail41.hostingdiscounter.nl (mail41.hostingdiscounter.nl [91.217.57.67])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTPS;
        Wed, 27 Nov 2019 23:42:01 +0100 (CET)
Received: from [192.168.1.105] (130-208-201-31.ftth.glasoperator.nl [31.201.208.130])
        by mail41.hostingdiscounter.nl (Postfix) with ESMTPSA id D07624054C;
        Wed, 27 Nov 2019 23:42:34 +0100 (CET)
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
 <20191126004647.GD14157@google.com>
From:   Ruud van Asseldonk <dev@veniogames.com>
Message-ID: <a5fb708d-e7b6-b149-7b21-07649487fb65@veniogames.com>
Date:   Wed, 27 Nov 2019 23:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126004647.GD14157@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for having a look Jonathan.

Jonathan Nieder wrote:
> Ruud van Asseldonk wrote:
> 
>> The git-request-pull.sh script invokes Perl,
> 
> Okay, on second glance I found it:
> 
>    set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
> 
> This does seem pretty inherently to require perl, so makes sense.
> 
> I wonder if we can generalize this.  For example, would it make sense to
> have a helper that looks for @@PERL@@ in a file,  so we could say
> 
> 	if uses_perl git-request-pull.sh && ! test_have_prereq PERL
> 	then
> 		...
> 	fi
> 
> That way, this would be more futureproof in case someone eliminates
> the perl dependency (either by improving that particular parsing step
> or by rewriting the whole program in C).

That sounds like a good idea. How about turning that into a test itself? 
The test would check that the script mentions @@PERL@@, as the first 
subtest. That way, if somebody removes the Perl dependency in the 
future, that will make the test fail, and that will be a reminder to 
remove the check from the test, so the test runs unconditionally.

> In any event,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Do the request-pull tests in t7006-pager.sh need the same treatment?

I think these tests are fine, they run "git -p request-pull", not enough 
arguments to make request-pull do something, so it prints its usage and 
exits with 1. The tests use test_must_fail to verify the exit code, and 
printing usage does go through the pager. request-pull does not call 
Perl when it only prints its usage.
