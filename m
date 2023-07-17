Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F80EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 05:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGQFgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 01:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 01:36:18 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C59010F
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 22:36:14 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689572170;
        bh=o6ImfPADh+ya6cyoXHJShquLm00Smh8xr2CaUFf1TZA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=XPKw+nB0KBQ6e4sV8nHNqQEYqtyVLyB04iptXPn79FGvOd/yQK3RlEJRBb8bzZmtX
         5FJA1BpnQZ3tBYhC4iu4+d+/e0FOXWKqHEs0jvUEia/5PB7199k29Cir90283P8OBv
         8dAKmgX5hVLccFIHCL/i0iNxDX8FSASQl/MzTT6/vjMBbSaPGrbdev12uf3opvah6X
         RX4KVTKvElP9JAojHU7TsY2xWmAUckHhoh4guaQ3V2d2UrOp20wVWy8Y2bMCXoJskz
         qsbPOlPfqY+QjMtHX3vKkjU1pljZxFJ/efBEb8wdZb+w7CvvTQOYUa3B/ba0Yrlxhv
         y+37NH2l/DUcw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 05:36:48 +0000
Message-Id: <CU47D1G1Y1E2.GID9E4XI7W1K@anonymous>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de> <xmqqsf9njmc9.fsf@gitster.g>
 <xmqq5y6jjlcs.fsf@gitster.g>
In-Reply-To: <xmqq5y6jjlcs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > and just use them), we should NOT be adding a "--privacy" option
> > that picks rand(24)*60 as UTC offset and pretends that it the
> > timezone of the author, and picks some random timestamp between the
> > timestamp of the latest commit in the repository and the actual
> > wallclock timestamp and pretends that is the author time.  After
> > all, our project is not about coming up with a quality time
> > obfusucation.
>
> We could go to the extreme in the complete opposite, if we do not
> care about the quality of the "privacy" feature, and you could
> probably talk me into adopting below as long as the option or the
> configuration are not named with the word "privacy" in them (a
> "--useless-time" option, or a "core.uselesstime" configuration
> variable, are OK).

I hadn't considered it in my other responses, but calling it --privacy
would be a bad idea for exactly the reasons you laid out. Calling it
--useless-time would be better.

> When the feature is in effect, all timestamps in commit and tag
> objects pretend to be in UTC timezone, and
>
> (1) the commits record the Epoch as its timestamps if there is no
> parent;
>
> (2) the commits record one second after the largest of the
> timestamps as its timestamps of all its parents;
>
> (3) in any case, the same (phoney) timestamp is used for author and
> committer.
>
> (4) the tags record the Epoch as its timestamp if they point at
> trees or blobs.
>
> (5) the tags record one second after the largest timestamp of
> pointee as their timestamp, if they point at tags or commits.
>
> (6) as the reflog is a local matter, its timestamp may be local,
> but it is OK if it ends up being just a useless number if that
> is more convenient to implement.

You're the expert on Git's internals and clearly know best how to
implement this with the least amount of breakage. So I can't comment on
that.

I will say these points seem to be sufficient to satisfy the privacy use
case. I don't think any more can reasonably be expected.

> The resulting history will be shouting that "I am privacy conscious
> and hiding my activities behind a fake clock" in capital letters,
> which I would not call a quality design of a privacy feature, but it
> does completely dissociate the wallclock time from the recorded
> history without breaking the monotonicity of timestamps in the
> recorded history.

Depending on one's threat model, revealing the fact that one is using a
privacy feature/tool isn't necessarily a problem. I agree that perhaps a
really high-quality implementation of a privacy feature could do this,
but I think that's outside the scope and way too much to expect from
devs as you said.

> When the useless-time feature is in use, you cannot expect features
> like "git log --since" would work sensibly, but that is a given, I
> would guess.

There could be a warning in the documentation that this feature may
cause breakage.
