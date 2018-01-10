Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C9F1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeAJS2B convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 Jan 2018 13:28:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44911 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeAJS2B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 13:28:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0AIRreN008722
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Jan 2018 13:27:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>, "'Bill Honaker'" <bhonaker@xid.com>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>
References: <f08a9506afb73c57751d3d413bfb433a.squirrel@secure.elehost.com> <47197839-720f-3c8d-729c-3fcb615aeb36@kdbg.org> <005d01d389a7$c55da9f0$5018fdd0$@nexbridge.com> <f485f647-bff6-e219-2fc5-a2a9410b6d17@kdbg.org>
In-Reply-To: <f485f647-bff6-e219-2fc5-a2a9410b6d17@kdbg.org>
Subject: RE: [PATCH] Prototype PATH_MAX length detection in tests, demonstrated in t0001-init.sh
Date:   Wed, 10 Jan 2018 13:27:47 -0500
Message-ID: <00e501d38a40$ba8f4d50$2fade7f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIsbxSdIT0HX8bTkZvBsKb6qpXvfgHeGaYPAh+I5qUBWDvO4qKQ8+Rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 10, 2018 1:16 PM, Johannes Sixt wrote:
> Am 10.01.2018 um 01:12 schrieb Randall S. Becker:
> > On January 9, 2018 6:01 PM, Johannes Sixt wrote:
> > I'm encountering strange warnings, while looking into the details of what
> test t0001 fails in spots. These include:
> > #24 warning: templates not found x00000000000000...[lots of 0
> > deleted...]00000000000000000000 which exceeds 2K, but that's just
> content, right, and not causing an apparent breakage.
> 
> This warning occurs also on Linux and Windows. I think it is by design and
> not something to be fixed.
> 
> >
> > # 34. Admittedly it was shorter than 2K, but there is something weird in this
> path that I can't find, causing a failure out of fts_read from gnulib.
> > Initialized empty Git repository in /home/ituglib/randall/git/t/trash
> > directory.t0001-
> init/123456789abcdef/123456789abcdef/123456789abcdef/1
> >
> 23456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/123
> 4567
> > 89abcdef/newdir/.git/
> > rm: fts_read failed: No such file or directory
> >
> > This error is coming from some of shell utilities (in this case rm)
> > used in the test rather than git code itself.
> 
> So, the problem is not in the git executable. This does not warrant a change
> in the build process, yet.
> 
> >  While well within the
> > supported path length of the operating system/platform (1K), there is
> > an acknowledged issue that is causing breakage when paths get large
> > enough (even only this large, unfortunately). We're at 221 breaks out
> > of 12982-ish, which is good, but have to otherwise visually check each
> > breakage until the fts_read problem is resolved - I know what the
> > issue is, but I don't have the auth to resolve it, so waiting on HPE
> > platform development for that. Of course, manually patching that many
> > breaks is equally unwieldy, so I'm willing to tolerate not having this
> > patch applied at this time.
> 
> Let me propose a different workaround. In my build on Windows, I inject a
> few blind spots in the test suite using GIT_SKIP_TESTS for cases where I do
> not have time to find a fix. It looks like this:
> 
> diff --git a/t/Makefile b/t/Makefile
> index 96317a35f4..fd8b18c3c0 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -103,3 +103,19 @@ perf:
>  	$(MAKE) -C perf/ all
> 
>  .PHONY: pre-clean $(T) aggregate-results clean valgrind perf
> +
> +# see
> +https://public-inbox.org/git/alpine.DEB.2.21.1.1710260008270.37495@virt
> +ualbox/ # the suggested solution is for MSYS2; don't have time to fix
> +this for MSYS GIT_SKIP_TESTS += t0021.1[5-9] t0021.2[0-6] # special
> +file names GIT_SKIP_TESTS += t1300.14[02] # GIT_SSH_COMMAND with args
> +forwarded incompletely via git clone to test_fake_ssh GIT_SKIP_TESTS +=
> +t5601.5[01] # unknown failure in shallow submodule test GIT_SKIP_TESTS
> ++= t7406.46 # mktemp missing?
> +GIT_SKIP_TESTS += t7610.22
> +export GIT_SKIP_TESTS
> +
> +NO_SVN_TESTS=SkipThem
> +export NO_SVN_TESTS
> --
> 
> Build the list of test cases that do not pass, until the test suite runs through.
> Then start fixing the cases.
> 
> It is not foolproof, but very effective in keeping the focus on new cases. You
> have to run tests with 'make' so that the variable is picked up. Also, when
> somebody adds new tests in front of the mentioned cases, the numbers
> must be adjusted.

I can live with this. Thanks for your advice. Let's hold off on applying my approach.

Cheers,
Randall

