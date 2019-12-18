Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF518C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873952176D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLRWfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:35:04 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:46190 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:35:04 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ihhuE-00005Y-8i; Wed, 18 Dec 2019 22:34:59 +0000
Subject: Re: Ability to ignore EOL changes for certain projects
To:     Scott Richmond <scott@brightrockgames.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191218192741.ybi3xpvax7lrrubz@tb-raspi4>
 <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b4338168-50c5-8aa1-32e0-2fe96e82e9bf@iee.email>
Date:   Wed, 18 Dec 2019 22:34:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/12/2019 21:33, Scott Richmond wrote:
> Hey Torsten,
>
> Thanks for the reply!
>
> Correct me if am wrong, but those steps don't tell git to "ignore"
> line endings. That just causes git to check all text files in and out
> with a specific EOL type (Either automatically chosen, or not). If an
> app in the dev env changes a files' EOL to something else, git will
> notice the change locally.

A broader question is "how does the dev environment handle lone `CR`
characters? are they also considered as EOLs?"

If I recall previous discussions, part of the issue is determining what
the alternate abuse cases are, such as lone CRs, or alternate character
sets to the 'pure' utf-8.

You will still have the difficulty of how `identicality` is determined,
which currently uses the sha1/oid value. In essence you need a way of
ensuring that all checkins are always of one defined EOL, but then need
git to have a broader allowance of changed EOL values (including no lone
CRs that are not EOL, etc).

Does the environment (on any of the OS's) change the files in the
background, such that the file time stamps will indicate a modification?

Philip

> Regards,
>
> Scott Richmond.
>   Director, Producer, Programmer
>   Brightrock Games
>   T: 07480795661
>
> On Wed, Dec 18, 2019 at 7:27 PM Torsten Bögershausen <tboegi@web.de> wrote:
>> On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
>>> The Problem Domain
>>> In certain dev environments (Unity3D projects) there is (AFAIK) an
>>> unsolvable problem where some files are often modified with line
>>> endings that aren't the native system or not the committed line
>>> endings for that file. Secondarily, in this case line endings don't
>>> matter - Nothing in the dev environment "cares" which kind of line
>>> ending is used.
>>>
>>> The Problem
>>> Git always cares about EOL. Git has options to transparently modify
>>> EOLs when files are checked in or out. However it is not possible to
>>> tell Git to ignore EOLs in other commands:
>>> Git status shows the file modified.
>>> Merging/Pulling has to care because it can't merge with a modified
>>> working tree. Which means the user has to care - They have to either
>>> stash the EOL changes or wipe them out. Sometimes, if the user has a
>>> particular app running, it may automatically reload that file and
>>> recreate the modified EOL changes, causing an endless loop. This
>>> problem is often made unclear to the user how to solve, especially if
>>> they aren't domain experts.
>>>
>>> To be clear, in this particular dev environment, I can say with
>>> confidence that this particular issue is a major and common pain point
>>> for users. It is made worse as many users in this environment aren't
>>> programmers by trade and aren't domain experts in version control. I
>>> also believe this environment is becoming a non-trivial portion of the
>>> Git userbase and it would be worthwhile looking into resolving.
>>>
>>> Solution Request
>>> It would be fantastic if we could tell Git to stop caring about EOL
>>> changes on a per-repo basis, with the effective output being that git
>>> status shouldn't show changes for files with differing EOLs.
>>>
>>> I'm experienced with Git, though I am not expert enough to consider
>>> creating such a change myself - It is unclear to me just how
>>> complicated a change may be. However maybe I could look into it if it
>>> was made clear that this improvement is possible and has no serious
>>> side effects.
>> Hej Scott,
>> I think that you problem can be solved.
>> For each repository, you can tell Git to ignore the line endings,
>> CRLF vs LF.
>>
>> If you start with a fresh repo,
>> you can do something like:
>>
>> echo "* text=auto" >.gitattributes
>> git add .gitattributes
>> git commit -m "Add .gitattributes"
>>
>> For existing repos, we need to take another step:
>>
>> echo "* text=auto" >.gitattributes
>> git add .gitattributes
>> git add  --renormlize .
>> git commit -m "Add .gitattributes"
>>
>> More information can be found e.g. here:
>> https://git-scm.com/docs/git-add
>>
>> Once you done that, you can merge branches
>> into the master branch with help of the renormalize
>>
>> git merge -X renormalze branch-name
>>
>> See even here:
>> https://git-scm.com/docs/git-merge
>>
>>
>> This is just a (too) short introduction, I hope that it
>> helps and that you find the time to dig somewhat deeper into
>> the documentation.
>>
>> Other developers have that problem as well, you are not alone.
>>
>> If you have a public repo, I could help with one example.
>>
>>
>>> Regards,
>>>
>>> Scott Richmond.
>>>   Director, Producer, Programmer
>>>   Brightrock Games
>>>   T: 07480795661

