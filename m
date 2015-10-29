From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Thu, 29 Oct 2015 09:10:05 +0100
Message-ID: <CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
	<1445990089.8302.27.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Luciano Rocha <luciano.rocha@booking.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 09:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZriI4-0007aZ-4x
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 09:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbJ2IKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 04:10:16 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34437 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbJ2IKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 04:10:07 -0400
Received: by lfaz124 with SMTP id z124so14975186lfa.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ko59Dh1sEX9eslkOBe4wV+Okmsj01gsVO3Ewob5iKLo=;
        b=lrUHo0nvVVLQ4AlO4htDTHfNAAac5G8gZihvIkCuwlFjBH6yz5/Z7eEMsqbKIJwugP
         KTNY6BPBYz3Japf8b2tMij29dN+eJ7TvQ6HzO1FdCUYkvjiuhdDM+tMEzSGuw/n07bRV
         gcx8arM9VDjUdelFIb9HRAsrOsHOCQzggqktcRNOQJJLpenCya4gFCZd3K93R2xZmjlq
         9A/lRTaiVhx5awN3YyJoNntzVJEab7KsAiX1bbgNPvpCURtM1J0aXskF2tnYXh69UwlC
         dUXOI1+lPOHv9jUEC4RI6a3Eq+TTDMRgOL0d1AfvBY+F8HfiVpaTWk/4erv66eSmuPRd
         HN6Q==
X-Received: by 10.25.18.233 with SMTP id 102mr145104lfs.96.1446106205203; Thu,
 29 Oct 2015 01:10:05 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Thu, 29 Oct 2015 01:10:05 -0700 (PDT)
In-Reply-To: <1445990089.8302.27.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280436>

On Wed, Oct 28, 2015 at 12:54 AM, David Turner <dturner@twopensource.com> wrote:
>
> On Thu, 2015-10-22 at 07:59 +0200, Christian Couder wrote:
>> Hi everyone,
>>
>> I am starting to investigate ways to speed up git status and other git
>> commands for Booking.com (thanks to AEvar) and I'd be happy to discuss
>> the current status or be pointed to relevant documentation or mailing
>> list threads.
>>
>> From the threads below ([0], [1], [2], [3], [4], [5], [6], [7], [8]) I
>> understand that the status is roughly the following:
>>
>> - instead of working on inotify support it's better to work on using a
>> cross platform tool like Watchman
>>
>> - instead of working on Watchman support it is better to work first on
>> caching information in the index
>>
>> - git update-index --untracked-cache has been developed by Duy and
>> others and merged to master in May 2015 to cache untracked status in
>> the index; it is still considered experimental
>>
>> - git index-helper has been worked on by Duy but its status is not
>> clear (at least to me)
>>
>> Is that correct?
>> What are the possible/planned next steps in this area? improving
>
> We're using Watchman at Twitter.  A week or two ago posted a dump of our
> code to github, but I would advise waiting a day or two to use it, as
> I'm about to pull a large number of bugfixes into it (I'll update this
> thread and provide a link once I do so).

Great, I will have a look at it then!

> It's good, but it's not great.  One major problem is a bug on OS X[1]
> that causes missed updates.  Another is that wide changes end up being
> quite inefficient when querying watchman.  This means that we do some
> hackery to manually update the fs_cache during various large git
> operations.
>
> I agree that in general it would be better to store or all some of this
> information in the index, and the untracked-cache is a good step on
> that. But with it enabled and watchman disabled, there still appears to
> be 1 lstat per file (plus one stat per dir).  The stats per-directory
> alone are a large issue for Twitter because we have a relatively deep
> and bushy directory structure (an average dir has about 3 or 4 entries
> in it).  As a result, git status with watchman is almost twice as fast
> as with the untracked cache (on my particular machine).

Thanks for this detailled description.

> [1] https://github.com/facebook/watchman/issues/172
