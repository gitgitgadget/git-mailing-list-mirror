From: =?windows-1252?Q?Damien_G=E9rard?= <damien@iwi.me>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Mon, 20 Jan 2014 15:01:47 +0100
Message-ID: <2BB6F289-A5B2-4213-8B8C-0AAECF5CFB4C@iwi.me>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me> <20140114001820.GA12058@padd.com> <20140114232432.GA31465@padd.com> <843E4B24-5EDD-4451-8849-425160576A99@iwi.me> <20140116130833.GA15613@padd.com> <4FE5D5E6-60F6-4111-B538-5CA01092A2F0@iwi.me> <20140116144519.GB15674@padd.com> <B6C98918-4339-4D14-8C52-4B3AEC2526E7@iwi.me> <20140118182225.GA6072@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 15:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5FQJ-00033i-BC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 15:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaATOBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jan 2014 09:01:51 -0500
Received: from catkin.iwi.me ([91.121.49.159]:43917 "EHLO catkin.iwi.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbaATOBu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jan 2014 09:01:50 -0500
Received: from imac-de-admin.private.4d.fr (unknown [194.98.194.79])
	(Authenticated sender: damien@iwi.me)
	by catkin.iwi.me (Postfix) with ESMTPSA id 23D0BA1E69;
	Mon, 20 Jan 2014 15:01:47 +0100 (CET)
In-Reply-To: <20140118182225.GA6072@padd.com>
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240710>


On 18 Jan 2014, at 19:22, Pete Wyckoff <pw@padd.com> wrote:

> damien@iwi.me wrote on Thu, 16 Jan 2014 17:02 +0100:
>>=20
>> On 16 Jan 2014, at 15:45, Pete Wyckoff <pw@padd.com> wrote:
>>=20
>>> Oh cool, that helps a lot.  P4 is just broken here, so we can get
>>> away with being a bit sloppy in git.  I'll try just pretending
>>> "empty symlinks" are not in the repo.  Hopefully you'll have a
>>> future commit in your p4 repo that brings back bn.h properly.
>>=20
>> Thanks !
>> I would love to use git instead of perforce if possible :)
>>=20
>>> Still not sure about how I'll test this.
>>=20
>> I can test for you, no probleme with that.
>=20
> Any chance you can give this a go?  I've a bigger patch in
> a longer series, but this should be the minimal fix.  If it
> works, I'll ship it to Junio.
>=20

Just for info, it works but it seems there are still some issues when a=
 git repository is present within the perforce repo :

error: Invalid path 'Tools/Doc/bin/yuidoc/.git/FETCH_HEAD'
error: Invalid path 'Tools/Doc/bin/yuidoc/.git/HEAD'
error: Invalid path 'Tools/Doc/bin/yuidoc/.git/ORIG_HEAD=92
[...]

Those files have been added then removed in another commit

I=92ve have to make git reset =97hard =91HEAD^=92 && git p4 sync to a c=
lean staging area right after the "clone".




> Thanks,
>=20
> 		-- Pete
>=20
> ----8<--------
>=20
> From 8556ab04dd126184e26a380b7ed08998fd33debe Mon Sep 17 00:00:00 200=
1
> From: Pete Wyckoff <pw@padd.com>
> Date: Thu, 16 Jan 2014 18:34:09 -0500
> Subject: [PATCH] git p4: work around p4 bug that causes empty symlink=
s
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Damien G=E9rard highlights an interesting problem.  Some p4
> repositories end up with symlinks that have an empty target.  It
> is not possible to create this with current p4, but they do
> indeed exist.
>=20
> The effect in git p4 is that "p4 print" on the symlink returns an
> empty string, confusing the curret symlink-handling code.
>=20
> In p4, syncing to a change that includes such a bogus symlink
> creates errors:
>=20
>    //depot/empty-symlink - updating /home/me/p4/empty-symlink
>    rename: /home/me/p4/empty-symlink: No such file or directory
>=20
> and leaves no symlink.
>=20
> Replicate the p4 behavior by ignoring these bogus symlinks.  If
> they are fixed in later revisions, the symlink will be replaced
> properly.
>=20
> Reported-by: Damien G=E9rard <damien@iwi.me>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
> git-p4.py | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 5ea8bb8..e798ecf 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2075,7 +2075,14 @@ class P4Sync(Command, P4UserMap):
>             # p4 print on a symlink sometimes contains "target\n";
>             # if it does, remove the newline
>             data =3D ''.join(contents)
> -            if data[-1] =3D=3D '\n':
> +            if not data:
> +                # Some version of p4 allowed creating a symlink that=
 pointed
> +                # to nothing.  This causes p4 errors when checking o=
ut such
> +                # a change, and errors here too.  Work around it by =
ignoring
> +                # the bad symlink; hopefully a future change fixes i=
t.
> +                print "\nIgnoring empty symlink in %s" % file['depot=
=46ile']
> +                return
> +            elif data[-1] =3D=3D '\n':
>                 contents =3D [data[:-1]]
>             else:
>                 contents =3D [data]
> --=20
> 1.8.5.2.320.g99957e5
>=20
>=20
