From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sat, 31 Jan 2009 09:56:22 +0900
Message-ID: <20090131095622.6117@nanako3.lavabit.com>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> 
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> 
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com> 
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4Bb-0000dz-VC
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbZAaA4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbZAaA4u
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:56:50 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46098 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbZAaA4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:56:49 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id B7D70C8406;
	Fri, 30 Jan 2009 18:56:48 -0600 (CST)
Received: from 8540.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id YRJGV2K0IWJ6; Fri, 30 Jan 2009 18:56:48 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=sNnAchOLfvYvJQ09lNJ7U62xwzq9T2Shp8zs2sZJHERsWPQlG1/Lw4TdM+XzaGhsO/zt7aZOYO4i/OX8Fxao9pV14aD4uZNE1QCcsTuguFwN14do5It6q+2XTZNdAja9FSh/sge1FcAxpsoapWevJ7CFw+pwACGKH2CwGFQsY3w=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107894>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> You cannot just cater for one workflow and fsck the other workflows over.
>
> You'll have to devise a method that helps the workflow you are interested 
> in, but leaves the others alone.

I think you'd want to repeat that to yourself when you propose to switch
the default for denyCurrentcurrentBranch config to "true" too hastily the
next time?

I don't think your patch matches the tradition of how defaults are changed
in git project. You don't introduce a large change just after the maintainer
hints about going into a freeze for 1.X.Y release when Y isn't zero.

I assume that everybody, including the maintainer who is too heavyweight
and has too much inertia to accept too sudden a change of the course,
wants to eventually make the default to deny pushing to the current
branch. But I think such a change should come at 1.7.0 release at the
earliest, and a constructive thing to do is to put in a patch to 1.6.2
that helps the users with the eventual transition.

How about doing these before the 1.7.0 release?

 1. Add some code to git-clone to set the config to "deny" if it is
    not a bare repository. The reason I think this makes sense is
    because the reason why old-timers want to push into the current
    branch is because they are used to the old layout that doesn't use
    separate remotes. If they use today's git-clone and still want to
    use the old layout, they need to update the config file in the new
    clone anyway. The "deny" is just another thing for them to fix at
    that point.

    I suspect that Junio will not like this in 1.6.2 because it is an
    unannounced and unplanned change in behavior, but I think it is a
    reasonable preparatory step, probably in 1.6.3, before you change
    the default to deny in release 1.7.0.

 2. Reword the warning message as Junio suggested in his response. I
    don't know the details of the code very well, but I think you can
    tell a repository that doesn't have the config at all from a
    repository that has the config set to "warn", and you can use
    "annoyingly long" (in Junio's words) message to force the user set
    the config to a desired value only when pushing into the former
    kind, and say that the default will change to deny in release
    1.7.0. When pushing into the latter, the warning message can be
    shorter (probably you can say "warning: updating the current
    branch in a non-bare repository" and nothing else).

 3. Reword the error message as you proposed to say "error: won't
    update the current branch in a non-bare repository", without
    saying anything else. You want to eventually change the default to
    deny, and there is no point to teach how to allow it to people who
    set the config to deny themselves, nor to new people who created
    their repository with updated git-clone.

    I think this makes sense to do in 1.6.2 release, because the only
    people who will see this message will be the people who set the
    config to deny themselves, especially if you postpone the change
    to git-clone for the upcoming release.

What do people think?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
