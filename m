Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E78F1F424
	for <e@80x24.org>; Wed, 28 Mar 2018 08:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeC1IIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 04:08:07 -0400
Received: from e1i290.smtp2go.com ([103.36.109.34]:48002 "EHLO
        e1i290.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeC1IIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 04:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1522225385; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=HJWnyGJ1L2GWgg4Wtho395K3NOj8nparkb3tcHXT9gk=; b=F+HpXNNm
        IALUJcWVJoef34ZYXyWfjWK4ft1FJ0u2WD413DLGWSyo7u5JHhRPUakQ5zGxfcjhFVtXx7iVlItWz
        lJTxv/XyneuKRWdI53HgLRejtcX/KnkyF3a41yRoCRmJ1qfvvIcZ4e61MCl1BwJST3z8AmnKvUBfZ
        krDZ9cCsvwCYjXAXQD0DnUkvhJMwmADb7R5fp6oXkphnoQCx60orVThVKitBQaVK5Wvo6p9WpBnil
        XdBWzqvWrEhJi895b+lJ09BpevlnTaKzYiY3g+E8vAbPjBJYSEp6cqMkVb9kcaVLPFP7MhDFzMzP5
        G9W3WMBtXfeFatneTLbWXTnEgw==;
Message-ID: <D4DCD9C1E17B4AD5AFB501B8FADA02BB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Jason Frey" <jfrey@redhat.com>
Cc:     <git@vger.kernel.org>, "Stefan Beller" <sbeller@google.com>
References: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com> <87r2o5w5mn.fsf@evledraar.gmail.com>
Subject: Re: Bug: duplicate sections in .git/config after remote removal
Date:   Wed, 28 Mar 2018 08:54:09 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1f15vur_ZHbrSw.I2pMAydF1
Feedback-ID: 66524m:66524aMf6O2Y:66524s05ewz12Um:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
> On Tue, Mar 27 2018, Jason Frey wrote:
>
>> While the impact of this bug is minimal, and git itself is not
>> affected, it can affect external tools that want to read the
>> .git/config file, expecting unique section names.
>>
>> To reproduce:
>>
>> Given the following example .git/config file (I am leaving out the
>> [core] section for brevity):
>>
>>     [remote "origin"]
>>         url = git@github.com:Fryguy/example.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>     [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>>
>> Running `git remote rm origin` will result in the following contents:
>>
>>     [branch "master"]
>>
>> Running `git remote add origin git@github.com:Fryguy/example.git` will
>> result in the following contents:
>>
>>     [branch "master"]
>>     [remote "origin"]
>>         url = git@github.com:Fryguy/example.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> And finally, running `git fetch origin; git branch -u origin/master`
>> will result in the following contents:
>>
>>     [branch "master"]
>>     [remote "origin"]
>>         url = git@github.com:Fryguy/example.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>     [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>>
>> at which point you can see the duplicate sections (even though one is
>> empty).  Also note that if you do the steps again, you will be left
>> with 3 sections, 2 of which are empty.  This process can be repeated
>> over and over.
>
> This can be annoying and result in some very verbose config files when
> we automatically edit them, e.g.:
>
>    (rm -v /tmp/test.ini; for i in {1..3}; do git config -f /tmp/test.ini 
> foo.bar 0 && git config -f /tmp/test.ini --unset foo.bar; done; cat 
> /tmp/test.ini)
>    removed '/tmp/test.ini'
>    [foo]
>    [foo]
>    [foo]
>
> But it's not so clear that it should be called a bug, yes we could be a
> bit smarter and not add obvious crap like the example above (duplicate
> sections at the end), but it gets less obvious in more complex cases,
> see my c8b2cec09e ("branch: add test for -m renaming multiple config
> sections", 2017-06-18) for one such example.
>
> Git has a config format that's hybrid human/machine editable. Consider a
> case like:
>
>    [gc]
>    ;; Here's all the gc config we set up to avoid the great outage of 2015
>    autoDetach = false
>    ;; Our aliases
>    [alias]
>    st = status
>
> Now, if I run `git config gc.auto 0` is it better if we end up with:
>
>    [gc]
>    ;; Here's all the gc config we set up to avoid the great outage of 2015
>    autoDetach = false
>    auto = 0
>    ;; Our aliases
>    [alias]
>    st = status
>
> Or something that makes it more clear that a machine added something at
> the end:
>
>    [gc]
>    ;; Here's all the gc config we set up to avoid the great outage of 2015
>    autoDetach = false
>    ;; Our aliases
>    [alias]
>    st = status
>    [gc]
>    auto = 0
>
> Most importantly though, regardless of what we decide to do when we
> machine-edit the file, it's also human-editable, and being able to
> repeat sections is part of our config format that you're simply going to
> have to deal with.

One option may be to create  a simple 'lint' style checker that simply 
hiughlights and suggests options so the user can decide for themselves what 
they need to do. This would help span the gap between hard format and the 
soft format capabiulities of machine readable ini files, the Git config 
reader and being human readable.

Thus duplicate sections would be noted, likewise the presence of comments 
immediately preceding a section header, or terminating a section (with or 
without spacing?), etc.Such a config_lint could reside in the contrib as a 
supprt tool, and may in the long term be a guide to a common format. 
However, as noted, it would be more of a long term aspiration..


>
> The external tool (presumably some generic *.ini parser) you're trying
> to point at git's config is broken for that purpose if it doesn't handle
> duplicate sections. You're probably better off trying to parse `git
> config --list --null` than trying to make it work.
>
> I don't think we'd ever want to get rid of this feature, it's *very*
> useful. Both for config via the include macro, and for people to
> manually paste some config they want to try out to the end of their
> config, without having to manually edit it to incorporate it into their
> already existing sections.
>

--
Philip 

