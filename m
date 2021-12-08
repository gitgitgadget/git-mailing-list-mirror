Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1BAC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhLHNsy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 8 Dec 2021 08:48:54 -0500
Received: from elephants.elehost.com ([216.66.27.132]:22551 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhLHNso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 08:48:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B8Dj343025280
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Dec 2021 08:45:04 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Fabian Stelzer'" <fs@gigacodes.de>
Cc:     "'Robert Coup'" <robert.coup@koordinates.com>,
        <git@vger.kernel.org>, <avarab@gmail.com>
References: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com> <CAFLLRp+yakYKxeGHjvg-8s-5QP8GqMeA5t+azfny=v6wtPPW2A@mail.gmail.com> <00b901d7eb79$c374f070$4a5ed150$@nexbridge.com> <20211208125149.enyd22nnhmvou6lr@fs>
In-Reply-To: <20211208125149.enyd22nnhmvou6lr@fs>
Subject: RE: [Question] Switching the URI from SSH to HTTPS for submodules
Date:   Wed, 8 Dec 2021 08:44:59 -0500
Organization: Nexbridge Inc.
Message-ID: <012d01d7ec39$ce3e4f40$6abaedc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLS8uQa68NLdYMjzyL1Ti0pjcbf7gMNtF3fAvC5Zf4BNcem26n455xw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 8, 2021 7:52 AM, Fabian Stelzer wrote:
> On 07.12.2021 09:50, rsbecker@nexbridge.com wrote:
> >On December 6, 2021 6:54 PM, Robert Coup wrote:
> >> On Mon, 6 Dec 2021 at 23:10, <rsbecker@nexbridge.com> wrote:
> >> >
> >> > git@bitbucket.org:project/module.git
> >> >
> >> > When in SSH mode, clones are simple with --recurse-submodules doing
> >> > what we want. However, we had to clone on a system where SSH was
> >> > locked down and we could only use HTTPS. The form of the URIs
> >> > changed
> >> rather radically:
> >> >
> >> > https://user@bitbucket.org/project/repo.git
> >> >
> >> > I'm looking for better practices than I used - I'm sure there is at least
> one.
> >>
> >> AFAIK the existing `url.<base>.insteadOf` config option[1] deals with
> this...
> >>
> >> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-
> >> urlltbasegtinsteadOf
> >>
> >>     $ git config --global url."https://user@bitbucket.org/".insteadOf
> >> "git@bitbucket.org:"
> >>
> >> If you don't want to set it globally (not a throwaway CI
> >> environment?) then you can do it as a one-off:
> >>
> >>     $ git -c
> url."https://user@bitbucket.org/".insteadOf="git@bitbucket.org:"
> >> clone --recurse-submodules git@bitbucket.org:repo/project.git
> >>
> >> But it isn't persisted into your repo config then, so subsequent
> >> fetches won't work. You'd need to persist it using something like:
> >>
> >>     $ git config url."https://user@bitbucket.org/".insteadOf
> >> "git@bitbucket.org:"
> >>     $ git submodule foreach --recursive 'git config
> >> url."https://user@bitbucket.org/".insteadOf "git@bitbucket.org:" '
> >>
> >> Maybe there's an opportunity to make that part easier?
> >
> >Well, I gave this a shot. The mapping did not appear to work - I tried
> >a few combinations. I was left with the original URIs. Note that I also
> >had to do
> >
> >$ git submodule init
> >
> >which reported the wrong URIs
> >
> >$ git submodule update
> >
> >which obviously failed since they were still using SSH.
> >
> >I think there may be something not working correctly with the insteadOf
> operator. This is easily reproduceable.
> >
> 
> I ran into this as well some time ago. For submodules this only works if you
> put it into your global config since the parent projects config is not relevant to
> the submodule.
> 
> There's some discussion in the archive about this as well:
> https://lore.kernel.org/git/404d109f-e5a7-85a3-e64c-
> ab1b21c3045d@durchholz.org/

The minimal procedure that I got to work is:

$ git config --global url."https://user@bitbucket.org/".insteadOf "git@bitbucket.org:"
$ git clone --recurse-submodules https://user@bitbucket.org/project/repo.git 

This leaves .gitmodules untouched and contains the original URIs, so the status is clean and there is no real risk of someone pushing an unwanted URI change back to the upstream repo. I don't see a major downside to leaving the redirect in global as this would be useful for subsequent clones. Any scripting that might depend on .gitmodules being correct would break - not in my case though - to that should probably be noted.

I think I have enough to document this consideration in Documentation/gitsubmodules.txt. Thanks everyone.
-Randall

