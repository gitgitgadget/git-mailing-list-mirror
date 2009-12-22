From: Robert Schiele <rschiele@gmail.com>
Subject: following untracked parents in git-svn
Date: Tue, 22 Dec 2009 11:28:17 +0100
Message-ID: <20091222102815.GA12259@sigfpe.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 11:28:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN1yb-0000Ho-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 11:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbZLVK2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 05:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbZLVK2U
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 05:28:20 -0500
Received: from mtagate7.de.ibm.com ([195.212.17.167]:60696 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZLVK2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 05:28:19 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id nBMASI1X007268
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 10:28:18 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id nBMASIhl1363990
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 11:28:18 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id nBMASI6q026430
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 11:28:18 +0100
Received: from sigfpe.ibm.com (itv06579.uk.ibm.com [9.145.106.99])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id nBMASH6Z026421;
	Tue, 22 Dec 2009 11:28:18 +0100
Received: by sigfpe.ibm.com (Postfix, from userid 1000)
	id 9A76B13E0E5; Tue, 22 Dec 2009 11:28:17 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135578>


--NDin8bjvE/0mNLFQ
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric et al.,

While using git-svn to work with a repository with a very complex history I
discovered a very unfortunate behavior:

In general when a branch was derived (copied) from somewhere else git-svn
follows this parent branch and imports it.  If multiple branches do that
git-svn detects that the corresponding parrent branch already had been
imported and reuses the imported data.  Unfortunately when the parent
directory in the svn repository is not tracked as a branch in the svn-remote
section of the config file (for instance when it is just a subdirectory of a
tracked branch) this situation is no longer detected and this parent branch is
imported multiple times with the same result.  In a large repository this can
increase importing time drastically.

My analysis (as far as I understand the code) is that this is because the map
files in .git/svn are indexed by their ref name in the git repository.
Untracked branches are indexed by the name of their following branch ref name
followed by @XX where XX is the revision number of the branch point.
Obviously with that scheme the index name for two branches following a common
parent tree is different and thus an already imported tree is not correctly
detected.

My thoughts where now that this could potentially be fixed by not indexing
those map files by their ref name in the git repository but by their location
in the original svn repository.  Given that my understanding of the git-svn
code is not good enough to decide about all the consequences of such a design
change I'd like to ask you whether you think this change would be a good idea
or whether I might have overlooked a fundamental problem that makes it
impossible (or at least hard) to implement this idea.

Since my description of the problem might be a bit confusing without an
example I created a very small svn repository that shows this problem.  A svn
repository dump for it is attached.  When importing this repository using the
svn-remote section

[svn-remote "svn"]
	url = file:///dev/shm/x/svn1
	fetch = trunk:refs/remotes/trunk
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*

you will get the following behavior during the import:

$ git svn init -s file:///dev/shm/x/svn1
Initialized empty Git repository in /dev/shm/x/git2/.git/
$ git svn fetch
r1 = 7920f3e7e70c9bb9d8a7caf28830c7ed205c20c6 (refs/remotes/trunk)
	A	x/alpha
r2 = db7ad1b41f1d2ad18d198b9a80d2606b27557faf (refs/remotes/trunk)
	A	x/beta
r3 = a35cab9c510f66d96437f21ecb738c93e0c6b793 (refs/remotes/trunk)
Found possible branch point: file:///dev/shm/x/svn1/trunk/x => file:///dev/shm/x/svn1/branches/foo1, 2
Initializing parent: refs/remotes/foo1@2
	A	alpha
r2 = 5584693b5216dc1fa05f56455c67dfd61093ee43 (refs/remotes/foo1@2)
Found branch parent: (refs/remotes/foo1) 5584693b5216dc1fa05f56455c67dfd61093ee43
Following parent with do_switch
	A	beta
Successfully followed parent
r4 = d0cb7cfc1f69e52ecd39d8eb67518abe136b53d3 (refs/remotes/foo1)
Found possible branch point: file:///dev/shm/x/svn1/trunk/x => file:///dev/shm/x/svn1/branches/foo2, 2
Initializing parent: refs/remotes/foo2@2
	A	alpha
r2 = 5584693b5216dc1fa05f56455c67dfd61093ee43 (refs/remotes/foo2@2)
Found branch parent: (refs/remotes/foo2) 5584693b5216dc1fa05f56455c67dfd61093ee43
Following parent with do_switch
	A	beta
Successfully followed parent
r5 = 181cb81070b816bef74adefa1bc4c451100a5eef (refs/remotes/foo2)
Checked out HEAD:
  file:///dev/shm/x/svn1/trunk r3

As you can see file:///dev/shm/x/svn1/trunk/x is imported twice.  For this
small repository this is not a big issue but when this tree had a deep history
in a large repository you wanted to avoid that.

Robert

--4Ckj6UjgE2iN1+kY
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="svndump.gz"
Content-Transfer-Encoding: base64

H4sICAYoKksCA3N2bmR1bXAA3ZXLbtswEEX3/Ar9AG0OyeFD26aLokAa5LXojhLJ2IgtGXoY
yd+XtgPUjuTagdssCmnDS5CHM/eKunu8prGlvl+uaKybpevoOjTtvK7yjBPy8PDtKs90NFx4
b2hwRlEAH6hBUVAorPEWhdWxIOQ2rOebhbTql0Vo8oyRm6Ze0bKuulB1dBGqp26WZ6jIl6FE
vmeGtOsq964L5DHjmnDGLAVOQd1zyJnIJU6ERKHwJ7m5/XFzR79eX41wYZwLAAPwRktkvSUv
6qcEBkbarunLrm/CZm4zTpOu72Z1k+YVaeqE6U4fWOWgJwbQoj048HWdGrhyG37RuKqchXan
Pc8rn2d+3uyGruy2Pjjvj1TEhgUxso/aZ3Xu6XM4TV89/zPQwG1+bCs1spd677YibrGaucuM
1jnyibWgQR4zetuU6cun9X/6Mt0VtgeM80U4n3gfXrqBrg7lpcc8szE9zBdBBAwBOJjSqMIY
YX0B1uLhknbmINXOpCq9LXSMhVYKgpRWGSFAeAlRxVKIkAYjdav9ut+8G4ZCHCsLRzqJ70OB
pAjdhZkwOdgJZwpRnMjEdAv7uz7hiE+RlZE7yxEUk8i4dKxMoZW64CYyLMZ8UiVj2oE0Gj2K
ZFhkIaJLBjGOujSgI4uFEcOu4r5Pu3YObZIX2hTrGi6yCVguZfqpMNQn7+jplnbqA94KZb16
jU29pE1Yb26oQ/HwRjjOOjMYI0TxJ+Ju2zezV6+0rfumDB/LyO9lH8zJSAjw8hDwy0KQXj5B
LhScFQL+iSHg/2cIfgGW9LLidwoAAA==

--4Ckj6UjgE2iN1+kY--

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkswnz8ACgkQxcDFxyGNGNfD3wCfYozQELqDQniAJYqyS0q9eBr5
cV0AnRE9MwmYQ6dkFeEja8vdtJgJCRT3
=YBsD
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
