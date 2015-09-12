From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bloom filters for have/want negotiation
Date: Sat, 12 Sep 2015 12:01:42 -0700
Message-ID: <xmqqtwqzxy09.fsf@gitster.mtv.corp.google.com>
References: <55F343F5.6010903@alum.mit.edu>
	<CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Wilhelm Bierbaum <bierbaum@gmail.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zaq3a-0004HE-5P
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 21:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbbILTBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 15:01:45 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36391 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbbILTBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 15:01:44 -0400
Received: by padhk3 with SMTP id hk3so104290985pad.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nVsSSg4Xo1vI7qIq5nw4Pm12A5JovwSc9VqC8Aoe6Rs=;
        b=w4LYWhJhjJPwtsLpHdFc8HqF6mxyd/itAHstBrz/nMLkDPtpALS73JG/yWR/EEI6MI
         tkJYjXRErvm5Qk+RxIhCFbLoCaV2RdEwWYb10XJlpBRjXPYkx6UdJo7x+eQZJ8XPe5AS
         65CWVdAH6qe4/ECP5Zdh3YKZudFdMeMxi7iAnG93ai5GOuCoi/O7KyA4j03GafxBUb/z
         GcQbGLLQg8g2pBQ9HVeqET2eodyGgcMmjR8SOKrJ79M/HIsR7wtIXTC4h/JjM542TV1P
         mlYefO1e/FFG8fTDxsr1VwjsEpu2VgaVLLh0R+fADN1+ss2KsFbjXShrOrxkZB9cnKmw
         uHTw==
X-Received: by 10.69.2.227 with SMTP id br3mr13230936pbd.9.1442084503934;
        Sat, 12 Sep 2015 12:01:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b563:b427:39df:b23])
        by smtp.gmail.com with ESMTPSA id sl7sm7171170pbc.54.2015.09.12.12.01.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 12 Sep 2015 12:01:43 -0700 (PDT)
In-Reply-To: <CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 11 Sep 2015 22:16:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277732>

Shawn Pearce <spearce@spearce.org> writes:

> The worst case is due to a bug in the negotiation. With nothing
> common, the client just goes on forever until it reaches roots
> (something is wrong with MAX_IN_VAIN). We saw 56,318 have lines ... a
> 2.6 MiB section. But smart HTTP gzips, so this may be only 1.3 MiB on
> the wire.

This one is interesting.

> But average/worst doesn't tell the entire picture. Bucketing requests
> by have lines gives us more:
>
>   %req | have_lines
>   -----|-----------
>   100%   56,318
>    99%       88
>    98%       52
>    97%       35
>    96%       31
>    95%       26

So is this.  From this observation, at least for your audience, it
is expected that we would usually not need a very long back and
forth session to discover where the history diverges.

But that is kind of expected.  Because the current protocol, in
which the upload-pack speaks first and advertises all tips it has,
allows the fetcher to omit what is known to be common very early and
to concentrate on sending the "have"s from the branches the fetcher
has worked on since the last time it fetched.  The amount of "have"s
needed is expected to be small in an "everybody meets at the same
central place and pushes into and fetches out of there" workflow,
because the amount of work done by a single fetcher since the last
fetch will by definition be a lot smaller than what happened in the
central meeting place.

I wonder how flipping the "who speaks first" would affect that
equation, though.

> Ergo, if this is all working correctly on smart HTTP, clients can
> fetch from a server they already "know" with decent efficiency, and
> smaller than your 2 KiB Bloom filter estimate for git.git at 1% error
> rate.

Isn't this part a bit of oranges and apples comparison?  If I
understand the motivation of Michael's looking into Bloom filter or
some other techniques correctly, it is to find a way to address the
initial advertisement from the sender.  Your analysis is about the
amount of "have", which is an orthogonal issue.

> I do wonder if we are stuffing the pipe deep enough with multi_ack on
> Internet links. Git doesn't need very long to walk 16 commits,
> certainly less than the 200 ms RTT a user might have talking to a
> server on the other side of the US. It is possible both sides are
> spending most of their time waiting for data transfer of the batches
> in flight.

Yes, this is a very useful insight.  An experiment or two with
larger amount of data in flight may be an interesting thing to try.
Do we still have the deadlock possibility caused by our implicit
reliance on the fact that a single batch was expected to fit in a
pipe buffer, by the way, or have we addressed that issue already?
