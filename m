Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DA71F462
	for <e@80x24.org>; Mon, 17 Jun 2019 21:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfFQVgU (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 17:36:20 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:19811 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfFQVVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 17:21:36 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id cz4HhjIgMniZTcz4IhIZbB; Mon, 17 Jun 2019 22:21:34 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=Ew9TdX-QAAAA:8 a=JlxFSgI3AAAA:8
 a=BdkfJp-5pNBO2YI523QA:9 a=BEnMfZkRMD0jgplH:21 a=cSaR3M5QUnH4rnIh:21
 a=QEXdDO2ut3YA:10 a=wl115X_wuvoA:10 a=MY9urf3tlLUA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=obabQ9O6v7JZJTLIbnk7:22 a=QhaoaRRJkptday4GwVIL:22
Subject: Re: Deadname rewriting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, CB Bailey <cb@hashpling.org>
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
 <87sgsb8dmx.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <95cde058-37b3-a168-ff45-97f9501305a0@iee.org>
Date:   Mon, 17 Jun 2019 22:21:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87sgsb8dmx.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFsIWKXCj4wQJ+r5z3a9lDR0BQwcBM6XZcRxlWw2Kw+xp5CBoiUfXRrvIafnJmjvz1mpXp+udAlLTW9ekQoufvOuXD255fLCAr4rlNaA6K2bbygX9SYJ
 zMOnKJpbyebkJGMiz7m2jvFejw6SGMpfiQyuA+2bYUtjBuW4/lWuFa+9GE7VU2ZRanNOA2R2FbM1bFydvzhrJjFsgN1EG5eyxQDKmBRjRy+x0Yi+kV1w6uXt
 rwipppsGSKGgl6ognOUpAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2019 09:19, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Jun 15 2019, Phil Hord wrote:
>
>> I know name-scrubbing is already covered in filter-branch and other
>> places. But we have a scenario becoming more common that makes it a
>> more sensitive topic.
>>
>> At $work we have a long time employee who has changed their name from
>> Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
>> is prone to be offended if they do.  This is called "deadnaming".
>>
>> We are able to convince most of our work tools to expunge the deadname
>> from usage anywhere, but git stubbornly calls Bob "Alice" whenever
>> someone asks for "git blame" or checks in "git log".
>>
>> We could rewrite history with filter-branch, but that's quite
>> disruptive.  I found some alternatives.
>>
>> .mailmap seems perfect for this task, but it doesn't work everywhere
>> (blame, log, etc.).  Also, it requires the deadname to be forever
>> proclaimed in the .mailmap file itself.
>>
>> `git replace` works rather nicely, except all of Bob's old commits
>> show "replaced" in the decorator list. Also, it doesn't propagate well
>> from the central server since `refs/replaces` namespace isn't fetched
>> normally.  But in case anyone wants it, here's what I did:
>>
>> git log --author=alice.smith --format="%h" --all |
>>     while read hash ; do
>>        GIT_EDITOR='sed -i -e s/Alice Smith/Bob Smith/g' -e
>> 's/alice.smith/bob.smith/' \
>>        git replace --edit $hash
>>     done
>> git push origin 'refs/replace/*:refs/replace/*'
>>
>> I'd quite like the .mailmap solution to work, and I might flesh that
>> out that some day.
>>
>> It feels like `.git/info/grafts` would work the best if it could be
>> distributed with the project, but I'm pretty sure that's a non-starter
>> for many reasons.
>>
>> Any other ideas?  Has anyone here encountered this already?
> What should be done is to extend the .mailmap support to other
> cases. I.e. make tools like blame, shortlog etc. show the equivalent of
> %aN and %aE by default.
>
> This topic was discussed at the last git contributor summit (brought up
> by CB Bailey) resulting in this patch, which I see didn't make it in &
> needs to be resurrected again:
> https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/
>
> So, patches welcome :)
>
> What's not going to be supported is some notion of 100% forgetting that
> there was ever an Alice that's now called Bob. They did in fact create
> commit objects with "Alice" in them, and low-level plumbing like
> "cat-file -p <commit>" is always going to show that, and there's going
> to be the mapping in .mailmap.
>
> But as far as porcelain UI things that would show the mailmapped value
> goes those can be made to always show "Bob".
>
> Unless of course your $work is willing to completely rewrite the repo...
This may become a bigger issue for corporates that prevents Git from 
being used because it doesn't handle the _legal requirements_ for proper 
current `known-by:` naming.

I found this [1] on the UK Parliament website that also covers 
'deadnaming', and the potential misunderstandings about what is (and is 
not) a (unnecessary) 'legal name'.

It may be an option for the SHA1 transition to also include, as an 
independent step, the appropriate mailmap conversion for dead-names 
(which is a private document owned by the hosting repo owner - see GDPR 
Data Controller responsibilities).

If author/committer renaming is done as part of a full hash conversion 
(with a golden repo providing hash mapping) then it is less of a problem 
for a one-shot conversion, but still an issue for everyday name changes 
(including those from divorce, adoption, etc). Maybe even convert (swap) 
the ascii/utf-8 names for unique hashes (in the repo) for reverse look 
up of the latest known-by name (getting a bit complicated here)

The distributed nature of the classic Git open source usage may have 
similar issues to that of gmane, where it pulled the hosting of email 
lists. A legal case is likely needed before any level of clarification 
is obtained (which will still have overlaps!)

The mailmap is probably not the right place for holding deadname 
conversions as they should not be public, but it may be a partial 
workaround to reduce visibility of deadnames.

Philip

[1] 
https://publications.parliament.uk/pa/cm201516/cmselect/cmwomeq/390/39009.htm
