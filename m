Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939E71F453
	for <e@80x24.org>; Fri,  8 Feb 2019 08:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBHIi4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 03:38:56 -0500
Received: from gecko.sbs.de ([194.138.37.40]:51874 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 03:38:55 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 03:38:53 EST
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x188XP46015944
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 09:33:25 +0100
Received: from md1za8fc.ad001.siemens.net ([139.25.0.64])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x188XOaw003610;
        Fri, 8 Feb 2019 09:33:24 +0100
Date:   Fri, 8 Feb 2019 09:33:24 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190208093324.7b17f270@md1za8fc.ad001.siemens.net>
In-Reply-To: <20190208031746.22683-1-tmz@pobox.com>
References: <20190208031746.22683-1-tmz@pobox.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

both patches look good to me. Killing the agent once should be enough,
i remember manually killing it many times as i was looking for a way to
generate certs and trust (configure gpgsm for the test). That is
probably why i copied it over in the first place.

Henning

Am Thu, 7 Feb 2019 22:17:44 -0500
schrieb Todd Zullinger <tmz@pobox.com>:

> Hi,
> 
> Looking through the build logs for the fedora git packages, I noticed
> it was missing the GPGSM prereq.  I added the necessary package to the
> build requirements but GPGSM was still failing to be set.  This turned
> out to be due to a use of ${GNUPGHOME} without quoting, which leads
> to a non-zero exit from echo and the end of the happy && chain when
> using bash as the test shell.  Fixing this allows the GPGSM test
> prereq to be set.
> 
> While I was poking around I also saw an extra gpgconf call to kill
> gpg-agent.  This was copied from the GPG block earlier in lib-gpg.sh,
> but should not be needed (as far as I can tell).  I don't think it can
> cause any real harm apart from causing gpg and gpgsm to start the
> agent more often than necessary.  But I didn't run the tests with the
> --stress option to look for potential issues that could be more
> serious.
> 
> Lastly, the GPG test prereq was failing in two of the tests where it
> was used, t5573-pull-verify-signatures and
> t7612-merge-verify-signatures.  I tracked this down to an annoying
> issue with gnugp-2¹, which recently became the default /bin/gpg in
> fedora².
> 
> Using gnupg2 as /bin/gpg means using gpg-agent by default.  When
> using a non-standard GNUPGHOME, gpg-agent defaults to putting its
> socket files in GNUPGHOME and fails if the path for any of them is
> longer than sun_path (108 chars on linux, 104 on OpenBSD and FreeBSD,
> and likely similar on other unices).
> 
> When building in the typical fedora build tool (mock), the path to the
> git test dir is "/builddir/build/BUILD/git-2.20.1/t."  That path then
> has "trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX" appended and a
> "gpghome" directory within.  For t5573 and t7612, the gpg-agent socket
> path for S.gpg-agent.browser exceeds the sun_path limit and gpg-agent
> fails to start.  Sadly, this is handled poorly by gpg and makes the
> tests fail to set either the GPG or GPGSM prereqs.
> 
> For the fedora packages, I decided to pass --root=/tmp/git-t.XXXX (via
> mktemp, of course) to the test suite which ensures a path short enough
> to keep gpg-agent happy.
> 
> I don't know if there are other packagers or builders who run into
> this, so maybe it's not worth much effort to try and have the test
> suite cope better.  It took me longer than I would have liked to
> track it down, so I thought I'd mention it in case anyone else has
> run into this or has thoughts on how to improve lib-gpg.sh while
> waiting for GnuPG to improve this area.
> 
> A GIT_TEST_GNUPGHOME_ROOT var to set the root path for the GNUPGHOME
> dirs in the tests is one thought I had, but didn't try to put it into
> patch form.  Setting the --root test option is probably enough control
> for most cases.
> 
> ¹ https://dev.gnupg.org/T2964
> ²
> https://fedoraproject.org/wiki/Changes/GnuPG2_as_default_GPG_implementation
> 
> Todd Zullinger (2):
>   t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
>   t/lib-gpg: drop redundant killing of gpg-agent
> 
>  t/lib-gpg.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

