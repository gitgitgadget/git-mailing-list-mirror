Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CEC61F461
	for <e@80x24.org>; Thu, 29 Aug 2019 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfH2XMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 19:12:19 -0400
Received: from smtp121.ord1d.emailsrvr.com ([184.106.54.121]:58541 "EHLO
        smtp121.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbfH2XMT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 19:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567120338;
        bh=9s24maXAF0Vut9ISYc7fUWOl1H2O5bgClTriV2gsPNM=;
        h=Subject:To:From:Date:From;
        b=uRSSzzsukDAr2JGzY3djdgvBVheWTA4X5uSkTO9uFI21xMzoaEblYePS8qYUV+Yg6
         8qNy4k9qp269JVbmnW0e5xApcb3uPKCLWCQJk/S3fuUffWhGtmGOPf0uy0wdQGno9v
         ZVZCMfdJaA8oFrOGNW+RTJPZQPMYXR2Hp4K8ICH8=
X-Auth-ID: jon@jonsimons.org
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7E4F940140;
        Thu, 29 Aug 2019 19:12:17 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from simonsj-mba2.hsd1.ca.comcast.net (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 19:12:18 -0400
Subject: Re: [PATCH v2 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
References: <20190829223811.12072-1-jon@jonsimons.org>
 <20190829223811.12072-2-jon@jonsimons.org>
 <CAPig+cQDPsXvOYa3HYo_cYeVq4PhJE_2RGw9n+92=t3BA0-yaw@mail.gmail.com>
From:   Jon Simons <jon@jonsimons.org>
Message-ID: <d8f1b891-4ff7-9815-2405-76e53506027c@jonsimons.org>
Date:   Thu, 29 Aug 2019 16:12:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQDPsXvOYa3HYo_cYeVq4PhJE_2RGw9n+92=t3BA0-yaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/19 3:45 PM, Eric Sunshine wrote:
> On Thu, Aug 29, 2019 at 6:38 PM Jon Simons <jon@jonsimons.org> wrote:
>> Fix a bug in partial cloning with sparse filters by ensuring to check
>> for 'have_git_dir' before attempting to resolve the sparse filter OID.
>> [...]
>> Signed-off-by: Jon Simons <jon@jonsimons.org>
>> ---
>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>> @@ -241,6 +241,27 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
>> +test_expect_success 'setup src repo for sparse filter' '
>> +       git init sparse-src &&
>> +       git -C sparse-src config --local uploadpack.allowfilter 1 &&
>> +       git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
>> +       for n in 1 2 3 4
>> +       do
>> +               test_commit -C sparse-src "this-is-file-$n" file.$n.txt || return 1
>> +       done &&
>> +       test_write_lines /file1.txt /file3.txt >sparse-src/odd-files &&
>> +       test_write_lines /file2.txt /file4.txt >sparse-src/even-files &&
>> +       test_write_lines /* >sparse-src/all-files &&
> 
> Hmm, does this work correctly? I would expect the /* to expand to all
> names at the root of your filesystem, which isn't what you want. You
> want the literal string "/*", which means you should quote it (with
> double quotes inside the test body). I'd also suggest using the simple
> 'echo' for this one as you did in v1 since it's more obvious that
> you're writing just a single line to the file, whereas using
> test_write_lines() has the potential to confuses readers.

Oof, thanks -- yes, this is incorrect.  I will revert this back to
'echo'.  I misapplied your initial suggesttion to all three lines.


-Jon
