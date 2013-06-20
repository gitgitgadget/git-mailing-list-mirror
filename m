From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 15:39:38 +0530
Message-ID: <CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
 <1371640304-26019-4-git-send-email-artagnon@gmail.com> <7v38sdzx8o.fsf@alter.siamese.dyndns.org>
 <7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 12:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upbov-0002wX-E2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 12:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329Ab3FTKKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 06:10:21 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38591 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153Ab3FTKKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 06:10:19 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so15967588iec.13
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s88seMah4uAaR5TKrUNLBqamIy0Defya0uCCwC/sX/k=;
        b=btqyVu9gf3kli0yZHJWSVsp2vu5UxVlTUNq813qMyv/cEVj9d/LbH9Eial6IDlnlz2
         OHqKDCxRdqOJTixTXsURo5OXMgW1j+hH0z0DIfaJNzgHfWE9pNT/9nSatWr32cZhZ/UU
         C1gtaVdJygWuU5VOuZSKPyY5LO8jvnVFa2WD6Ssqiqv0IKS8jl2CyKsIraqL+z4nQJHU
         /NPdzglFcrfsbJmtpADUc5KBSy9y9h8c77xemrHD2OIJCGHJWFdIr4Z84nlvVG/wwekf
         dg7uBHootxdLwY3ezuxiDYRYKP7FGY4WVSInYNjMQClONMvc9k1xpPHIGH23zLxbkKHR
         B42w==
X-Received: by 10.50.154.106 with SMTP id vn10mr11936216igb.0.1371723019467;
 Thu, 20 Jun 2013 03:10:19 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 03:09:38 -0700 (PDT)
In-Reply-To: <7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228475>

Junio C Hamano wrote:
>> Decouple `simple` from `upstream` completely, and change it to mean
>> `current` with a safety feature: a `push` and `pull` should not be
>> asymmetrical in the special case of central workflows.
>
> Double negation confused my parser.  'push' and 'pull' should be
> kept symmetrical in central workflows?

They're not the same thing.  It is very much intentional and intended:
the safety net is not to "ensure that the push and pull are
symmetrical" (i.e. among other things, error out if
branch.$branch.merge is unset), but rather "ensure that the push and
pull are never asymmetrical".

>> Without any configuration the current branch is pushed out, which
>> loosens the safety we implemented in the current 'safer upstream'.
>>
>> I am not convinced this is a good change.  I am not convinced this is
>> a bad change, either, yet, but this loosening smells bad.
>
> Provided that we would want to keep the "Push the current one to the
> same name but you have to have it set up as your integration source"
> safety for central workflow (which I am starting to think we
> should), we would want something like this on top of your entire
> series, I think.  The behaviour change can be seen in the revert of
> one test you made to the test that expects "simple" to fail due to
> the safety.

Now I'd like to question what you are labelling as "safety".  What is
the consequence of erroring out when branch.$branch.merge is unset
when pushing using `upstream`?  For me, it only means additional
inconvenience: any new branches I create can't be pushed out without
explicitly setting branch.$branch.merge to an "invalid" value.  What
is invalid about it?  The fact that it doesn't exist, @{u} still
doesn't resolve, and git branch -u doesn't work.  Hell, even git push
-u doesn't work!  So, what is this huge "safety" that can justify
inconveniencing me like this?  By making sure that
branch.$branch.merge is set, my prompt responds immediately to
divergence, and this is awesome.  Predictably, I use git push -u when
I push out a new branch with `current`.  So, unless you have a damn
good reason to inconvenience me in the name of safety,
branch.$branch.merge should default to refs/heads/$branch, unless set
explicitly.

I didn't want to contaminate this series with an unrelated improvement
to `upstream`, which is why you don't see the change here: it is
orthogonal to designing a good `simple`, and I only brought it up to
question the "safety" you're carrying over to `simple`; what
obligation does `simple` have to carry over this "feature"?  I've made
it clear that I want a clean break from `upstream`, and I find your
proposal is very inelegant: `simple` has two modes of operation; when
branch.$branch.remote is equal to $pushremote, branch.$branch.merge
must be set and equal to $branch (the `upstream` mode); when
branch.$branch.remote is unequal to $pushremote, don't care about
whether branch.$branch.merge is set (the `current` mode).  My proposal
is much smoother than this "modal" operation, no?
