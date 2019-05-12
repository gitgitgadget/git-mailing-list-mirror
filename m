Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7671F461
	for <e@80x24.org>; Sun, 12 May 2019 09:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfELJ4S (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 05:56:18 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:43076 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfELJ4S (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 May 2019 05:56:18 -0400
Received: from 200116b8469b650098850f1638ad2e80.dip.versatel-1u1.de ([2001:16b8:469b:6500:9885:f16:38ad:2e80]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hPlDL-0002R2-Db; Sun, 12 May 2019 11:56:15 +0200
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Subject: Re: [PATCH] make slash-rules more readable
To:     git@vger.kernel.org
References: <20190507104507.18735-1-admin@in-ici.net>
 <xmqqzhnxh5nm.fsf@gitster-ct.c.googlers.com>
Message-ID: <094f3746-67c9-0284-0593-eb6b24d5c4a3@in-ici.net>
Date:   Sun, 12 May 2019 11:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhnxh5nm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1557654977;bce7a29b;
X-HE-SMSGID: 1hPlDL-0002R2-Db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08.05.19 07:33, Junio C Hamano wrote:
> "Dr. Adam Nielsen" <admin@in-ici.net> writes:
> 
>> + - A pattern that contains a non-trailing slash is matched  relative to the location of the `.gitignore` file.
>> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
>> +   `a/doc/frotz` (relative from the `.gitignore` file).
>> +   Note that the pattern `doc/frotz` and `/doc/frotz` have the
>> +   same effect in any `.gitignore` file, while `/bar` and `bar`
>> +   have not the same effect (`/bar` will not match `foo/bar`).
> 
> The "note" is not incorrect per-se.  The behaviour described is
> because the leading slash is removed for the purpose of textual
> matching against paths, but still counts as a non-trailing slash for
> the purpose of anchoring the pattern to the level of recursion.
> 
> I am not sure if that is obvious to the readers, though.

Yes, its not explained to the reader that the leading slash is removed 
for the purpose of textual matching. But maybe this is not necessary in 
order to understand the effect of the pattern.

>  Especially
> because the "a leading slash matches the beginning of ..." which was
> in the original is still left and appears two bullet points after
> this one, the presentation order seem a bit suboptimal.

I agree. The paragraph "a leading slash matches the beginning of ..." 
should be deleted, because its already covered by the top rule plus an 
example.

> 
> How about deleting that "A leading slash matches the beginning..."
> bullet, and then splitting the above bullet into two?  That is
> 
> - A pattern that contains a non-trailing slash is matched
is matched relative to the location of the `.gitignore` file.
>    For example, `doc/frotz/` matches `doc/frotz` directory, but not
>    `a/doc/frotz` (relative from the `.gitignore` file).
> 

I agree that the case of a leading slash is important and deserves its 
own paragraph, especially if we remove the last bullet.


> - A leading slash, if any, is implicitly removed before matching the
>    pattern with the pathname, but the pattern still counts as having
>    a non-trailing slash for the purpose of the above rule.  For

I would try to avoid ambiguous words like  `implicitly removed ` and 
`pathname` that have not been used before. Also I am not sure if 
explaining the reader how the algorithm works is the best approach.

>    example, a pattern `{asterisk}.c` does not have any slash in it,
>    so it would match a file or a directory whose name ends with `.c`
>    anywhere in the directory that has `.gitignore` file in it
>    (e.g. `sub/foo.c`, `bar.c`).

A similar example is already in the  "If the pattern contains no 
slash.." paragraph. I think it takes a bit too much space just to 
explain the difference when a leading slash appears.

> By prefixing a slash to make it
>    `/{asterisk}.c`, it can be limited to match only at the current
>    level (i.e. `bar.c` but not `sub/foo.c`).

How about we split it like this:

   - A pattern that contains a non-trailing slash is matched
     relative to the location of the `.gitignore` file.
     For example, `doc/frotz/` matches `doc/frotz` directory, but not
     `a/doc/frotz` (relative from the `.gitignore` file; note that the
     example has a trailing and a non-trailing slash at the same time).

   - Note: A pattern with a leading slash has a non-trailing slash
     and is therefore effected by the previous paragraph.
     For example, the pattern `/bar` only matches the file or
     folder `bar` that is at the same location as the `gitignore` file.
     Whereas the pattern `bar` would also match in folders below the
     `gitignore`  file.
     On the other hand,  the pattern `doc/frotz` and `/doc/frotz`
     have the same effect in any `.gitignore` file, because both
     have a non-trailing slash.

> 
>> + - An asterisk "`*`" matches anything except a slash.
>> +   A pattern "foo/*", for example, matches "foo/test.json"
>> +   (a regular file), "foo/bar" (a diretory), but it does not match
>> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
>> +   patter does not match "bar/hello.c" which has a slash in it.
> 
> s/patter/&n/
> 
>> +   The character "`?`" matches any one character except "`/`".
>> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
>> +   one of the characters in a range. See fnmatch(3) and the
>> +   FNM_PATHNAME flag for a more detailed description.
>>   
>>    - A leading slash matches the beginning of the pathname.
>>      For example, "/{asterisk}.c" matches "cat-file.c" but not
> 
> Then this last paragraph can be removed.

Agree.
-

Another thing that I noticed is that its not mentioned anywhere that the 
pattern use a slash as a directory separator (instead of a backslash), 
its only clear from the examples. Maybe its worth to mention it in the 
"PATTERN FORMAT" section. Also its maybe worth to introduce the term 
"leading slash" and "trailing slash" because they will be of importance 
of the following paragraphs. Something like this after the paragraph of "!":

     [...] for example, "\!important!.txt".

     A slash `/` is used as a directory separator.
     A leading slash (that is if the pattern begins with a slash)
     or a trailing slash (that is if the pattern ends with a slash)
     have special meaning and are explained below.

     If the pattern contains a trailing slash, it would only find
     a match with a directory. [...]





