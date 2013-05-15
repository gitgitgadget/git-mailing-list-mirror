From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 17:56:56 -0500
Message-ID: <CAMP44s1kWkNgFMAvThczCvTZppWGca0YvGv=CQ15GtViA1zy_Q@mail.gmail.com>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
	<7vzjvvanro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 00:57:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uckd5-0000Hy-HB
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 00:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3EOW46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 18:56:58 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:61686 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3EOW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 18:56:58 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so2362730lab.35
        for <git@vger.kernel.org>; Wed, 15 May 2013 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vodOXYk45NsYqO68m+GSk1Nmw5GSM8Q7j+Su/MbwEcY=;
        b=nL9hyUW4oYDxLepRUHvGDJZAfTCUiKz3l08PhdSr8DU2xNuSMPE6Q35yXS9XvshqSN
         hx3VZbFzS0SdB3UwxVvxLBEmbVkgvvFx2IVQVgU46dbcK40Vug5F/ZUhMe4ZdTC0cd5q
         bq6w3s9lsL/USdjYhh913WXG9VEbAzwgRily8BDh9VjQLATYPNVGrUESiRUetp/uMukH
         8Z0Jm2qHWmqCbrhnViLYHS9puBx0HCsWFqiREVP6WD6IQOMSM8cj/joIvhAjMzpBBucP
         zEbYwRityF/15bSZ+siGOQwW9X6HnBbmR5DV8yK2PezSZtHElMNr2xqSB7dgOsKVmbUO
         LKgA==
X-Received: by 10.112.135.70 with SMTP id pq6mr18826328lbb.82.1368658616305;
 Wed, 15 May 2013 15:56:56 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 15:56:56 -0700 (PDT)
In-Reply-To: <7vzjvvanro.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224454>

On Wed, May 15, 2013 at 5:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The 'base' branch will be set each time you create a branch from another;
>> 'git checkout -b foobar master' sets 'master' as the 'base' of 'foobar'.
>
> "git checkout -t -b foobar mastee" would instead set 'upstream' of
> 'foobar' to the branch 'master' of remote '.' (the current one).

Yeah, but I don't to set an upstream, because 'master' is not the
upstream of 'foobar'.

> This 'base' is a new mechanism to explicitly say "The upstream of
> this branch lives locally" by not setting "branch.foobar.remote".

No, 'base' can point to a remote tracking branch.

>> Then you can do 'git rebase foobar@{base}' or simply 'git rebase', and Git will
>> pick the right branch to rebase unto, even if you have no 'upstream'
>> configured.
>
> Surely you can teach rebase to pay attention to 'base' and achieve
> that.  But you can already do so with upstream, so this is not an
> advertisement of a 'plus', but rather a lack of 'minus' (which is
> not a bad thing at all).

Only if there's an upstream configured, which many times is not the
case, and many times causes side-effects the user doesn't want to.

The purpose of 'upstream' is completely different.

>> This way 'git fetch' will keep picking 'origin', and other commands that make
>> use of 'upstrem' would be undisturbed.
>
> And this is the true plus, because 'git fetch' with the current
> "setting a local base using the same upstream mechanism to point at
> a branch of _this_ repository, indirectly setting the upstream
> _repository_ for this branch to the current repository" will end up
> making you fetch from yourself, which is not very interesting.
>
> So I think I understand your itch and I agree that it is a valid
> one.
>
> I however am not yet convinced if that direction is what you really
> want go in, though.  What should your 'git pull' on that branch do,
> for example?

Exactly the same as 'git pull' does right now.

'base' has absolutely nothing to do with pulling or pushing.

> When you are on foobar and want to integrate with the branch you
> based your work on (i.e. local 'master'), you can do one of these:
>
>     $ git pull
>     $ git pull --rebase
>
> to "fetch the upstream branch and integrate with it", without having
> to even care if that upstream branch is from the remote, or happens
> to be truly local.  By making 'git fetch' to go to the remote origin
> site, what will you be merging (or rebasing on) when you do the
> above two?

The same as we do now.

> Incidentally, I suspect you can do exactly the same thing without
> introducing a new concept "base" and instead special casing a remote
> whose URL is "."; you essentially declare that "The upstream of this
> branch whose branch.$name.remote is set to '.' lives locally", which
> is not all that different from saying "The upstream of this branch
> whose branch.$name.base exists lives locally", which is what you
> seem to be proposing.

That would be good, but it doesn't have the same benefits:

If I have set an 'upstream' branch, say 'github/master', and I have
'base' branch, say 'origin/master'. I would expect 'git rebase' to
rebase onto 'origin/master'. When I do 'git push', I expect to push to
'github/master'. Moreover, I would expect 'git fetch' to fetch from
'origin', but that can be discussed later.

Right now I'm forced to choose a single branch and set it to
'upstream'. If I choose 'origin/master' (which is not really the
upstream), the rebase would do what I want, but not the push, unless I
have configured a remote.pushdefault, but that would only work if I
the real upstream is the common one. If I choose 'github/master', then
rebase would not do what I want (and neither would fetch).

> One of the things this alternative approach
> would "special case" such remote is probably to cause "git fetch" to
> ignore such a branch.$name.remote setting and instead go fetch from
> 'origin', just like your "if there is branch.$name.base, but no
> branch.$name.remote, fetch will go to 'origin'" does.
>
> But it has exactly the same "what happens when you do 'git pull'"
> problem, so even though it is conceptually a lot simpler, it has the
> same brokenness.

There is no brokenness; 'git pull' does different things depending on
the configuration. With my proposal nothing would change.

-- 
Felipe Contreras
