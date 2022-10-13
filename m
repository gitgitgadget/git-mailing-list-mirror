Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD7DC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJMGqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJMGqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 02:46:00 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6F107CCD
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:45:58 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Mp0Qq5jmqz5tlJ;
        Thu, 13 Oct 2022 08:45:55 +0200 (CEST)
Message-ID: <f2453084-9f9a-74a1-6a43-0c1b91c95e93@kdbg.org>
Date:   Thu, 13 Oct 2022 08:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Git diff misattributes the first word of a line to the previous
 line
To:     Gurjeet Singh <gurjeet@singh.im>
References: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.22 um 07:51 schrieb Gurjeet Singh:
> Git diff seems to get confused about word boundaries, and includes the
> first word from the next line.

No, that would misattribute the perceived malfunction.

> It seems that the first word of a line gets attributed to the previous
> line, ignoring the fact that there's an intervening newline before the
> word.
> [...]
> $ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt
> diff --git a/tmp/1.txt b/tmp/2.txt
> index 8239f93..099fb80 100644
> --- a/tmp/1.txt
> +++ b/tmp/2.txt
> @@ -1,2 +1,2 @@
>     x = yz [-ab-]{+opt1+}
> {+    ac+} = [-cd ef-]{+pq opt2+}
> 
> $ cat /tmp/1.txt
>     x = yz
>     ab = cd ef
> 
> $ cat /tmp/2.txt
>     x = yz opt1
>     ac = pq opt2

The reason for this is that the implementation of word-diff does not
treat newline characters in any special way. They are treated as
"whitespace" like any other character that is not captured by the
word-diff patterns. Whitespace characters following each word are
recorded, but are disregarded when the word-diff is computed. When the
text is reconstructed in the output, these recorded space characters are
printed only for unchanged and added words, but are not printed for
removed words (IIRC). Combine this with the fact that when there is a
change, i.e., a combination of removal and addition, then the removal is
printed before the addition, and you get the observed output.

I don't see an easy solution for this without completely rewriting the
implementation.

-- Hannes

