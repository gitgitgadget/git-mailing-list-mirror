Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F1AC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC51922B4E
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHCSRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:17:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:40077 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCSRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:17:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4BL5hb0xFQz5tlF;
        Mon,  3 Aug 2020 20:17:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9F403496C;
        Mon,  3 Aug 2020 20:17:34 +0200 (CEST)
Subject: Re: [PATCH] connected: use buffered I/O to talk to rev-list
To:     Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
 <CAPx1Gvesmwf_CBj6D=YriFQgtEsDyUe7PHa6p9AvxG=fwAvHpA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5de5acdf-382b-6907-4a64-02ae02abaf13@kdbg.org>
Date:   Mon, 3 Aug 2020 20:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPx1Gvesmwf_CBj6D=YriFQgtEsDyUe7PHa6p9AvxG=fwAvHpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.20 um 18:08 schrieb Chris Torek:
> On Sun, Aug 2, 2020 at 7:39 AM René Scharfe <l.s.r@web.de> wrote:
>> @@ -135,16 +135,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>>                 if (new_pack && find_pack_entry_one(oid.hash, new_pack))
>>                         continue;
>>
>> -               memcpy(commit, oid_to_hex(&oid), hexsz);
>> -               if (write_in_full(rev_list.in, commit, hexsz + 1) < 0) {
>> -                       if (errno != EPIPE && errno != EINVAL)
>> -                               error_errno(_("failed write to rev-list"));
>> -                       err = -1;
>> -                       break;
>> -               }
>> +               fprintf(rev_list_in, "%s\n", oid_to_hex(&oid));
>>         } while (!fn(cb_data, &oid));
>>
>> -       if (close(rev_list.in))
>> +       if (fclose(rev_list_in))
>>                 err = error_errno(_("failed to close rev-list's stdin"));
>>
>>         sigchain_pop(SIGPIPE);
> 
> The same ferror()-before-fclose() remarks apply here too,
> but this time the explicit errno checking (EPIPE) cannot
> be done -- it's too late, errno is probably overwritten.

The EPIPE check should really remain in the loop above. (Same comment on
EPIPE on Windows applies here.)

-- Hannes
