From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff: support custom callbacks for output
Date: Mon, 07 Aug 2006 01:54:38 -0700
Message-ID: <7vr6zt3oz5.fsf@assigned-by-dhcp.cox.net>
References: <20060807075002.GA29693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 10:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA0sl-0002nw-Qv
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 10:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWHGIyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 04:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHGIyk
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 04:54:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24499 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWHGIyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 04:54:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807085439.ENVY18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 04:54:39 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060807075002.GA29693@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 7 Aug 2006 03:50:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25003>

Jeff King <peff@peff.net> writes:

> I'm re-writing git-status in C, and that entails using the git library
> to replace calls to things like git-diff-index. Fortunately,
> run_diff_index does just what I want. Unfortunately, it ends up wanting
> to send its output to stdout in one of the pre-defined diff formats, and
> what I really want is my own status format.

Good.  I then can stop the same I've been doing in "pu" ;-).

> I could, of course, add diff_flush_status() support to diffcore.
> However, I'm not sure that it really belongs there. In the interests of
> libification, it seems reasonable for diffcore to provide a callback
> mechanism for each filepair.
>
> Below is an attempt to provide such a mechanism. My questions are:
>   1. Am I right that there is no other way to accomplish this task? This
>      is my first interaction with diffcore, so I might have overlooked
>      something.

What I was going to do was to give a hook to run_diff_index()
and friends, to be called just before diff_flush().  Then the
hook can inspect the diff_queued_diff for the result.  Obviously
you do not want diff_flush() to say anything, so you would call
it with no-output option.  But I think adding a new generic
"output format" in the form of a callback hook is a very good
idea.  I am not sure if a callback per filepair is a good
interface, or passing the q (that is &diff_queued_diff) and let
the hook iterate over it might be better, though.  It probably
would not be such a big deal either way.

Having said that, I am wondering how much of "git status" you
are doing in C.  Initially, I was going to do the whole thing
(one good reason to do so is that then we do not have to write
out a temporary index file; we can do everything in-core.
However I came to realize it is quite a big undertaking.  In
order to handle -o, you would need to run diff-files (to make
sure the index is clean at specified paths), discard_cache() and
read-tree (to re-read the HEAD commit tree), update-index with
ls-files like pathspec (to update the index at specified paths),
then do "diff-index --cached" (to say "Will commit"),
"diff-files" (to say "Changed"), and "ls-files -o"
("Untracked").

If you are planning to go the whole nine yards, more power to
you ;-), but a less ambitious fallback position would be to
rewrite only git-commit.sh::run_status() in C.  That is, let the
current git-commit.sh drive the parts to prepare TMP_INDEX (or
NEXT_INDEX), and write a C program that uses the given index
(most likely specified by GIT_INDEX_FILE environment variable by
the caller -- git-commit.sh), REFERENCE (probably given as a
parameter, usually HEAD but HEAD^1 while --amend and nothing if
the initial commit) and the working tree files.  The program
would run (internally) diff-index --cached, diff-files and
ls-files -o to do "Will commit", "Changed" and "Untracked".

By the way, I was pondering about making the git status output a
bit more readable by making it shorter.  Instead of listing the
same file in "Updated but not checked in" and "Changed but not
updated" sections twice, it might be more alarming and concise
to say:

        Will commit
                modified: Makefile (warning: further changed)
                modified: foo.c

        Changed
                modified: bar.c

        Untracked
                baz.c
