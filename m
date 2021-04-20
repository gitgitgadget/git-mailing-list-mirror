Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E15C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD03613E2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhDTTiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:38:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27287 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhDTTix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:38:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13KJcIfq050680
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Apr 2021 15:38:19 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Jacob Keller'" <jacob.keller@gmail.com>
Cc:     "'Git mailing list'" <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Albert Cui'" <albertcui@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Matheus Tavares Bernardino'" <matheus.bernardino@usp.br>
References: <YHofmWcIAidkvJiD@google.com> <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com> <013401d73552$287f49e0$797ddda0$@nexbridge.com> <CA+P7+xrOuhG5ujQRYS0=o7S9=xD5zm6BGp5mBRt493Lme9xYcw@mail.gmail.com> <YH8hxQKarZW6sU+9@google.com>
In-Reply-To: <YH8hxQKarZW6sU+9@google.com>
Subject: RE: RFC/Discussion - Submodule UX Improvements
Date:   Tue, 20 Apr 2021 15:38:13 -0400
Message-ID: <01a001d7361c$b73c8560$25b59020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbFLMgoJsVHqAp1Cmec2AAO4rv5QHospcfAHjTQh0BBs2iNAHXPLMaqYwRPRA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 20, 2021 2:48 PM, Emily Shaffer wrote:
> On Tue, Apr 20, 2021 at 09:18:05AM -0700, Jacob Keller wrote:
> >
> > On Mon, Apr 19, 2021 at 12:28 PM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> > > On April 19, 2021 3:15 PM, Jacob Keller wrote:
> > > > A sort of dream I had was a flow where I could do something from
> > > > the parent like "git blame <path/to/submodule>/submodule/file" and
> > > > have it present a blame of that files contents keyed on the
> > > > *parent* commit that changed the submodule to have that line, as
> > > > opposed to being forced to go into the submodule and figure out
> > > > what commit introduced it and then go back to the parent and find
> > > > out what commit changed the submodule to include that submodule
> commit.
> > >
> > > Not going to disagree, but are you looking for the blame on the
submodule
> ref file itself or files in the submodule? It's hard to teach git to do a
blame on a
> one-line file.
> > >
> >
> > Well, I would like if "git blame <path/to/submodule>" did.. something
> > other than just fail. Sometimes my brain is working in a "blame where
> > this came from" and I type that out and then get frustrated when it
> > fails. Additionally...
> >
> > > Otherwise, and I think this is what you really are going for, teaching
it to do
> a blame based on "git blame <path/to/submodule>/submodule/file" would be
> very nice and abstracts out the need for the user (or more importantly to
me =
> scripts) to understand that a submodule is involved; however, it is
opening up a
> very large door: "should/could we teach git to abstract submodules out of
every
> command". This would potentially replace a significant part of the use
cases for
> the "git submodule foreach" sub-command. In your ask, the current paradigm
> "cd <path/to/submodule>/submodule && git blame file" or pretty much every
> other command does work, but it requires the user/script to know you have
a
> submodule in the path. So my question is: is this worth the effort? I
don't have a
> good answer to that question. Half of my brain would like this very
much/the
> other half is scared of the impact to the code.
> > >
> > > Just my musings.
> >
> > I'm not asking for "git blame <path/to/submodule>/<file>" to give the
> > the same outout as "cd <path/to/submodule> && git blame <file>"
> >
> > What i'm asking is: given this file, tell me which commit in the
> > parent did the line get introduced. So basically I want to walk over
> > the changes to the submodule pointer and find out when it get
> > introduced into the parent, not when it got introduced into the
> > submodule itself.
> >
> > This is a related question, but it is actually not trivial to go
> > instantly from "it was in xyz submodule commit" to "it was then pulled
> > in by xyz parent commit". It's something that is quite tedious to do
> > manually, especially since the submodule pointer could change
> > arbitrarily so knowing the submodule commit doesn't mean you can
> > simply grep for which commit set the submodule exactly to that commit.
> > Essentially, I want a 'git blame' that ignores all changes which
> > aren't actually the submodule pointer, update.
> >
> > I think that's something that is much harder to do manually, but feels
> > like it should be relatively simple to implement within the blame
> > algorithm. I don't feel like this is something strictly replaceable by
> > "git submodule foreach"
> 
> I think I understand what you're saying. Something like the following
> tree:
> 
> super   sub
> b------->4
>          3
>          2
> a------->1
> 
> producing something like this:
> 
> 'git -C sub blame main.c'
> 
> 1 AU Thor	2020-01-01
> 2 CO Mitter	2020-01-02		int main() {
> 4 AU Thor	2020-01-04		  printf("Hello world!\n");
> 3 Dev E		2020-01-03		  return 0;
> 2 CO Mitter	2020-01-02		}
> 
> and
> 'git blame sub/main.c'
> 
> a Mai N		2020-01-01
> b Senior Dev	2020-01-04		int main() {
> b Senior Dev	2020-01-04		  printf("Hello world!\n");
> b Senior Dev	2020-01-04		  return 0;
> b Senior Dev	2020-01-04		}
> 
> or to put it another way: if we are treating superproject commit as "the
whole
> feature", then it could be useful to see "which feature added this change"
> instead of "which atomic commit inside a feature added this change".
> 
> To me, it sounds expensive to compute... wouldn't you  need to say, for
each
> blame line, "is this commit an ancestor of the commit associated in THIS
> superproject commit? ...how about the next superproject commit?"
> But I also don't have much experience with the blame implementation so
> maybe I'm thinking naively :) :)
> 
> And even if it is expensive, considering that Jacob and Randall both had
> different ideas of what their ideal 'git blame' recursive behavior would
be,
> maybe it makes sense to use a flag to ask for the more expensive behavior,
e.g.
> 'git blame --show-superproject-commit sub/main.c'?

I was partly trying to figure out which path Jacob was requesting and "both"
seem useful to me. Looking at our own super-repo history and comparing what
is in one specific submodule, we have the commit on the submodule ref file
flipping repeatedly between two commits during a period of time (in
timestamp order) where an there were multiple submodule topic branches in
parallel with super-repo topic branches. I'm not saying that was a good
thing, just the reality of one particular icky submodule. Once back on the
main branch, things moved to something rational, but a blame of changing
submodule contents of sub/main.c --show-superproject-commit would lead to
something inherently non-deterministic until the topic branches are all
pruned and/or merged, at least in this degenerative situation. After the
merge, everything was back to deterministic and simple to compute.

Randall

