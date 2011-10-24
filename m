From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on GNU/kFreeBSD
Date: Mon, 24 Oct 2011 19:07:52 -0400
Message-ID: <rmibot6aszb.fsf@fnord.ir.bbn.com>
References: <20111003064120.GA24396@elie>
	<20111022111107.GA12130@elie.domain.sunraytvi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	"Christopher M. Fuhrman" <cfuhrman@panix.com>,
	Stefan Sperling <stsp@stsp.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 01:19:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RITnH-0001aG-TQ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 01:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab1JXXSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 19:18:54 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:49231 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab1JXXSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 19:18:53 -0400
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Oct 2011 19:18:53 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 9211E52C9; Mon, 24 Oct 2011 19:08:03 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:111024:gitster@pobox.com::lESpuhl4ls0SQf5d:0000000000000000000000000000000000000000000005Ml
X-Hashcash: 1:20:111024:jrnieder@gmail.com::RdjZR7KEU79xZcNE:00000000000000000000000000000000000000000000tuJ
X-Hashcash: 1:20:111024:raa.lkml@gmail.com::lESpuhl4ls0SQf5d:00000000000000000000000000000000000000000001Gjw
X-Hashcash: 1:20:111024:git@vger.kernel.org::RdjZR7KEU79xZcNE:0000000000000000000000000000000000000000001vjb
X-Hashcash: 1:20:111024:stsp@stsp.name::qH+DBesUi2xikq6y:000327p
X-Hashcash: 1:20:111024:cfuhrman@panix.com::lESpuhl4ls0SQf5d:000000000000000000000000000000000000000000027SD
In-Reply-To: <20111022111107.GA12130@elie.domain.sunraytvi.com> (Jonathan
	Nieder's message of "Sat, 22 Oct 2011 06:11:07 -0500")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184191>

--=-=-=
Content-Type: text/plain


   * On some BSD systems, adding +s bit on directories is detrimental
     (it is not necessary on BSD to begin with). The installation
     procedure has been updated to take this into account.

I looked at the NetBSD 5 sources, and as expected files are created
(unconditionally) with the gid of the parent directory.

Setting the setgid flag is only allowed if the inode's gid is in the
process gid set.   This is really about files that might be executed,
but the check is independent of regular file/directory.

"git init --shared" creates a repository, mode 2775, and that normally
seems fine.  It seems good to have the sgid bit on, in case the
repository is transferred to another machine with different semantics,
and it's a clue to humans about the intended behavior, even if it's
non-optional on BSD.

I created a directory, mode 755, owned by me, and with group that I *do
not* belong to.  Then, "git init --shared" produced:

  fatal: Could not make /home/gdt/FOO/.git/refs writable by group

but really the issue was setting the sgid bit:

# all with git version 1.7.6.3
13 $ l -d .git/refs/
drwxr-xr-x  2 gdt  kmem  512 Oct 24 18:53 .git/refs/
14 $ chmod g+w .git/refs/
15 $ l -d .git/refs/
drwxrwxr-x  2 gdt  kmem  512 Oct 24 18:53 .git/refs/
16 $ chmod g+s .git/refs/
chmod: .git/refs/: Operation not permitted

However, this is a pathological situation, because I've created a shared
repository that I can write to because I own it, and group kmem people
can write to because they're in the group, but I couldn't write to other
group kmem resources.

Is this not-allowed-to-set-setgid issue the problem the patch is trying
to avoid?  Or something else?

I did run the regression tests at one point and don't remember this
failing.

So all in all I am agnostic as to whether DIR_HAS_BSD_GROUP_SEMANTICS
should be defined on NetBSD; personally I prefer to see the setgid
bits.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk6l78gACgkQ+vesoDJhHiV0RgCgqgVPblup6ha7kZcRZFrJ+t7n
C1gAoJ0bVHthO8IpPo5nNWnKEioVIqKJ
=0wH0
-----END PGP SIGNATURE-----
--=-=-=--
