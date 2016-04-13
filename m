From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 19/21] bisect: use a bottom-up traversal to find
 relevant weights
Date: Wed, 13 Apr 2016 16:11:01 +0200
Message-ID: <CAP8UFD2_3jwGVJaoOzrKESi8qBN=4D49kiZes+bJARxMvAi3tg@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-20-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 16:11:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqLVd-0007tW-VU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 16:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933815AbcDMOLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 10:11:04 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35988 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcDMOLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 10:11:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so177081725wme.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BfcrEpL4x98efKmIVF4s/5PBacVz+ZCshVEAg8CP6wA=;
        b=W0TViKuyboOHkEmyugmnFaWXp1pF7N+pUzJXG13FdDFheBdLNyYN8Xveqdhdee3Fn+
         qgYX6E2TqnldQcCK5FkrPHJcbol4KjNmE2cdfzkzd6piQuD87+ec1WJvP4EMQXwrA4wG
         Ne5bqeIao83R7ch2ShGSobeuuHOxYwqxrFPh7zgga1R2uAOC0ooEMfi2bNmO4bQYVwIn
         oELPgFp+xTAy+TgniR2uA91k2LgfcCUEwGSjHyCQ6Sd8vcLXaYn6VslrVeThETIeQXd5
         8+WLzGFrRlubp6HVtvk4EmIx6M9WpRLnZCb5DJp1/EAby3UQDWL9Rn3jESIlGvHciYoC
         9HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BfcrEpL4x98efKmIVF4s/5PBacVz+ZCshVEAg8CP6wA=;
        b=YvoyzQJrELHZ79H+8AHXxlkG4O3PovQVZodkL8k3dUt643vRPbD9emCL4nrnAOAXIr
         M8RxYbM9SUF2eGekH4d9NdzrLxyfcwWpxUDXsCc/15lJvIebmImnxQBZgrU5QHWFjleJ
         y6hWoLIAyL+1xf/DEJWeSsspuQroyePLRXmDjrPRoEaWGebu0bC25QJpa37w38qkiKi8
         OUZYK11JTyA026IcEZ2jGhczMWZeH4hD74q3BeWB0Uv/wfkR0AsUmYGtZWv/aOTJS5fG
         mlHKf8Z5AoQGTQHd/CbWj9kCdz/cytiRCTszqhHDHOO8mZslwUva9bC6ayVrNYeoi3LJ
         eExQ==
X-Gm-Message-State: AOPr4FWk1NWrLJ3d0b7lQZ163DvqpINiJxqdSAMQftTOMDpyhKAK0ohV/tMbO3M4LWsQoKu5Y9DQSrs3BguVfw==
X-Received: by 10.194.117.70 with SMTP id kc6mr10669916wjb.94.1460556661532;
 Wed, 13 Apr 2016 07:11:01 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 13 Apr 2016 07:11:01 -0700 (PDT)
In-Reply-To: <1460294354-7031-20-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291453>

On Sun, Apr 10, 2016 at 3:19 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> The idea is to reverse the DAG and perform a traversal
> starting on all sources of the reversed DAG.
>
> We walk from the bottom commits, incrementing the weight while
> walking on a part of the graph that is single strand of pearls,
> or doing the "count the reachable ones the hard way" using
> compute_weight() when we hit a merge commit.
>
> A traversal ends when the computed weight is falling or halfway.

Yeah, it looks like it could be a good optimization to end a traversal
looking for "relevant" commits when the weight is falling.

> This way, commits with too high weight to be relevant are never
> visited (and their weights are never computed).
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> Notes:
>     I rephrased the commit message.
>
>     I renamed the functions such that they don't talk about "BFS"
>     because that is irrelevant. Also use a DFS now because it is
>     less code (and a little more efficient).
>
>     I plugged some leaks.

That's a lot of things in just one commit.

>  bisect.c | 250 +++++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 162 insertions(+), 88 deletions(-)

Also from the diff stats it looks like you add a lot of code in this
commit and the previous one.
I wonder why you are saying that a DFS is less code above then.

The previous patch (18/21) has the following diff stat:

> bisect.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 97 insertions(+), 19 deletions(-)

And the subsequent patches don't reduce code size overall.
Diff stat for 20/21 is:

> bisect.c | 44 +++++++++++++++++++-------------------------
> 1 file changed, 19 insertions(+), 25 deletions(-)

And diff stat for 21/21 is:

> bisect.c | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)

So after your patches from 18/21 to 21/21 there are around 150 more
lines of code.
Maybe this is worth it, but I wonder if at least some optimizations,
like for example ending a traversal looking for "relevant" commits
when the weight is falling, could be implemented without changing the
code so much and adding so many lines.
