From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 07:53:35 +0700
Message-ID: <CACsJy8C-Wfh16jroWACEFybtnhwYX91GvgGwk8XxJRft4ZURSw@mail.gmail.com>
References: <20160307221539.GA24034@sigill.intra.peff.net> <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 01:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad5ug-0003nK-F5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 01:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbcCHAyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 19:54:09 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34484 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbcCHAyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 19:54:08 -0500
Received: by mail-lb0-f172.google.com with SMTP id xr8so209474lbb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3brg0+zBKnMSrHDQ1zymvexXFpjt93oZNRlb2TC2zqE=;
        b=ZD8M1qmcejI8kpFOZASTzgWDmIO3SgoPT/lidUJzdkBOxhyhxergabvCtRfJtXI9aw
         vIxrVDTVPiaN+YvBFGH1Z+R+j3OHRK29OHXZAA2EZCloXgqYFrx4k/bNdm2MSNI7bfX2
         JpR0fCR3qICPWKYJNp0s3lqwWrI/eC7cjL/kYEGkqYxLNJEVisrR2DsaIFlxcSoVNeVW
         OTYm6ImvLkDGRHHOLbGk2jS2/M1eW0PnujCxS4WqF48tPTGUjhAe23GBd9gXDx5Kh5D8
         XbApPQXINCx3Tp4xJXXnNh18b3TbMoJvXDE6XzGV5NSCcJUnwDPWUB3W/SfwWDt5/Yjo
         c6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3brg0+zBKnMSrHDQ1zymvexXFpjt93oZNRlb2TC2zqE=;
        b=efBybAr1LB9lDkTsfNSm4YyPjd/XJcD1YLPK3kpYgEDBXowduApIqfOz+yR6jv3f68
         eSZTjze6+RzjJQzFJX6cisgMF5YQx7OAWnLpo1fqSrxntLZ8yDvlznf718H/Mj/M64Tt
         Y7NMp+j7fOVjSqgRm6WjMQwjdRXguZ2E8EsZrJcQISLr1m6fUCwVqzcfZrZAUmPpbq4z
         ewYisFiZcSyFqgQ8f1pZJGtHiv061Q3ap7oJZVstUsAzmE9UZflR5zT8WduPfCCEZpp+
         bSNP3NX+BhDVQCJFJs/l3oRCMhGIQxoQSfK3E+aR0fKBAbe8Sok8lMAZ2ECOa/cjp5+C
         nEBg==
X-Gm-Message-State: AD7BkJLu3C/qa20kcJM3UhqTYr0MjDBNb+ejX/ORRO+7GUwK4R2zeG/NV/4ZYB0wvnmTryyaaumCW+Kvid26Rg==
X-Received: by 10.25.147.202 with SMTP id v193mr8533781lfd.162.1457398445508;
 Mon, 07 Mar 2016 16:54:05 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Mon, 7 Mar 2016 16:53:35 -0800 (PST)
In-Reply-To: <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288410>

On Tue, Mar 8, 2016 at 6:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I don't know how the client invoked git, but we can guess what happened
>> and simulate with:
>>
>>   git tag shallow ecd7ea6033fe8a05d5c21f3a54355fded6942659
>>   git tag old 067f265bb512c95b22b83ccd121b9facbddcf6b1
>>   git tag new d7a6d9295d718c6015be496880f1a293bdd89185
>>
>>   git clone --no-local --bare --branch=shallow --depth=1 . clone.git
>>   cd clone.git
>>   git fetch origin old:refs/tags/old
>>   git fetch origin new:refs/tags/new
>>
>> Of the two follow-up fetches in the clone, the first is reasonably fast
>> (it just grabs a few new commits on top of the shallow base), but the
>> second is expensive (it grabs the merge which pulls in the whole
>> history). If we add "--depth=1" to each of those fetches, everything
>> remains fast.
>>
>> Is this user error to call "git fetch" without "--depth" in the
>> subsequent cases? Or should git remember that we are in a shallow repo,
>> and presume that the user by default wants to keep things shallow?
>
> Hmph, you shouldn't, and I somehow thought that you do not, have to
> explicitly say things like "--deepen" to break the original
> shallowness, but your example illustrates that the logic to do so is
> not well thought out.  A new side branch will prevent you from
> hitting an already-known shallow cut-off and traverse down to the
> root.

Yep. It "works" by design.

> Giving a random "depth" in subsequent fetch would however not work
> very well, I suspect, as that is very prone to make the part of the
> history the user originally obtained, and presumably used to build
> her own history, into an island that is unconnected to the updated
> tip of the history.

The new --deepen, --shallow-since and --shallow-exclude should be
better in this aspect and we can send them all the time without
affecting original cut points. Well, deepen can't be used here because
it needs shallow cut points as anchor in the first place.

> I also do not offhand think of a good way to use the topology or
> timestamp to figure out the best "depth" to truncate the side branch
> at.  The server side may be able to figure out that things before 'F'
> in your picture is not relevant for a client that has the shallow
> cut-off at 067f265, but the side branch can be forked arbitrarily
> long in the past, or it may not even share the ancient part of the
> history and has its own root commit.

If a shallow point can reach root without seeing another shallow
point, we can mark all reachable commits from it shallow. If it sees
another shallow point, maybe we can mark at the merge point of them..
We can also send "here is --depth=10, but only apply it on new refs".
That should mitigate the problem a bit. But I'm not sure if I can
solve it completely.
-- 
Duy
