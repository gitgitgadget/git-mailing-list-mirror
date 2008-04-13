From: Jon Loeliger <jdl@jdl.com>
Subject: git-rm fu
Date: Sun, 13 Apr 2008 15:44:45 -0500
Message-ID: <E1Jl949-0000yh-M1@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 22:45:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl951-0005i0-3y
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYDMUoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYDMUoy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 16:44:54 -0400
Received: from jdl.com ([208.123.74.7]:51098 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbYDMUoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 16:44:54 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1Jl949-0000yh-M1
	for git@vger.kernel.org; Sun, 13 Apr 2008 15:44:53 -0500
X-Spam-Score: -102.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79423>


Given:

$ git init
Initialized empty Git repository in .git/
$ echo one >> git-foo.sh
$ mkdir subdir
$ echo two >> subdir/git-foo.sh
$ mkdir subdir/snizzle
$ echo three >> subdir/snizzle/git-foo.sh
$ git add .
$ git commit -m"All quiet on the western front."
Created initial commit 15fe70d: All quiet on the western front.
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 git-foo.sh
 create mode 100644 subdir/git-foo.sh
 create mode 100644 subdir/snizzle/git-foo.sh

The "git rm" manual's second example says:

    git-rm -f git-*.sh

        Remove all git-*.sh scripts that are in the index. Because this
        example lets the shell expand the asterisk (i.e. you are listing
        the files explicitly), it does not remove subdir/git-foo.sh.

It is not true that this command will remove all git-*.sh scripts
that are in the index.  Here are three:

    $ git ls-files
    git-foo.sh
    subdir/git-foo.sh
    subdir/snizzle/git-foo.sh

Using -f on this command is a red herring.  Using -f or -n
doesn't matter, and since we want to do more than one command
here, I'm just going to show it all using -n:

The effect of the command is to match just one file at the top level:

    $ git rm -n git-*.sh
    rm 'git-foo.sh'

Furthermore, there is an implication in the wording of the
second example that suggests that if you had let git expand the
file glob, the subdir/git-foo.sh file would have been removed.

Also not true:

    $ git rm -n git-\*.sh
    rm 'git-foo.sh'

To actually get the behavior of "removing all git-*.sh scripts
from the index", you have to prefix a file glob at the front
of the paths to match directories too:

    $ git rm -n \*git-\*.sh
    rm 'git-foo.sh'
    rm 'subdir/git-foo.sh'
    rm 'subdir/snizzle/git-foo.sh'

But then, using any of:

        \*git-\*.sh
        \*git-*.sh
        *git-\*.sh

all effectively *will* match subdir/git-foo.sh:

    $ git rm -n \*git-*.sh
    rm 'git-foo.sh'
    rm 'subdir/git-foo.sh'
    rm 'subdir/snizzle/git-foo.sh'

    $ git rm -n *git-\*.sh
    rm 'git-foo.sh'
    rm 'subdir/git-foo.sh'
    rm 'subdir/snizzle/git-foo.sh'

So it seems that the two parts discussed in the second example
are really unrelated.

It seems like "git rm d2/*" should remove all of d2's files
without trying to recursively remove any subdirectories,
but it won't:

    $ git rm -n d2/*
    fatal: not removing 'd2/two' recursively without -r

But then using -r force d2/two/ to be removed as well:

    $ git rm -n d2/\*
    rm 'd2/two/xyzzy'
    rm 'd2/x'
    rm 'd2/y'
    rm 'd2/z'

There's no real way to say "just the files in d2/".

(Yeah, sure, I could have said "git rm d2/\?", but that wouldn't
work if d2/xyzzy existed too. :-))

jdl
