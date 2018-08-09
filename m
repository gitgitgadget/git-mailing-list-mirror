Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BEA1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 13:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHIQYp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 Aug 2018 12:24:45 -0400
Received: from ao2.it ([92.243.12.208]:35795 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbeHIQYp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 12:24:45 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fnlS8-0005CL-4R; Thu, 09 Aug 2018 15:58:12 +0200
Date:   Thu, 9 Aug 2018 15:59:40 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 03/12] t7411: be nicer to future tests and really
 clean things up
Message-Id: <20180809155940.0505e6d6525d39068a5a6925@ao2.it>
In-Reply-To: <CAGZ79kYn8hCV3z7wLhG+-nOooie-PwHN7n1SrEJdka8bSHc+3w@mail.gmail.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-4-ao2@ao2.it>
        <20180802164042.28026-1-szeder.dev@gmail.com>
        <CAGZ79kYn8hCV3z7wLhG+-nOooie-PwHN7n1SrEJdka8bSHc+3w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Aug 2018 11:15:03 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Aug 2, 2018 at 9:41 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
[...]
> > >
> > > Note that test_when_finished is not used here, both to keep the current style
> > > and also because it does not work in sub-shells.
> >
> > That's true, but I think that this:
> >
> >   test_when_finished git -C super reset --hard HEAD~2
> >
> > at the very beginning of the test should work.
> 
> Yeah that is a better way to do it.
> Even better would be to have 2 of these for both tests 5 and 8,
> such that each of them could be skipped individually and any following
> tests still work fine.
>

Test 6 also relies on the error introduced in test 5.

So the options would be either to remove one commit at the time in
test 6 and 8 (with a comment in test 6 to note that the commit is from
the previous test), or to remove both the commits in test 8. I am going
to go with the former, using test_when_finished.

> > >  t/t7411-submodule-config.sh | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> > > index 0bde5850ac..248da0bc4f 100755
> > > --- a/t/t7411-submodule-config.sh
> > > +++ b/t/t7411-submodule-config.sh
> > > @@ -135,7 +135,9 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> > >                       HEAD submodule \
> > >                               >actual &&
> > >               test_cmp expect_error actual  &&
> > > -             git reset --hard HEAD^
> > > +             # Remove both the commits which add errors to .gitmodules,
> > > +             # the one from this test and the one from a previous test.
> > > +             git reset --hard HEAD~2
> 
> I am a bit hesitant to removing the commits though, as it is expected to have
> potentially broken history and submodules still working.
>

The commits which are removed only affected .gitmoudles, no "submodule
init" nor "submoudle update" is ever called after they are added, so I
don't know what problems there could be.

Would a revert be any different?

> The config --unset already fixes the gitmodules file,
> so I think we can rather do
> 
>     git commit -a -m 'now the .gitmodules file is fixed at HEAD \
>         but has a messy history'
> 
> But as I have only read up to here, not knowing what the future tests will
> bring this is all speculation at this point.

IIUC the "config --unset" is used to cause the error, not to fix it, I
am not sure I understand this point.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
