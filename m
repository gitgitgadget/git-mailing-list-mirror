Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC5AC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGAYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGAYj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:24:39 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA595222
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:24:37 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1p2iEl-000A2O-8h;
        Wed, 07 Dec 2022 00:24:36 +0000
Message-ID: <093e1dca-b9d4-f1f2-0845-ad6711622cf5@iee.email>
Date:   Wed, 7 Dec 2022 00:24:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without ellipsis,
 options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221102120853.2013-1-philipoakley@iee.email>
 <20221112143616.1429-1-philipoakley@iee.email> <xmqqfsedywli.fsf@gitster.g>
 <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email> <xmqqedtvu7py.fsf@gitster.g>
 <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email> <xmqq7czjecfr.fsf@gitster.g>
 <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email> <xmqq35a5cnhq.fsf@gitster.g>
Content-Language: en-GB
In-Reply-To: <xmqq35a5cnhq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the delays.
On 26/11/2022 23:19, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>>  in that they may do "[][].." or "[][][]" when told to
>>> "trunc" fill a string with four or more double-width letters into a
>>> 5 display space.  But the point is at least for these with ellipsis
>>> it is fairly clear what the desired behaviour is.
>> That "is fairly clear" is probably the problem. In retrospect it's not
>> clear in the docs that the "%<(N" format is (would appear to be) about
>> defining the display width, in terminal character columns, that the
>> selected parameter is to be displayed within.
>>
>> The code already pads the displayed parameter with spaces as required if
>> the parameter is shorter than the display width - the else condition in
>> pretty.c L1750
>>
>>>   For "trunc" in
>>> the above example, I think the right thing for it to do would be to
>>> do "[][].", i.e. consume exactly 5 display columns, and avoid
>>> exceeding the given space by not giving two dots but just one.
>> The existing choice is padding "[][]" with a single space to reach 5
>> display chars.
>> For the 6-char "[][][]" truncation it is "[][..", i.e. 3 chars from
>> "[][][]", then the two ".." dots of the ellipsis.
> Here, I realize that I did not explain the scenario well.  The
> message you are responding to was meant to be a clarification of my
> earlier message and it should have done a better job but apparently
> I failed.  Sorry, and let me try again.
>
> The single example I meant to use to illustrate the scenario I worry
> about is this.  There is a string, in which there are four (or more)
> letters, each of which occupies two display columns.

I hadn't appreciated that utf8 has 'wide' characters that are
effectively double width, i.e. use 2 display columns, such as emojis.
I had been well aware of the multi-byte nature of utf8, and vaguely
aware of the potential for combined characters.

>   And '[]' in my
> earlier messages stood for a SINGLE such letter (I just wanted to
> stick to ASCII, instead of using East Asian script, for
> illustration).  So "[][.." is not possible (you are chomping the
> second such letter in half).
>
> I could use East Asian 一二三四 (there are four letters, denoting
> one, two, three, and four, each occupying two display spaces when
> typeset in a fixed width font),

These 4 characters came through ok.
>  but to make it easier to see in
> ASCII only text, let's pretend "[1]", "[2]", "[3]", "[4]" are such
> letters.  You cannot chomp them in the middle (and please pretend
> each of them occupy two, not three, display spaces).
>
> When the given display space is 6 columns, we can fit 2 such letters
> plus ".." in the space.  If the original string were [1][2][3][4],
> it is clear trunk and ltrunk can do "[1][2].." 

> (remember [n] stands
> for a single letter whose width is 2 columns, so that takes 6
> columns) 

Aside: The man pages aren't that clear about the distinction between
display columns and characters, both for these width based formats
(allow this placeholder parameter a width of <N> columns), and the
terminal's column position formats (start this parameter at the
on-screen column <N>) .


> and "..[3][4]", respectively.  It also is clear that Trunk
> and Ltrunk can do "[1][2][3]" and "[2][3][4]", respectively.  We
> truncate the given string so that we fill the alloted display
> columns fully.

While this example is clear, it's not clear what should be done if we
have mixed width strings, e.g. with emojis, as the boundaries in random
text will also be randomly placed.
>
> If the given display space is 5 columns, the desirable behaviour for
> trunk and ltrunk is still clear.  Instead of consuming two dots, we
> could use a single dot as the filler.  As I said, I suspect that the
> implementation of trunk and ltrunc does this correctly, though.

The current implementation is buggy in the case of combining character
code points. We forget to add the (zero space) combining code points
once we have the base character when it is the character before the
split (where the double dot ".." is inserted). I.e. the zero space
characters are added after the ".." double dot.

This can cause problems with the existing code for `mtrunc` where the
'lost' combing code points then become attached to the preceding "two
dots".
>
> My worry is it is not clear what Trunk and Ltrunk should do in that
> case.  There is no way to fit a substring of [1][2][3][4] into 5
> columns without any filler.

I'm not sure that anyone has fully solved that issue of what to do when
a wide character overlaps the end of an available display space, such as
terminal word-wrap when resizing the window (in my mintty terminal
window it displays a 'space' then starts the wide character on a new line).

There's also a 'bug' reported for one of the microsoft terminals that
the user wants to position the cursor at a column that is the middle of
a wide emoji character and wants half of it over written!

For our case (no wordwrap) I'd be minded to to mark the end column with
a single width character to show that some (wide) thing should be here,
but we've had to cut it off, such as the vertical ellipsis. At least
it's explainable.

I'll at least work on the doc clarification regarding the column width,
column position and wide char (2-col) issue, and hopefully a few failing
tests for the combing code point and the wide char fitment issue.

--
Philip
