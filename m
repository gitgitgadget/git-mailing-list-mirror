From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 20:38:03 +0530
Message-ID: <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org> <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 17:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWphB-0004IT-MY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 17:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab3D2PIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 11:08:45 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:45592 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3D2PIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 11:08:44 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so5779889iag.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e26D27AqYADq4JuMiuV4cfmHm6TlowVr53YLnvsqiqM=;
        b=K0aZNECHcy0uirJP75DIcQLaDIlvNHCVFy4iwa11PboNhV24C8FCp5EwcLWCtFMlsb
         6tI5RlRDnH70/+JW8tTDA7VQc5T6Acg5Sus+QBZnKDUC1gJ52IX9HKAUGB6gHog/Hzv0
         E0IzhDdzxnAmGaylKuiD2SyMBQdOtQpOvZCzSZJQVWLIxvRj9og+xe/+hv0kPE95cONA
         RtyjJyreWylJak87qjJ9VEaxVIjdAGLtO7rdJ5lAtBBGlvSEL5ePeR5aKL+C9+RResY1
         B9Ntukt9eoMXe7IRMS4PKa0WPSKp38E6FVnZSztXWWIXX5RUTCqn5fHGwmZvGKVcL/Qx
         5fEA==
X-Received: by 10.50.57.200 with SMTP id k8mr7652940igq.44.1367248123498; Mon,
 29 Apr 2013 08:08:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 08:08:03 -0700 (PDT)
In-Reply-To: <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222800>

Junio C Hamano wrote:
>  - If the UI language for "rebase" were designed following the
>    "composition using common elements like ranges and revisions"
>    school, it would have started from "rebase --onto=X A..B".

I think you're looking at the whole issue backwards from the way I
look at it.  Let's try to lay out some fundamental principles and
build a representations on top of that:

1. All rev specs (those specified in revisions.txt) either emit a
single positive/ negative (^) commit or multiple positive/ negative
commits (where the ordering does not matter).

2. Fundamentally, all commands require single/ multiple commits to
operate on.  They might also require some additional information.

rebase requires three pieces of information: the commit onto which to
replay, a list of commits to replay, and a refspec to update once the
replaying is done.

log requires one piece of information: the list of commits.

diff requires two pieces of information: two commits to diff.

3. "Range" is not an inherent property of A..B or A...B.  There are no
"revision ranges".

4. Every command is free to interpret positive and negative commits as
it sees fit.  Since there is no ordering, it must never treat one
negative commit differently from another negative commit, or one
positive commit differently from another positive commit.

show takes a list of positive commits and shows all of them.

log will show all the commits reachable from positive commits, and
exclude all the commits reachable from negative commits.  Here, the
"list of commits" are interpreted differently from the show case.

diff can either take two positive commits or one positive + one
negative commit.  In the latter case, it swaps the arguments and
treats both as positive commits.

rebase can take one negative commit and one positive commit.  The
commits reachable from the positive commit, but not from the negative
commit are replayed onto the negative commit.  Now, we can use --onto=
to override the commit onto which to replay.  But the fundamental
constraint remains: rebase _cannot_ make this --onto= parameter part
of the normal rev spec (we only have two types of commits: positive
and negative to which we can assign different meanings).
--

This, I think, is the way forward.  In any command, forcing the user
to differentiate between the two commits only using argv[0] and
argv[1] is just horrible (diff with two positive commits is the only
necessary exception to this rule).

Further, what I think is of utmost importance is consistency.
Inventing loose mnemonics like in the diff case is the road to
insanity.  All commands _must_ behave exactly the same way with all
the different rev specs (or error out when the particular rev spec
emits more commits than the command needs/ the wrong number of
positive-negative commits).

What's more?  I have a solution.  A brand new revspec is the _only_
way to solve our problems without breaking consistency, or trading off
terseness [Who wants to do git rebase --onto master $(git merge-base
master topic)..topic every single time?].  I mentioned it on the other
thread, but didn't get feedback :(
