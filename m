Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587AC433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 00:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB556141C
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbhDXAb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 20:31:26 -0400
Received: from marcos.anarc.at ([206.248.172.91]:44680 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhDXAbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 20:31:24 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 20:31:24 EDT
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id 09C0210E237; Fri, 23 Apr 2021 20:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1619223727;
        bh=A6XdepFrtsoGHbxwcStjpDPpZdY4iUYmoy4xYBmBvvM=;
        h=From:To:Subject:Date:From;
        b=oQmh9tuEk1RDahpb4JBl+BH5fx6pFh7HYbP/VUY5OjIgjYvNu/G+ByUeCmBzUqPbO
         1S466FuPIm1n2JlRn3ohWTezzmIyzOuakRg50VJnn1BUOD+6/yQbrq4Y7vPKT6C4u3
         vxFXQYCotflryo1cUGXCb2xDT+HgQZW69LVvMWwoGU6sRXx81VJusE6+cyUjHkXnWI
         TVWc/xdpDFrDkQ7875lUkon6Oh/FJRjp/8LzRPRv1dy98jaqX7rBtaLuSXNZmU1VBe
         CW5k4HAS53jNVSQB7bjEK/ZKkfCOVNLTVJvoweWhXJkRbhJcXr7Vwmyc/mFnGm9gkD
         22FG9F5veeF3w==
Received: by angela.anarc.at (Postfix, from userid 1000)
        id B3DD5AC08E; Fri, 23 Apr 2021 20:22:06 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: how to rename remote branches, the long way
Organization: Debian
Date:   Fri, 23 Apr 2021 20:22:06 -0400
Message-ID: <87mttofs5t.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

So this is a rather long story, which I plan to expand on in a blog post
when I find the time, but to make that story short:

I wrote a Python script to rename branches in git.

Before people start throwing things (like `git push origin oldref:newref
:oldref`) at me, consider that I've been beating my head against this
for a while, and everywhere I look basically suggests this:

    git branch -m to_branch
    git push origin from_branch:to_branch :from_branch

Now, to be fair, the latter is an optimization I found only after
searching more deeply for the problem (of course, on SO):

https://stackoverflow.com/a/21302474

But while the above look fine to a Stackoverflow user, a more experience
git user might know it has multiple problems:

 1. it will fail if you try to rename the master branch, or any
    branch protected by hooks on (say) GitHub or GitLab (because you
    can't delete a default or protected branch)
 2. it will not update the remote default branch (AKA the remote HEAD)
 3. it will not update the local HEAD pointer for the remote branch
    (noticeable on a `git remote prune origin`)
 4. it will break all links to from_branch on the remote (e.g. on gitweb
    and so on)

I made a script which fixes all those problems except the last one (and
only for GitLab, for problem 1). I am kind of hoping I didn't waste my
time doing so, but I would still be happy to be proven wrong and be
shown an easier way.

This is the script:

https://gitlab.com/anarcat/scripts/-/blob/main/git-branch-rename-remote

Raw/javascript-less version:

https://gitlab.com/anarcat/scripts/-/raw/main/git-branch-rename-remote

Also attached at the end of this email.

Now, I send this in a gesture of good will and spirit of sharing. I
would of course be happy to take contributions, in the form of merge
requests on GitLab or patches by email, as you see fit.

I wrote this primarily with the "master to main" migration, because a
bunch of projects (including mine) are suddenly, actually migrating
their main branch from master to main. Personnally, it's because I'm
tired of being yelled "master" from my shell prompt all the time, but
naturally, I guess opinions on the matter vary. The script, of course,
works with any combination of branch names and remotes -- heck, you can
even rename back from master to main if that's your kink -- but the
defaults are to cover for the "main" migration.

But this also makes me wonder if we there ever was a wider discussion on
(remote) branch renames as a primary operation. It seems like git
doesn't really support branch renames right now. `git branch --move`
*looks* like a rename, but really, it's probably just laying down a new
ref and deleting the old one (I haven't actually looked). With remotes,
anyways, that's certainly the only story there is.

For local branches, that doesn't matter much: no "links" should point
there. But git repos are, nowadays, living web sites on web servers like
GitHub, GitLab, cgit, or whatever. You have no way of telling those
sites "I am renaming a branch", so they don't have an opportunity of
fixing broken links (and, incidentally, bypassing branch protection,
although I actually use the GitLab API to workaround that problem).

So I wonder: could git remote branch renames as an operation on remotes?
How would that look? Is that something that the git project should work
on? Or is this something strictly reserved to the API space of git
forges? In that case, how do I tell my gitolite server that it's okay
to rename a branch since it doesn't have an API? :)

Or, maybe, should this script be sent as a [PATCH] instead and just be
merged into git itself? Maybe in contrib/? I do see some Python in
there, so I don't feel too much like an heretic... Obviously, it could
be rewritten in C, but it would feel such a pain in the back to me... I
already rewrote it from this shell script, which is still available
here:

https://gitlab.com/anarcat/scripts/-/blob/2bd01ae584994b8160b1dff20f3e290ace23265c/git-rename-to-main

So many questions, I hope I don't make a fool of myself here, and thanks
in advance for your time.

A.

-- 
Imagination is more important than knowledge.
Knowledge is limited.
Imagination encircles the world.
                        - Albert Einstein

--=-=-=
Content-Type: text/x-python
Content-Disposition: inline; filename=git-branch-rename-remote

#!/usr/bin/python3

"""Rename a branch locally and, as much as possible, remotely. This
was designed to help with the master/main transition, but can be used
with any branch name combination."""

import argparse
import logging
import os
import re
from subprocess import run, check_call, check_output, CalledProcessError, DEVNULL

import gitlab


def main():
    logging.basicConfig(format="%(levelname)s: %(message)s", level="INFO")
    args = RenamerArgumentParser().parse_args()
    if args.quiet:
        git_output = DEVNULL
    else:
        # None actually means "normal", ie. stdout
        git_output = None
    try:
        check_output(("git", "show-ref", "refs/heads/%s" % args.from_branch))
    except CalledProcessError:
        logging.warning(
            "branch %s does not exist, assuming already renamed", args.from_branch
        )
    else:
        logging.info("renaming %s to %s", args.from_branch, args.to_branch)
        check_call(
            ("git", "branch", "--move", args.from_branch, args.to_branch),
            stdout=git_output,
        )

    logging.info("fetching remote %s to see if it needs a rename", args.remote)
    check_call(("git", "fetch", args.remote), stdout=git_output)

    logging.info("reseting %s/HEAD to %s unconditionnally", args.remote, args.to_branch)
    check_call(
        (
            "git",
            "symbolic-ref",
            f"refs/remotes/{args.remote}/HEAD",
            f"refs/remotes/{args.remote}/{args.to_branch}",
        ),
        stdout=git_output,
    )

    logging.info(
        "setting local branch to follow %s/%s unconditionnally",
        args.remote,
        args.to_branch,
    )
    if (
        run(
            ("git", "branch", "-u", f"{args.remote}/{args.to_branch}"),
            stdout=DEVNULL if args.quiet else None,
        ).returncode
        == 0
    ):
        logging.info(
            "remote branch %s/%s already exists, all done", args.remote, args.to_branch
        )
        return

    logging.info("remote branch %s not found, pushing new branch", args.to_branch)
    check_call(("git", "push", "-u", args.remote, args.to_branch), stdout=git_output)

    remote_ssh, remote_url_http, forge_url, project = guess_remote_urls(args.remote)
    if "@" in remote_ssh:
        ssh_cmd = ("ssh", remote_ssh, f"git symbolic-ref HEAD {args.to_branch}")
        logging.info(
            "SSH remote detected, trying to fix default branch with: %s", ssh_cmd
        )
        if run(ssh_cmd, stdout=git_output).returncode != 0:
            logging.warning("failed to change HEAD on remote with SSH")

    logging.info("trying to delete old branch %s from remote", args.from_branch)
    if (
        not run(
            ("git", "push", "-d", args.remote, args.from_branch), stdout=git_output
        ).returncode
        == 0
    ):
        logging.warning("push denied by remote, maybe a branch protected in GitLab?")
        # TODO: GitHub support
        gitlab_branch_change_default(
            forge_url, project, args.from_branch, args.to_branch
        )
        logging.info(
            "trying to delete old branch %s from remote, again", args.from_branch
        )
        check_call(
            ("git", "push", "-d", args.remote, args.from_branch), stdout=git_output
        )
    logging.info(
        "all done, branch %s renamed to %s locally and on remote %s",
        args.from_branch,
        args.to_branch,
        args.remote,
    )


def gitlab_branch_change_default(forge_url, project, from_branch, to_branch):
    """wrapper around the branch default change

    Just changing the default is not enough: we also want to apply the
    same protections as the previous branch to the new branch.
    """
    private_token = os.environ.get("GITLAB_PRIVATE_TOKEN", None)
    if private_token is None:
        logging.error(
            "cannot talk to the GitLab forge without the GITLAB_PRIVATE_TOKEN environment variable"
        )
        return

    gl = gitlab.Gitlab(forge_url, private_token=private_token)
    gl_project = gl.projects.get(project)

    logging.info("protecting new branch %s", to_branch)
    gl_project.branches.get(to_branch).protect()
    logging.info("unprotecting old branch %s", from_branch)
    gl_project.branches.get(from_branch).unprotect()

    logging.info("changing default branch to %s", to_branch)
    gl_project.default_branch = to_branch
    gl_project.save()
    logging.info("all done with GitLab host %s", forge_url)


def guess_remote_urls(remote):
    """convenience wrapper around parse_remote_urls"""
    return parse_remote_urls(
        check_output(("git", "remote", "get-url", remote)).strip().decode("utf-8")
    )


def parse_remote_urls(remote_url):
    """this mess looks at the git remote URL and tries to guess a bunch of things

    In particular, it tries to guess an HTTP URL from a SSH-looking
    URL. Then It will try to guess the project (whatever comes after
    the slash), and *then* the name of the site, which we call the
    "forge_url", on which the site is hosted.

    >>> parse_remote_urls("https://example.com/foo.git")
    ('example.com', 'https://example.com/foo.git', 'https://example.com/', 'foo')
    >>> parse_remote_urls("git@example.com:foo.git")
    ('git@example.com', 'https://example.com/foo.git', 'https://example.com/', 'foo')
    >>> parse_remote_urls("ssh://example.com/foo.git")
    ('example.com', 'https://example.com/foo.git', 'https://example.com/', 'foo')

    Other URL formats are untested.
    """
    remote_ssh = remote_url_http = remote_url
    if "@" in remote_url:
        remote_url_http = re.sub(r".*@", "https://", remote_url.replace(":", "/"))
        logging.warning("rewritten URL %s to %s", remote_url, remote_url_http)
        remote_ssh = re.sub(":.*", "", remote_ssh)
    elif remote_url.startswith("ssh://"):
        # strip leading ssh://
        remote_ssh = re.sub(r"^ssh://", "", remote_url)
        remote_url_http = "https://" + remote_ssh
        # strip project path to keep just user@host.example.com
        remote_ssh = re.sub(r"/.*", "", remote_ssh)
    elif remote_url.startswith("https://"):
        # strip project path and url, keeping only host.example.com
        remote_ssh = re.sub(r"/.*", "", re.sub(r"^https://", "", remote_url))
    else:
        assert not remote_url.startswith("http://"), "cleartext HTTP URL unsupported"
        logging.warning("unsupported scheme for remote URL: %s", remote_url)

    logging.info("guessed remote URL %s", remote_url_http)
    project = re.sub(r"^https://[^/]*/(.*?)(\.git)?$", r"\1", remote_url_http)
    logging.info("guessed project path %s", project)

    forge_url = re.sub(r"^(https://[^/]*/).*$", r"\1", remote_url_http)
    logging.info("guessed forge URL %s", forge_url)
    return remote_ssh, remote_url_http, forge_url, project


class LoggingAction(argparse.Action):
    """change log level on the fly

    The logging system should be initialized befure this, using
    `basicConfig`."""

    def __init__(self, *args, **kwargs):
        """setup the action parameters

        This enforces a selection of logging levels. It also checks if
        const is provided, in which case we assume it's an argument
        like `--verbose` or `--debug` without an argument.
        """
        kwargs["choices"] = logging._nameToLevel.keys()
        if "const" in kwargs:
            kwargs["nargs"] = 0
        super().__init__(*args, **kwargs)

    def __call__(self, parser, ns, values, option):
        """if const was specified it means argument-less parameters"""
        if self.const:
            logging.getLogger("").setLevel(self.const)
        else:
            logging.getLogger("").setLevel(values)
        # cargo-culted from _StoreConstAction
        setattr(ns, self.dest, self.const)


class RenamerArgumentParser(argparse.ArgumentParser):
    def __init__(self, *args, **kwargs):
        "add parameters to the argument parser"
        super().__init__(
            description="rename a git branch locally and remotely",
            epilog=__doc__,
            *args,
            *kwargs,
        )
        self.add_argument(
            "-f",
            "--from-branch",
            default="master",
            help="branch to rename from, default: %(default)s",
        )
        self.add_argument(
            "-t",
            "--to-branch",
            default="main",
            help="branch to rename to, default: %(default)s",
        )
        self.add_argument(
            "-r",
            "--remote",
            default="origin",
            help="remote to also operate on, default: %(default)s",
        )
        self.add_argument(
            "-q",
            "--quiet",
            action=LoggingAction,
            const="WARNING",
            help="enable verbose messages",
        )
        self.add_argument(
            "-d",
            "--debug",
            action=LoggingAction,
            const="DEBUG",
            help="enable debugging messages",
        )


if __name__ == "__main__":
    main()

--=-=-=--
