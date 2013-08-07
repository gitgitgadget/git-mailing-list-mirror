From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Wed, 7 Aug 2013 10:06:38 +0530
Message-ID: <CALkWK0=41FNXQk1cAKdgAd3t3Bzh1KEc3bksu0M1LjdSgfmr3Q@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com> <201308061825.28579.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Aug 07 06:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6vUy-0003v7-Vn
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 06:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab3HGEhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 00:37:20 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34479 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3HGEhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 00:37:19 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so2884706obc.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 21:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BQvOKjrLSMaQPnX8CgpX4SFCKzf5HoJGOkZf25oVO1k=;
        b=0ufCiDuk6AtUDPNsrXkqEhZqM6iPs8gpujGq69nEzm0jpEKeXoejsIJ3Xjzsmyi9mU
         lxlPuX4sAhCd57ITyHF8w+0xsdkdP17GTQNpHHNvNX6qsY/JRCpE0fGuqv65uUsgtx/z
         CT4ozoeLoJt0jGGyGAn6bVxVznf3TMvhV+i7VPoK5Bjm3+A0I+ti8mWXiLHdrtn0NL7o
         ZZtOhnURWFPKOQfmgJywGnuQ6caq78XzbVTPX38MwrjKDfQDWvjXOO688roQVjFagDE+
         BjS5SZVxYHzSiRsBzBPBwlL2adaNiwDVG5104ook2HaA6w/Z/Yjdfo/6L7jo4DsuIqQg
         SkJQ==
X-Received: by 10.50.131.137 with SMTP id om9mr110291igb.55.1375850238260;
 Tue, 06 Aug 2013 21:37:18 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 6 Aug 2013 21:36:38 -0700 (PDT)
In-Reply-To: <201308061825.28579.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231804>

Martin Fick wrote:
> So, it has me wondering if there isn't a more accurate way
> to estimate the new packfile without wasting a ton of time?

I'm not sure there is. Adding the sizes of individual packs can be off
by a lot, because your deltification will be more effective if you
have more data to slide windows over and compress. For the purposes of
illustration, take a simple example:

packfile-1 has a 30M Makefile and several tiny deltas. Total = 40M.
packfile-2 has a 31M Makefile.um and several tiny deltas. Total = 40M.

Now, what is the size of packfile-3 which contains the contents of
both packfile-1 and packfile-2? 80M is a bad estimate, because you can
store deltas against just one Makefile.

So, unless you do an in-depth analysis of the objects in the packfiles
(which can be terribly expensive), I don't see how you can arrive at a
better estimate.

> If not, one approach which might be worth experimenting with
> is to just assume that new packfiles have size 0!  Then just
> consolidate them with any other packfile which is ready for
> consolidation, or if none are ready, with the smallest
> packfile.  I would not be surprised to see this work on
> average better than the current summation,

That is assuming that all fetches (or pushes) are small, which is
probably a good rule; you might like to have a "smallness threshold",
although I haven't thought hard about the problem.
