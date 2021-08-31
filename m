Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C25C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F48160FED
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhHaIr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:47:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:52631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236028AbhHaIrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:47:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="215303409"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="215303409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 01:47:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="519551366"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 01:46:59 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mKzPz-00FyKN-D2;
        Tue, 31 Aug 2021 11:46:55 +0300
Date:   Tue, 31 Aug 2021 11:46:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <YS3sfzlkTjFXTWVh@smile.fi.intel.com>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
 <20210830182845.pnv7ywnc364jnblt@box>
 <YS1Bni+QuZBOgkUI@coredump.intra.peff.net>
 <20210830224215.hay6rjbt3vk26nk5@box>
 <YS3GMqz4WHUS0Cjt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS3GMqz4WHUS0Cjt@coredump.intra.peff.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:03:30AM -0400, Jeff King wrote:
> On Tue, Aug 31, 2021 at 01:42:15AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Aug 30, 2021 at 04:37:50PM -0400, Jeff King wrote:
> > > I am sympathetic that this used to work, and now doesn't. But this proxy
> > > case is affected by the problem that ae1a7eefff was solving. The root of
> > > the issue is just that "socat" in its default form is not doing the
> > > right thing. So I'd prefer not to try to make any change to Git's
> > > behavior here.
> > 
> > As a kernel developer I learned hard way that breaking user experience by
> > kernel changes considered a kernel regression, even if userspace "does it
> > wrong"™. I'm not sure what standard of care for Git users is.
> > 
> > I'm fine adjusting the proxy script and make my colleagues aware about the
> > issue, but the approach doesn't scale.
> 
> I think we're a little less extreme there than the kernel. Like I said,
> my preference is to leave Git as-is, but if somebody feels strongly, I
> don't think it would be that hard to leave core.gitproxy untouched here.

So far the massive (annoying) Git breakage happened second time to me (*).
I would agree with you if it's rare to happen, to me it's like once per
~2 years. So, can you define what the tolerable period of time is when
I have to expect a Git breakage next time?

(*) First time it was a few years ago when out of a sudden Git started to pull
gigabytes of repositories without any need. It was annoying, but tolerable to
some extent. Current situation is not better form my user perspective.

> I agree it doesn't scale, but my suspicion is that we're talking about
> an extremely small population here. IMHO we should be considering
> deprecating git:// entirely (from Git itself, and kernel.org should
> consider turning it off). In the v2 protocol, there's no advantage to
> using it over HTTP.

So far don't you need to support current use cases?

(Here of course a philosophical question: is a driver moves a car, or the car moves the driver)

> > > But one option would be to limit it only to ssh, and not
> > > git:// proxies (we already don't do that half-duplex shutdown for raw
> > > TCP git://, for reasons discussed in that commit message).
> > 
> > I wounder if it's possible to detect the situation, warn the user that
> > gitproxy has to be fixed and retry fetching pack without closing fd[1].
> 
> I don't think it can be easily distinguished from an actual network
> hangup (or proxy command failure, etc). I would much rather stop doing
> the close() entirely than add any kind of heuristic retry.

-- 
With Best Regards,
Andy Shevchenko


