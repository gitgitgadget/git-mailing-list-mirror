Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D9C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbiFTQck (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiFTQch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 12:32:37 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA218E11
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:32:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id D24671600EF;
        Mon, 20 Jun 2022 09:32:36 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TR1DoDcnftzv; Mon, 20 Jun 2022 09:32:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 2DFFF160143;
        Mon, 20 Jun 2022 09:32:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IYvx9NU3hGp5; Mon, 20 Jun 2022 09:32:36 -0700 (PDT)
Received: from [192.168.0.205] (ip72-206-2-24.fv.ks.cox.net [72.206.2.24])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id BB8671600EF;
        Mon, 20 Jun 2022 09:32:35 -0700 (PDT)
Message-ID: <7b7a2876-f6fe-1234-813b-71ba94a00422@cs.ucla.edu>
Date:   Mon, 20 Jun 2022 11:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] grep: add --max-count command line option
Content-Language: en-US
To:     "Carlos L." <00xc@protonmail.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3JlbiBbIF0=?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
 <449bede6-82b0-72ef-300d-bc0c49a1858b@cs.ucla.edu>
 <xy0kCdbtIjKb_GkXpHs7eeE8eWLbbct69_tVczBGS3CMnnnKTlTheaeNlH-RB1mMAfWThSTN6bMThsQ4lLtr0Ji6RwG3Nd52L1muiEqdtCU=@protonmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
In-Reply-To: <xy0kCdbtIjKb_GkXpHs7eeE8eWLbbct69_tVczBGS3CMnnnKTlTheaeNlH-RB1mMAfWThSTN6bMThsQ4lLtr0Ji6RwG3Nd52L1muiEqdtCU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/22 11:25, Carlos L. wrote:
> This does not work well with OPTION_INTEGER, since it assumes the value to be int-sized:
>
> parse-options.c:
>   219             *(int *)opt->value = strtol(arg, (char **)&s, 10);

OK, so parse-options messes up if the user specifies a count that does 
not fit in 'int'? Although that's a separate bug, let's not make things 
worse here; let's make the new count an 'int'.

In the long run parse-options should be changed to use strtoimax instead 
of strtol, and the corresponding integers should be changed to intmax_t, 
and the proper thing should be done if the string value does not fit 
into intmax_t. But this longer-run fix affects all integer-valued 
options, not just this one.


> I also wanted to avoid using signed int so both sides of the comparison with `count` in grep_source_1() have the same sign.

Such comparisons cannot misfire if both values are nonnegative, and that 
can easily be arranged here.

