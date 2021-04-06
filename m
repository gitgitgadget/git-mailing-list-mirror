Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F322C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3D961396
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbhDFOAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:00:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:42504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344829AbhDFOAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:00:16 -0400
Received: (qmail 7383 invoked by uid 109); 6 Apr 2021 14:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 14:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28770 invoked by uid 111); 6 Apr 2021 14:00:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 10:00:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 10:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
Message-ID: <YGxpZ/vJ/MyS0tLB@coredump.intra.peff.net>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <YGuMaxoYgRkUR1sa@coredump.intra.peff.net>
 <CAOLTT8TwjRyT6MK_ekEx9APBv7jn17JRKj=mJQMO5Sk-DgHA-A@mail.gmail.com>
 <CAOLTT8SzDsoScFaGe5emQc6V5QDJD=osdE5OMAz2Xs8=AvrfVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SzDsoScFaGe5emQc6V5QDJD=osdE5OMAz2Xs8=AvrfVQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 06:35:57PM +0800, ZheNing Hu wrote:

> ZheNing Hu <adlternative@gmail.com> 于2021年4月6日周二 下午5:49写道：
> > But this is the first time I use `t/perf/*` and there is a little problem.
> > It seem like whatever I run single script like `sh ./p0007-write-cache.sh`
> > or just `make` or `./run ${HOME}/git -- ./p0002-read-cache.sh` , these
> > tests will fail.
> >
> It's because I don't have /usr/bin/time, solved after installation.
> So best have this:
> 
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -152,6 +152,10 @@ immediate=t
>  # Perf tests require GNU time
>  case "$(uname -s)" in Darwin) GTIME="${GTIME:-gtime}";; esac
>  GTIME="${GTIME:-/usr/bin/time}"
> +if ! test -f "$GTIME"
> +then
> +       error "command not found: "$GTIME""
> +fi

This patch would create problems when we expect to find the value of
$GTIME in the $PATH e.g., you can see in the Darwin case it is set to
just "gtime", not an absolute path).

I am sympathetic to helping people see what's wrong, but I think in this
case we're better off pointing people to using "-v". E.g.:

  $ GTIME=pretend-we-do-not-have-gtime ./p0001-rev-list.sh 
  perf 1 - rev-list --all:
  not ok 1 - rev-list --all
  #	
  #		git rev-list --all >/dev/null
  #	

Uh oh, that wasn't very informative. But how about this:

  $ GTIME=pretend-we-do-not-have-gtime ./p0001-rev-list.sh -v
  [...]
  perf 1 - rev-list --all:
  running: 
  	git rev-list --all >/dev/null
  
  ./p0001-rev-list.sh: 160: pretend-we-do-not-have-gtime: not found
  not ok 1 - rev-list --all
  #	
  #		git rev-list --all >/dev/null
  #	

which I think makes it reasonably clear.

-Peff
