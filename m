From: Yann Dirson <ydirson@altern.org>
Subject: cvsexportcommit / cvsimport issues
Date: Sat, 7 Jan 2006 10:01:48 +0100
Message-ID: <20060107090148.GB32585@nowhere.earth>
References: <20060106205441.GA32585@nowhere.earth> <7virsxrnik.fsf@assigned-by-dhcp.cox.net> <46a038f90601062329s35163616i7c658e4d6ede294b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	matthias@urlichs.de
X-From: git-owner@vger.kernel.org Sat Jan 07 09:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9uv-0001KZ-H7
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWAGI7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWAGI7O
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:59:14 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:20200 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030372AbWAGI7O (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 03:59:14 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id D08F3170D7;
	Sat,  7 Jan 2006 09:59:12 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1Ev9xM-0000z0-Rp; Sat, 07 Jan 2006 10:01:48 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90601062329s35163616i7c658e4d6ede294b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14247>

On Sat, Jan 07, 2006 at 08:29:08PM +1300, Martin Langhoff wrote:
> Definitely. It's a bit of a hack job that I got started with, and as
> it's /worked for me/ so far, haven't done much with it. I am actually
> quite busy at the moment, so I don't think you'll see many patches
> from me on this fron yet...

In any case, I'm likely to send occasional patches as I hit the
limitations.

> Indeed, and you can also use it for the same thing you'd use git-am --
> for instance, to "merge into CVS" feature branches kept on GIT.

That's also the way I use it.  We have an official CVS repo, and I'm
doing all of my work in git, until it's ready for publication in the
central CVS repo.



While we're talking about cvs<->git, I also hit a couple of problems
with git-cvsimport, which I did not have time to fully investigate:

- when there are very large files in the CVS repo (eg. a 85MB
tarball), cvsimport timeouts while fetching it (saying the server has
gone away), when accesing via pserver or ssh.  I tried to play with
the socket timeout, but also it helped to reproducibly import a 15MB
file, I could not raise it enough to get the 85MB file.

Hunting for this problem, I found myself asking the question, why it
was chosen in the first place to implement a cvs client, instead of
using the reference implementation.

I was finally able to workaround this by transfering a copy of the
cvsroot to the local machine, but that's not quite practical :)


- the "-k" flag is dangerous as-is, since it overrides any flag
(eg. -kb) set on the files in the cvs repo.  I got a plain
(non-compressed) tarball of sources corrupted because of this, and was
subsequently unable to use -k at all.  Fortunately, I had done the
original cvs imports using -ko, so it was not a problem for me, but we
may want to fix the issue eventually, and at least document this
caveat.


- when doing an incremental import using -P, where the 1st patchset
was just a module creation with a single .cvsignore to allow creation
of a pseudo-vendor-branch, and the 2nd patchset was an import on the
said branch, cvsimport complained that it could not find the branch in
my git repo, and I had to create it manually, whereas while importing
all patchsets in one batch, the branch was created without manual
intervention (but import subsequently failed because of the big file
as mentionned above).  Similarly, still when using -P, using the local
repository copy, importing the initial patchset complained 'cannot
find "origin"' - I prefered to do this initial import using the
pserver access, which worked fine, and did the later imports via the
local repo.

We could thus want to mention in the doc that -P can also be used to
help circumvent problems by using for each patchset the most adequate
import method :)


- as of cvsps 2.1, patchsets only contain a single tag, even when
there are several of them on the cvs repo.  We should surely document
this shortcoming so people do not get caught by surprise.


Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
