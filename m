Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC2C636D3
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBEVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 16:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBEVdb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 16:33:31 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED9EC7F
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 13:33:29 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4P92gn0ZXzz5tlC;
        Sun,  5 Feb 2023 22:33:24 +0100 (CET)
Message-ID: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
Date:   Sun, 5 Feb 2023 22:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/3] userdiff: Java updates
Content-Language: en-US
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        git@vger.kernel.org, Tassilo Horn <tsdh@gnu.org>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
 <45830cf4-41c1-0bc1-3e4e-26b9f713f452@kdbg.org>
 <6ca6ebf0-b357-e1d0-4866-dd04a5f987ad@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6ca6ebf0-b357-e1d0-4866-dd04a5f987ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.23 um 20:27 schrieb Andrei Rybak:
> On 2023-02-05T11:09, Johannes Sixt wrote:
>> Am 04.02.23 um 14:43 schrieb Andrei Rybak:
>>> On 04/02/2023 10:22, Tassilo Horn wrote:
>>>> Thanks for including me being the last contributor to java userdiff.
>>>> The patches look good from my POV and are safe-guarded with tests, so
>>>> I'm all for it.
>>>
>>> Thank you for review!
>>>
>>> I've realized that I've been writing modifiers "abstract" and
>>> "sealed" in a
>>> technically correct, but not the conventional order.  Here's a reroll
>>> with the
>>> order of modifiers following the style of original authors of
>>> https://openjdk.org/jeps/409.  It doesn't matter for the purposes of
>>> the test,
>>> but it will be less annoying to any future readers :-)
>>
>> I've looked through the patches and run the tests, and they all make
>> sense to me. By just looking at the patch text I noted that no
>> whitespace between the identifier and the opening angle bracket is
>> permitted and whether it should be allowed, but the commit messages make
>> quite clear that whitespace is not allowed in this position.
> 
> There is some kind of misunderstanding.  I guess the wording in commit
> messages of the first and second patches could have been clearer.
> 
> In Java, whitespace is allowed between type name and the brackets.
> It is permitted both for angle brackets of type parameters:
> 
>     class SpacesBeforeTypeParameters         <A, B> {
>     }
> 
> and for round brackets of components in records:
> 
>     record SpacesBeforeComponents      (String comp1, int comp2) {
>     }
> 
> The common convention, is however, to omit the whitespace before the
> brackets.
> 
> The regular expression on branch master already allows for whitespace
> after the name of the type:
> 
>     "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[
> \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
>                                                                               ^^^^^^
> so I didn't need to cover this case.  Note that it requires a non-zero
> amount of whitespace. This part of the regular expression was left as
> is (v2 after patch 3/3):
> 
>     "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[
> \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
>                                                                                        ^^^^^^
> 
> 
> That being said, I guess it would be an improvement to also allow
> the name of the type be followed by the end of the line, for users
> with fairly common code style that puts braces on separate lines:
> 
>     class WithLineBreakBeforeOpeningBrace
>     {
>     }
> 
> or `extends` and `implements` clauses after a line break:
> 
>     class ExtendsOnSeparateLine
>         extends Number
>         implements Serializable
>     {
>     }
> 
> even type parameters:
> 
>     class TypeParametersOnSeparateLine
>         <A, B>
>     {
>     }
> 
> Something like the following:
> 
>     "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[
> \t]+[A-Za-z][A-Za-z0-9_$]*(([ \t]+|[<(]).*)?)$\n"
>                                                                                       ^               ^^
> perhaps? Technically, the following is also valid Java:
> 
>     class WithComment//comment immediately after class name
>     {
>     }
> 
> but I'm not sure if allowing it is needed.  If so, we might as well just
> do this:
> 
>     "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[
> \t]+[A-Za-z][A-Za-z0-9_$]*.*)$\n"
>                                                                                       ^^

Having seen all these examples, I think the following truncated
expression might do the right thing for all cases that are valid Java:

"^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t].*)$"

i.e., we recognize a whitespace in order to identify the keyword, and
then capture anything that follows without being specific. My reasoning
is that "class", "enum", "interface", and "record" cannot occur in any
other context than the beginning of a class definition. (But please do
correct me; I know next to nothing about Java syntax.) As always,
userdiff regular expressions can assume that only valid constructs are
inspected.

-- Hannes

