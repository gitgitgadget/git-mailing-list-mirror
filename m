From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Sat, 13 Apr 2013 10:19:20 +0530
Message-ID: <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com> <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 06:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQsPh-0002CP-FL
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 06:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3DMEuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 00:50:02 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:46395 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3DMEuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 00:50:01 -0400
Received: by mail-ia0-f181.google.com with SMTP id y25so1979463iay.40
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=j9WPEOkES9bNI+Q3oL4pwUu1Y6w25tT/LoDmFcUe1Js=;
        b=XOCuxiujjo2yuK5QS5m6BGGkv8ZRI3HvRPGCLeEt5X+eT5XzelftKh1vp6ofNBRpnu
         32r7ZlojMPvxs9LNqOqBWL8AiwruIFXS/NTKs4PpTe4aLuIPeo18V3T4SZQK7t47W/ZQ
         mhxcB5TjIUZxXLWOepGDQatu8pMA+eb21MLw6g5M75Z5oH4V2AyzZWj3nlWW0T02AyyZ
         GoasVGQpIyaZZ7aYGrWGsXUuuZt5z+x5L9c6DsTAIKhp/SaZ3Ey1jl28KcMeDILr/Fb/
         WCyGYnY2GQjWHLE7vNiQX9L99UGg980t5x5vBDVnFlFMkuAbzy4UehS5uBWVy2T2wvV0
         FwXg==
X-Received: by 10.50.108.235 with SMTP id hn11mr727286igb.107.1365828600555;
 Fri, 12 Apr 2013 21:50:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 12 Apr 2013 21:49:20 -0700 (PDT)
In-Reply-To: <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221048>

Junio C Hamano wrote:
> The primary reason is the confusion factor Jeff mentioned in the
> thread that inspired this patch.  People would realize it is very
> natural to decide where to push to based on what branch is being
> pushed, but only after they think it long and hard enough [*1*].  I
> suspect that it is an equally natural expectation for casual users
> that the destination is chosen based on the current branch, if only
> because that is what they are used to seeing when they say "git
> push" without any argument.

I agree with you largely, but I would still argue that choosing a
destination based on the current branch is a historical mistake made
by "matching".  We don't have to be stuck with this historical
mistake, because this is a new syntax: when users read about it in the
documentation/ What's New in git.git type email, they will also learn
that it chooses the destination based on the refspec.

> Even though I personally am in favor of this "destination is tied to
> what is pushed out", not "destination is chosen based on the current
> branch", I can understand why some people would prefer the latter,
> and why they find it simpler and easier to explain.

Agreed.  This is a consequence of not introducing triangular workflows
earlier, and getting our users used to distributed workflows.  With
this patch, users must mandatorily know about remote.pushdefault and
branch.<name>.pushremote, if they want to work in multiple-remote
scenarios.  My argument for that is that multiple-remote workflows
have always been a hack until now, and users of that setup will thank
us for fixing this.

> The second reason is purely on the differences between what the
> above clean-nice explanation says and what the patch actually does.
>
> I think "is-possible-refspec" and "pushremote-get-for-refspec" are
> both way over-engineered, even for people who agree with me and the
> above introduction for this change to favor "destination depends on
> what branch is pushed out".  If is-possible-refspec is replaced with
> a much simpler to understand logic, "Is this a local branch name?",
> possibly combined with "There is no such path on the filesystem" and
> "It's not a defined remote" (iow, reject "git push master:next" and
> anything more complex) [*2*], I suspect it would be a bit more
> sellable.

I don't feel strongly either way, as I just want a simple 'git push
master next +pu' to DTRT.  I rarely, if ever, specify the :<dst> part
of the refpsec.  Just so we're clear, we want:

- In git push master, master is verified not to be a path on the
filesystem, not a remote, and finally a local branch.

- In git push master:next, master:next is interpreted as a destination.

- In git push master next:pu, master is verified as usual, and next:pu
is pushed to the remote specified by next.  My patch currently does
this (checks that <src> and <dst> are branches).

- In git push master next:refs/tags/v3.1 and git push master
v3.1:refs/heads/next, master is verified as usual and the refspec is
pushed to the remote specified by remote.pushdefault, falling back to
origin (since the <dst> is not a branch).  My patch currently pushes
it to the current branch's configuration, and I've already marked it
as a TODO.
