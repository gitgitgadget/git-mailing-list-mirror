Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EEC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA616100B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhDST2y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Apr 2021 15:28:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41748 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhDST2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:28:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13JJSK1c089909
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Apr 2021 15:28:20 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jacob Keller'" <jacob.keller@gmail.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     "'Git mailing list'" <git@vger.kernel.org>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jonathan Nieder'" <jrnieder@gmail.com>,
        <albertcui@google.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        <matheus.bernardino@usp.br>
References: <YHofmWcIAidkvJiD@google.com> <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
In-Reply-To: <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
Subject: RE: RFC/Discussion - Submodule UX Improvements
Date:   Mon, 19 Apr 2021 15:28:15 -0400
Message-ID: <013401d73552$287f49e0$797ddda0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbFLMgoJsVHqAp1Cmec2AAO4rv5QHospcfqaUyivA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 19, 2021 3:15 PM, Jacob Keller wrote:
> On Fri, Apr 16, 2021 at 4:38 PM Emily Shaffer <emilyshaffer@google.com>
> wrote:
> >
> > Hi folks,
> >
> > As hinted by a couple recent patches, I'm planning on some pretty big
> > submodule work over the next 6 months or so - and Ævar pointed out to
> > me in https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com
> > that I probably should share some of those plans ahead of time. :) So
> > attached is a lightly modified version of the doc that we've been
> > working on internally at Google, focusing on what we think would be an ideal
> submodule workflow.
> >
> > I'm hoping that folks will get a chance to read some or all of it and
> > let us know what sounds cool (or sounds extremely broken). The best
> > spot to start is probably the "Overview" section, which describes what
> > the "main path" would look like for a user working on a project with
> > submodules. Most of the work that we're planning on doing is under the
> "What doesn't already work" headings.
> >
> > Thanks in advance for any time you spend reading/discussing :)
> >
> >  - Emily
> >
> > Background
> > ==========
> >
> > It's worth mentioning that the main goal that's funding this work is
> > to provide an alternative for users whose projects use repo
> > (https://source.android.com/setup/develop#repo) today. That means that
> > the main focus is to try and reach feature parity to repo for an
> > easier transition for those who want to switch. As a result, some of
> > the direction below is aimed towards learning from what has worked
> > well with repo (but hopefully more flexible for users who want to do more, or
> differently).
> >
> > There are also a few things mentioned that are specifically targeted
> > to ease use with Gerrit, which is in wide use here at Google (and
> > therefore also a consideration we need to make to keep getting paid ;) ).
> >
> > Overview
> > =======
> >
> 
> One thing that I think I didn't see covered when I scanned this, that is
> something I find difficult or annoying to resolve is using "blame"
> with submodules. I use blame a lot to do code history analysis to understand
> how something got to the way it is. (Often this helps resolve issues or bugs by
> using new context to understand why an old change was broken).
> 
> It has bothered me in the past when I try to do "git blame
> <path/to/submodule>" and I get nothing. Obviously there are ways around this:
> you can for example just log the path and get the commit that changed it most
> recently, or try to search for when the submodule was set to a given commit.
> 
> A sort of dream I had was a flow where I could do something from the parent
> like "git blame <path/to/submodule>/submodule/file" and have it present a
> blame of that files contents keyed on the *parent* commit that changed the
> submodule to have that line, as opposed to being forced to go into the
> submodule and figure out what commit introduced it and then go back to the
> parent and find out what commit changed the submodule to include that
> submodule commit.

Not going to disagree, but are you looking for the blame on the submodule ref file itself or files in the submodule? It's hard to teach git to do a blame on a one-line file.

Otherwise, and I think this is what you really are going for, teaching it to do a blame based on "git blame <path/to/submodule>/submodule/file" would be very nice and abstracts out the need for the user (or more importantly to me = scripts) to understand that a submodule is involved; however, it is opening up a very large door: "should/could we teach git to abstract submodules out of every command". This would potentially replace a significant part of the use cases for the "git submodule foreach" sub-command. In your ask, the current paradigm "cd <path/to/submodule>/submodule && git blame file" or pretty much every other command does work, but it requires the user/script to know you have a submodule in the path. So my question is: is this worth the effort? I don't have a good answer to that question. Half of my brain would like this very much/the other half is scared of the impact to the code.

Just my musings.

Randall

