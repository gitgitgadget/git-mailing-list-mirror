From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 14:38:09 +0530
Message-ID: <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKAR-0002Am-31
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934547Ab3DHJIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 05:08:53 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:36468 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934520Ab3DHJIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 05:08:53 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so2933859bkc.17
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Uiq3HnGcvyPtgbnMhlLl3mlPf+Ywebos9/VOlNykVTs=;
        b=f7UaUVc7jHmuFa79DZusZxe42BwbxID//gApQsIPsh+UadpSbUC61U6PUILxCXIsb5
         kdtukM/LasJPwRTOwN2McJoCXNVCAXFmvbsI45U6arggrSMWhBYFxqPQ19NDBKsb/0O/
         88vqFGIarWKZAqh2x9T3mvQzpprNfFpXtk/Y6XbvJdyjnnRp8RRAGoq9jJvMLpJlVMgW
         jJnOiXFFmvzEvXsfPt7yddJxAuK2H8o4wqGw/ZSH+sF5+PF5Chny8LqMrNflQJ1J/TlP
         nx/xlhA+vzXjfomMwsD8MbSRmsCJjvej5sSr8SPrgz0IWYS6vlteBZjWR+ccbUwsn+fz
         1xkA==
X-Received: by 10.205.39.194 with SMTP id tn2mr10636106bkb.80.1365412130256;
 Mon, 08 Apr 2013 02:08:50 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 8 Apr 2013 02:08:09 -0700 (PDT)
In-Reply-To: <20130408081959.GD20159@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220410>

Jonathan Nieder wrote:
> What do you think of .gitignore and .gitattributes?  Should they be
> somewhere other than the filesystem as well?

I would argue that .gitignore and .gitattributes are done right.  They
are integrated into a very mature part of git-core very well, and
their nature is fundamentally different from that of .gitmodules.

.gitignore and .gitattributes specify extended globs (see: wildmatch)
rules to apply on the worktree, and can be in multiple places in the
worktree.  They apply strictly on the current worktree; they have
nothing to do with the index, and have no interaction with other
objects in the repository.  Now, you might argue that they should be
part of the tree object, but I will disagree because they don't
operate on concrete entries in the tree but rather extended globs that
match worktree paths.  .gitmodules, on the other hand, specifies
fundamental repository composition: it should be a special object in
the tree precisely because it changes the fundamental meaning of one
concrete tree entry.  It has nothing to do with path treatment in the
worktree, and hence has nothing to do with .gitattributes
or.gitignore.

> I don't think Jens had any obligation to work on submodules and
> nothing else for the last five years. ;-)

I know.  What I'm saying is that his current approach is just filled
with tons of unnecessary complexity, inelegance, and pain.  This is
evidenced by the fact that the current submodule system is pathetic
after five years of work (and I don't think the developers working on
it were particularly incompetent or lazy).

> If you end up convincing others that your tools are worth working
> on and those tools pleasantly take care of the same workflows that
> submodules do, then I imagine people will be happy to migrate.

Yes, I'm planning a strict superset of the current submodule system
features.  After some thought, I've decided not to have any feature
regressions in my first version for merge (although that means a lot
of work for me).

> Speaking only for myself, I actually prefer the submodule UI, despite
> not being thrilled with the
> single-.gitmodules-file-at-the-root-of-the-worktree feature.  So I
> will not be working on your proposed redesign, unless it evolves
> enough to be as pleasant a UI as (the long proposed UI of) submodules.

I'm very interested in building a pleasant UI.  I've always been a
person who cares deeply about UI: this is evidenced by my recent
remote.pushdefault patch, and my pull.autostash WIP.
