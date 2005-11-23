From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/6] Add check_repo_format check for all major operations.
Date: Tue, 22 Nov 2005 16:57:13 -0800
Message-ID: <7v8xvg89li.fsf@assigned-by-dhcp.cox.net>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
	<113261929333-git-send-email-matlads@dsmagic.com>
	<7vlkzhf5li.fsf@assigned-by-dhcp.cox.net>
	<200511221555.24572.matlads@dsmagic.com>
	<7vd5ksefth.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 01:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeiwo-0004YL-MI
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 01:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVKWA5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 19:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVKWA5P
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 19:57:15 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44711 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030292AbVKWA5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 19:57:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123005646.HTEE3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 19:56:46 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <7vd5ksefth.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 22 Nov 2005 09:46:18 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12592>

Junio C Hamano <junkio@cox.net> writes:

> Yes, although that is exactly what I said "this does not quite
> feel right" ;-).  Is it hard to arrange things so that a process
> does exactly one check_repo_format() during its lifetime?

Let's back up a bit.  I'll deal with only low-level commands
here.

First, the easiest group.  The following commands do not look at
the repository (.git directory) at all.

    check-ref-format get-tar-commit-id git index-pack mailinfo
    mailsplit patch-id shell show-index stripspace verify-pack

We do not need to do anything special about them.

The following three use enter_repo() to the given path (either
from the end user at the command line or over the network):

    daemon receive-pack upload-pack

The repo format check should be done at the same place as we
make sure enter_repo() finds the given directory a satisfactory
path.  That is, just before putenv(GIT_DIR=.) in enter_repo().

The following use setup_git_directory(), which chdir()s to the
toplevel unless GIT_DIR is set.

    cat-file config-set diff-files diff-index diff-stages diff-tree
    ls-files name-rev rev-list rev-parse show-branch symbolic-ref
    update-index update-ref

Maybe we can have a thin wrapper around setup_git_directory()
and after it returns check "${GIT_DIR-.git}" for repository
format mismatch.  What to do when GIT_DIR is set?  Then we can
just use it to read the config from "$GIT_DIR/config" and check
the version.

The following commands implicitly assume that they are either
run from the toplevel or GIT_DIR environment tells them where
the .git/ directory is:

    apply checkout-index clone-pack commit-tree convert-objects
    fetch-pack fsck-objects hash-object http-fetch http-push init-db
    local-fetch ls-tree merge-base merge-index mktag pack-objects
    pack-redundant peek-remote prune-packed read-tree send-pack
    ssh-fetch ssh-upload tar-tree unpack-file unpack-objects
    update-server-info var write-tree

With some exceptions, they are pretty much repository wide
commands, so I think it is OK for them to assume they start at
the toplevel (the Porcelain would chdir to the top for them
otherwise).  The ones that take paths, namely, checkout-index,
hash-object and ls-tree, may want to use setup_git_directory()
and do the path prefixing.

That means we would need to have some way for the rest of the
commands to check if "${GIT_DIR-.git}" is of the right format
version, and call that *once* per process invocation,
perferrably at the beginning of the main().

We need an access to .git/config file to do the repository
format check anyway, which means we need setup_git_directory()
if we ever want to run them from subdirectories.  And running
setup_git_directory() from the toplevel would not hurt, so
perhaps if we add setup_git_directory() at the beginning of
main() for the "implicity toplevel" class, and rewrite
setup_git_directory() like this:

        static const char *setup_git_directory_main(void)
        {
                /* current setup_git_driectory() */
        }

	const char *setup_git_directory(void)
        {
        	const char *retval = setup_git_directory_main();
                check_repository_format_version(); /* dies on mismatch */
		return retval;
	}

it _might_ be good enough.

I said "it _might_" here, because we need to be careful.  Right
now, if you run the "implicitly toplevel" commands from a
subdirectory, they fail.  Some Porcelains and scripts may be
relying on that and there will be consequences if things
suddenly start not to fail but do something unexpected in higher
directories.
