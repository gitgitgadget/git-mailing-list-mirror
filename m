From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: backups with git and inotify
Date: Mon, 10 Dec 2007 21:47:28 +0000
Message-ID: <20071210214728.GB17458@bit.office.eurotux.com>
References: <20071210202911.GA14738@bit.office.eurotux.com> <e1dab3980712101318v264fcce5pebbb829d8cefb1ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Cc: git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 22:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qTm-0007zF-7H
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbXLJVrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbXLJVrg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:47:36 -0500
Received: from os.eurotux.com ([216.75.63.6]:42152 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbXLJVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:47:35 -0500
Received: (qmail 14294 invoked from network); 10 Dec 2007 21:47:33 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 10 Dec 2007 21:47:33 -0000
Content-Disposition: inline
In-Reply-To: <e1dab3980712101318v264fcce5pebbb829d8cefb1ac@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67762>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2007 at 09:18:18PM +0000, David Tweed wrote:
> Hi, looks interesting project.
>=20
> I've been doing something similar-ish (but periodically rather than
> upon changes). Here are some rough off-the-cuff observations (probably
> telling you things you already know).

Thanks.

>=20
> Firstly, are you doing backups (be able to restore to n previous
> states upon catastrophe) or archives (being able to lookup arbitrary
> points in history to compare with current stuff, eg, for regressions)?
> (Archiving is useful if you aren't in a disciplined enough project to
> do rewritten proper commits but still want to be able to look around
> and try to figure out what's caused regressions, etc.)

Archives, only. If the project requires a coherent state, then I don't
think that automatic commits are the way to go.

>=20
> The scripts I use are at
>=20
> http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz
>=20
> but they're designed around archiving rather than backups.

Thanks, I'll take a look, and maybe borrow some ideas. :)

>=20
> On Dec 10, 2007 8:29 PM, Luciano Rocha <luciano@eurotux.com> wrote:
> > The following is a work in progress. There are some problems in how I'm
> > using git and recording the history:
> >
> > 1. I use an opened fd for each monitored directory (and subdirectories),
> >    (inotify_add_watch_at would be nice).
> >    I fchdir(fd) when a change happens to register and commit it.
>=20
> I thought about trying to have a daemon using inotify to record the
> git-add's/git-rm's but keeping the cron driven actual commits, and
> looked at python support module. I didn't because firstly I wasn't
> sure how far inotify scaled (the fact the Linux VFS maintainer insists
> on calling it "idiotify" doesn't inspire confidence). If it was me,
> I'd pull the git-commit outside your loop that does the git-add/git-rm
> (see later comment about emacs, etc).

I'd like to have the changes committed as soon as an application closes
its files. As I monitor a small subset of possible inotify events, I
think I shouldn't have much problems with scale. I'll have to test it
with my Maildir, though, to have a definitive answer.

> Obviously if your buffer isn't
> completely emptied you'll get a misleading granularity of commits, but
> then I guess that'll happen anyway. I think inotify drops events if an
> internal queue fills: personally I'd try to check for that and
> initiate manually scanning if I detected that happening.

Hm, that could be a problem. Maybe a periodic git-status followed by
git-add/rm, etc.. Hourly, perhaps.

>=20
> > 2. git-rm dir/file also removes <dir> if file was the only entry of
> >    <dir>. So, when committing the removal, git complains that it can't
> >    find cwd. So I record the parent directory, do the git command, check
> >    if getcwd() works, and if not do the commit in the parent directory.
> >
> > 3. git-rm (empty) directory fails
> >
> > 4. Changes aren't atomic, but I can live with that and I doubt I would
> >    be able to make it atomic without implementing a filesystem (FUSE or
> >    not).
>=20
> With things like emacs that do update writes by writing a new file
> with a temporary name and then copying it over the top of the old
> file, you'll get presumably 3 commits. Is that acceptable?

No. Vim also has that behaviour. I plan on accepting ignore patterns,
and maybe also parse .gitignore, and add those temporary files (*~,
=2E*.sw[po]), etc.) implicitly.

>=20
> > I can work around most of the problems, and rewrite to use recorded path
> > names instead of directories fd, but before I do that, and while I'm
> > at the beginning, I'd like to probe for opinions and suggestions.
>=20
> The only other thing that occurs to me is whether you need any greater
> support for stopping the automatic monitoring than just stopping the
> daemon. Eg, what happens if you decide you need to recover a previous
> version of a file. Git checks it out, presumably updates the index
> itself and then inotify fires off a git-add that will want to write to
> the index. Basically, I'm trying to think if there's any situation
> where you can have a delete event that git causes, followed by a
> creating some new content where delay in your program processing the
> delete will cause the new content to be `lost'? (I know, I sould read
> the code.) In chronoversion, the first thing it does is check for a
> "suppress" file which stops it doing anything automatically and I put
> one in there whenever I'm doing anything more than looking at the data
> (eg, switch branch, checkout old version, etc). But I might be being
> hyper-cautious.

I'll have to think about that. A stop/pause button is a good idea, and
checking if the tree is at HEAD. I don't think a commit of changes to a
file checked-out to a previous version will lose any information,
but I'll check.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHXbPwinSul6a7oB8RAh5EAKChNYMZ71l4a1vF1Tq26l6Erc7odACeOjYK
8ZP3lJPoezCIS8PBLzmaiyE=
=C7Eq
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
