From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Removing files
Date: Thu, 11 Jan 2007 15:19:55 -0800
Message-ID: <20070111231955.GB13564@localdomain>
References: <87bql5cok3.fsf@morpheus.local> <7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 00:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59DG-00040v-7C
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbXAKXT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 11 Jan 2007 18:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbXAKXT6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:19:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36811 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030240AbXAKXT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:19:57 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B55417DC094;
	Thu, 11 Jan 2007 15:19:55 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 11 Jan 2007 15:19:55 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36631>

Junio C Hamano <junkio@cox.net> wrote:
> David K=E5gedal <davidk@lysator.liu.se> writes:
>=20
> > I'm wondering what the best way to commit the removal of a file is.
>=20
>  $ rm -f foo
>  $ git-commit -a
>=20
> > git status shows:
> >
> >   $ git status
> >   # On branch refs/heads/messages
> >   # Changed but not added:
> >   #   (use "git add <file>..." to incrementally add content to comm=
it)
> >   #
> >   #       deleted:    foo
>=20
> Suggesting "git add" to record the deletion feels insane.  Is
> this what we still do?  I think there have been much work=20
> in this area recently so the wordings might have already fixed.
>=20
> > Ok, so that didn't work.  Let's try rm instead:
> >
> >   $ git rm foo
> >   fatal: pathspec 'foo' did not match any files
> >
>=20
> The above message is from an older version of git-rm, but the
> one that will be in v1.5.0 is not any better.  It errs out with
> "No such file or directory".  A workaround using today's tool is
> to do "git rm --cached fo"
>=20
> I think the right fix is to suggest "git add/rm" in status
> output and make "git rm" not barf if the user has already
> removed the file from the working tree.

Would having a command like 'hg addremove' make things easier?  I've
been using the below script since my early days of using git, but I
don't think I've ever published it.  If you want I can create a
patch against git.git

-----------------------------------------------------------------------
#!/bin/sh
# like the addremove command in mercurial

if test "x$1" =3D "x-h"
then
	echo "Usage: git-addrm [<path>]"
	exit 0
fi
SUBDIRECTORY_OK=3D1
=2E git-sh-setup || die "Not a git archive"

EXCLUDE_ARGS=3D--exclude-per-directory=3D.gitignore

if test -f "$GIT_DIR/info/exclude"
then
	EXCLUDE_ARGS=3D"$EXCLUDE_ARGS --exclude-from=3D$GIT_DIR/info/exclude"
fi

set -e
git-ls-files -z --deleted $EXCLUDE_ARGS "$@"| \
	git-update-index --remove -z --stdin
git-ls-files -z --others $EXCLUDE_ARGS "$@" | \
	git-update-index --add -z --stdin
-----------------------------------------------------------------------

--=20
Eric Wong
