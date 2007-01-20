From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Don't call fstat() on stdin in index-pack.
Date: Sat, 20 Jan 2007 18:35:19 +0300
Message-ID: <20070120183519.3a182064.vsu@altlinux.ru>
References: <20070118212615.GO8624@jukie.net>
	<20070119024436.GQ8624@jukie.net>
	<45B034D2.6010007@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__20_Jan_2007_18_35_19_+0300_sR+Fsda=WE+FiXkh"
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 16:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8IGF-00011a-28
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 16:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbXATPgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 10:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbXATPgE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 10:36:04 -0500
Received: from master.altlinux.org ([62.118.250.235]:4382 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965291AbXATPgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 10:36:03 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 00CE9E31F9; Sat, 20 Jan 2007 18:36:00 +0300 (MSK)
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <45B034D2.6010007@fs.ei.tum.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37275>

--Signature=_Sat__20_Jan_2007_18_35_19_+0300_sR+Fsda=WE+FiXkh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2007 04:02:42 +0100 Simon 'corecode' Schubert wrote:

> Bart Trojanowski wrote:
> >  	/* If input_fd is a file, we should have reached its end now. */
> > -	if (fstat(input_fd, &st))
> > -		die("cannot fstat packfile: %s", strerror(errno));
> > -	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> > -		die("pack has junk at the end");
> > +        if (input_fd) {
> > +                if (fstat(input_fd, &st))
> > +                        die("cannot fstat packfile: %s", strerror(errno));
> > +                if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> > +                        die("pack has junk at the end");
> > +        }
>
> This is clearly the wrong fix.  input_fd being 0 doesn't mean that
> it is *not* a regular file.  Only doing a fstat can tell.  You are
> simply hiding your real issue there, which is that you can't fstat
> on a pipe or whatever input_fd is.
>
> The problem here is that your 64bit kernel can't fit the data into
> your struct stat provided by your 32bit libc.  Not a problem of git.
> However, it would be interesting to know what exactly produces the
> EOVERFLOW.

Most likely it is the st_ino field - the kernel assigns unique inode
numbers for pipes from an "unsigned long" counter, which is 64-bit in
this case, and *stat() calls must fail with EOVERFLOW if the inode
number does not fit into ino_t, which is 32-bit here.  This problem is
known for some time, and there is even a kernel patch proposed as a
workaround (which makes the counter 32-bit):

http://permalink.gmane.org/gmane.linux.file-systems/12526

AFAIK, that patch is not upstream yet - so upgrading the kernel did
not really fix the issue, it will appear again once the system will
use more than 4G of pipe inodes.

Compiling git with -D_FILE_OFFSET_BITS=64 will make ino_t 64-bit and
therefore will fix the problem (however, I'm not sure whether the git
code is ready for this).

--Signature=_Sat__20_Jan_2007_18_35_19_+0300_sR+Fsda=WE+FiXkh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFsja6W82GfkQfsqIRAlBJAJ97n/aimshcIdgqpl2bqrTYu4kTVQCeMvOo
Vx7TB6lEga4wsmlDj3HTP9A=
=kiIC
-----END PGP SIGNATURE-----

--Signature=_Sat__20_Jan_2007_18_35_19_+0300_sR+Fsda=WE+FiXkh--
