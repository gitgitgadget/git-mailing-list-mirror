From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 17:14:25 +0700
Message-ID: <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net> <20150605094545.GB11855@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 12:15:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0oeT-0002Vf-7J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 12:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbbFEKO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 06:14:57 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34723 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFEKO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 06:14:56 -0400
Received: by igbhj9 with SMTP id hj9so11981274igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oejCoPyOFnWo4WwwO9dMjfE6pbL6PFDMI6PxKWUg8No=;
        b=K/sZHqr3F5iGZSbLGPumYpuXY4rFzjqbYPQYdjKzJjlVN/Lpd1oGnfWoMGgddNQHqr
         eeRdrfKUK47fw//nNmXO+EroPm9RMBH+BTRCJEeCcogxzmY4OC/aUwRt5LH5gytpaGBm
         Sk/qbYi+3enalRJNOBMhKxk+DYS3OJQHT/qDEguQEsr5XOYK1STLjQuO5Z5YgeoUGDRs
         GvtXM53OThH8E6aVBo10Qey6MuWNMX0GjSQLo55phBcTidWfQehZ3AwXg7CTmQ4QYjQw
         M7uMX4cIkHw/iTKLxc8ohKxTCHwwuyZOe13em9mbgXgAlt/i4iNEWjp9LiZO41DeNvwR
         +0IA==
X-Received: by 10.42.93.17 with SMTP id v17mr9792657icm.42.1433499295613; Fri,
 05 Jun 2015 03:14:55 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Fri, 5 Jun 2015 03:14:25 -0700 (PDT)
In-Reply-To: <20150605094545.GB11855@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270822>

On Fri, Jun 5, 2015 at 4:45 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 05, 2015 at 01:41:21AM +0000, brian m. carlson wrote:
>
>> However, with the object_id conversion, we run into a problem: casting
>> those unsigned char * values into struct object_id * values is not
>> allowed by the C standard.  There are two possible solutions: copying;
>> and the just-do-it solution, where we cast and hope for the best.
>
> I'm not sure if it does violate the standard. The address of the first
> element of a struct is guaranteed to match the address of the struct
> itself. The object_id.hash member is an array of unsigned char, so there
> are no alignment issues. It might run afoul of rules about casting
> between pointer types (i.e., pointers for all types are not guaranteed
> to be the same size). The standard dictates that "char *" and "void *"
> are the same size, and big enough to hold a pointer to anything, so I
> think it might even be OK.
>
> But I'm not even sure that line of thinking is all that interesting.
> Even if we are violating some dark corner of the standard, this
> definitely falls into the "it's useful and works on all sane machines"
> category. We also do much worse things with struct-casting mmap'd data
> elsewhere (e.g., see the use of "struct pack_header"). It works fine in
> practice as long as you are careful about alignment and padding issues.
>
> So my vote would be to retain the cast. This is very low-level,
> performance-sensitive code. I did some very naive timings and didn't see
> any measurable change from your patch, but I also don't think we are
> seeing a real portability benefit to moving to the copy, so I'd prefer
> to keep the status quo.

I'm more concerned about breaking object_id abstraction than C
standard. Let's think a bit about future. I suppose we need to support
both sha-1 and sha-512, at least at the source code level. That might
make casting tricky. Maybe we should deal with it now instead of
delaying because if the final solution is vastly different, we may be
redoing this conversion again. In any case, if we cast, we should make
it grep-able (maybe hide the casting in a macro so we can grep the
macro's name) so we can examine them when the time comes for us to
move away from sha-1.
-- 
Duy
