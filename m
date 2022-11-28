Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A7C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiK1NkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiK1Nj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:39:57 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93467B1E4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:39:55 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ozeMT-0006o2-Dw;
        Mon, 28 Nov 2022 13:39:53 +0000
Message-ID: <b7b84dde-a723-0773-279f-c04c7f35cb7f@iee.email>
Date:   Mon, 28 Nov 2022 13:39:52 +0000
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
 <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email> <xmqq35a5cnhq.fsf@gitster.g>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq35a5cnhq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
> letters, each of which occupies two display columns.  And '[]' in my
> earlier messages stood for a SINGLE such letter (I just wanted to
> stick to ASCII, instead of using East Asian script, for
> illustration).  So "[][.." is not possible (you are chomping the
> second such letter in half).
>
> I could use East Asian 一二三四 (there are four letters, denoting
> one, two, three, and four, each occupying two display spaces when
> typeset in a fixed width font),

Thanks for that clarification, I'd been thinking it was about c char
(bytes) such as ASCII and multi-byte characters (code points), e.g.
European umlaut style distinctions.

I hadn't really picked up on the distinction between wide and narrow
'glyphs' (if that's the right term to use).
 
I see that the code does properly count the widths of narrow and wide
code points as 1 and 2 columns of the display, but then doesn't
explicitly try any adjustment for the wide code point problem you noted.
>  but to make it easier to see in
> ASCII only text, let's pretend "[1]", "[2]", "[3]", "[4]" are such
> letters.  You cannot chomp them in the middle (and please pretend
> each of them occupy two, not three, display spaces).
>
> When the given display space is 6 columns, we can fit 2 such letters
> plus ".." in the space.  If the original string were [1][2][3][4],
> it is clear trunk and ltrunk can do "[1][2].." (remember [n] stands
> for a single letter whose width is 2 columns, so that takes 6
> columns) and "..[3][4]", respectively.  It also is clear that Trunk
> and Ltrunk can do "[1][2][3]" and "[2][3][4]", respectively.  We
> truncate the given string so that we fill the alloted display
> columns fully.
>
> If the given display space is 5 columns, the desirable behaviour for
> trunk and ltrunk is still clear.  Instead of consuming two dots, we
> could use a single dot as the filler.  As I said, I suspect that the
> implementation of trunk and ltrunc does this correctly, though.

I believe there is a possible solution that, if we detect a column
over-run, then we can go back and replace the current two column double
dot with a narrow U+2026 Horizontal ellipsis, to regain the needed column.
>
> My worry is it is not clear what Trunk and Ltrunk should do in that
> case.  There is no way to fit a substring of [1][2][3][4] into 5
> columns without any filler.
For this case where the final code point overruns, my solution
could/would be to use the Vertical ellipsis U+22EE "⋮" to re-write that
final character (though the Unicode Replacement Character "�" could be
used, but that's ugly)

I suspect the code would need some close reading to ensure that the
column counting and replacement would correctly cope with the 'off by
one' wide width case inside the strbuf_utf8_replace().

I.e. given the same off-by-one position and replacement length, get back
to the same point to replace either the double dot or the final code
point in an idempotent manner.

The logic feels sound, as long as there are no three wide crocodile
code-points. Either we counted the right number of columns, or we
over-ran by one, so we go back and substitute with a one-for-two
replacement.

Philip

For watchers, https://github.com/microsoft/terminal/issues/4345 shows
some of the issues in the general case.
