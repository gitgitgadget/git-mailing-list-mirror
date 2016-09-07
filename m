Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7563620712
	for <e@80x24.org>; Wed,  7 Sep 2016 18:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757976AbcIGSRu (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:17:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56172 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757633AbcIGSRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:17:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A095E2070F;
        Wed,  7 Sep 2016 18:17:47 +0000 (UTC)
Date:   Wed, 7 Sep 2016 18:17:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, tboegi@web.de
Subject: Re: [PATCH v1 1/2] sha1_file: open window into packfiles with CLOEXEC
Message-ID: <20160907181747.GB14931@starla>
References: <20160905211111.72956-1-larsxschneider@gmail.com>
 <20160905211111.72956-2-larsxschneider@gmail.com>
 <20160905222715.GA30031@starla>
 <alpine.DEB.2.20.1609061333030.129229@virtualbox>
 <F8E7B7CE-1177-4CBD-999E-21C593A8ACD2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F8E7B7CE-1177-4CBD-999E-21C593A8ACD2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 06 Sep 2016, at 13:38, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > On Mon, 5 Sep 2016, Eric Wong wrote:
> >> larsxschneider@gmail.com wrote:
> >>> -int git_open_noatime(const char *name)
> >>> +int git_open_noatime_cloexec(const char *name)
> >>> {
> >>> -	static int sha1_file_open_flag = O_NOATIME;
> >>> +	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
> >>> 
> >>> 	for (;;) {
> >>> 		int fd;
> > 
> >> I question the need for the "_cloexec" suffixing in the
> >> function name since the old function is going away entirely.
> > 
> > Me, too. While it is correct, it makes things harder to read, so it may
> > even cause more harm than it does good.
> 
> What name would you suggest? Leaving the name as-is seems misleading to me.
> Maybe just "git_open()" ?

Maybe "_noatime" is useful in some cases, but maybe not *shrug*

My original point for removing the "_cloexec" suffix was that
(at least for Perl and Ruby), cloexec-by-default was so prevalent
in FD-creating syscalls that having the suffix wasn't needed.

> >> I prefer all FD-creating functions set cloexec by default
> >> for FD > 2 to avoid inadvertantly leaking FDs.  So we
> >> ought to use pipe2, accept4, socket(..., SOCK_CLOEXEC), etc...
> >> and fallback to the racy+slower F_SETFD when not available.


> I applied the same mechanism here. Would that be OK?
> 
> Thanks,
> Lars
> 
> -       static int sha1_file_open_flag = O_NOATIME;
> +       static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
> 
>         for (;;) {
>                 int fd;
> @@ -1471,12 +1471,17 @@ int git_open_noatime(const char *name)
>                 if (fd >= 0)
>                         return fd;
> 
> -               /* Might the failure be due to O_NOATIME? */
> -               if (errno != ENOENT && sha1_file_open_flag) {
> -                       sha1_file_open_flag = 0;
> +               /* Try again w/o O_CLOEXEC: the kernel might not support it */
> +               if (O_CLOEXEC && errno == EINVAL && (sha1_file_open_flag & O_CLOEXEC)) {

80 columns overflow

> +                       sha1_file_open_flag &= ~O_CLOEXEC;
>                         continue;
>                 }
> 
> +               /* Might the failure be due to O_NOATIME? */
> +               if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
> +                       sha1_file_open_flag &= ~O_NOATIME;
> +                       continue;
> +               }

But otherwise much better since it doesn't blindly zero
sha1_file_open_flag :>
