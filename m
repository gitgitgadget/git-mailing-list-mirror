From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 13:29:07 +0530
Message-ID: <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 01 10:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uigjc-0001Qq-9x
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 10:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab3FAIAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 04:00:01 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56894 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab3FAH7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 03:59:48 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so744149iec.13
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=agCwD6ODTBwQra7Ntw94CsWK6tgKvQxtdNNpbSsmEes=;
        b=i+ZGv9TdF0i0NXsCD+TmKDcxkubBCWw3tuvJ/LPVBlV6886fJzI+bMqRguTQxM9Uqz
         TVfgdbeuFM4JeR7gawE7A3mH/IAlCEgUACFxoeMFD/U86yICOscOShA/0Opg5diiS6zf
         /dhYMmkKcuyhA2XiQv1Nsow+vg3nxZdvftnNOtTyJEm6QgKTnNpQhfru6B4qVmIogS8s
         UPdBEj0MRDvfryVdKtdR0ksC4e3z+ebvbdqEyuwHFSGPrfEiG33csTt6SItHi0qDp7zh
         h1hH/FVF/jXKOivjqGGB7FslmMkDABJrj6ag05IZW6Ibb1y4heFVoFPBtM128Ho4U50Q
         +TPQ==
X-Received: by 10.50.32.8 with SMTP id e8mr3263787igi.89.1370073587566; Sat,
 01 Jun 2013 00:59:47 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Sat, 1 Jun 2013 00:59:07 -0700 (PDT)
In-Reply-To: <20130601050355.GA23408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226103>

Jeff King wrote:
> I wonder if simply sticking
> the reflog entries into a big GRAVEYARD reflog wouldn't be a great deal
> simpler and accomplish the "keep deleted reflogs" goal, which is what
> people actually want.

Exactly what I was thinking when I read your proposal.  What is the
point of having individual graveyards for deleted branches?  The
branch names no longer have any significance, and separating the
reflogs using branch names nobody remembers is only making
discoverability harder.

What is the problem we are trying to solve?  Someone deletes a branch
by mistake, and wants to get it back?  There's the HEAD reflog for
that.  So, I think the problem is that the person did a flurry of
creation/ deletion/ rebases, and wants to reach one particular commit
she remembers seeing sometime in the past (possibly in refs/remotes/*,
in which case HEAD reflog wouldn't have logged it).  More than adding
a graveyard to provide hard-to-dissect information, I'm interested in
tooling support for the information we already have.

So, I want to search all reflogs for this particular commit I've seen:

  git log -1 --relative-date -g :/quuxery

Doesn't work.  I can search only search one reflog at a time:

  git log -1 --relative-date @@{0}^{/quuxery}

Isn't this much too painful?

Our "default" reflog command displays useless information: why should
I see HEAD@{1} followed by HEAD@{2} and other numbers in ascending
order?  What is the point of that when the abbreviated sha1 is already
shown in the first field?  I use the following alias for reflog:

  rfl = log --oneline --relative-date -g

but it could easily be better.

There are tons of other issues: for instance, after an
interactive-rebase, 'git checkout -' doesn't take me back to the
previous branch (because the parser for @{<N>} is broken).  There are
way too many SHA-1s polluting the description, which can easily be
replaced by a git-describe output.  When I git checkout @~1, my prompt
doesn't scream the sha1; it shows me upstream-error~1, which makes a
lot more sense.

I was under the impression that heavy reflog users would be more
interested in fixing these issues before dumping even more data onto
the user.
