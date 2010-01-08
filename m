From: Avery Pennarun <apenwarr@gmail.com>
Subject: Idea: global git object cache
Date: Fri, 8 Jan 2010 16:05:15 -0500
Message-ID: <32541b131001081305nc25a811i73c96d1d252b9246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTM1d-0007e3-I8
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab0AHVFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 16:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944Ab0AHVFh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 16:05:37 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:41028 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0AHVFg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 16:05:36 -0500
Received: by yxe26 with SMTP id 26so19070750yxe.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=qlDN9SejSQn9HXTCt2MnNsInPBjLI7xzrtQ2W7j/vUo=;
        b=atbcmDh2VzuERTBfAywkCL2Kb17l0Rnf8vfGV6UcoDG0p8C/b4yiuHvjM69jT5gxCY
         rx74s+BAh30nw3dWXs9P4PKKRiEKT0XHerZ9I/Y01m40NO1iQGLeE/LalI7Jk/x6ZgYU
         pZLSbnNbX0eDTqzjOwh+NcQMvnP6yguY6smQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=CvywbPnnfHrpqu/oO83RRV2GpLKg/2FDEaoFtRwt0PEUJ5nPHu5XlQfH0aock1Scbl
         SiBo0NbVx55ybnYvpU548Gg6MyaWrU6ozPeAvgxMIG3RGmQlfln7CgjH0DYPC7AbPuVF
         nDMcslZuPBKUFVSIkJNroy8WhXXss48Ox3fBU=
Received: by 10.150.117.35 with SMTP id p35mr1394744ybc.210.1262984735725; 
	Fri, 08 Jan 2010 13:05:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136477>

Hi all,

One thing I find curious about git is how objects mostly aren't shared
between multiple repositories on the local system.  For example, if I
do:

   git clone git://git.kernel.org/pub/scm/git/git.git  git1
   git clone git://git.kernel.org/pub/scm/git/git.git  git2

Then I end up downloading the same objects from kernel.org *twice*.
If I use --reference on the second clone, then I can avoid
re-downloading all the objects, and it's much faster.

Unfortunately, I have to provide that option by hand, which is a
problem for git-submodule: it goes out to clone someone else's
repository automatically and doesn't know how to guess a value for
--reference.  Another thing I commonly want to do with submodules is
to rm -rf the submodule's files, eg. because I change branches and git
doesn't clean it automatically.  But then when I switch branches back
to the one with the submodule, git wants to go re-download the
submodule *again*.  Redoing the checkout makes sense to me (just as
git deletes/recreates files when I normally switch branches) but
re-downloading seems silly.

So here's my suggestion to minimize downloads in a pretty easy way:

- whenever git creates a packfile in any repo (eg. during git gc or
git fetch), make an *extra* hardlink of it into
~/.gitcache/objects/pack.

- whenever git is considering which objects it does/doesn't currently
have, also consider the packs in ~/.gitcache/objects/pack (ie. using
the git/objects/alternates mechanism).  If one of the packs qualifies,
hardlink it into the current repo.  Maybe give it a .keep file to
indicate that it's counterproductive to repack this pack.

- after git deletes a packfile in any repo (eg. during git gc), check
the link count of that pack in ~/.gitcache/objects/pack; if it's now
down to just 1, there are no other users of the pack, so delete it
there too.  You would also need to prune the cachedir occasionally to
deal with repositories that were deleted in other ways (eg. rm -rf).

- share the list of refs in a similar way (noticing that you probably
have different refs in multiple repos that are named
"refs/heads/master" of course) so that fetches will be efficient.

- extra improvement to submodule behaviour: hardlink packs from the
submodule into the supermodule's objects/pack directory (or use a
different directory like .git/submodules/pack to keep things
separate).  Also, submodules should use the superproject's pack
directory as an alternate, in case (as often happens for me) the
supermodule already contains a bunch of objects from the submodule,
because the modules were split at some point.

I believe this would be quite easy to implement and would give an
immediate efficiency improvement.  The ~/.gitcache feature could be
enabled/disabled by a config option.  Is there any reason not to do
it?

Thanks,

Avery

P.S. I've been testing git's behaviour with lots of very large packs -
I'm currently using about 58 packs of about 1 GB each - as part of my
'bup' git-based backup tool (http://apenwarr.ca/log/?m=201001#04).
Repacking and fsck are obviously horrendously slow with that much
data, but bup avoids those operations as much as possible, and a
~/.gitcache wouldn't need to worry about them either (since each repo
is still responsible for repacking its own packs).  Overall
performance for other git operations seems to be fine, though.  And
searching the cache as a last restore can be optimized by always
searching packs in MRU order, in case git doesn't already do this.
