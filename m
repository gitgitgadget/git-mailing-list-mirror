From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Git performance results on a large repository
Date: Mon, 06 Feb 2012 16:07:58 -0500
Message-ID: <rmir4y7vff5.fsf@fnord.ir.bbn.com>
References: <CB55A6A4.40AFD%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:08:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVnB-0007z7-Nb
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab2BFVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 16:08:00 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:55931 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab2BFVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 16:07:59 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id C416A53C3; Mon,  6 Feb 2012 16:07:58 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:120206:git@vger.kernel.org::yrdjLqGDXLcp3ww4:0000000000000000000000000000000000000000000kAh
X-Hashcash: 1:20:120206:david@lang.hm::1ygkfOaUhNLdUYu4:00000QL8
X-Hashcash: 1:20:120206:joshua.redstone@fb.com::QuAs3uoV665I0Kqa:0000000000000000000000000000000000000000oAY
X-Hashcash: 1:20:120206:dgma@mohsinc.com::lO3b17Q1qhfnKWnU:018C+
X-Hashcash: 1:20:120206:pclouds@gmail.com::DYs2R4ZEYdjCZ1rv:000000000000000000000000000000000000000000002RRp
X-Hashcash: 1:20:120206:joey@kitenet.net::LUBJStbkFl6KN9tl:03XGd
X-Hashcash: 1:20:120206:davidbarr@google.com::LUBJStbkFl6KN9tl:000000000000000000000000000000000000000001q2y
X-Hashcash: 1:20:120206:mdg149@gmail.com::joacQIz+pgmvO5it:08Q+X
X-Hashcash: 1:20:120206:tom@dbservice.com::yrdjLqGDXLcp3ww4:000000000000000000000000000000000000000000007u1D
In-Reply-To: <CB55A6A4.40AFD%joshua.redstone@fb.com> (Joshua Redstone's
	message of "Mon, 6 Feb 2012 20:50:08 +0000")
User-Agent: Gnus/5.130002 (Ma Gnus v0.2) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190103>

--=-=-=
Content-Type: text/plain


Joshua Redstone <joshua.redstone@fb.com> writes:

> Greg,  'git commit' does some stat'ing of every file, even with all those
> flags - for example, I think one instance it does it is, just in case any
> pre-commit hooks touched any files, it re-stats everything.

That seems ripe for skipping.  If I understand correctly, what's being
committed is the index, not the working dir contents, so it would follow
that a pre-commit hook changing a file is a bug.

> Regarding the perf numbers, I ran it on a beefy linux box.  Have you
> tried doing your measurements with the drop_caches trick to make sure
> the file cache is totally cold?

On NetBSD, there should be a clear cache command for just this reason,
but I'm not sure there is.  So I did

  sysctl -w kern.maxvnodes=1000 # seemed to take a while
  ls -lR # wait for those to be faulted in
  sysctl -w kern.maxvnodes=500000

Then, git status on my repo churned the disk for a long time.

  real    2m7.121s
  user    0m3.086s
  sys     0m7.577s

and then again right away

  real    0m6.497s
  user    0m2.533s
  sys     0m3.010s

That repo has 217852 files (a real source tree with a few binaries, not
synthetic).

> Sorry for the dumb question, but how do I check the vnode cache size?

On BSD, sysctl kern.maxvnodes.  I would aasume that on Linux there is
some max size for the the vnode cache, and that stat of a file in that
cache is faster than going to the filesystem (even if reading from
cached disk blocks).  But I really don't know how that works in Linux.

I was going to say that if your vnode cache isn't big enough, then the
hot run won't be so much faster than the warm run, but that's not true,
because the fs blocks will be in the block cache and it will still help.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk8wQS4ACgkQ+vesoDJhHiWk+ACdFh/b7sSvsj99WLZMVrRHYSY4
7mYAnjXN28dKif89nq0J6sg9rr02NHx0
=TDLs
-----END PGP SIGNATURE-----
--=-=-=--
