From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 18:24:10 +0200
Message-ID: <CAC9WiBgb18ZX0vr8V79tCEUStrDRhRiSh44nH6+3B_Kf8rypYg@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<8761x87wc8.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 18:24:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upheh-0003UM-Og
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 18:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748Ab3FTQYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 12:24:12 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:56169 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757826Ab3FTQYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 12:24:11 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so7443019obc.10
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6xwE9y0WqGHDqr6fCxkvVpQx49VMAHx3/HtMlXh0LCY=;
        b=oRVWKq5L5SjHM8Ux4hpSOZN4wLRFxStsYI3rKO6cVywaNH+xbcanAoBAmNg+az5F7m
         RH/d0m6U4+v0kD6OXNbtf7KiOko7Ve9UrwHoaUqk6bUDvDGTo26EgqE4nOAdlTFtrNiC
         cbmw65B0LIKtq1uQk8EyQA8C+ThwA6X/LfsTJZ7/m5Lbv/gPb9ZrG4deZNxYXVjherxy
         1pVVlIrGZ9ktH1Y+HESfOJ58hKJHsSiF4wTSUvkVXOZTB5vDLbO6plEXzQdkaj8vETkR
         +Qk+7PcnJdwyi3M6TNqPGhF4XBNCV6z3vIT7l4amP/BxuBy/tsf3IkbYFzHKjPKjkAot
         z5HQ==
X-Received: by 10.60.146.202 with SMTP id te10mr987248oeb.13.1371745450325;
 Thu, 20 Jun 2013 09:24:10 -0700 (PDT)
Received: by 10.182.200.169 with HTTP; Thu, 20 Jun 2013 09:24:10 -0700 (PDT)
In-Reply-To: <8761x87wc8.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228511>

Hi,

On Thu, Jun 20, 2013 at 3:20 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Francis Moreau <francis.moro@gmail.com> writes:
>>
>> But I'm wondering if someone can see another solution more elegant ?
>
> I think there's a cute way.  Suppose your arguments are of the form

Really nice !

>
>   p1 p2 ... --not n1 n2 ...
>
> that is each pX is positive, and each nX is negative.  Then as you
> observed, building the difference with master is easy: just add it to
> the negative args.

I didn't know that git-rev-parse could be used to transform any range
specification into that form (p1 p2 .. -not n1 n2..)

>
> Intersecting with master is harder, because you don't know what parts of
> it (if any) are in the range.  But the --boundary option can help: these
> are the commits where the positive and negative ranges "first" met, and
> prevented the walk from continuing.
>
> So the part of master reachable from p1, p2, etc. is exactly the set of
> boundary commits of 'p1 p2 ... ^master'.  And on top of that, excluding
> the parts reachable from the n's is easy.  So you can do:

Really clever.

>
>   positive=$(git rev-parse "$@" | grep -v '^\^')
>   negative=$(git rev-parse "$@" | grep '^\^')
>   boundary=$(git rev-list --boundary $positive ^master | sed -n 's/^-//p')
>   # the intersection is
>   git rev-list $boundary $negative

I think there's a minor issue here, when boundary is empty. Please
correct me if I'm wrong but I think it can only happen if positive is
simply master or a subset of master. In that case I think the solution
is just make boundary equal to positive:

     # the intersection is
     git rev-list ${boundary:-$positive} $negative

Now I'm going to see if that solution is faster than the initial one.

Great Thanks
--
Francis
