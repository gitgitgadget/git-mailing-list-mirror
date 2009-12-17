From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Thu, 17 Dec 2009 22:48:43 +0100
Message-ID: <20091217214843.GA414@pcpool00.mathematik.uni-freiburg.de>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <20091217093547.GA25451@pcpool00.mathematik.uni-freiburg.de> <4B2A1895.2000803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 22:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLODJ-0007Nd-NK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 22:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765432AbZLQVsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 16:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765429AbZLQVsp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 16:48:45 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:59488
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765421AbZLQVso (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 16:48:44 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLODD-0003AV-Iy; Thu, 17 Dec 2009 22:48:43 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLODD-0000CA-H0; Thu, 17 Dec 2009 22:48:43 +0100
Mail-Followup-To: git@vger.kernel.org, j.sixt@viscovery.net
Content-Disposition: inline
In-Reply-To: <4B2A1895.2000803@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135384>

* Johannes Sixt <j.sixt@viscovery.net> [091217 12:40]:
> > I want the default for format-patch changed.
>
> I do not see why format-patch would have to be changed. The case that you
> outline (a merge -s ours happened and you want to follow only one parent)
> is rare enough

While it is rare, the result format-patch currently produces is quite a
desaster without any need.

> and even more rarly will somebody want to apply format-patch to such a history.
> But I guess that you are actually not interested in format-patch per se,
> but rather in rebase (which uses format-patch).

I'm looking for a nice way to store the history of a patches in a Debian package.
Currently the best way is to use quilt and store the patches in git.
Topgit is quite overkill, git directly preserving history means no way to
export sane patches. And git rebase -i means losing history of previous
states and pullability.

An way to combine those is doing many trivial merges, but that kills
rebase and format-patch. (While the patch exporting for creating the
debian source packages could change to the right directory and give the
proper arguments, needing to remember the extra argument and teaching
anyone else involved how to call it to get what to sent to upstream
is annoying).

> I haven't looked at the code, but wouldn't it be matter of "if we do not
> have any pathspec, add '.'" *after* all options are parsed?

That's what I would say my patch is doing.

> git rev-list -- . works in a bare repository, too. If you hard-code "-- ."
> in the rev-list invocations in git-rebase[--interactive], then it cannot
> be said that this works "by chance" due to cd_to_toplevel.

It works in a bare repository. But it does not work when called from a
subdirectory of the working dir.

The easiest way I see to express generally

git rev-list --prune-tree $args

is

topdir=$(git rev-parse --show-cdup)
if test -z "$topdir" ; then
        topdir=.
fi
set -- $args
while test $# -gt 0 ; do
        if test "x$1" = "x--" ; then
                break
        fi
        shift
done
if test $# -gt 1 ; then
        git rev-list $args
elif test $# -eq 1 ; then
        git rev-list $args $topdir
else
        git rev-list $args -- $topdir
fi

Hochachtungsvoll,
	Bernhard R. Link
-- 
"Never contain programs so few bugs, as when no debugging tools are available!"
	Niklaus Wirth
