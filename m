Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A14C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351689AbiFUNT6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Jun 2022 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351572AbiFUNTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:19:37 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3C28E17
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:19:00 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25LDIsjE024331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Jun 2022 09:18:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Stephen Smith'" <ischis2@cox.net>
Cc:     "'git'" <git@vger.kernel.org>, "'Jeff King'" <peff@peff.org>
References: <12011256.O9o76ZdvQC@thunderbird> <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
Subject: RE: SHA-256 transition
Date:   Tue, 21 Jun 2022 09:18:49 -0400
Organization: Nexbridge Inc.
Message-ID: <011f01d88571$755df480$6019dd80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKdzPESrq0KdVHDZKCsGYSrLnv73gEu09Ihq8XPkgA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 21, 2022 6:25 AM, Ævar Arnfjörð Bjarmason wrote:
>On Mon, Jun 20 2022, Stephen Smith wrote:
>
>> What is the current status of the SHA-1 to SHA-256 transition?   Is the
>> transition far enough along that users should start changing over to
>> the new format?
>
>Just my 0.02, not the official project line or anything:
>
>I wouldn't recommend that anyone use it for anything serious at the moment, as
>far as I can tell the only users (if any) are currently
>(some) people work on git itself.
>
>The status of it is, I think it's fair to say, that it /should/ work 100% (or at least
>99.99%?) as far as git itself is concerned.
>
>I.e. you can "init" a SHA-256 repository, all our in-repo tooling etc. will work with it.
>We run full CI tests with a SHA-256 test suite, and it's passing.
>
>But the reason I'd still say "no" on the technical/UX side is:
>
> * The inter-op between SHA-256 and SHA-1 repositories is still
>   nonexistent, except for a one-off import. I.e. we don't have any
>   graceful way to migrate an existing repository.
>
> * For new repositories I think you'll probably want to eventually push
>   it to one of the online git hosting providers, none of which (as far
>   as I'm aware) support SHA-256 repos.
>
> * Even if not, any local git tooling that's not part of git.git is
>   likely to break, often for trivial reasons like expecting SHA-1 sized
>   hashes in the output, but if you start using it for your repositories
>   and use such tools you're very likely to be the first person to run
>   into bugs in those areas.
>
>But more importantly (and note that these views are definitely *not* shared by
>some other project members, so take it with a grain of salt):
>There just isn't any compelling selling point to migrate to SHA-256 in the near or
>foreseeable future for a given individual user of git.
>
>The reason we started the SHA-1 -> $newhash (it wasn't known that it would be
>SHA-256 at the time) was in response to https://shattered.io; Although it had
>been discussed before, e.g. the thread starting at [1] in 2012.
>
>We've since migrated our default hash function from SHA-1 to SHA-1DC (except
>on vanilla OSX, see [2]). It's a variant SHA-1 that detects the SHAttered attack
>implemented by the same researchers. I'm not aware of a current viable SHA-1
>collision against the variant of SHA-1 that we actually use these days.
>
>But even assuming for the sake of argument that we were using a much weaker
>and easier to break hash (say MD4 or MD5) most users still wouldn't have much or
>anything to worry about in practice.
>
>Discovering a hash collision is only the first step in attacking a Git repository. This
>aspect has been discussed many times on-list, but e.g. [3] is one such thread.
>
>The above is really *not* meant to poo-poo the whole notion of switching to a
>new hash. We're making good progress on it, although I think the really hard part
>UX-wise is left (online migration).
>
>Likewise I'd be really surprised if given the progress of that work the average Git
>user isn't going to be using not-SHA-1 with Git in 15-20 years, of it's even still
>around at that time as a relevant VCS.
>
>But should even advanced git users be spending time on migrating their data at
>this point?
>
>No, I don't think so given all of the above, and I really think we should carefully
>consider all of the trade-offs involved before recommending that the average
>user of git migrate over.
>
>1.
>https://lore.kernel.org/git/CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47E
>QDE+DiUQ@mail.gmail.com/
>2. https://lore.kernel.org/git/cover-0.5-00000000000-20220422T094624Z-
>avarab@gmail.com/
>3. https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-
>VtKZeKM5q9mhyCR7dwGg@mail.gmail.com/
>

Adding my own 0.02, what some of us are facing is resistance to adopting git in our or client organizations because of the presence of SHA-1. There are organizations where SHA-1 is blanket banned across the board - regardless of its use. While it is sometimes possible to educate of out the situation, as above, and show that SHA-1 is not really vulnerable except as above, which arguably applies to any hash given enough computing power, and in in-flight communication scenarios and cryptographic use.  Getting around this blanket ban is a serious amount of work and I have very recently seen customers move to older much less functional (or useful) VCS platforms just because of SHA-1.

I also think the comment about git in 15-20 years is a bit concerning if we are making decisions on that basis. Having written code in the mid 1980s that is still alive and relevant today, once processes are put in place, customers are very reluctant to move. I expect git to continue to be relevant for a long time, particularly if it is actively maintained by a motivated team.

IMO, the SHA-1 to SHA-256 (or other hash) migration should receive more attention, which I am willing to give, but I think it requires a deeper discussion. Arguably, if GitHub were to offer SHA-256 repos, I am 99% certain you will see much wider adoption.

--Randall

