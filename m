From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Git performance results on a large repository
Date: Sat, 04 Feb 2012 16:42:11 -0500
Message-ID: <rmivcnm2s3w.fsf@fnord.ir.bbn.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtnWQ-0000bD-Sy
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab2BDVvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 16:51:46 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:64127 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab2BDVvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 16:51:45 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Feb 2012 16:51:45 EST
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id D246352F8; Sat,  4 Feb 2012 16:42:18 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:120204:git@vger.kernel.org::GKZK/cskngIb3jxz:0000000000000000000000000000000000000000001BTV
X-Hashcash: 1:20:120204:joshua.redstone@fb.com::VyG8WzyjmHmeVD3e:0000000000000000000000000000000000000001p0N
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com> (Joshua Redstone's
	message of "Fri, 3 Feb 2012 14:20:06 +0000")
User-Agent: Gnus/5.130002 (Ma Gnus v0.2) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189914>

--=-=-=
Content-Type: text/plain


Joshua Redstone <joshua.redstone@fb.com> writes:

> The test repo has 4 million commits, linear history and about 1.3 million
> files.  The size of the .git directory is about 15GB, and has been
> repacked with 'git repack -a -d -f --max-pack-size=10g --depth=100
> --window=250'.  This repack took about 2 days on a beefy machine (I.e.,
> lots of ram and flash).  The size of the index file is 191 MB. I can share
> the script that generated it if people are interested - It basically picks
> 2-5 files, modifies a line or two and adds a few lines at the end
> consisting of random dictionary words, occasionally creates a new file,
> commits all the modifications and repeats.

I have a repository with about 500K files, 3.3G checkout, 1.5G .git, and
about 10K commits.  (This is a real repository, not a test case.)  So
not as many commits by a lot, but the size seems not so far off.

> I timed a few common operations with both a warm OS file cache and a cold
> cache.  i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' and then did
> the operation in question a few times (first timing is the cold timing,
> the next few are the warm timings).  The following results are on a server
> with average hard drive (I.e., not flash)  and > 10GB of ram.
>
> 'git status' :   39 minutes cold, and 24 seconds warm.

Both of these numbers surprise me.  I'm using NetBSD, whose stat
implementation isn't as optimized as Linux (you didn't say, but
assuming).   On a years-old desktop, git status seems to be about a
minute semi-cold and 5s warm (once I set the vnode cache big over 500K,
vs 350K default for a 2G ram machine).

So on the warm status, I wonder how big your vnode cache is, and if
you've exceeded it, and I don't follow the cold time at all.  Probably
some sort of profiling within git status would be illuminating.

> 'git blame':   44 minutes cold, 11 minutes warm.
>
> 'git add' (appending a few chars to the end of a file and adding it):   7
> seconds cold and 5 seconds warm.
>
> 'git commit -m "foo bar3" --no-verify --untracked-files=no --quiet
> --no-status':  41 minutes cold, 20 seconds warm.  I also hacked a version
> of git to remove the three or four places where 'git commit' stats every
> file in the repo, and this dropped the times to 30 minutes cold and 8
> seconds warm.

So without the stat, I wonder what it's doing that takes 30 minutes.

> One way to get there is to do some deep code modifications to git
> internals, to, for example, create some abstractions and interfaces that
> allow plugging in the specialized servers.  Another way is to leave git
> internals as they are and develop a layer of wrapper scripts around all
> the git commands that do the necessary interfacing.  The wrapper scripts
> seem perhaps easier in the short-term, but may lead to increasing
> divergence from how git behaves natively and also a layer of complexity.

Having hooks for a blame server cache, etc. sounds sensible.  Having a
way to call blames sort of like with --since and then keep updating it
(eg. in emacs) to earlier times sounds useful.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk8tpjMACgkQ+vesoDJhHiVtNQCeP1A3/Yy84s931pgXwVVcGYrC
4GgAoJWgWXKar3cUeddCdIKAerOKVpYk
=1rnz
-----END PGP SIGNATURE-----
--=-=-=--
