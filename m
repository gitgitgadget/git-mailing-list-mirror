From: Junio C Hamano <junkio@cox.net>
Subject: cg-fetch auto-following tags
Date: Sat, 15 Oct 2005 17:58:44 -0700
Message-ID: <7vfyr2i8fv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 02:59:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQwrX-0004Sp-Ui
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 02:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJPA6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 20:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVJPA6q
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 20:58:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30928 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751268AbVJPA6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 20:58:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016005845.IYTE9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 20:58:45 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10152>

In cg-fetch, you have some code at the bottom starting with:

	$get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" || rsyncerr=1

Under http, I presume get is get_http which is recursive wget to
slurp all tags to .git/refs/tags?

Earlier you were talking about fetching tags automatically as
the user follows a branch (or multiple branches) development,
but the current git-http-fetch's semantics of making sure the
repository has all the reachable objects when slurping from a
ref makes it impossible, and you are playing things safer by
essentially cloning the remote repository.

The latest "master" branch of git-core sends unwrapped tag
information to make this easier to implement.  I think you
should be able to do something like this (between "FIXME: Warn
about conflicting tag names?" and "rm fetch-$name-dirty").

        git-ls-remote --tags $uri/ |
	# SHA1 refs/tags/v0.99.8^{} --> SHA1 tags/v0.99.8
	# where SHA1 is the object v0.99.8 tag points at.
        sed -ne 's:\([^	]\)	refs/\(tags/.*\)^{}$:\1	\2:p' |
        while read sha1 tagname
        do
		# do we have the object pointed at by the tag?
                git-cat-file -t "$sha1" >/dev/null 2>&1 ||
                continue

                # if so, fetch the tag -- which should be a
                # cheap operation -- to complete the chain.
                $fetch "$tagname" "$uri" "$tagname"
        done

This sample code assumes your $fetch implements the same
semantics for various transports ($1 is the ref to fetch, $2 is
the repo url, $3 is the local ref to write into); I only checked
http transport in your code.
