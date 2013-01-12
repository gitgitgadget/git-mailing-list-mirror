From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Sat, 12 Jan 2013 09:44 +0100
Message-ID: <4836187.09xoy3kJnj@blacky>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jardel Weyrich <jweyrich@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:51:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttwnw-0004aQ-PS
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 09:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab3ALIul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 03:50:41 -0500
Received: from babbelbox.org ([83.133.105.186]:44817 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab3ALIuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 03:50:40 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2013 03:50:40 EST
Received: (qmail 3888 invoked from network); 12 Jan 2013 08:45:11 -0000
Received: from p54aea21f.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.162.31)
  by babbelbox.org with ESMTPA; 12 Jan 2013 08:45:11 -0000
User-Agent: KMail/4.9.5 (Linux/3.7.1-gentoo; KDE/4.9.5; x86_64; ; )
In-Reply-To: <7vliby98r7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213278>

Am Freitag, 11. Januar 2013, 23:10:36 schrieb Junio C Hamano:
> Jardel Weyrich <jweyrich@gmail.com> writes:
> > I believe `remote set-url --add --push` has a bug. Performed tests
> > with v1.8.0.1 and v1.8.1 (Mac OS X).
> >=20
> > Quoting the relevant part of the documentation:
> >> set-url
> >>=20
> >>     Changes URL remote points to. Sets first URL remote points to
> >>     matching regex <oldurl> (first URL if no <oldurl> is given) to
> >>     <newurl>. If <oldurl> doesn=E2=80=99t match any URL, error occ=
urs and
> >>     nothing is changed.
> >>    =20
> >>     With --push, push URLs are manipulated instead of fetch URLs.
> >>     With --add, instead of changing some URL, new URL is added.
> >>     With --delete, instead of changing some URL, all URLs matching=
 regex
> >>     <url> are deleted. Trying to delete all non-push URLs is an er=
ror.>=20
> > Here are some steps to reproduce:
> >=20
> > 1. Show the remote URLs
> >=20
> > jweyrich@pharao:test_clone1 [* master]$ git remote -v
> > origin  /Volumes/sandbox/test (fetch)
> > origin  /Volumes/sandbox/test (push)
> >=20
> > 2. Add a new push URL for origin
> >=20
> > jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add --=
push
> > origin \>=20
> >     /Volumes/sandbox/test_clone2
> >=20
> > 3. Check what happened
> >=20
> > jweyrich@pharao:test_clone1 [* master]$ git remote -v
> > origin  /Volumes/sandbox/test (fetch)
> > origin  /Volumes/sandbox/test_clone2 (push)
>=20
> The original pushurl was replaced with the additional one, instead
> of being left and the new one getting added.  That looks certainly
> wrong.
>=20
> However, the result of applying the attached patch (either to
> v1.7.12 or v1.8.1) still passes the test and I do not think it is
> doing anything differently from what you described above.
>=20
> What do you get from
>=20
> 	git config -l | grep '^remote\.origin'
>=20
> in steps 1. and 3. in your procedure?  This question is trying to
> tell if your bug is in "git remote -v" or in "git remote set-url".

I'm not sure, if there is a bug at all. According to man git-push:

	The <pushurl> is used for pushes only. It is optional and defaults to
   <url>.
	(From the section REMOTES -> Named remote in configuration file)

the command:
    git remote add foo git@foo-fetch.org/some.git

will set "remote.foo.url" to "git@foo-fetch.org". Subsequently, fetch a=
nd push=20
will use git@foo-fetch.org as url.
=46etch will use this url, because "remote.foo.url" explicitly sets thi=
s. push=20
will use it in absence of a "remote.foo.pushurl".

Now, we're adding a push-url:
    git remote set-url --add --push foo git@foo-push.org/some.git

Relevant parts of config are now looking like:
	[remote "foo"]
        url =3D git@foo-fetch.org/some.git
        pushurl =3D git@foo-push.org/some.git

Since, pushurl is now given explicitly, git push will use that one (and=
 only=20
that one).

If we add another push-url now,
    git remote set-url --add --push foo git@foo-push-also.org/some.git

the next git-push will push to foo-push.org and foo-push-also.org.

Now, using --set-url --delete on both of these urls restores the origin=
al=20
state: only "remote.foo.url" is set; meaning implicitly pushurl default=
s to=20
url again.

To me this is exactly what Jardel was observing:

> In step 2, Git replaced the original push URL instead of adding a new
> one. But it seems to happen only the first time I use `remote set-url
> --add --push`. Re-adding the original URL using the same command seem=
s
> to work properly.

> And FWIW, if I delete (with "set-url --delete") both URLs push, Git
> restores the original URL.

Or am I missing something here?

Might be that the "bug" actually is that the expectation was

	git remote add foo git@foo-fetch.org/some.git

should have created a config like:

	[remote "foo"]
        url =3D git@foo-fetch.org/some.git
        pushurl =3D git@foo-fetch.org/some.git

since that is what "git remote -v" reports.

If that is the case, we might want to amend the output of 'git remote -=
v' with=20
the information that a pushurl is not explicitly given and thus default=
s to=20
url.

Sascha
