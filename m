Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB3C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0C8207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgE0KY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 06:24:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22720 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgE0KY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 06:24:56 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jdtF0-0000ud-E4; Wed, 27 May 2020 11:24:54 +0100
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
References: <20200525215751.1735-1-philipoakley@iee.email>
 <20200527072318.GA4006199@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
Date:   Wed, 27 May 2020 11:24:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527072318.GA4006199@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 27/05/2020 08:23, Jeff King wrote:
> On Mon, May 25, 2020 at 10:57:47PM +0100, Philip Oakley wrote:
>
>> While `git blame` is able to select interesting line regions of a
>> file, it's not easy to just display blame lines since a recent date,
>> especially for large files.
> I'm not convinced this is a useful thing to do in general. Lines don't
> always stand on their own, and you'd lack context for deciphering them.
> So a real example from "git blame -b --since=1.year.ago Makefile", for
> example (pardon the long lines):

My contention is that there is a lot of effort needed _beforehand_ to
reach that point. We've already had to page down 2700 line to get there,
and then had to carefully select the differing before and after context
lines.

The use of the --blame-only (especially with broad date range --since)
is to quickly narrow focus with the rather large file to the few areas
of concern (probably related why the -b was introduced initially?)

>
>   3a94cb31d52 (Johannes Schindelin        2019-07-29 13:08:16 -0700 2734)              -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
>
> but in context it looks like:
>
>               (Junio C Hamano             2019-05-19 16:46:42 +0900 2730) bin-wrappers/%: wrap-for-bin.sh
>               (Junio C Hamano             2019-05-19 16:46:42 +0900 2731)         @mkdir -p bin-wrappers
>               (Junio C Hamano             2019-05-19 16:46:42 +0900 2732)         $(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>               (Junio C Hamano             2019-05-19 16:46:42 +0900 2733)              -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
>   3a94cb31d52 (Johannes Schindelin        2019-07-29 13:08:16 -0700 2734)              -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
>               (Junio C Hamano             2019-05-19 16:46:42 +0900 2735)         chmod +x $@
>
> Of course there are cases where it might be useful. But you can already
> do:
>
>   git blame --since=1.year.ago Makefile | grep -v ^^
>
> I'm not totally opposed to the feature. I'm just really struggling to
> see how it would be generally useful. For special cases where you're
> just counting up lines, you'd be more likely to post-process the result
> anyway, at which point --line-porcelain is often easier to work with.
I'm also thinking that use of Git has expanded well beyond its core
Linux VCS roots, so not all users are ready for the grep regex [1].
Hence the expansion of the `-b` to truly filter only the blamed commits.


>
>> Philip Oakley (4):
>>   doc: blame: show the boundary commit '^' caret mark
> This doc fix seems worthwhile on its own, though.
>
>>   blame: add option to show only blamed commits `--blame-only`
>>   blame: do not show boundary commits, only those blamed
> If we do go this direction, these really ought to be a single commit.
>
>>   blame: test the -b option, use blank oid for boundary commits.
> This one might be worth doing independently, too.
OK. The final test look a while to come up with, so it ended up last.

>
> -Peff
Thanks
Philip

[1] https://stackoverflow.com/a/42540014/717355 "Git Blame see changes
after a certain date" (longer regex for the same effect)
