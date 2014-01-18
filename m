From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Sat, 18 Jan 2014 13:22:25 -0500
Message-ID: <20140118182225.GA6072@padd.com>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
 <20140114001820.GA12058@padd.com>
 <20140114232432.GA31465@padd.com>
 <843E4B24-5EDD-4451-8849-425160576A99@iwi.me>
 <20140116130833.GA15613@padd.com>
 <4FE5D5E6-60F6-4111-B538-5CA01092A2F0@iwi.me>
 <20140116144519.GB15674@padd.com>
 <B6C98918-4339-4D14-8C52-4B3AEC2526E7@iwi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Damien =?iso-8859-1?Q?G=E9rard?= <damien@iwi.me>
X-From: git-owner@vger.kernel.org Sat Jan 18 19:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4aXR-0001xm-QJ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 19:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaARSWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jan 2014 13:22:30 -0500
Received: from honk.padd.com ([74.3.171.149]:52813 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaARSW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jan 2014 13:22:29 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 7AA8270F3;
	Sat, 18 Jan 2014 10:22:28 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A89CA26272; Sat, 18 Jan 2014 13:22:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <B6C98918-4339-4D14-8C52-4B3AEC2526E7@iwi.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240650>

damien@iwi.me wrote on Thu, 16 Jan 2014 17:02 +0100:
>=20
> On 16 Jan 2014, at 15:45, Pete Wyckoff <pw@padd.com> wrote:
>=20
> > Oh cool, that helps a lot.  P4 is just broken here, so we can get
> > away with being a bit sloppy in git.  I'll try just pretending
> > "empty symlinks" are not in the repo.  Hopefully you'll have a
> > future commit in your p4 repo that brings back bn.h properly.
>=20
> Thanks !
> I would love to use git instead of perforce if possible :)
>=20
> > Still not sure about how I'll test this.
>=20
> I can test for you, no probleme with that.

Any chance you can give this a go?  I've a bigger patch in
a longer series, but this should be the minimal fix.  If it
works, I'll ship it to Junio.

Thanks,

		-- Pete

----8<--------

=46rom 8556ab04dd126184e26a380b7ed08998fd33debe Mon Sep 17 00:00:00 200=
1
=46rom: Pete Wyckoff <pw@padd.com>
Date: Thu, 16 Jan 2014 18:34:09 -0500
Subject: [PATCH] git p4: work around p4 bug that causes empty symlinks
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Damien G=E9rard highlights an interesting problem.  Some p4
repositories end up with symlinks that have an empty target.  It
is not possible to create this with current p4, but they do
indeed exist.

The effect in git p4 is that "p4 print" on the symlink returns an
empty string, confusing the curret symlink-handling code.

In p4, syncing to a change that includes such a bogus symlink
creates errors:

    //depot/empty-symlink - updating /home/me/p4/empty-symlink
    rename: /home/me/p4/empty-symlink: No such file or directory

and leaves no symlink.

Replicate the p4 behavior by ignoring these bogus symlinks.  If
they are fixed in later revisions, the symlink will be replaced
properly.

Reported-by: Damien G=E9rard <damien@iwi.me>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 5ea8bb8..e798ecf 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2075,7 +2075,14 @@ class P4Sync(Command, P4UserMap):
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
             data =3D ''.join(contents)
-            if data[-1] =3D=3D '\n':
+            if not data:
+                # Some version of p4 allowed creating a symlink that p=
ointed
+                # to nothing.  This causes p4 errors when checking out=
 such
+                # a change, and errors here too.  Work around it by ig=
noring
+                # the bad symlink; hopefully a future change fixes it.
+                print "\nIgnoring empty symlink in %s" % file['depotFi=
le']
+                return
+            elif data[-1] =3D=3D '\n':
                 contents =3D [data[:-1]]
             else:
                 contents =3D [data]
--=20
1.8.5.2.320.g99957e5
