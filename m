From: Geoff Thorpe <qc.libre@gmail.com>
Subject: is it just me, or does --all ignore --no-tags?
Date: Wed, 22 May 2013 17:16:14 -0400
Message-ID: <CAKSmPgYFLZ59uAek8=GMXZE2tgGMo40s=y8X87m2GJbPVJo9WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 23:16:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfGOZ-0002z9-OM
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 23:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148Ab3EVVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 17:16:18 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:57329 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912Ab3EVVQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 17:16:15 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so6388590iec.21
        for <git@vger.kernel.org>; Wed, 22 May 2013 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jjGATbO0cLOwxd3nCLEleBn/4K0HHtw3ibpQgPTfuis=;
        b=vHnp5hYRwC0tquTWwqp67OU64nrjtJdcGsB82nrUHdCnk0rqu3kdwbbhAjuqdwAHd9
         muxK4hIaK77wxtUSwQydSkcu1rBPIriMVVNJuwZ61DF04Faj39nAnFvmoMtrpNnsEQ6m
         u79nzaPNtaJ3RhDGuPJJ+133IlKBWdbCFuwdjoSAmS/O7FKnxmv8bViD3hJG3Cey/fOQ
         GJTpuey6A31Yq4ytPKTf6Z/tM5uKAhlmrHL1YURosViNcFxxeZmxR7BkfivextnCf4pS
         j4qEOmGXGYO2KyJORSdlPa5dIPhVuGPS5D/h75/yuVi/q+/K2TfwnVU7r1rUXIF35jPo
         rLMw==
X-Received: by 10.50.114.161 with SMTP id jh1mr3481958igb.112.1369257374511;
 Wed, 22 May 2013 14:16:14 -0700 (PDT)
Received: by 10.64.57.115 with HTTP; Wed, 22 May 2013 14:16:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225192>

I have some peculiar reasons for doing this, but nonetheless I don't
believe there's anything illegal here. I have a repo with a bunch of
remotes set up to pull in branches and tags from different places, and
I need all those branches and tags name-spaced. Eg. to illustrate, the
config looks something like;

[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
[remote "foo"]
        url = git://some.address/foo
        fetch = +refs/heads/*:refs/remotes/foo/heads/*
        fetch = +refs/tags/*:refs/remotes/foo/tags/*
[remote "bar"]
        url = git://somewhere.else/bar
        fetch = +refs/heads/*:refs/remotes/bar/heads/*
        fetch = +refs/tags/*:refs/remotes/bar/tags/*

If I do "git fetch --no-tags foo && git fetch --no-tags bar",
everything's fine - all the branches and tags from "foo" sit under
refs/remotes/foo/{heads,tags}/, and similarly for "bar". OTOH, if I do
"git fetch --all --no-tags", it's as though the --no-tags wasn't
there. Inverting the argument order doesn't seem to help.

What this means is that in addition to putting branches and tags in
the locations specified in the refspecs, it also puts copies of all
the tags in refs/tags/. In my case, "foo" and "bar" will sometimes
define the same tag name but they don't refer to the same thing,
that's (one of the reasons) why I need them name-spaced. The current
situation with "--all" is that refs/tags/ contains an ad-hoc union of
tags from the different remotes, and if there are any collisions they
seem to resolve in favour of whichever was fetched last.

So instead of doing;
    git fetch --all --no-tags
I'm now doing this to avoid the problem;
    git remote | xargs -n 1 git fetch --no-tags

BTW, I've hit this problem on a system I don't administer, so I can't
easily verify this with the latest source. It's a ubuntu system and
"git --version" indicates 1.7.9.5. Apologies in advance if this is
just noise about an already-fixed-bug, but I didn't find anything via
a quick search (of the mail-list and the net more generally) so
figured I'd send this in.

Cheers,
Geoff
