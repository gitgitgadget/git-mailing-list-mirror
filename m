From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: warn about '.' and '..' in trees
Date: Tue, 27 Nov 2012 23:32:16 -0500
Message-ID: <20121128043215.GA5362@sigill.intra.peff.net>
References: <20121128022736.GA3739@sigill.intra.peff.net>
 <CACsJy8DQCo9UzDadHJ2dF-eK20tFDTVn_ScwV+T7z-qLDJMytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:32:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZK6-00089h-BT
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab2K1EcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:32:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58998 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab2K1EcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:32:18 -0500
Received: (qmail 3018 invoked by uid 107); 28 Nov 2012 04:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 23:33:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 23:32:16 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DQCo9UzDadHJ2dF-eK20tFDTVn_ScwV+T7z-qLDJMytw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210699>

On Wed, Nov 28, 2012 at 11:22:20AM +0700, Nguyen Thai Ngoc Duy wrote:

> > I don't think this is happening in the wild, but I did see somebody
> > playing around with libgit2 make such a tree (and it is easy to do with
> > git-mktree, of course).
> >
> > Technically one could use git with such a tree as long as you never ever
> > checked out the result, but I think it is sufficiently crazy that we
> > should probably detect it, just in case.
> 
> Can we declare "." and ".." illegal? There's no room for extension in
> tree objects and I'm thinking of using maybe "." entry as an extension
> indicator. Not sure if it works, old gits may attempt to checkout "."
> entries and fail...

Yeah, current git fails pretty hard. Try this:

  check() {
    git init -q "$1" &&
    (cd "$1" &&
     blob=$(echo foo | git hash-object -w --stdin) &&
     tree=$(printf '100644 blob %s\t%s' $blob "$2" | git mktree) &&
     commit=$(echo foo | git commit-tree $tree) &&
     git update-ref HEAD $commit &&
     git clone -q . clone
    )
  }

  $ check dot .
  error: Invalid path '.'

  $ check dotdot ..
  error: Updating '..' would lose untracked files in it

  $ check dotgit .git
  error: Updating '.git' would lose untracked files in it

Interesting that we detect the first one while reading into the cache,
but apparently try much harder to checkout on the latter two. Not sure I
want to try "git checkout -f". :)

-Peff
