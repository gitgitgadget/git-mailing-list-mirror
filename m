From: Jeff King <peff@peff.net>
Subject: Re: git default behavior seems odd from a Unix command line point
	of view
Date: Tue, 12 May 2009 12:34:03 -0400
Message-ID: <20090512163403.GD29566@coredump.intra.peff.net>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com> <7vd4ae8fls.fsf@alter.siamese.dyndns.org> <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Schein <andrew@andrewschein.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uvo-0006w3-Fv
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZELQeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbZELQeH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:34:07 -0400
Received: from peff.net ([208.65.91.99]:50108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbZELQeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:34:06 -0400
Received: (qmail 32116 invoked by uid 107); 12 May 2009 16:34:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 May 2009 12:34:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2009 12:34:03 -0400
Content-Disposition: inline
In-Reply-To: <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118920>

On Tue, May 12, 2009 at 12:24:56PM -0400, Andrew Schein wrote:

> # environment set up occurs before loop, I pull before "pushing" in an
> attempt to prevent
> # conflicts from being left on the shared repository.
> for dir in ./* ; do
>     if [ ! -d $dir ]      ; then continue ; fi #not a directory
>     if [ ! -e $dir/.git ] ; then continue ; fi #not a git repo
>     dir=`basename $dir`
>     echo "syncing: $dir"
>     set +e # commit returns an error if there is nothing to commit.
>     (cd ./$dir ; git commit -a)
>     set -e

One trick to avoid playing with "set -e" is just:

  thing_whose_error_you_want_ignore || true

But that aside, it might be nice _not_ to ignore the result from "commit
-a", since it could also be warning you that it failed to correctly
commit. You probably want to do:

  git diff --quiet HEAD || git commit -a

That is "either there is nothing to commit, or we succeed in committing
everything". That of course has a race condition between the two
commands, though (i.e., if you modify files in between). If you want
something truly atomic, I think we would need "git commit" to
distinguish error codes between "I had nothing to commit" and "an error
occurred" (returning "1" right now could mean either).

>     (cd ./$dir ; git pull $UP "$REPO/$dir" master)        #pull
>     ssh $HOST "mkdir -p $DEST_CACHE/$LOC/$dir"  # these three lines
> handle "push"
>     rsync -rl --delete ./$dir/.git -e ssh "$DEST:$DEST_CACHE/$LOC/$dir/.git"
>     ssh $DEST "(cd $LOC/$dir ; /tools/bin/git pull
> $DEST_CACHE/$LOC/$dir/.git master)"

Pushing directly should be a lot more efficient in the case of repacking
(git will realize that the remote already has certain objects, but if
the filenames change, rsync will not).

-Peff
