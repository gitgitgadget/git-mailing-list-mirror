Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE51B1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeIVTPQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 15:15:16 -0400
Received: from smtp-3.orcon.net.nz ([60.234.4.44]:47246 "EHLO
        smtp-3.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeIVTPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 15:15:16 -0400
X-Greylist: delayed 1537 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2018 15:15:14 EDT
Received: from [150.107.172.80] (port=57941 helo=[192.168.20.103])
        by smtp-3.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <psainty@orcon.net.nz>)
        id 1g3hS3-0006mW-R4
        for git@vger.kernel.org; Sun, 23 Sep 2018 00:56:07 +1200
Subject: Re: Feature request: Provide porcelain to manage symbolic references
 as branch aliases
From:   Phil Sainty <psainty@orcon.net.nz>
To:     git@vger.kernel.org
References: <535FA063.9040701@orcon.net.nz>
Message-ID: <fb742b1c-7638-cde3-6e6c-10dab86e9dd7@orcon.net.nz>
Date:   Sun, 23 Sep 2018 00:55:59 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <535FA063.9040701@orcon.net.nz>
Content-Type: multipart/mixed;
 boundary="------------B65895129EA6FC24CE30C656"
Content-Language: en-GB
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------B65895129EA6FC24CE30C656
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Updating the proof-of-concept script for this feature request.

(See attachment.)

I'm quoting the entire original message for reference, just because
it's been a while since I proposed this.

-Phil


On 30/04/14 00:51, Phil Sainty wrote:
> Most of the plumbing for having branch name aliases already exists
> in the form of symbolic references, and people do use them for this
> purpose; but I get the impression that it's not really supported
> officially, and I'm not aware of any porcelain features to
> facilitate this use-case.
>
> I'd like to propose that such porcelain be added. I feel that a new
> argument to 'git branch' would make the most sense:
>
> git branch --alias <alias> [<branch>]
>
> For reference/testing, I'm attaching a wrapper script I wrote to
> implement the same functionality (as a separate command). I did this
> primarily to provide the error-checking I felt was needed to make it
> practical to use branch aliases -- git symbolic-ref will happily
> trash your branch references if you make a mistake, whereas it's
> pretty difficult to mess anything up with my git-branch-alias script.
>
> Thus far it's worked nicely for me. Examples:
>
> $ git branch-alias <alias> <long-and-unwieldy-branch-name> # create alias
> $ git branch-alias <alias> # create alias for current branch
> $ git branch # view branches and branch aliases
> $ git log <alias>
> $ git checkout <alias>
> $ git push origin <alias> # pushes the branch, not the alias/reference
> $ git branch-alias -d <alias> # delete an alias safely
>
> n.b. For my proposed porcelain change, these examples would become:
> $ git branch --alias <alias> <long-and-unwieldy-branch-name> # creates
alias
> $ git branch --alias <alias> # create alias for current branch
> $ git branch --delete <alias> # works since 1.8.0.1, but see below.
>
>
> Since using this script, the only thing I've spotted that I'd like
> to be different is the commit message if I "git merge <alias>". The
> commit message indicates that I've merged <alias> rather than the
> <branch> that it points at. I'd prefer that it was dereferenced
> when the message was generated, so that the real branch name was
> printed instead.
>
>
> That niggle aside, significant things I noted along the way were:
>
> 1. Git 1.8.0.1 fixed the problem whereby git branch -d <symref>
>    used to dereference <symref> and therefore delete the branch
>    it pointed at, rather than the reference.
>
> 2. HOWEVER if you have <symref> checked out at the time you
>    delete it, you're in trouble -- git allows you to do it, and
>    you're then left with an invalid HEAD reference.
>
>    (I think this ought to be considered a current bug in git.)
>
> 3. I resolved that situation (2) by using "git symbolic-ref HEAD"
>    to find the target ref, and setting HEAD to that target. Nothing
>    changes for the user, but we can now delete the reference safely.
>
>    HOWEVER, there's a problem with detecting that situation (2)
>    in the first place:
>
> 4. Chains of references are de-referenced atomically -- the entire
>    reference chain is followed to its end; and I could find no
>    facility to obtain ONLY the "next link of the chain".
>
>    This means we can't use "git symbolic-ref HEAD" to check whether
>    it points to another reference. In my script I had to resort to
>    inspecting HEAD manually, which obviously isn't desirable.
>
>    I think a new argument is warranted here, perhaps something like:
>    "git symbolic-ref --max-deref-count=1"
>
>    I'll justify that on the assumption that (2) needs fixing in git
>    regardless, either by:
>
>    (i) Not allowing the user to delete the checked-out symref (which
>        would be consistent with the behaviour if the user attempts to
>        "git branch -d <branch>" (for an actual branch name) when that
>        is the currently checked-out branch.
>
>    or,
>    (ii) Using the approach I've taken: silently setting HEAD to the
>         branch to which the symref points before deleting that symref.
>         (I couldn't see any reason not to use this approach.)
>
>    But as in both cases we need to detect that HEAD is the symref
>    being deleted, which means that we need the ability to explicitly
>    dereference only a single step of a reference chain.
>
>
> -Phil
>


--------------B65895129EA6FC24CE30C656
Content-Type: text/plain; charset=UTF-8;
 name="git-branch-alias"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-branch-alias"

#!/bin/sh
# git branch-alias
# Author: Phil S.
# Version 1.11
version=1.11

# Creates branch aliases, so that you can refer to a long branch name
# by a convenient short alias.  This is particularly useful for branch
# names beginning with bug-tracker ID numbers (or similar), where the
# benefits of tab-completion are greatly reduced.

# This is mostly a "do what I mean" wrapper around "git symbolic-ref",
# with numerous safety measures included in order to eliminate the
# (otherwise considerable) risk of trashing a branch if you get your
# arguments wrong.

# Installation:
# Place this script somewhere in your PATH and name it "git-branch-alias"
# and you will be able to invoke it with "git branch-alias" as per the
# following examples.

# Examples:
# git branch-alias <alias> <long-and-unwieldy-branch-name> # create alias
# git branch-alias <alias> # create alias for current branch
# git branch # view branches and branch aliases
# git log <alias>
# git checkout <alias>
# git push origin <alias> # pushes the branch, not the alias/reference
# git branch-alias -d <alias> # delete an alias safely
# git branch-alias -h # help / usage details

# Caveats:
# Although everything else I've tried works seamlessly, I note that
# git merge <alias> will cause the alias name to be mentioned in the
# commit message, rather than the name of the real branch. It would be
# nicer if the branch name appeared.

# Compatibility:
# Originally developed with git version 1.7.12.4
# Also tested with git versions 1.9.0, 2.5.4, 2.6.6, 2.8.3
#
# Related git changes between versions 1.7.12.4 and 2.8.3:
# git v1.8.0.1
#  * A symbolic ref refs/heads/SYM was not correctly removed with "git
#    branch -d SYM"; the command removed the ref pointed by SYM
#    instead.
#
# git v1.8.1
#  * "git symbolic-ref" learned the "-d $symref" option to delete the
#    named symbolic ref, which is more intuitive way to spell it than
#    "update-ref -d --no-deref $symref".
#
# git v2.6.5
#  * "git symbolic-ref" forgot to report a failure with its exit status.
#
#  I believe this is commit 3e4068ed90fd3c6f24303560113aae6dbb758699:
#  > symbolic-ref: propagate error code from create_symref()
#  > If create_symref() fails, git-symbolic-ref will still exit with
#  > code 0, and our caller has no idea that the command did nothing.
#  > This appears to have been broken since the beginning of time
#
#  As this affects symref creation only, the sole adverse effect here
#  would be an unintended message to the user if symref creation had
#  actually failed (but not even a misleading one, on account of our
#  reading the reference after its creation, and thus displaying an
#  error if it turned out to be invalid).
#
# git v2.8.3
#  * A change back in version 2.7 to "git branch" broke display of a
#    symbolic ref in a non-standard place in the refs/ hierarchy (we
#    expect symbolic refs to appear in refs/remotes/*/HEAD to point at
#    the primary branch the remote has, and as .git/HEAD to point at the
#    branch we locally checked out).
#
#  This caused "git branch" to display "ref -> ref" instead of "ref -> branch"
#  for branch aliases.  The functionality still works otherwise, but is not
#  nearly so convenient to work with when you cannot trivially see what each
#  alias points to.  This bug affected git versions 2.7.0 - 2.8.2 (inclusive).

# Change Log:
# v1.11:
# Minor tidy-ups.  Re-posted to git mailing list.
#
# v1.10:
# No longer dependent on refs existing as individual files, as they
# may be packed in .git/packed-refs.
#
# v1.09:
# POSIX-compatible option handling and output.
# Documented an issue with "git branch" in git versions 2.7.0 - 2.8.2.
#
# v1.08:
# Removed test git show-ref --verify --heads --quiet "refs/heads/${symref}"
# for asserting that the specified reference was valid before deleting a
# reference, as we need to permit the deletion of references to branches
# which have /already/ been deleted, and this test prevented that.
# n.b. We already had another validation test to fall back on, using
# git symbolic-ref "refs/heads/${symref}"
#
# v1.07:
# Minor tweaks. Posted as feature-request to git mailing list:
# http://www.mail-archive.com/git%40vger.kernel.org/msg49171.html

command=$(basename $0)
command="git ${command##git-}"

# Print argument (and newline) to stdout or stderr
stdout () {
    printf %s\\n "$1"
}
stderr () {
    printf %s\\n "$1" >&2
}

# Returns the supplied parameters suitably quoted for later evaluation.
quote () {
    for param; do
        printf %s "${param}Z" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/Z\$/' /"
    done
}

# Process option parameters
parameters=
while [ $# -gt 0 ]; do
    case "$1" in
        ( --           ) shift; break;;
        ( -v|--version ) version_help=1; shift;;
        ( -h|--help    ) help=1; shift;;
        ( -d|--delete  ) delete=1; shift;;
        ( -*           ) {
            stdout "Invalid option: $1"
            stdout
            shorthelp=1
            shift
        };;
        ( * ) { # non-option parameter
            parameters="${parameters}$(quote "$1")"
            shift
        };;
    esac
done

# Process non-option parameters
eval "set -- ${parameters}"
symref=$1
branch=$2

# If no parameters were supplied, display shorthelp.
if [ -z "${symref}" ] && [ -z "${help}" ]; then
    shorthelp=1
fi

if [ -n "${version_help}" ]; then
    stdout "${command} version ${version}"
    exit 0
fi

# Include the usage summary in both short and long help.
if [ -n "${help}" ] || [ -n "${shorthelp}" ]; then
    cat <<EOF
Usage:
${command} <alias> [<branch>]
${command} (-d | --delete) <alias>
${command} (-v | --version)
EOF
fi

# n.b. Calling "git branch-alias --help" causes git to look for
# a man page for "git-branch-alias", so we shouldn't advertise
# the long option (although we support it if the script is called
# by its real name, rather than via git).
if [ -n "${shorthelp}" ]; then
    cat <<EOF

For help, use: ${command} -h

EOF
    exit 0
fi

# Detailed help.
if [ -n "${help}" ]; then
    cat <<EOF

Creates a symbolic reference <alias> referring to <branch>.
<branch> defaults to the current checked-out branch.

This symbolic reference acts as an alias for <branch>, and can be
used in its place. More specifically, it WILL be dereferenced to
its target in nearly all situations, so for any given command you
should treat every usage of <alias> as if it were actually <branch>.

To safely delete a branch alias, always use:
${command} -d <alias>

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
in an invalid state. Using ${command} -d <alias> resolves
this situation by first switching HEAD to <alias>'s target branch
if HEAD was currently set to <alias>.

EOF
    exit 0
fi

# Confirm the CWD is within a git repository.
#cwd=$(git rev-parse --show-toplevel)
git=$(git rev-parse --git-dir)
if [ $? -ne 0 ]; then
    exit 1
fi

# Use the current branch by default.
if [ -z "${branch}" ]; then
    branch=$(git symbolic-ref -q HEAD)
    if [ $? -ne 0 ]; then
        stderr "Could not establish current HEAD."
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
    if ! git show-ref --verify --heads --quiet "refs/heads/${symref}"; then
        stderr "Symbolic reference refs/heads/${symref} does not exist."
        exit 1
    fi

    # Verify that it IS a symbolic reference
    if ! git symbolic-ref "refs/heads/${symref}" >/dev/null; then
        stderr "Error validating refs/heads/${symref} as symbolic reference."
        exit 1
    fi

    # If we currently have <symref> checked out, deleting it is bad
    # (as HEAD would no longer be a valid reference). I believe we do
    # need to inspect the file here, as attempting to read the HEAD
    # reference via git dereferences it to its target branch, and thus
    # we are unable to distinguish between the branch and the symref.
    if grep "^ref: refs/heads/${symref}\$" "${git}/HEAD" >/dev/null 2>&1; then
        stdout "Cannot delete the currently checked out symbolic reference."
        branch=$(git symbolic-ref -q HEAD)
        if [ $? -ne 0 ]; then
            stderr "Could not establish current HEAD."
            exit 1
        fi
        stdout "Switching HEAD to target branch ${branch}"
        # By using git symbolic-ref HEAD to find the target ref
        # and setting HEAD to that target, nothing really changes,
        # but we can now delete the reference safely.
        if ! git symbolic-ref HEAD "${branch}"; then
            stderr "Error updating HEAD from ${symref} to ${branch}"
            stderr "Aborting."
            exit 1
        fi
    fi

    # Delete the reference.
    # git 1.8.1+ provides: git symbolic-ref --delete <symref>
    # but older versions do not include that option, so we use
    # the backwards-compatible command.
    stdout "Deleting symbolic reference refs/heads/${symref}"
    git update-ref -d --no-deref "refs/heads/${symref}"
    exit $?
fi

# Creating a new symbolic reference.

# Error checking. git symbolic-ref doesn't really do any, and will
# happily mess up your branches; particularly if you get the arguments
# the wrong way around (treating it like ln -s is a really bad idea).
if ! git show-ref --verify --heads --quiet "refs/heads/${branch}"; then
    stderr "Target branch refs/heads/${branch} does not exist."
    exit 1
fi
if git show-ref --verify --heads --quiet "refs/heads/${symref}"; then
    target=$(git symbolic-ref "refs/heads/${symref}")
    if [ $? -eq 0 ]; then
        stderr "Symbolic reference refs/heads/${symref} already exists:"
        stderr "  ${symref} -> ${target##refs/heads/}"
        stderr "To remove it, use: ${command} --delete ${symref}"
    else
        stderr "Reference refs/heads/${symref} already exists"
        stderr "(and is not a symbolic reference!)"
    fi
    exit 1
fi

# The parameters are good.
# Generate the reference and display the confirmed result.
if git symbolic-ref "refs/heads/${symref}" "refs/heads/${branch}"; then
    target=$(git symbolic-ref "refs/heads/${symref}")
    stdout "  ${symref} -> ${target##refs/heads/}"
else
    stderr "Failed to create branch alias."
    exit 1
fi

--------------B65895129EA6FC24CE30C656--
