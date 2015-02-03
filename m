From: Jeff King <peff@peff.net>
Subject: Re: folder naming bug?
Date: Tue, 3 Feb 2015 00:23:17 -0500
Message-ID: <20150203052317.GA1262@peff.net>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io>
 <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com>
 <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Kevin Coleman <kevin.coleman@sparkstart.io>
X-From: git-owner@vger.kernel.org Tue Feb 03 06:24:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIVy3-0005iB-Ru
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 06:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965966AbbBCFXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 00:23:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:44407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965022AbbBCFXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 00:23:20 -0500
Received: (qmail 7807 invoked by uid 102); 3 Feb 2015 05:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 23:23:20 -0600
Received: (qmail 6305 invoked by uid 107); 3 Feb 2015 05:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 00:23:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 00:23:17 -0500
Content-Disposition: inline
In-Reply-To: <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263306>

On Mon, Feb 02, 2015 at 11:52:21PM -0500, Kevin Coleman wrote:

> Yes, I am on a Mac.  I just tried that, but I don=E2=80=99t think tha=
t
> completely fixed it.  As you can see it tracks =E2=80=9Cfoo/bar.md=E2=
=80=9D and then
> it tracks =E2=80=9CFoo/bar.md=E2=80=9D.  It still tracks both =E2=80=9C=
foo=E2=80=9D and =E2=80=9CFoo=E2=80=9D even tho
> only =E2=80=9CFoo=E2=80=9D exists in my dir after the rename.

Yes, because your filesystem _is_ case insensitive, but now you have
told git that it is not. In your example:

> 11:41:57 ~/test $ git init
> Initialized empty Git repository in /Users/kcoleman/test/.git/
> 11:42:03 ~/test (master #) $ git config core.ignorecase false
> 11:42:06 ~/test (master #) $ mkdir foo
> 11:42:13 ~/test (master #) $ cd foo
> 11:42:26 ~/test/foo (master #) $ touch bar.md
> 11:42:30 ~/test/foo (master #) $ cd ..
> 11:42:32 ~/test (master #) $ git add .

Now git has "foo" (lowercase) in the index. And that's what your
filesystem has, too.

> 11:42:35 ~/test (master #) $ git commit -m "first"
> [master (root-commit) 6125a1d] first
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 foo/bar.md
> 11:42:39 ~/test (master) $ mv foo Foo
> 11:42:44 ~/test (master) $ ls
> Foo

Now we still have "foo" in the index, but "Foo" in the filesystem.

> 11:42:46 ~/test (master) $ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>=20
> 	Foo/

When git asks the filesystem lstat("foo") to find out if we still have
it, the filesystem returns the entry for "Foo" (because it is
case-insensitive).

But when git asks the filesystem to iterate over all of the files, so i=
t
can check which ones are not tracked, it will get "Foo", which of cours=
e
is not in the index.

So you do not see a deletion of "foo", but you do see "Foo" as
untracked.

> 11:42:48 ~/test (master) $ git add .
> 11:43:18 ~/test (master +) $ git commit -m "second"
> [master f78d025] second
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 Foo/bar.md

And this tells git to look through the filesystem for untracked files
and add them to the index. So it adds "Foo".

Now that you have both "foo" and "Foo" in the index, but the filesystem
treats them the same, you can create more mayhem. If you were to update
one entry but not the other (e.g., by writing to bar.md before doing th=
e
second commit), then git would be perpetually confused. _One_ of the
files would always look like needed to be updated, because the
filesystem cannot represent the situation that is in the index.

And that is why git sets core.ignorecase in the first place. :)

As to your original problem:

> >> git isn=E2=80=99t tracking folder renames when the case of the let=
ters
> >> change, but it will track it if the folder changes names.  Is this
> >> intentional?

Yes, this is intentional. Your filesystem treats them as the same file,
so git has to, as well.

If your goal is to change the case that git records, then you should be
able to do it with "git mv". But git will never pick up a case change
that you made separately in the filesystem, because it's
indistinguishable from the filesystem simply picking a different case t=
o
store the file.

And that does happen. For instance, if you switch between two branches
with "Foo" and "foo", most case-preserving filesystems will leave you
with whichever version you had first (i.e., git asks the filesystem to
open "foo", and the filesystem says "ah, I already have Foo; that must
have been what you meant").

-Peff
