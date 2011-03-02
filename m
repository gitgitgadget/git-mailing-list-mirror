From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: got myself into trouble; now what? - how to revert once you've pushed
Date: Thu, 3 Mar 2011 02:52:40 +1100
Message-ID: <AANLkTi=Oiu19R8+hX16gWDghkPkYf12731KkYctwQgEG@mail.gmail.com>
References: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
	<20110301195027.GE10082@sigill.intra.peff.net>
	<AANLkTi==_zmSy4j-JwyCuYouV-J3shSObJe2y942PjCn@mail.gmail.com>
	<20110302133720.GA26989@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Buck <buck.robert.j@gmail.com>, Jeff King <peff@peff.net>
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 16:52:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuoM2-0001VV-KT
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 16:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1CBPwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 10:52:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54152 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBPwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 10:52:41 -0500
Received: by wwb22 with SMTP id 22so145403wwb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gNsQ4hbxnXpiCVDmJSyt2Xzyrh6oArStWcSaU4HQ6wA=;
        b=U80wCqoeNk73RdBkEjbe8N4ICyNHfKMMLO/SJRMTpxqSfQLcbeFF870qS2qXKG9KoT
         MM2nyWAaSwgskhbuz+L3uEI/Bmv3s3oQjcE2zy3uz91O/ywH0H4yUotm+6F+xr0odIi1
         EgODE23Nv5pacYttA5oQSy08MRF0D1DVw7/H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pcz7K/M4dlUN0EQIAPDjwsX25iS9d3aWLmJYfOLYh7VjG4rRVA/rLX2SpZTYRBySSi
         FclobBFVArFx+68h9NLbA4MO4EOnCRT+fcz3tT/3vlyAACvLxD24agVJBYwP+Jx5S/pV
         ks0glzvxwzkH4TYC7PN0+ApeslnZG9pkkHjeI=
Received: by 10.227.166.201 with SMTP id n9mr2084272wby.157.1299081160284;
 Wed, 02 Mar 2011 07:52:40 -0800 (PST)
Received: by 10.227.64.66 with HTTP; Wed, 2 Mar 2011 07:52:40 -0800 (PST)
In-Reply-To: <20110302133720.GA26989@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168314>

Here's the approach I take to backout a merge with a bogus topic
branch. I use this in a large team environment where backtracking the
shared integration branch is simply not an option.

Suppose a topic branch 'topic' was merged with master to produce a
merge and then it was decided that topic was a little half-baked

e.g.

$> git merge topic #1
$> git tag M

$> git checkout -b deliver-topic M^2
$> git diff --full-index M M^1 | git apply --index   # should work if
#1 did not produce a conflict
$> git git commit -m "backout premature delivery of topic"
$> git checkout master
$> git merge deliver-topic  # backouts changes contributed by #1

This assumes that neither the original merge with bogus or the merge
with deliver-topic produce any conflicts.

Then, suppose I fix the original problem with the topic branch by
making additional commits to the original topic branch
that fix the problem.

I then revert the revert on the deliver-topic branch

$> git checkout deliver-topic
$> git revert # revert the backout to restore the deliver-topic to the
same state as the original topic
$> git merge topic # this is the fixed topic
$> git checkout master
$> git merge deliver-topic

The nice thing about using a separate delivery branch to manage the
backouts of prematurely merged topics is that the topic branch
itself stays clean. All the revert and apply logic is confined to a
delivery branch which can be forgotten about once the history moves
on. Yes, the integration branch itself looks a little messy, but
integration branches tend to a look a little messy anyway.

jon.
