Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CFC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 19:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjERTO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjERTOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 15:14:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A783DF2
        for <git@vger.kernel.org>; Thu, 18 May 2023 12:14:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB7F6178967;
        Thu, 18 May 2023 15:14:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=WcALJN4EXE9WBwJ91Hn5o1F7fKntdjX8eRbGxpR
        /uWc=; b=uc+RyhbtJ6wvbiLatBmO+frbWvllkS2EucPDx2dTUWHWjJqvu3j1zUA
        S2lZ9t2n1Qmjqoyv7G28lznZlWzO336rUQ9Mwm0LAW47ARK6aGWQMEXnVt91+bb8
        w3fHTBRQa4z8Olf46fVpWfWp5sFNr7vMHL0MA/Z8uETRamjnct9U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2EA9178966;
        Thu, 18 May 2023 15:14:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31320178964;
        Thu, 18 May 2023 15:14:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 18 May 2023 15:14:50 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <ZGZ5KsbkwoT68J1S@pobox.com>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518184532.GC557383@coredump.intra.peff.net>
X-Pobox-Relay-ID: 4402C086-F5B0-11ED-A4B8-307A8E0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, May 17, 2023 at 03:06:18PM -0400, Todd Zullinger wrote:
> 
>> The problem is that CGIPassAuth, added in 988aad99b4 (t5563:
>> add tests for basic and anoymous HTTP access, 2023-02-27) is
>> not supported by httpd < 2.4.13:
> 
> Thanks for reporting. I don't think we dug into version requirements for
> that (obviously CGI stuff goes back forever, so it's just that
> particular option). That version of Apache is "only" 8 years old. Which
> is old, but we often go back that far for dependencies.

Indeed, thanks.  I don't imagine there are too many people
looking to support the latest git auth mechanisms via http
who are also running CentOS 7.  But it's nice to not have to
disable all the other http tests.

>> Since edd060dc84 (t/lib-httpd: bump required apache version
>> to 2.4, 2023-02-01), we require httpd-2.4 and no longer have
>> any <IfVersion> conditions.  I'm not sure if this a reason
>> to add some again (nor am I certain if httpd's IfVersion
>> supports minor versions).
> 
> I don't think an IfVersion would be sufficient, because we need to also
> tell the script making use of that config that it should skip its tests.
> So I think we want something more like the HTTP/2 tests have: a separate
> script which enables the extra config, and bails if the web server setup
> fails.
> 
> Something like this:

[...]

I'll try to apply this and see how it goes, skipping t5563,
a little later in the day.

> And then the theory is that t5551 works as before (it does not try to
> use that config), and t5563 will either work out of the box (for recent
> versions), or web server setup will fail, and we'll skip all tests.
> 
> BUT. That won't work if you have set GIT_TEST_HTTPD=1, rather than the
> default of "auto". Because then it is instructed to complain about
> webserver setup failing, so t5563 will fail rather than skip. So we have
> a few options there:
> 
>   1. You use the looser value of GIT_TEST_HTTPD for CentOS tests, which
>      would do the right thing. The downside is that if server setup
>      failed for other reasons, we wouldn't notice and would silently
>      skip the HTTP tests.
> 
>   2. We do some kind of version check in enable_cgipassauth(),
>      and skip tests manually if it doesn't pass.
> 
>   3. You just skip the test manually on that platform with
>      GIT_SKIP_TESTS=t5563.
> 
> Obviously (1) and (3) are the least work for us upstream, but I don't
> think (2) would be too hard to do.

Yeah, the path of least effort seems ideal here.  If the
tests are split I can easily skip them for CentOS 7.  For
something that's going away in little over a year, it's good
to put at least some of the onus on folks packaging for it.
And that's less cruft in the test suite after CentOS 7 is
gone (or any other ancient httpd's git may wish to support).

Thanks Peff!  I'm really glad you know your way around the
test suite so well.  It'd take me far longer to figure out a
good plan for something like this.

-- 
Todd
