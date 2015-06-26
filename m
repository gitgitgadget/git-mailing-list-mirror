From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set,
 like $GIT_DIR
Date: Fri, 26 Jun 2015 07:56:03 -0400
Message-ID: <20150626115603.GB4315@peff.net>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
 <1435315055-27011-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 13:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8SEu-0005X0-R2
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 13:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbbFZL4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 07:56:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:52200 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751738AbbFZL4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 07:56:06 -0400
Received: (qmail 2670 invoked by uid 102); 26 Jun 2015 11:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 06:56:05 -0500
Received: (qmail 15515 invoked by uid 107); 26 Jun 2015 11:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 07:56:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 07:56:03 -0400
Content-Disposition: inline
In-Reply-To: <1435315055-27011-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272774>

On Fri, Jun 26, 2015 at 05:37:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is where the "fun" is. The legacy behavior is, if $GIT_WORK_TREE=
 is
> not set but $GIT_DIR is, cwd is chosen as worktree's top. If you happ=
en
> to stand at worktree's top when you do this, all is well. If you are =
in
> a subdir "foo/bar" (real worktree's top is "foo"), this behavior bite=
s
> you: your detected worktree is now "foo/bar", but the first run
> correctly detected worktree as "foo". You get "internal error: work t=
ree
> has already been set" as a result.

I think this makes sense. I feel like we've dealt with this before, but
the two previous rounds I found were basically:

  - we have GIT_IMPLICIT_WORK_TREE, but that is for the _opposite_ case=
=2E
    I.e., when we do not have a work tree and must communicate so to
    later code (including sub-processes).

  - a discussion about switching the "work tree defaults to '.' when
    $GIT_DIR is set" behavior yielded almost the identical patch:

      http://article.gmane.org/gmane.comp.version-control.git/219196

    but we were so wrapped up in the greater discussion we did not appl=
y
    that simple fix. :)

> Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be set to=
o
> unless there's no work tree. But setting $GIT_WORK_TREE inside
> set_git_dir() may backfire. We don't know at that point if work tree =
is
> already configured by the caller. So set it when work tree is
> detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DIR is
> not.

Yeah, it would be nicer if we could make sure we always set
GIT_WORK_TREE along with GIT_DIR (since anything else is potentially
dangerous), but I don't think it's feasible to do it in set_git_dir for
the reasons you state.

I gave a quick peek through setup_explicit_git_dir to see if we missed
other cases (spoiler: no):

  - if we have core.bare set, we set $GIT_DIR without setting the
    working tree. But that's OK, because we'll never look at
    $GIT_WORK_TREE in that case. Good.

  - if we have core.worktree set, then we call set_git_work_tree to
    match. Good.

  - If GIT_IMPLICIT_WORK_TREE is turned off, we set_git_dir but do not
    set GIT_WORK_TREE. Good, because otherwise it would take precedence=
=2E

  - there are some more calls to set_git_dir at the end, but I think in
    those cases we will already have set up the working tree (or decide=
d
    we do not have one, by the above logic).

So that all seems fine. We also call set_git_dir from enter_repo, but i=
n
that case we have already moved into the .git directory itself, so that
is OK. setup_discovered_git_dir also makes some calls, but either we ar=
e
explicitly bare there, or we call set_git_work_tree(".").

So I do not see any cases that will regress, or that are uncovered. Of
course, that is just from reading the code. Getting one million monkeys
to bang on the keyboard may turn up any real problems. :)

> +	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
> +		error("Could not set GIT_WORK_TREE to '%s'", work_tree);

Should this be die()? setenv() should basically never fail, but if it
does, it could be confusing and/or dangerous to run without the variabl=
e
set.

-Peff
