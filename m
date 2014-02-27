From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 27 Feb 2014 14:46:44 -0800
Message-ID: <CAH5451mHOHb6xAGuqvVKBrB=jjjVJMbov1oBDdSNOG4p8MXRxQ@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
 <CAP8UFD0Wd3FcgxW+Vb-YKACLqqaeF+AAf=YRScZd84t7qiNkjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9jm-0003gw-UR
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaB0Wr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:47:26 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:40853 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaB0WrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:47:25 -0500
Received: by mail-ve0-f177.google.com with SMTP id sa20so1264503veb.36
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 14:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7GB9GJIROcn07JIpEWuhcS+N63MSmMvNjduy0zmk3Y4=;
        b=FSUvIKpB3XPKfj9oIAD299ixas6/7PtszgTjJc+c94LxqjbK6I7kTWSITo76ncpSAz
         1LaWoLBpWXOIRO6X/XZqsTidnyCb0RhI4uwmbMVgc7q4FLcly5gJOOHo6e1uCSDDQ1Tm
         FghX7uIRMawMWlFFDNpT5v1rJFelp8BnQxxLKmhc2k49IV4C0QBacTRipbJ5S7DHAxgu
         YKnbSG83PzCnQyfjIkkNQmHdtxf2p/nBEVQieM1F04qy9+qJZq1/IEKJ75jaJQOPXINY
         IAIBzOLk+nlVSfXMUgt+uzOtfg8U4naB+RYv5AYjDA4JnR+5J676LIy2/Nw3R7vsD/dw
         i3lQ==
X-Received: by 10.58.168.142 with SMTP id zw14mr3190835veb.33.1393541245050;
 Thu, 27 Feb 2014 14:47:25 -0800 (PST)
Received: by 10.221.8.133 with HTTP; Thu, 27 Feb 2014 14:46:44 -0800 (PST)
In-Reply-To: <CAP8UFD0Wd3FcgxW+Vb-YKACLqqaeF+AAf=YRScZd84t7qiNkjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242872>

On 27 February 2014 06:47, Christian Couder <christian.couder@gmail.com> wrote:
> But I think the most important thing right now is first to gather as
> much information as you can from the previous discussions on this
> topic on this mainling list.
> Perhaps you should also gather information on how git bisect works.

I have also, at one time, started working on this problem, though I
never submitted any of my patches :(. I went the way of renaming the
internal logic to make it less tied to the good/bad distinction that
is currently hard coded in. That may not be the best starting point,
but let me summarise the thoughts I had at the time, particularly
around the different adjective pairs that we might use.

A general description of git bisect is that you start with a commit
that exhibits a given property, find a commit that does not have that
property, and then look for when the property was introduced. I think
of this property as the 'bisect property' of the bisect search. The
property is described with our adjective pair, currently 'bad' (with
the property) and 'good' (without the property). We assume that
commits with the property have an ancestor without the property, and
as this assumption is so essential to how git bisect works I think of
it as the 'bisect relationship' of the bisect search, and we care
about the direction of this relationship between commits.

The proposed adjectives tend to be along the lines of the following:

- good->bad (current); good<->bad
The bisect property is currently always described as 'bad', the
introduction of a bug being the motivating use case. The problem with
this is that we often want to find when a 'good' behaviour was
introduced, or when a neutral change occurred.
A solution is to allow reversing our bisect relationship, by either
detecting the intended direction or allowing the user to choose. If we
reverse the direction our adjectives also flip, and so the bisect
property we are now looking for is 'good' instead of 'bad'. The terms
good and bad don't work well with neutral searches.

- unfixed->fixed
For this pair, the bisect property would always be described by the
'fixed' adjective. It seems odd to ever reverse the bisect
relationship, as we don't usually say something was 'fixed' and then
became 'unfixed'. The behaviour of this pair would thus be near
identical to current usage of 'good->bad', but with the bisect
property conceptually reversed (when was a bug fixed vs when was a bug
introduced).

- old->new
This pair avoids making any judgement on what type of bisect property
we have. The adjectives are thus simply describing the bisect
relationship, and the user is free to use any bisect property they
wish. The main problem with this is that it is possible to have
commits without the property (thus described as 'old') that were made
chronologically after a commit with the property ('new'). This has the
potential to cause confusion for users.

- without->with
This pair also avoids making a judgement on the bisect property, but
avoids potential chronological confusion that 'old->new' has. You
could potentially allow users to reverse the bisect relationship's
direction, but these adjectives allow you to easily invert the bisect
property without causing confusion. For example, 'without bug XYZ' can
instead be written as 'with bug XYZ fixed'.

----

My preference is for the without->with adjective pair, as I believe it
maps most closely to the concept of finding a commit that changed a
given property, and it allows that property to be negated without
introducing too much confusion. Reversing the relationship's direction
would also make sense, however that is a significantly greater change
to the commands logic.

Thus, my initial work was to refactor the internal naming to use the
terms with and without, as that would make a better place from which
to add other features (such as reversing the relationship direction,
or adding new adjective pairs).

Sorry if that is all confusing to read, or if I'm repeating things
that have been said before :)

Regards,

Andrew Ardill
