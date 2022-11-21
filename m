Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F598C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKUSKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKUSKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:10:50 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A209A24A
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:10:49 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oxBFn-000Bk3-C2;
        Mon, 21 Nov 2022 18:10:48 +0000
Message-ID: <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
Date:   Mon, 21 Nov 2022 18:10:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without ellipsis,
 options
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221102120853.2013-1-philipoakley@iee.email>
 <20221112143616.1429-1-philipoakley@iee.email> <xmqqfsedywli.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqfsedywli.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/11/2022 00:34, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Instead of replacing with "..", replace with the empty string,
>> implied by passing NULL, and adjust the padding length calculation.
> What's the point of saying "implied by passing NULL" here?  Is it an
> excuse for passing NULL when passing "" would have sufficed and been
> more natural, or something?  

Passing the empty string was my first approach, however Taylor had
commented "why pass the empty string, when NULL will do", hence I
checked, and yes, we can pass NULL, so I followed that guidance on the
re-roll.

> Also, it is unclear to whom you are
> passing the NULL.  I think that it is sufficient that you said
> "replace with the empty string" there.

I could drop the commit message comment, and keep the NULL being passed
tostrbuf_utf8_replace to indicate the empty string, though that may
create the same reviewer question that Taylor had.
>
>> Extend the existing tests for these pretty formats to include
>> `Trunc` and Ltrunc` options matching the `trunc` and `ltrunc`
>> tests.
> A more important thing to say is that we add Trunc and Ltrunc, than
> we test for these new features ;-)

That would be to swap the paragraphs about, yes?
>
> You may also want to explain why there is no matching Mtrunc added.

Can do, though it felt obvious that the original mtrunc ellipsis would
be necessary for the mid-case.
>
> I also have another comment on the design.
>
> Imagine there are series of wide characters, each occupying two
> display columns, and you give 6 display columns to truncate such a
> string into.  "trunc" would give you "[][].." (where [] denotes one
> such wide letter that occupies two display columns), and "Trunc"
> would give you "[][][]".  Now if you give only 5 display columns,
> to fill instead of 6, what should happen?

My reading of the existing code for ltrunc/mtrunc/trunc was that all
these padding conditions were already covered. It was simply a matter of
column counting.
>
> I do not recall how ".."-stuffed truncation works in this case but
> it should notice that it cannot stuff 3 wide letters and give you
> "[][].".  The current code may be already buggy, but at least at the
> design level, it is fairly clear what the feature _should_ do.
>
> As a design question, what should "Trunc" do in such a case now?  I
> do not think we can still call it "hard truncate" if the feature
> gives "[][]" (i.e. fill only 4 display columns, resulting in a
> string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
> that are given), but of course chomping a letter in the middle is
> not acceptable behaviour, so ...
The design had already covered those cases. The author already had those
thoughts

--

Philip
