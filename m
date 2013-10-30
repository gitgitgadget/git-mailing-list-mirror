From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 16:04:06 +0000
Message-ID: <CAJo=hJvm_sZqobzO0Er-OVp-Xkf4fT_tySQeNWf0mveHH-G-Xg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180357.GJ24180@sigill.intra.peff.net>
 <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com>
 <20131030081023.GK11317@sigill.intra.peff.net> <CAFFjANQyMfV4M_wynPORfN2S1=eAdBxScgNYzD_dsRmKekp83Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYG0-0005dy-JE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab3J3QE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:04:29 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:44573 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3J3QE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:04:28 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so1489972wes.20
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z0OwWiBFWRYj2mm098OAhx8tujyiRk+/ZHFeLseY/pQ=;
        b=Ve9BQlHh7A9/xyGLocY2wvpnkP6174OIIYm24TYLza5zuOr+o2nOeJ7o6QYN190AAs
         34aNih262G4LKWebgkb8Ax3xN20xYVsd9oZNFD9DMfHO/wz03jR9JxaYr/WZosROrEQm
         jk1RKOWh8+JKQkXXiKupC+s9zjd3y8by/swoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=z0OwWiBFWRYj2mm098OAhx8tujyiRk+/ZHFeLseY/pQ=;
        b=ODZmWWmpM5iuCl+0FwUiIMlV2F9sR+pPrHcHUhqEicplSvqSWd22KKO2blQ9bgM5jf
         gYq4chRNkPf8Wu3uWM9GDoTwgRyb5jhOegHWa5vRqJyS974loPb4FaRr8tCNZ0Lq8D1F
         knrBLqO/m4GXyFyFgOgCalM6qgUdtgjH+grlEwyVxUJH1OoM04OoBKgwVI0YO1XAC7Pe
         QtB3Gh6v6qnLxFUyR0/g6c65HL4aXenYZ/s2UekbZ04Y5jFUKVNrRAnMKZVq/LSM6Vl7
         /V2xAYAx3PRMwEYWE6UL9NsODZcGHy3wN7n1m4fyGkGRQ2hTH04sW0xgT7Ezyv1oHMbM
         d0Bg==
X-Gm-Message-State: ALoCoQniDWV2gm/hO+geGjs57YjxOA44DnZV14ay2p6Wcz+0hASCFUYYFhdbHDTOLMo6spnKypWr
X-Received: by 10.194.9.100 with SMTP id y4mr5345299wja.22.1383149066904; Wed,
 30 Oct 2013 09:04:26 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Wed, 30 Oct 2013 09:04:06 -0700 (PDT)
In-Reply-To: <CAFFjANQyMfV4M_wynPORfN2S1=eAdBxScgNYzD_dsRmKekp83Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237029>

On Wed, Oct 30, 2013 at 3:47 PM, Vicent Marti <vicent@github.com> wrote:
> On Wed, Oct 30, 2013 at 9:10 AM, Jeff King <peff@peff.net> wrote:
>>
>> In fact, I'm not quite sure that even a partial reuse up to an offset is
>> 100% safe. In a newly packed git repo it is, because we always put bases
>> before deltas (and OFS_DELTA objects need this). But if you had a bitmap
>> generated from a fixed thin pack, we would have REF_DELTA objects early
>> on that depend on bases appended to the end of the pack. So I really
>> wonder if we should scrap this partial reuse and either just have full
>> reuse, or go through the regular object_entry construction.
>>
>> Vicent, you've thought about the reuse code a lot more than I have. Any
>> thoughts?
>
> Yes, our pack writing and bitmap code takes enough precautions to
> arrange the objects in the packfile in a way that can be partially
> reused, so for any given bitmap file written from Git, I'd say we're
> safe to always reuse the leader of the pack if this is possible.
>
> For bitmaps generated from JGit, however, we cannot make this
> assumption. I mean, we can right now (from my understanding of the
> current implementation for pack-objects on JGit), but they are free to
> change this in the future.

JGit certainly doesn't promise the ordering behavior, so the fact that
its happening is just luck. The code could change in the future to
invalidate this.

> Obviously I intend to keep the pack reuse on production because the
> CPU savings are noticeable, but we can drop it from the public
> patchset.

I think you should keep it in, its a significant improvement.

> Ideally, we'd have full pack reuse like JGit, but we cannot
> reasonably do that in GitHub because splitting a pack for the network
> root would double our disk usage for all the forks.

I gave a talk the week before about Git bitmaps and why we sometimes
have to slice pack files by object.

Some guy in the audience kept yelling that since its Git its all open
source and `git clone` is "just" a file transfer problem. So maybe for
his GitHub repositories and forks its OK to include the entire fork
network when someone clones?  :-)
