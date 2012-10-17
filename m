From: Jeff King <peff@peff.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 03:18:17 -0400
Message-ID: <20121017071817.GA15419@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TONth-0008Kf-09
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab2JQHSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:18:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55877 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab2JQHSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:18:21 -0400
Received: (qmail 24522 invoked by uid 107); 17 Oct 2012 07:18:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 03:18:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 03:18:17 -0400
Content-Disposition: inline
In-Reply-To: <1109432467.20121017104729@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207899>

On Wed, Oct 17, 2012 at 10:47:29AM +0400, Ilya Basin wrote:

> The filter-branch command, the contents of ~/.gitconfig and the tree
> are the same.
> The command succeeds on cygwin, but fails on Solaris due to
> unset GIT_AUTHOR_NAME and GIT_COMMITTER_NAME :

That shouldn't happen. The likely culprit is that the sed magic in the
set_ident function of git-filter-branch is not portable to your version
of sed.

What happens if you run this:

	echo 'author Your Name <you@example.com> 1350408529 -0400' >commit
	set -- author
	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
        pick_id_script='
                /^'$lid' /{
                        s/'\''/'\''\\'\'\''/g
                        h
                        s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
                        s/'\''/'\''\'\'\''/g
                        s/.*/GIT_'$uid'_NAME='\''&'\''; export GIT_'$uid'_NAME/p

                        g
                        s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
                        s/'\''/'\''\'\'\''/g
                        s/.*/GIT_'$uid'_EMAIL='\''&'\''; export GIT_'$uid'_EMAIL/p

                        g
                        s/^'$lid' [^<]* <[^>]*> \(.*\)$/@\1/
                        s/'\''/'\''\'\'\''/g
                        s/.*/GIT_'$uid'_DATE='\''&'\''; export GIT_'$uid'_DATE/p

                        q
                }
        '
        LANG=C LC_ALL=C sed -ne "$pick_id_script" <commit

in your shell? You should get:

  GIT_AUTHOR_NAME='Your Name'; export GIT_AUTHOR_NAME
  GIT_AUTHOR_EMAIL='you@example.com'; export GIT_AUTHOR_EMAIL
  GIT_AUTHOR_DATE='@1350408529 -0400'; export GIT_AUTHOR_DATE

> I use git 1.7.6, from sunfreeware.

It might also be worth testing v1.7.12, but reading the logs, I don't
think there has been any meaningful update to filter-branch since then.

-Peff
