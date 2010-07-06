From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 17:02:51 +0200
Message-ID: <AANLkTikWGzEq8wiVyu_xJ-tK92N1oRFOrawjOe9UQXkr@mail.gmail.com>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
	<20100705025900.GQ22659@josefsipek.net>
	<67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
	<20100705185238.GS22659@josefsipek.net>
	<20100705192201.GI25518@thunk.org>
	<20100706080322.GA2856@burratino>
	<AANLkTinZ4UV9in60Y4myfUWv08Vx3OMvh-_YQl2BXSjC@mail.gmail.com>
	<20100706142921.GB6666@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, tytso@mit.edu,
	jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9iY-0000kq-SU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab0GFPCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 11:02:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39013 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab0GFPCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:02:53 -0400
Received: by bwz1 with SMTP id 1so3578346bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=JmjcGk+RxxAZ5hgLJGM+qvtUq4I2or5N2bfvciNQ6ow=;
        b=Mg+yzFbkz8LX5cbwdVW+uxiFqsd9+Js0f1LTKy55R3c394wmlaNX3CIVZCK6vl/ZaW
         YSm+9dwLCFt+u9CiZzs9erGZIHu/E/XU6ODS/4o3p9FeGMwvq3IJBN4UO3L8T5c99HWn
         hLjd/sYaCIQw1Ld4tMAgEoHihYQLnKxff2QH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=OgM6hWo+vbXOrhRIzOJCCjpIe7oQhfugRNN05LKwv6do80x0Vcta8J/3eJNyp3kFWZ
         s5wPg89BMJNTnkdGQ3VxDjhzWf4btCFydW37u9XhbBx2t7kTjjm1yq4VwmABd1GGSFD3
         7ruk/xv0ZpXoummQPV0ml+dkD5RbmcJXWnDHU=
Received: by 10.204.85.89 with SMTP id n25mr3792769bkl.105.1278428571979; Tue, 
	06 Jul 2010 08:02:51 -0700 (PDT)
Received: by 10.204.71.1 with HTTP; Tue, 6 Jul 2010 08:02:51 -0700 (PDT)
In-Reply-To: <20100706142921.GB6666@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150361>

On Tue, Jul 6, 2010 at 4:29 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 06, 2010 at 03:53:56PM +0200, Erik Faye-Lund wrote:
>
>> > At one point rev-list did require monotonic --- i.e., the committer
>> > date of each commit had to be equal to or later than that of each of
>> > its parents) with no clock skew but that was considered a bug and
>> > fixed by v1.5.5-rc1~16 (Make revision limiting more robust against
>> > occasional bad commit dates, 2008-03-17)
>> >
>>
>> This might be a stupid question, but I'm not entirely clear on why
>> it's not a strict requirement; surely it would be easy to ensure that
>> the commit-time is at least as big as the parents when generating the
>> commit...?
>>
>> Is it to avoid the case where a user commits with the clock set to
>> some point (potentially far) in the future, so all subsequent commits
>> would have the same, artificially high commit time? Or is there some
>> other reason I can't think of?
>
> You can have clock skew between distributed developers. So imagine you
> commit at 5:00pm, then I pull at 5:01pm, but it turns out your clock is
> two minutes fast, so it's actually 4:59pm.
>
> What should my commit do? If I insist on monotonic increases, then my
> clock gets pushed forward artificially by your fast, broken clock (which
> is probably not the end of the world; in practice, if your clock is N
> seconds fast, there will presumably be some N second period where I'm
> not making a commit, and the clocks can "catch up" with each other).
>

Yeah, but this doesn't really answer my question; as you're saying,
it's probably not the end of the world, at least when the skew is low.

But I can imagine it becoming a big deal when the skew is high. The
again, perhaps this should constitute a "bad commit" and commit should
error out if a parent commit was more than some number of minutes
newer than the current time (or whatever)? That way, skewed commits
would be caught early if a developer is working with other people, and
a lot of the traversal could perhaps be faster (or more robust). If
the developer with the skewed clock doesn't work with anyone, skew
isn't really a problem, but perhaps he'd have to do some
branch-filtering to un-skew commits when starting to work with others.
And only if the skew is really high... like, multiple days... Which
can't really be THAT common?

However, turning a technical problem that already have a solution that
seems to work for everyone into a social one might be a bad idea. I'm
really just thinking out loud here :)

-- 
Erik "kusma" Faye-Lund
