Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D2C4321E
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 14:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKZOcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKZOcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 09:32:36 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985325FD6
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:32:31 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oywEH-0004U2-6o;
        Sat, 26 Nov 2022 14:32:29 +0000
Message-ID: <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
Date:   Sat, 26 Nov 2022 14:32:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without ellipsis,
 options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221102120853.2013-1-philipoakley@iee.email>
 <20221112143616.1429-1-philipoakley@iee.email> <xmqqfsedywli.fsf@gitster.g>
 <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email> <xmqqedtvu7py.fsf@gitster.g>
 <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email> <xmqq7czjecfr.fsf@gitster.g>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq7czjecfr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/11/2022 07:11, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 22/11/2022 00:57, Junio C Hamano wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>>> As a design question, what should "Trunc" do in such a case now?  I
>>>>> do not think we can still call it "hard truncate" if the feature
>>>>> gives "[][]" (i.e. fill only 4 display columns, resulting in a
>>>>> string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
>>>>> that are given), but of course chomping a letter in the middle is
>>>>> not acceptable behaviour, so ...
>>>> The design had already covered those cases. The author already had those
>>>> thoughts
>>> Sorry, I was saying that none of
>>>
>>>  * giving only [][] to fill only 4 display columns, without filling
>>>    the given 5 display columns,
>>>
>>>  * giving [][][] to fill 6 display columns, exceeding the given 5
>>>    display columns,
>>>
>>>  * giving [][][ that chomps a letter in the middle, in a failed
>>>    attempt to fill exactly 5 displya columns.
>>>
>>> would be a sensible design of the behaviour for "Trunc", so I am not
>>> sure what "had already covered" really mean...
>>>
>> I'm still unsure what you are trying to say here.
>>
>> Is this a question about the prior `trunc`, `mtrunc`, and `ltrunc`
>> design and tests?
>> e.g. how complete are their tests?
> No.  As I said, the existing lowercase ones may already be buggy (I
> didn't check),

That question hadn't come across in the previous emails.

>  in that they may do "[][].." or "[][][]" when told to
> "trunc" fill a string with four or more double-width letters into a
> 5 display space.  But the point is at least for these with ellipsis
> it is fairly clear what the desired behaviour is.

That "is fairly clear" is probably the problem. In retrospect it's not
clear in the docs that the "%<(N" format is (would appear to be) about
defining the display width, in terminal character columns, that the
selected parameter is to be displayed within.

The code already pads the displayed parameter with spaces as required if
the parameter is shorter than the display width - the else condition in
pretty.c L1750

>   For "trunc" in
> the above example, I think the right thing for it to do would be to
> do "[][].", i.e. consume exactly 5 display columns, and avoid
> exceeding the given space by not giving two dots but just one.

The existing choice is padding "[][]" with a single space to reach 5
display chars.
For the 6-char "[][][]" truncation it is "[][..", i.e. 3 chars from
"[][][]", then the two ".." dots of the ellipsis.
>
> But with "hard truncate", I do not think we can define any sensible
> behaviour 

Given the existing code and the display column expectation, it felt
rather simple to apply the hard cut at the display width, or pad with
spaces if the chars to display were shorter than the allocated columns.

> when we ask it to do the same.  Giving "[][]" leaves one
> display space unconsumed and giving "[][][]" would exceed the given
> space, so anything you would write after that would be unaligned on
> the line.

A careful read (and testing) of the existing 'mtrunc' does show a
rounding error bug though. Its a confusion between the computed start
and end points of the cut that loses one display column (the string
displayed is short by one when the count is odd, IIUC).

>
> As to the tests, the question was, whatever the designed behaviour
> for the above case, if they record the design choice made by this
> series (even though, as I said, I suspect no design choice for the
> "hard-fill/trunc odd number of columns with a run of double-width
> letters" problem is satisfactory).

The existing tests already cover the trailing space padding issues.
However I'd agree that the documentation (and original commit messages
for the existing code) do not make clear the distinction between display
columns to be filled and characters in the displayed parameters (aka
'placeholders').

Within that, there is also the "%<(N" and "%<|(M" lack of clarity, where
the N count is for a single place holder's character count, while the M
value is the terminal's display column number, of the 24x80 column style.

Finally, the docs use of '<N>'  in the middle the place holders title
that also use `<` and `>` is a readability nightmare. Given that the
text then only talks about `N` it may be sensible to drop the
surrounding `<.>` to reduce confusion for these alignment placeholders.

--

Philip
