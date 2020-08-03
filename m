Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26DC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC5320792
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgHCSPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:15:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10853 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCSPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:15:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4BL5fQ2F6pz5tl9;
        Mon,  3 Aug 2020 20:15:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E126D496C;
        Mon,  3 Aug 2020 20:15:41 +0200 (CEST)
Subject: Re: [PATCH] upload-pack: use buffered I/O to talk to rev-list
To:     Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
 <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4c7adb21-e47c-1d11-0974-8387b554eb9e@kdbg.org>
Date:   Mon, 3 Aug 2020 20:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.20 um 18:03 schrieb Chris Torek:
> One suggestion here:
> 
> On Sun, Aug 2, 2020 at 7:41 AM René Scharfe <l.s.r@web.de> wrote:
>> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
>> 2016-06-08), significantly reduce the number of system calls and
>> simplify the code for sending object IDs to rev-list by using stdio's
>> buffering and handling errors after the loops.
>>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>>  upload-pack.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 86737410709..9f616c2c6a6 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
> 
> [snip]
> 
>> @@ -640,12 +636,11 @@ static int do_reachable_revlist(struct child_process *cmd,
>>                 }
>>                 if (reachable && o->type == OBJ_COMMIT)
>>                         o->flags |= TMP_MARK;
>> -               memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
>> -               if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
>> -                       goto error;
>> +               fprintf(cmd_in, "%s\n", oid_to_hex(&o->oid));
> 
> The fprintf() call here *can* return an error, e.g., if the
> connection has died.  If it does, it should set things up so that
> a later ferror(cmd_in) returns true.

True. We need an explicit test after each fprintf anyway because SIGPIPE
may be ignored, and then writing fails with EPIPE. On Windows, this is
doubly important because we do not have SIGPIPE at all (and always see
EPIPE), but we see EPIPE only on the first failed write; subsequent
writes produce EINVAL.

-- Hannes
