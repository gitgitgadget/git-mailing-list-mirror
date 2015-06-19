From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Thu, 18 Jun 2015 21:49:19 -0700
Message-ID: <xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
	<xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
	<CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
	<xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
	<20150618190417.GA12769@peff.net>
	<alpine.DEB.2.20.8.1506181536070.4322@idea>
	<20150618204505.GD14550@peff.net> <20150618212356.GA20271@peff.net>
	<20150619035408.GA23679@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 06:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5oFB-0001YR-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 06:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbFSEt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 00:49:28 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37717 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbFSEtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 00:49:22 -0400
Received: by igblr2 with SMTP id lr2so6092686igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 21:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EbjerOLt+RZL87YCkW8jQOAnPeqMpd5Ppp0mQKOPGiE=;
        b=HqLGTCEo1UiGNpxzC1Ro1Mmnojj8Jr44PFXts+g0BHWbSFprh5JEyVyYE0u5vznGiU
         sxWfpECQUlqUgvDuYaviXgIV8ogbc0td56sNKEB/ERL/1wh/or1avJLPDQUEib6O3OLs
         02LUPSeD9NF2uuzX2FvcG3OoJ84Tdr1cVoN9Xk6Gh77qiLvQzFb4mHiDmkBAsp/WpJWK
         FResg2pYbfBSzh+CR1XAVlHz9vW1uO0+/fNSbmj+tpBGUeXpJZnsYU4UeDkSz6ZiEHv6
         nw533rC7pxgKG2h8ermfGPvfcFSif1x66J5HY2PFvwRcZqz+f0Kq8GNNvmE2riW2yzic
         JNEA==
X-Received: by 10.50.79.129 with SMTP id j1mr1907738igx.32.1434689362204;
        Thu, 18 Jun 2015 21:49:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id c63sm6350145ioe.42.2015.06.18.21.49.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 21:49:20 -0700 (PDT)
In-Reply-To: <20150619035408.GA23679@peff.net> (Jeff King's message of "Thu,
	18 Jun 2015 23:54:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272101>

Jeff King <peff@peff.net> writes:

> ... I think you could also argue that
> because of whitespace-highlighting, colorized diffs are fundamentally
> going to have colors intermingled with the content and should not be
> parsed this way.

Painting of whitespace breakages is asymmetric [*1*].  If you change
something on a badly indented line without fixing the indentation,
e.g.

	-<SP><TAB>hello-world
        +<SP><TAB>hello-people

only the space-before-tab on the latter line is painted.

For the purpose of your diff highlighting, however, you would want
to treat the leading "<SP><TAB>hello-" on preimage and postimage
lines as unchanged.

Which means that you shouldn't be reading a colored output without
ignoring the color-control sequences.

So I think you arrived at the correct conclusion.

> All the more reason to try to move this inside diff.c, I guess.

That too, probably.

If we were to do this, I think it may make sense to separate the
logic to compute which span of the string need to be painted in what
color and the routine to actually emit the colored output.  That is,
instead of letting ws-check-emit to decide which part should be in
what color _and_ emitting the result, we should have a helper that
reads <line, len>, and give us an array of spans to flag as
whitespace violation.  Then an optional diff-highlight code would
scan the same <line, len> (or a collection of <line, len>) without
getting confused by the whitespace errors and annotate the spans to
be highlighted.  After all that happens, the output routine would
coalesce the spans and produce colored output.

Or something like that ;-)


[Footnote]

*1* We recently added a knob to allow us paint them on preimage and
common lines, too, but that is not the default.
