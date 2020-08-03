Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244AC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE57822BED
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHCSKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:10:52 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:5898 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCSKw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:10:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4BL5Xn3Yblz5tlJ;
        Mon,  3 Aug 2020 20:10:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 16168496C;
        Mon,  3 Aug 2020 20:10:49 +0200 (CEST)
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1fd18b0c-8c2c-54ab-89aa-357b046eb403@kdbg.org>
Date:   Mon, 3 Aug 2020 20:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.20 um 18:11 schrieb Chris Torek:
> On Sun, Aug 2, 2020 at 7:40 AM René Scharfe <l.s.r@web.de> wrote:
>> @@ -1443,10 +1446,15 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>>                         continue;
>>
>>                 nth_midxed_object_oid(&oid, m, i);
>> -               xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
>> -               xwrite(cmd.in, "\n", 1);
>> +               fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
>> +       }
>> +
>> +       if (fclose(cmd_in)) {
>> +               error_errno(_("could not close stdin of pack-objects"));
>> +               result = 1;
>> +               finish_command(&cmd);
>> +               goto cleanup;
>>         }
>> -       close(cmd.in);
>>
>>         if (finish_command(&cmd)) {
>>                 error(_("could not finish pack-objects"));
>> --
>> 2.28.0
> 
> Here, we don't have any explicit errno checking, but
> of course error_errno() uses errno.  This too needs
> an ferror() (or fflush()) test before the final fclose(),
> and then we just need to use plain error().  Otherwise
> you'll need the clumsier test-after-each-fprintf() and
> an explicit final fflush()-and-test.

We need this explicit test after each fprintf anyway because SIGPIPE may
be ignored, and then writing fails with EPIPE. On Windows, this is
doubly important because we do not have SIGPIPE at all (and always see
EPIPE), but we see EPIPE only on the first failed write; subsequent
writes produce EINVAL.

-- Hannes
