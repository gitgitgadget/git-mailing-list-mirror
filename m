From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Wed, 2 Sep 2009 04:19:17 -0400
Message-ID: <20090902081917.GA5447@coredump.intra.peff.net>
References: <20090902080305.GA11549@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mil3y-0002kU-Do
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 10:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbZIBITV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 04:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZIBITV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 04:19:21 -0400
Received: from peff.net ([208.65.91.99]:42561 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbZIBITS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 04:19:18 -0400
Received: (qmail 5767 invoked by uid 107); 2 Sep 2009 08:19:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 04:19:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 04:19:17 -0400
Content-Disposition: inline
In-Reply-To: <20090902080305.GA11549@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127594>

On Wed, Sep 02, 2009 at 10:03:05AM +0200, SZEDER G=C3=A1bor wrote:

> As the subject says, 'git add -u' does not work from an untracked
> subdir, because it doesn't add modified files to the index.  The
> following script reproduces the issue:
>=20
> mkdir repo
> cd repo
> git init
> echo 1 >foo
> git add foo
> git commit -m first
> echo 2 >foo
> mkdir untracked_subdir
> cd untracked_subdir
> git add -u
> git diff
>=20
> It worked in the initial 'git add -u' implementation (dfdac5d, git-ad=
d
> -u: match the index with working tree, 2007-04-20), but 2ed2c222
> (git-add -u paths... now works from subdirectory, 2007-08-16) broke i=
t
> later, and is broken ever since.

It is not just untracked subdirs. Try:

  mkdir repo && cd repo && git init
  echo 1 >foo
  mkdir subdir
  echo 1 >subdir/bar
  git add . && git commit -m first
  echo 2 >foo
  echo 2 >subdir/bar
  cd subdir
  git add -u
  git diff ;# still shows foo/1 in index
  git diff --cached ;# shows subdir/bar was updated

While I have sometimes found the behavior a bit annoying[1], I always
assumed that was the intended behavior.

And indeed, in modern builtin-add.c, we find this:

        if ((addremove || take_worktree_changes) && !argc) {
                static const char *here[2] =3D { ".", NULL };
                argc =3D 1;
                argv =3D here;
        }

which seems pretty explicit.

-Peff

[1] I would prefer "git add -u ." to add only the current directory, an=
d
"git add -u" to touch everything. But then, I am one of the people who
turn off status.relativepaths, so I think I may be in the minority in
always wanting to think of the project as a whole.
