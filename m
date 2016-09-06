Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188461F859
	for <e@80x24.org>; Tue,  6 Sep 2016 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbcIFLig (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 07:38:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:57725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932843AbcIFLif (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 07:38:35 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mb8HX-1bNDop2FsB-00Kcu3; Tue, 06 Sep 2016 13:38:24
 +0200
Date:   Tue, 6 Sep 2016 13:38:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     larsxschneider@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        tboegi@web.de
Subject: Re: [PATCH v1 1/2] sha1_file: open window into packfiles with
 CLOEXEC
In-Reply-To: <20160905222715.GA30031@starla>
Message-ID: <alpine.DEB.2.20.1609061333030.129229@virtualbox>
References: <20160905211111.72956-1-larsxschneider@gmail.com> <20160905211111.72956-2-larsxschneider@gmail.com> <20160905222715.GA30031@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t8kcf6uteGWIx7YyQIlPSoo1wdR0vjNBP7vZf0KFfvg85HvqtqZ
 U0FRhHVkVdfE7MNFopV7iGoT3iyaNL3XG7ekV+EJ0oxAtvguVIUJ+RkXsRoUk3EeLfTg788
 2dl5MVLx81S8PVPvwX9xcRgeXVGcz/liYf4g5bRYMjwPLzOHPmIn84gKKyC9iRcpSE/AJMT
 uOnyD7D47w2Vf3rdYs19g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZV4QxomIWmE=:lw57cvI6CahLygdl0QXSEC
 B8+dJE5IVue8/MvZIItFApUTeaghZN/Umv+eHkl1hRwts0CGORyb4EsQ5jDimvERVOE08sQNs
 Bf7fCZShX6ok3RPXRxcwwSYvP7F40eYGcBVukmIo8bhJnOeb06WSjq1ky26Ptpd1byecy3u9w
 ngZv+nquNADSzshcrsvrjVIvQLds1pztQpy/5hbRKnUKvkjv2c8A8XXn7mv2cZfZQ4TkBcV61
 gLN8uqGRRgrX9Bmf2ep9nBB7cC5Hsb+S6lhV4b6eKS3ttPop1kWkz6BDjjriqXuh1HkXUoHCK
 OFXQ67TZrznVK+Guqt+2vUStoTqYZPsv7zx0Wa59ITWsBHiseGRad+7qB/+9s0tntuBTo1ivO
 FtTuOlf2npfue3kDbtYgMDFGnvgo9gSbH5V+kJCsSpY5h+GBI+OJ6458Qcn77dYXoe7Txdj1b
 d2npfnERYzuzwklXRMFCHSV0IG8yKIYdnZpq8VUS8h9xJeCNU7viANrUG8OijInDQDoQ3HHsR
 cPhz3SeAIv2X1CZE9VVo5o7R2bQxhsLSxvao7UnVJw5a7MqCMPX4HnDUZZqo72UPoyqxOTLpq
 dxyVFfyloJAxgGOIQbel3xQH72YpfkynO+cUh9D30BnOK/mupd/mo/mvocCSLsSiJR3lqjWgY
 g1kZ/h5aaKLnCvEWruRHp0wAY/NEg1ujP3E49KlbCGPRFtgL4yCFKw/S2TKcdJm0Sw74rB31b
 4VKEEoVXFhymSzUezr95yTcuhSORhcq08laA0W5GNfVHcZLvTjOJa0T0Tn3E7SgueIsbrHUQX
 NQMlLEj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Lars,

On Mon, 5 Sep 2016, Eric Wong wrote:

> larsxschneider@gmail.com wrote:
> > All processes that the Git main process spawns inherit the open file
> > descriptors of the main process. These leaked file descriptors can
> > cause problems.
> 
> 
> > -int git_open_noatime(const char *name)
> > +int git_open_noatime_cloexec(const char *name)
> >  {
> > -	static int sha1_file_open_flag = O_NOATIME;
> > +	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
> >  
> >  	for (;;) {
> >  		int fd;
> 
> If there's real problems being caused by lack of cloexec
> today, I think the F_SETFD fallback I proposed in
> https://public-inbox.org/git/20160818173555.GA29253@starla/
> will be necessary.

Yes, it is good to have that patch available to go if we need it. I do not
think that we will need it, though, as the biggest problems that are
solved through the CLOEXEC flag are ones caused on Windows, when files
cannot be deleted or renamed because there are still (uselessly) open
handles referencing them.

> I question the need for the "_cloexec" suffixing in the
> function name since the old function is going away entirely.

Me, too. While it is correct, it makes things harder to read, so it may
even cause more harm than it does good.

> I prefer all FD-creating functions set cloexec by default
> for FD > 2 to avoid inadvertantly leaking FDs.  So we
> ought to use pipe2, accept4, socket(..., SOCK_CLOEXEC), etc...
> and fallback to the racy+slower F_SETFD when not available.

In the original Pull Request where the change was contributed to Git for
Windows, this was tested (actually, the code did not see whether fd > 2,
but simply assumed that all newly opened file descriptors would be > 2
anyway), and it failed:

https://github.com/git-for-windows/git/pull/755#issuecomment-220247972

So it appears that we would have to exclude at least the code path to `git
upload-pack` from that magic.

Ciao,
Dscho
