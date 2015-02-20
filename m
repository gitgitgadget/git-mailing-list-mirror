From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Fri, 20 Feb 2015 00:03:20 +0000
Message-ID: <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Cc: git@vger.kernel.org
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOb48-0006SG-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 01:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbBTAD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 19:03:27 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49021 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631AbbBTAD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 19:03:27 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e5aa:2c88:b0cf:ba1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9BA852808F;
	Fri, 20 Feb 2015 00:03:25 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Morton <stephen.c.morton@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264123>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 04:26:58PM -0500, Stephen Morton wrote:
> I posted this to comp.version-control.git.user and didn't get any respons=
e. I
> think the question is plumbing-related enough that I can ask it here.
>=20
> I'm evaluating the feasibility of moving my team from SVN to git. We have=
 a very
> large repo. [1] We will have a central repo using GitLab (or similar) that
> everybody works with. Forks, code sharing, pull requests etc. will be done
> through this central server.
>=20
> By 'performance', I guess I mean speed of day to day operations for devs.
>=20
>    * (Obviously, trivially, a (non-local) clone will be slow with a large=
 repo.)
>    * Will a few simultaneous clones from the central server also slow down
>      other concurrent operations for other users?

This hasn't been a problem for us at $DAYJOB.  Git doesn't lock anything=20
on fetches, so each process is independent.  We probably have about=20
sixty developers (and maybe twenty other occasional users) that manage=20
to interact with our Git server all day long.  We also have probably=20
twenty smoker (CI) systems pulling at two hour intervals, or, when=20
there's nothing to do, every two minutes, plus probably fifteen to=20
twenty build systems pulling hourly.

I assume you will provide adequate resources for your server.

>    * Will 'git pull' be slow?
>    * 'git push'?

The most pathological case I've seen for git push is a branch with a=20
single commit merged into the main development branch.  As of Git 2.3.0,=20
the performance regression here is fixed.

Obviously, the speed of your network connection will affect this.  Even=20
at 30 MB/s, cloning several gigabytes of data takes time.  Git tries=20
hard to eliminate sending a lot of data, so if your developers keep=20
reasonably up-to-date, the cost of establishing the connection will tend=20
to dominate.

I see pull and push times that are less than 2 seconds in most cases.

>    * 'git commit'? (It is listed as slow in reference [3].)
>    * 'git stautus'? (Slow again in reference 3 though I don't see it.)

These can be slow with slow disks or over remote file systems.  I=20
recommend not doing that.  I've heard rumbles that disk performance is=20
better on Unix, but I don't use Windows so I can't say.

You should keep your .gitignore files up-to-date to avoid enumerating=20
untracked files.  There's some work towards making this less of an=20
issue.

git blame can be somewhat slow, but it's not something I use more than=20
about once a day, so it doesn't bother me that much.

> Assuming I can put lots of resources into a central server with lots of C=
PU,
> RAM, fast SSD, fast networking, what aspects of the repo are most likely =
to
> affect devs' experience?
>    * Number of commits
>    * Sheer disk space occupied by the repo

The number of files can impact performance due to the number of stat()s=20
required.

>    * Number of tags.
>    * Number of branches.

The number of tags and branches individually is really less relevant=20
than the total number of refs (tags, branches, remote branches, etc).=20
Very large numbers of refs can impact performance on pushes and pulls=20
due to the need to enumerate them all.

>    * Binary objects in the repo that cause it to bloat in size [1]
>    * Other factors?

If you want good performance, I'd recommend the latest version of Git=20
both client- and server-side.  Newer versions of Git provide pack=20
bitmaps, which can dramatically speed up clones and fetches, and Git=20
2.3.0 fixes a performance regression with large numbers of refs in=20
non-shallow repositories.

It is totally worth it to roll your own packages of git if your vendor=20
provides old versions.

> Of the various HW items listed above --CPU speed, number of cores, RAM, S=
SD,
> networking-- which is most critical here?

I generally find that having a good disk cache is important with large=20
repositories.  It may be advantageous to make sure the developer=20
machines have adequate memory.  Performance is notably better on=20
development machines (VMs) with 2 GB or 4 GB of memory instead of 1 GB.

I can't speak to the server side, as I'm not directly involved with its=20
deployment.

> Assume ridiculous numbers. Let me exaggerate: say 1 million commits, 15 G=
B repo,
> 50k tags, 1,000 branches. (Due to historical code fixups, another 5,000 "=
fix-up
> branches" which are just one little dangling commit required to change th=
e code
> a little bit between a commit a tag that was not quite made from it.)

I routinely work on a repo that's 1.9 GB packed, with 25k (and rapidly=20
growing) refs.  Other developers work on a repo that's 9 GB packed, with=20
somewhat fewer refs.  We don't tend to have problems with this.

Obviously, performance is better on some of our smaller repos, but it's=20
not unacceptable on the larger ones.  I generally find that the 940 KB=20
repo with huge numbers of files performs worse than the 1.9 GB repo with=20
somewhat fewer.  If you can split your repository into multiple logical=20
repositories, that will certainly improve performance.

If you end up having pain points, we're certainly interested in=20
working through those.  I've brought up performance problems and people=20
are generally responsive.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU5nnIAAoJEL9TXYEfUvaL1OcP/1zi0IZvozdDPTp6Y0zM9ibu
49gMnYz+yMhbcBrsawoOuIwqFnU5NNR33tWW6SxxGWqq900RR0R91oRHvMjH/gy0
zWoSX3jmckmWdBSB6/W7meF0rnCa5v779jkoZ/EElhr9BO9uGHpauQLcppiWysAT
D+xbNEGdnG3aFr/b1f2aTVQwFLdSwIev6CX9uChgZPgCdLHj7N29qH0ewMRMj3LD
plPnKRnMxIYVbNDlndtxznymma3gau2mb6B9JrJ15MlllY6mkZlHOcunjJVOG0Qb
6vEHtlrEPiv6pvprgo//mrut4K2N3ujqIj9zjLjhoS5129mopZU00N9NHLfuOFRt
dEfvtGoSWVQbQapApkztSte9L+QseoQf3hQqyneOJITwl7qUxQtsP+lgpqU9OJF0
AI/otUlmV3hmXOQFdPkNqVQ579CEh9V9siVXYt7kmjsubRXECUjpu5Woh/8ZOyMo
LD1Lg8LGmwUfAeWubvP3PvyK4AttJt80EgIRUX6BHY6EJDkOKjo7KVM54rqNH1qR
L1R7ioPrUIEd/1vNfY5ICD9r3yzPtvwY+Yr+CLtvDY2H+ao2+eODpqpWngzBtspK
m6QJDwg6JvzUHPtPsf8gcvO3UXz14W2crSDPaT8qQx/7C0BQzDcVMHSChYWQ8xoc
ORiuDT3PiIiYkRWI7ZRe
=UiPS
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
