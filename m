From: Jeff King <peff@peff.net>
Subject: Re: Need support with git credential storage
Date: Wed, 27 Jan 2016 17:28:34 -0500
Message-ID: <20160127222834.GA355@sigill.intra.peff.net>
References: <CY1PR0701MB1836FFF6CEAC69DFB5E86DACB7D90@CY1PR0701MB1836.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Charles =?utf-8?B?QsOpbGFuZ2Vy?= <cbelanger@addenergie.ca>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYZu-00025N-21
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966275AbcA0W2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 17:28:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:33467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965009AbcA0W2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 17:28:37 -0500
Received: (qmail 19170 invoked by uid 102); 27 Jan 2016 22:28:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 17:28:36 -0500
Received: (qmail 15756 invoked by uid 107); 27 Jan 2016 22:29:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 17:29:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2016 17:28:34 -0500
Content-Disposition: inline
In-Reply-To: <CY1PR0701MB1836FFF6CEAC69DFB5E86DACB7D90@CY1PR0701MB1836.namprd07.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2016 at 09:49:38PM +0000, Charles B=C3=A9langer wrote:

> Here's the git clone command launch by a .sh script file called from =
~/.profile:
> git clone https://MyUserName@bitbucket.org/CompanyName/ProjectName.gi=
t ~/Projects/SubFolderName/ProjectName
>=20
> Here's the error from bash .profile:
> Fatal: unable to access 'https://MyUserName@bitbucket.org/CompanyName=
/ProjectName.git/':
> Could not resolve host: bitbucket.org

I don't think this is related to credentials. The credential code shoul=
d
never do a network hostname lookup. It looks more like git-clone is
failing to contact the host in the first place.

Try "ping bitbucket.org", which would presumably yield the same error.
If so, you need to figure out why you cannot resolve the name, but
that's beyond the scope of this list.

> I followed the excellent Web page here:
> https://git-scm.com/book/be/v2/Git-Tools-Credential-Storage
>=20
> Here's what I use as commands:
> git credential-store --file ~/git.store store
> protocol=3Dhttps
> host=3Dbitbucket.org/CompanyName/ProjectName.git
> username=3DMyUserName
> password=3DMyPassword
> (type enter on a blank line to exit)

This comes from the "under the hood" section, I think. In normal use,
you shouldn't need to run the credential-helper directly. Just configur=
e
it, via:

  git config credential.helper "store --file ~/git.store"

The first time git needs a password, it will prompt you on the terminal=
,
and then store the result in that file.

If you do want to pre-seed the store, you can do so using a command lik=
e
the one above. But as you noted later, the "host" field should be _just=
_
the hostname, not the rest of the url path. That would go in the "path"
field if you want it, but typically git does not even bother to store
paths, and just keys on whole domains (see "credential.useHttpPath" in
"git help config" for more details).

You can also specify a URL using the special key "url", which is then
parsed into its components. So for example:

  $ git credential-store --file my-store store
  url=3Dhttps://bitbucket.org/CompanyName/ProjectName.git
  username=3Dfoo
  password=3Dbar
  [blank line to end]

  $ cat my-store
  https://foo:bar@bitbucket.org/CompanyName/ProjectName.git

  $ git credential-store --file my-store get
  url=3Dhttps://bitbucket.org/

  [blank line ends our input, the rest is output]
  username=3Dfoo
  password=3Dbar

> Here's what the ~/git.store file looks like:
>         https://MyUserName:MyPassword@bitbucket.org%2fCompanyName%2fP=
rojectName.git
>=20
> I tried changing the %2f by / inside the git.store file and also trie=
d // but it's still showing the same fatal error.
> Perhaps I don't use the host=3D  property correctly.

Right. It should be:

  https://MyUserName:MyPassword@bitbucket.org/CompanyName/ProjectName.g=
it

Though as before, you can omit "CompanyName/ProjectName.git" completely=
,
to cover the whole domain.

-Peff
