From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Carrying over attributes when moving files
Date: Tue, 30 Mar 2010 23:30:25 -0400
Message-ID: <19378.49617.251787.103542@winooski.ccs.neu.edu>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
	<19376.50971.397375.810974@winooski.ccs.neu.edu>
	<19376.53419.640007.930897@winooski.ccs.neu.edu>
	<20100329231501.GA28194@progeny.tock>
	<19377.33747.838003.360864@winooski.ccs.neu.edu>
	<20100330213049.GB11192@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 05:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwodU-0000ns-Mb
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 05:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab0CaDa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 23:30:27 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:36312 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850Ab0CaDa0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 23:30:26 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NwodN-0000HT-8X; Tue, 30 Mar 2010 23:30:25 -0400
In-Reply-To: <20100330213049.GB11192@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143643>

On Mar 30, Jonathan Nieder wrote:
> Eli Barzilay wrote:
>=20
> > There are a number of technicalities that make git attributes a
> > poor substitute for svn properties -- mainly
> [...]
> > and the fact that they're not tracked with the files (as in svn,
> > where moving a file somewhere will move its properties with it).
>=20
> It would be great to improve this.
>=20
> Consider the following directory hierarchy.
>=20
> 	old-files/
> 		.gitattributes
> 		some-file.html
> 		other-file.html
> 	new-files/
> 		unrelated-file.html
>=20
> .gitattributes specifies that old HTML files use a CRLF line ending.
>=20
> 	*.html crlf
>=20
> What would you expect the following commands to do?
>=20
> 	git mv old-files/some-file.html new-files/
> 	git commit
>=20
> How about these?
>=20
> 	mv old-files/some-file.html new-files/
> 	git add new-files/some-file.html
> 	git commit -a
>=20
> I don=E2=80=99t think there=E2=80=99s any fundamental reason this has=
n=E2=80=99t been taken
> care of; it=E2=80=99s just that nobody has done it yet.

There's of course a whole bunch of similar issues, like having

  a/.gitattribute specifies: b/c foo=3Dbar
  a/b/.gitattribute specifies: c foo=3Dbar

or even worse -- when the two values are different.

In any case, the way that attributes are specified (which is flexible
and convenient, fwiw) is part of what makes them a bad substitution
for subversion properties...  Making attributes tracked with their
files would mean some change to how this specification is done.  For
example, it could be that attributes that are in (tracked)
=2Egitattribute files nad that have no "/" and no glob characters in th=
e
file names are the only ones that get tracked.  In short -- only
simple names of immediate files and/or directories.  Having such a
convention would also allow some equivalent of `svn propset' since
there's a canonical place to add them.

And this could be taken further -- for example, a command that will
crawl a tree and find "non-canonicalized" attributes, or will turn
them into such.  Another example would be to take something like
"*.html crlf" as meaning that new *.html files should get the crlf
attribute, etc.  But thinking about the kind of work that all of this
would imply, it seems to me that doing the svn thing and making the
attributes part of the content (ie, make them a part of the blob
objects somehow) makes more sense.  But this is a big change too...

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
