From: Damien Robert <damien.olivier.robert@gmail.com>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 12:23:18 +0100
Message-ID: <20140227112317.GC1215@feanor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 12:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIz3s-0007TQ-7m
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbaB0LXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:23:25 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:51774 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaB0LXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 06:23:22 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so2729374wgh.33
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 03:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:newsgroups:user-agent;
        bh=xfor9gEYNW9zpGk80khmD+UZFqPAiq5WslfqC0wAlyQ=;
        b=QnPsWLLDGrVe4IX4iUStYa4Grw7MceMx/5tNqOv4p7OFj/Qud+GgiTBMSrvEsexVV7
         MQ+cXb6G8zh8FWontSxLUkcflBLW78tpPXNG98l8724EGy9IJHSsaKSKqwSfbJXuuxo/
         5gKKNGIvMDMZyg6LTjUaW/K5ZNxsUYYWfUFolo/gTFuUTIyI9s9ogGS3YjxiVYlgYfov
         QaC9TPWNUpjdOgq8e5OCGgPmmG1f81xhFzMHpNYxBTJcG5eGfIJYHOwK8LLP7Vh950tY
         uCOOr0BMAMVyG3UE+5SeyJr+ie9+db9D21lApF0yMCHJabjF5Pi6hynp/UufH70vSPsx
         Y+BQ==
X-Received: by 10.180.109.77 with SMTP id hq13mr2200211wib.0.1393500201373;
        Thu, 27 Feb 2014 03:23:21 -0800 (PST)
Received: from feanor ([2a01:e35:2e95:b9b0:de85:deff:fe74:f5f5])
        by mx.google.com with ESMTPSA id f3sm14391679wiv.2.2014.02.27.03.23.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 03:23:20 -0800 (PST)
Content-Disposition: inline
Newsgroups: gmane.comp.version-control.git
X-Start-date: Thu, 27 Feb 2014 12:13:21 +0100
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242804>

Matthieu Moy  wrote in message <vpqzjlf5q2z.fsf@anie.imag.fr>:
>> Maybe status should display a stash count if that count is > 0, as
>> this is part of the state of the repo.
> Maybe it would help some users, but not me for example. My main use of
> "git stash" is a safe replacement for "git reset --hard": when I want to
> discard changes, but keep them safe just in case.
> So, my stash count is almost always >0, and I don't want to hear about
> it.

Related to your comment, I adapted git-stash
  https://gist.github.com/DamienRobert/9227034
to have the following (mis)features:

- There is a global --ref option that allows to specify the reference the
  stash will use (by default this is refs/mystash, git-stash.sh uses
  refs/stash).

  This allows to differenciate between different uses of stashes: save WIP
  before switching branch; keep a backup before a git reset;...

- There is a new command `git mystash dosave` that works like git stash but
  does not reset the worktree afterwards. Note that `git stash create`
  already does that, but it handles options differently than `git stash
  save`. `git mystash dosave` can be seen as a wrapper around `git stash
  create`.
  The reason is that while `git stash create` is intended for scripts, `git
  mystash dosave` is intended for the UI. One example of when we don't want
  to drop the worktree is when we want to do a `git checkout -m -- paths`
  but we want to save the current state in case the merge has conflicts.

- `git stash branch` pops the stash once the branch is created. I did not
  like this feature so `git mystash branch` does not pop the stash; use `git
  mystash popbranch` to have the original meaning of `git stash branch`.

- `git mystash save` (and `git stash dosave`) has a new option
  `--on-branch` which stores the stash onto the current branch rather than
  in $ref_stash. The idea is that when I use `git stash` for a WIP, then
  when I come back to the original branch I always forget that I had a
  stash for this branch, and if there were several WIP in between it can be
  hard to remember which stash to apply. With `--on-branch`, when I come
  back to the original branch I am now on the stash, and I know I just need
  to apply it. For that `git mystash apply` (or `git mystash pop`) also has
  a `--on-branch` option that tells it to use the stash on the current
  branch.

- `git mystash info` gives informations about a stash.

So obviously not all of these would be good for inclusion into git, but
maybe some of them would be somewhat worth it. When I have the time I'll
try to write tests and send proper patches.

-- 
Damien Robert
