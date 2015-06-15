From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Mon, 15 Jun 2015 10:42:18 -0700
Message-ID: <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net>
	<CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
	<20150610185635.GA22800@peff.net>
	<xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
	<20150610192734.GA23715@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4YOy-0001v8-5X
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 19:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbbFORmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 13:42:24 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37482 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbbFORmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 13:42:22 -0400
Received: by igbsb11 with SMTP id sb11so55963712igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tCN2ZRz5eLZgYTLel7iqkh1r/fDMVduNM6zVCB9wRio=;
        b=kfwPrjBENwkdyHpSNoxmct1hK73n7vbAQ6CnrD5J/XviKrkE09Hv/NLQxPAFuq/8sc
         FqBufcgr8MoY3JeL+iWx4H5i59XKl+69Tpp5gChfuS4AOE4tip++tvhlLCOEU2Bcu8TK
         BgwVNdp9JkkMcW0Vz0NdIo/qR/R1lFTh1Q55ggp8P6xN/nJ7jLLhVOfnLEz+JxGugA0R
         G+KJYkbzo0mIso3tWBA8GfIq4oexxWIeH6OWR+QQn4RtNQb4vAwuZZc6CePrmaxjipBf
         6f+29Heop9+mN3mBXLCf0RB9au4372saftqUW6jNB+oz8cli6+Ky1VwjW7Cj4rKHw91I
         j17A==
X-Received: by 10.107.152.14 with SMTP id a14mr34766826ioe.92.1434390142310;
        Mon, 15 Jun 2015 10:42:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id g1sm9277831iog.4.2015.06.15.10.42.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 10:42:21 -0700 (PDT)
In-Reply-To: <20150610192734.GA23715@peff.net> (Jeff King's message of "Wed,
	10 Jun 2015 15:27:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271693>

Jeff King <peff@peff.net> writes:

> It seems like applying a stash made with "-k" is fundamentally
> misdesigned in the current code. We would want to apply to the working
> tree the difference between the index and the working tree, but instead
> we try to apply the difference between the HEAD and the working tree.
> Which is nonsensical for this use case (i.e., to apply the diff between
> $stash and $stash^2, not $stash^1).
>
> I don't think there is any way to tell that "-k" was used, though. But
> even if the user knew that, I do not think there is any option to tell
> "stash apply" to do it this way.
>
> I dunno. With respect to the original patch, I am OK if we just want to
> revert it. This area of stash seems a bit under-designed IMHO, but if
> people were happy enough with it before, I do not think the safety
> benefit from ed178ef is that great (it is not saving you from destroying
> working tree content, only the index state; the individual content blobs
> are still available from git-fsck).

Yeah, I agree.   Somebody care to do the log message?

This is a tangent, but I'd actually not just agree with "'stash -k'
is a bit under-designed" but also would say something stronger than
that, IMHO ;-)

The very original idea of "git stash" to ssave away working tree
changes with respect to HEAD without bothering the index was at
least internally consistent.  You save away and then may later pop
the change on top of a different commit after dealing with an
emergency, at which time there may be conflicts that you would need
to resolve, and because it is only between HEAD and working tree,
you can safely use the index to resolve the conflicts just like in
any other situation when you help Git to resolve them.  In that
context, the flaw ed178ef1 (stash: require a clean index to apply,
2015-04-22) tried to correct made a lot of sense.

What broke the entire system was the throwing the "save the index,
too" into the mix, which was done without careful thinking.  While
it made the command more useful (when it works), it made the command
internally inconsistent---the command has to punt restoring index
state when it can't, for example, losing the state it tried to save.
I think that is where the "under-designed" started, I would think;
of course, "-k" needed to build on top of "save also the index",
but that is not the primary culprit.
