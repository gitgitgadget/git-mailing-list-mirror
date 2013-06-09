From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 14:32:47 -0400
Message-ID: <20130609183247.GF810@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
 <20130609060807.GA8906@sigill.intra.peff.net>
 <CAETqRCh9frekD8yiR0bE+WQ7b_et1th8p_LsqrL8NhPnC8yaow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:32:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkQB-0006oT-Rb
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3FIScv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:32:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:37408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab3FIScu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:32:50 -0400
Received: (qmail 19857 invoked by uid 102); 9 Jun 2013 18:33:40 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 13:33:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 14:32:47 -0400
Content-Disposition: inline
In-Reply-To: <CAETqRCh9frekD8yiR0bE+WQ7b_et1th8p_LsqrL8NhPnC8yaow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227089>

On Sun, Jun 09, 2013 at 02:35:45PM +0200, Beno=C3=AEt Person wrote:

> On 9 June 2013 08:08, Jeff King <peff@peff.net> wrote:
> > I also wonder if it would be useful to be able to specify not only =
files
> > in the filesystem, but also arbitrary blobs. So in 4b above, you co=
uld
> > "git mw preview origin:page.mw" to see the rendered version of what
> > upstream has done.
>=20
> Hum, so `git mw preview origin:page.mw` would just do the get
> request to the remote mediawiki, save it locally and - maybe - load i=
t
> in the browser ? Is it really better than just opening the browser an=
d
> typing the right URL ?

Not really, but when you start doing "origin^:page.mw", it may make mor=
e
of a difference.

> > If you just care about the remote name and not the name of the loca=
l
> > branch, you can just ask for
> >
> >   my $curr_branch =3D `git symbolic-ref HEAD`;
> >   my $remote =3D `git config "branch.$curr_branch.remote"`;
> >   my $url =3D `git config "remote.$remote.url"`;
> >
> > Of course you would want some error checks and probably some chomp(=
)s in
> > there, too.
>=20
> The fact is, `git symbolic-ref HEAD` result would have to be parsed i=
n order
> to extract the current branch name like I currently extract the remot=
e name.
> So, is it really better than `git rev-parse --symbolic-full-name @{up=
stream}` ?

It is, because it is not strictly true that an upstream of
"refs/remotes/foo/*" is for the remote "foo" (though in 99% of cases, i=
t
is). To find the upstream, git looks at branch.$curr_branch.remote, the=
n
calculates the upstream based on the fetch refspecs. Then you try to
undo that by converting it back from the right-hand side of the fetch
refspec into a remote name. It would be much easier to just look at the
config. :)

And yes, you do need the short name of the branch from HEAD, not the
full refname. You can use "git symbolic-ref --short" for that. You also
should check that it returns something useful (i.e., that we are not on
a detached HEAD).

> > That is probably OK as long as there is only one such remote, and i=
t
> > would help the case where you have branched off of a local branch (=
so
> > your upstream remote is ".").  If there are two mediawiki remotes,
> > though, it would make sense to simply fail, as you don't know which=
 to
> > use. But I'd expect the common case by far to be that you simply ha=
ve
> > one such remote.
>=20
> Well, I thought that `git mw preview` could provide an interactive mo=
de
> where, if the first search fails, it would find all the mediawiki rem=
otes, and
> offers to the user a way to choose the remote ?

That's fine; just as long as we do not silently produce output from an
unknown source when there is ambiguity.

You can do an interactive selection, or even just say something like:

  There are multiple mediawiki remotes, and I do not know which one you
  want to use for your preview. Which of:

    remote1
    remote2

  did you mean? Try using the "-r" option to specify the remote.

and then let the user repeat their command with the "-r" option using
shell history. That saves you from having to write an interactive
component, and teaches the user how to script it.

-Peff
