From: Phil Sainty <psainty@orcon.net.nz>
Subject: Feature request: Provide porcelain to manage symbolic references
 as branch aliases
Date: Wed, 30 Apr 2014 00:51:47 +1200
Message-ID: <535FA063.9040701@orcon.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060407090004000401080008"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 15:00:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf7ec-0003eo-Om
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 15:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbaD2NAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 09:00:54 -0400
Received: from nctlincom01.orcon.net.nz ([60.234.4.69]:38493 "EHLO
	nctlincom01.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbaD2NAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 09:00:52 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2014 09:00:52 EDT
Received: from mx9.orcon.net.nz (mx9.orcon.net.nz [219.88.242.59])
	by nctlincom01.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id s3TCui29026680
	for <git@vger.kernel.org>; Wed, 30 Apr 2014 00:56:44 +1200
Received: from 121-99-136-8.bng1.tvc.orcon.net.nz ([121.99.136.8] helo=[10.1.1.5])
	by mx9.orcon.net.nz with esmtpa (Exim 4.69)
	(envelope-from <psainty@orcon.net.nz>)
	id 1Wf7W8-0002bI-TV
	for git@vger.kernel.org; Wed, 30 Apr 2014 00:52:13 +1200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Bayes-Prob: 0.5 (Score 0, tokens from: @@RPTN, default)
X-Spam-Score: -3.00 () [Hold at 4.00] CC(NZ:-3)
X-CanIt-Geo: ip=121.99.136.8; country=NZ; latitude=-41.0000; longitude=174.0000; http://maps.google.com/maps?q=-41.0000,174.0000&z=6
X-CanItPRO-Stream: base:default
X-Canit-Stats-ID: 06LTMUI06 - 2d503c34c6b6 - 20140430
X-Scanned-By: CanIt (www . roaringpenguin . com) on 172.16.100.174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247581>

This is a multi-part message in MIME format.
--------------060407090004000401080008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Most of the plumbing for having branch name aliases already exists
in the form of symbolic references, and people do use them for this
purpose; but I get the impression that it's not really supported
officially, and I'm not aware of any porcelain features to
facilitate this use-case.

I'd like to propose that such porcelain be added. I feel that a new
argument to 'git branch' would make the most sense:

git branch --alias <alias> [<branch>]

For reference/testing, I'm attaching a wrapper script I wrote to
implement the same functionality (as a separate command). I did this
primarily to provide the error-checking I felt was needed to make it
practical to use branch aliases -- git symbolic-ref will happily
trash your branch references if you make a mistake, whereas it's
pretty difficult to mess anything up with my git-branch-alias script.

Thus far it's worked nicely for me. Examples:

$ git branch-alias short some-overly-long-branch-name # creates alias
$ git branch-alias short # creates alias for current branch
$ git log short
$ git checkout short
$ git push origin short # pushes the branch, not the alias/reference
$ git branch-alias --delete short

n.b. For my proposed porcelain change, these examples would become:
$ git branch --alias short some-overly-long-branch-name # creates alias
$ git branch --alias short # creates alias for current branch
$ git branch --delete short # works since 1.8.0.1, but see below.


Since using this script, the only thing I've spotted that I'd like
to be different is the commit message if I "git merge <alias>". The
commit message indicates that I've merged <alias> rather than the
<branch> that it points at. I'd prefer that it was dereferenced
when the message was generated, so that the real branch name was
printed instead.


That niggle aside, significant things I noted along the way were:

1. Git 1.8.0.1 fixed the problem whereby git branch -d <symref>
   used to dereference <symref> and therefore delete the branch
   it pointed at, rather than the reference.

2. HOWEVER if you have <symref> checked out at the time you
   delete it, you're in trouble -- git allows you to do it, and
   you're then left with an invalid HEAD reference.

   (I think this ought to be considered a current bug in git.)

3. I resolved that situation (2) by using "git symbolic-ref HEAD"
   to find the target ref, and setting HEAD to that target. Nothing
   changes for the user, but we can now delete the reference safely.

   HOWEVER, there's a problem with detecting that situation (2)
   in the first place:

4. Chains of references are de-referenced atomically -- the entire
   reference chain is followed to its end; and I could find no
   facility to obtain ONLY the "next link of the chain".

   This means we can't use "git symbolic-ref HEAD" to check whether
   it points to another reference. In my script I had to resort to
   inspecting HEAD manually, which obviously isn't desirable.

   I think a new argument is warranted here, perhaps something like:
   "git symbolic-ref --max-deref-count=1"

   I'll justify that on the assumption that (2) needs fixing in git
   regardless, either by:

   (i) Not allowing the user to delete the checked-out symref (which
       would be consistent with the behaviour if the user attempts to
       "git branch -d <branch>" (for an actual branch name) when that
       is the currently checked-out branch.

   or,
   (ii) Using the approach I've taken: silently setting HEAD to the
        branch to which the symref points before deleting that symref.
        (I couldn't see any reason not to use this approach.)

   But as in both cases we need to detect that HEAD is the symref
   being deleted, which means that we need the ability to explicitly
   dereference only a single step of a reference chain.


-Phil



--------------060407090004000401080008
Content-Type: text/plain; charset=windows-1252;
 name="git-branch-alias"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-branch-alias"

#!/bin/sh
# git branch-alias
# Version 1.07
# Author: Phil S.

# Creates branch aliases, so that you can refer to a long branch name
# by a convenient short alias. This is just a "do what I mean" wrapper
# around git symbolic-ref, but without the (considerable) risk of
# trashing a branch if you get your arguments wrong

# Examples:
# git branch-alias short some-overly-long-branch-name # creates alias
# git branch-alias short # creates alias for current branch
# git log short
# git checkout short
# git push origin short # pushes the branch, not the alias/reference
# git branch-alias --delete short

# Caveats:
# Although everything else I've tried works seamlessly, I note that
# git merge <alias> will cause the alias name to be mentioned in the
# commit message, rather than the real branch. It would be nicer if
# the branch name appeared.

# Compatibility:
# Developed with git version 1.7.12.4
# Tested with git version 1.9.0
#
# Related git changes between versions 1.7.12.4 and 1.9.0:
#
# 1.8.0.1
#  * A symbolic ref refs/heads/SYM was not correctly removed with "git
#    branch -d SYM"; the command removed the ref pointed by SYM
#    instead.
#
# 1.8.1
#  * "git symbolic-ref" learned the "-d $symref" option to delete the
#    named symbolic ref, which is more intuitive way to spell it than
#    "update-ref -d --no-deref $symref".

#cwd=$(git rev-parse --show-toplevel)
git=$(git rev-parse --git-dir)
if [ $? -ne 0 ]; then
    exit 1
fi

command=$(basename $0)
command="git ${command##git-}"

# Process command line options
opts=$(getopt -o hd -l help,delete -n "${command}" -- "$@")
if [ $? -eq 0 ]; then
    eval set -- ${opts}
    while true; do
        case "$1" in
            ( -d|--delete ) delete=1; shift;;
            ( -h|--help   ) help=1; shift; break;;
            ( --          ) shift; break;;
        esac
    done
else
    help=1 # getopt returned (and reported) an error.
fi

# Process non-option arguments
symref=$1
branch=$2

if [ -z "${symref}" ]; then
    help=1
fi

if [ -n "${help}" ]; then
    echo "\
Usage:
${command} <alias> [ <branch> ]
${command} [ --delete | -d ] <alias>

Creates a symbolic reference <alias> referring to <branch>.
<branch> defaults to the current checked-out branch.

This symbolic reference acts as an alias for <branch>, and can be
used in its place. More specifically, it WILL be dereferenced to
its target in nearly all situations, so for any given command you
should treat every usage of <alias> as if it were actually <branch>.

To safely delete a branch alias, use:
${command} --delete <alias>

WARNING: These symbolic references appear in your branch list as:
 <alias> -> <branch>
and so you might be tempted to try to delete them like a branch:
 git branch -d <alias>

However this can cause problems. In git versions prior to 1.8.0.1
<alias> will be dereferenced and you will instead delete the
branch it refers to (git will allow this even if you currently
have that branch checked out), and the symbolic reference will
still remain (referencing a branch which is no longer available).

In later versions of git the <alias> will be deleted rather than
the branch; however git will still not check to see whether you
currently have <alias> checked out, and will not prevent you
from deleting it in that situation. This will leave your HEAD ref
in an invalid state. Using ${command} --delete <alias>
resolves this situation by switching HEAD to <alias>'s target.

"
    exit 0
fi

# Use the current branch by default.
if [ -z "${branch}" ]; then
    branch=$(git symbolic-ref -q HEAD)
    if [ $? -ne 0 ]; then
        echo "Could not establish current HEAD." >&2
        exit 1
    fi
fi

# We expect plain branch names, but also accept the fully-qualified
# (refs/heads/NAME) paths needed by git symbolic-ref; so strip that
# refs/heads/ prefix if it is specified.
branch=${branch##refs/heads/}
symref=${symref##refs/heads/}

# Deleting a symref.
if [ -n "${delete}" ]; then
    if [ ! -f "${git}/refs/heads/${symref}" ]; then
        echo "Symbolic reference refs/heads/${symref} does not exist." >&2
        exit 1
    fi

    # Verify that it IS a symbolic reference
    if ! git show-ref --verify --heads --quiet "refs/heads/${symref}"; then
        echo "refs/heads/${symref} is not a valid reference." >&2
        exit 1
    fi
    if ! git symbolic-ref "refs/heads/${symref}" >/dev/null; then
        echo "Error validating refs/heads/${symref} as symbolic reference." >&2
        exit 1
    fi

    # If we currently have <symref> checked out, deleting it is bad
    # (as HEAD would no longer be a valid reference). I believe we do
    # need to inspect the file here, as attempting to read the HEAD
    # reference via git dereferences it to its target branch, and thus
    # we are unable to distinguish between the branch and the symref.
    if grep -q "^ref: refs/heads/${symref}\$" "${git}/HEAD"; then
        echo "Cannot delete the currently checked out symbolic reference."
        branch=$(git symbolic-ref -q HEAD)
        if [ $? -ne 0 ]; then
            echo "Could not establish current HEAD." >&2
            exit 1
        fi
        echo "Switching HEAD to target branch ${branch}"
        # By using git symbolic-ref HEAD to find the target ref
        # and setting HEAD to that target, nothing really changes,
        # but we can now delete the reference safely.
        if ! git symbolic-ref HEAD "${branch}"; then
            echo "Error updating HEAD from ${symref} to ${branch}" >&2
            echo "Aborting." >&2
            exit 1
        fi
    fi

    # Delete the reference.
    # git 1.8.1+ provides: git symbolic-ref --delete <symref>
    # but older versions do not include that option, so we use
    # the backwards-compatible command.
    echo "Deleting symbolic reference refs/heads/${symref}"
    git update-ref -d --no-deref "refs/heads/${symref}"
    exit $?
fi

# Creating a new symbolic reference.

# Error checking. git symbolic-ref doesn't really do any, and will
# happily mess up your branches; particularly if you get the arguments
# the wrong way around (treating it like ln -s is a really bad idea).
if [ ! -f "${git}/refs/heads/${branch}" ]; then
    echo "Target refs/heads/${branch} does not exist." >&2
    exit 1
fi
if [ -f "${git}/refs/heads/${symref}" ]; then
    target=$(git symbolic-ref "refs/heads/${symref}")
    if [ $? -eq 0 ]; then
        echo "Symbolic reference refs/heads/${symref} already exists:" >&2
        echo "  ${symref} -> ${target##refs/heads/}" >&2
        echo "To remove it, use: ${command} --delete ${symref}" >&2
    else
        echo "File refs/heads/${symref} already exists" >&2
        echo "(and is not a symbolic reference!)" >&2
    fi
    exit 1
fi
if git show-ref --verify --heads --quiet "refs/heads/${symref}"; then
    # n.b. I'm pretty sure this is unreachable, given the previous block.
    echo "refs/heads/${symref} is a valid reference without a file!?" >&2
    exit 1
fi

# The parameters are good.
# Generate the reference and display the confirmed result.
if git symbolic-ref "refs/heads/${symref}" "refs/heads/${branch}"; then
    target=$(git symbolic-ref "refs/heads/${symref}")
    echo "  ${symref} -> ${target##refs/heads/}"
else
    echo "Failed to create branch alias." >&2
    exit 1
fi

--------------060407090004000401080008--
