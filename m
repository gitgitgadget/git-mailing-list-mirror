From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 12:14:03 -0800
Message-ID: <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
References: <20131221135651.GA20818@sigill.intra.peff.net> <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com> <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:14:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QfV-0005dn-0i
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbaAWUOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:14:25 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:41918 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbaAWUOY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:14:24 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so2097509wgh.19
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aSn0YJbyD1uKNp1JtsK5ANlAZNBKFGjJEbzY7OCJOR8=;
        b=FG3/72q4arnKDAGgojlIPJkWwi0OAK7CmWEtW5EFjdMUidKmQvGuOYYkwLhkPnJ/Zt
         SiKfpHMxh/wda1sUV/ENEcJNoleNsBg7cOJ6SaCfPAquIzNmcllWUI4asXq2oAReX9EX
         kiGHxKaYjMu/hTMYWiYDp3YE127BSpByFiivc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aSn0YJbyD1uKNp1JtsK5ANlAZNBKFGjJEbzY7OCJOR8=;
        b=IH4coz0M3RefFCzzn8qmoVkrU5Ex/frE3VLUhSBP/0n4+KDkqn6nVWy2WDr9zCdMA2
         WxrwJggaZGhXmKNKKHzxBYxQLFRZDhsXIWU1nmA/iX8TrHq3kNRGzV/8+CxNVhCVnxug
         zzUG7OU5pa1OYhgfjicpbV6Ab7ZlKsSfYPqg9svHtPDKsQ4rEdYdvm4FKgQv80qoksUx
         2vc5mezR1wKjcCP8ISDe/Uhv/Xa9EAQY8TjxAOEpW2lUbaObYOvLjxJANe0qIqWo4mUi
         QI8JiyMCdTFMrf6KpWY9ofbFMI5WMMXeLEcmQoazJCynFpZLeu/sdrITnbq0w+xy8nGo
         QxdA==
X-Gm-Message-State: ALoCoQkCQF91Q4LKmRofi0otknCaw2EPkat3TmItMRSJRa9Zb2b2inbOE1QXPDxL4pZy2h7sIig7
X-Received: by 10.180.91.164 with SMTP id cf4mr671749wib.2.1390508063782; Thu,
 23 Jan 2014 12:14:23 -0800 (PST)
Received: by 10.227.16.136 with HTTP; Thu, 23 Jan 2014 12:14:03 -0800 (PST)
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240943>

On Thu, Jan 23, 2014 at 10:33 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 22, 2014 at 06:05:36PM -0800, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>>
>> > EWAH is a word-aligned compressed variant of a bitset (i.e. a data
>> > structure that acts as a 0-indexed boolean array for many entries).
>>
>> I suspect that for some callers it's not word-aligned.
>
> Yes, the mmap'd buffers aren't necessarily word-aligned. I don't think
> we can fix that easily without changing the on-disk format (which comes
> from JGit anyway).

Ouch, sorry about that. JGit doesn't mmap the file so we didn't think
about the impact of words not being aligned. I should have caught
that, but I didn't.
