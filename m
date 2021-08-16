Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A012C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB3F601FA
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhHPVzg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Aug 2021 17:55:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29505 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhHPVzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:55:35 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17GLsnnR090583
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Aug 2021 17:54:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com> <YRqwIAL/JgJp+RyI@coredump.intra.peff.net> <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com> <YRrSXhbaZMLMq+1/@coredump.intra.peff.net>
In-Reply-To: <YRrSXhbaZMLMq+1/@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Mon, 16 Aug 2021 17:54:44 -0400
Message-ID: <01d001d792e9$55f45470$01dcfd50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqAxbvBFwBEWuByQH2kUqUAce4woio1o3pgA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 5:02 PM, Jeff King wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
>
>On Mon, Aug 16, 2021 at 04:43:25PM -0400, Randall S. Becker wrote:
>
>> >Oh. Then the notion from my other mail of "if it's die(), then other
>> >tests would presumably see similar failures" might be true. ;)
>>
>> When running
>>
>> /home/git/git/t/trash directory.t9001-send-email: git send-email
>> --from="Example <nobody@example.com>" --to=nobody@example.com
>> --smtp-server="/home/git/git/t/trash
>> directory.t9001-send-email/fake.sendmail" --transfer-encoding=8bit
>> 0001-Second.patch longline.patch
>> fatal: longline.patch:35 is longer than 998 characters
>> warning: no patches were sent
>> /home/git/git/t/trash directory.t9001-send-email: echo $?
>> 162
>
>Well, that's a promising start to finding the source. :)
>
>> So this is strange. Where is perl run? I'd like to catch the completion inside git.
>
>This will all go through execv_dashed_external() in git.c. So we should just be exiting with the status code we got from the child via wait().
>
>You could try:
>
>  - running it as git-send-email (with a dash), which will exec the perl
>    script directly, rather than going through the main git binary
>
>  - instrumenting run-command.c:wait_or_whine() to see how it interprets
>    the value. If perl really is returning 255, then perhaps your
>    platform's WIFSIGNALED() is confused by that.
>
>If the problem does only show when going through the git binary, then I
>suspect:
>
>  git -c alias.foo='!perl -e die' foo
>
>may be an easier reproduction.

Running git-send-email reports completion 162. The code variable is optimized out but looks like it also is 162 when returning. The WIFEXITED(status) code did not appear to execute, although I think that also was optimized out. finish_command ret is 162. So perl looks like it is completing with a bad completion code. This percolates up to git, which also reports the same value.

I went to the perl maintainer on this subject. What I got back was that die is not guaranteed to return a specific value other than 0 for success and non-zero for failure. There are platforms where the return might known and has meaning but that is not portable. According to the current official perl documentation:

"die raises an exception. Inside an eval the exception is stuffed into $@ and the eval is terminated with the undefined value. If the exception is outside of all enclosing evals, then the uncaught exception is printed to STDERR and perl exits with an exit code indicating failure. If you need to exit the process with a specific exit code, see exit."

So assuming that a signal occurred because the value is between 129 and 192 is not correct in the case of perl. Could we do something like test_expect_perl_die that does not perform the signal check at line 980 in test-lib-functions.sh so just checks 0 vs. non-zero, which would be semantically correct no matter what the platform? Alternatively, and possibly better, the die could be caught and then exit() called in git-send-email, as in:

eval { die "Something bad happened" };
exit(255) if $@;


