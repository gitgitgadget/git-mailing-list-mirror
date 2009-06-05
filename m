From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 20:35:38 +0200
Message-ID: <20090605183538.GE764@atjola.homenet>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet> <20090605145508.GA6442@mit.edu> <20090605150212.GC764@atjola.homenet> <20090605180630.GC6442@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 05 20:36:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCeGs-0000a4-1u
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 20:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZFESfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbZFESfk
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 14:35:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:42469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbZFESfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 14:35:39 -0400
Received: (qmail invoked by alias); 05 Jun 2009 18:35:40 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp048) with SMTP; 05 Jun 2009 20:35:40 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19bbkkni/hbCiVP00yeSFtBRsMRwOkUL26fC6IKau
	tQjGRqc9o8mxI7
Content-Disposition: inline
In-Reply-To: <20090605180630.GC6442@mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120817>

On 2009.06.05 14:06:30 -0400, Theodore Tso wrote:
> On Fri, Jun 05, 2009 at 05:02:12PM +0200, Bj=F6rn Steinbrink wrote:
> > On 2009.06.05 10:55:08 -0400, Theodore Tso wrote:
> > > On Fri, Jun 05, 2009 at 03:21:26PM +0200, Bj=F6rn Steinbrink wrot=
e:
> > > > So the ctime got modified. I don't have any fancy indexing stuf=
f
> > > > running, and inotify doesn't see any events either while the ct=
ime is
> > > > changed.
> > > >=20
> > > > The only thing I changed lately was upgrading to 2.6.30-rc8 and=
 going
> > > > from ext3 to ext4. As the ctime change always seems to happen a=
round 30
> > > > seconds after the real change, I kind of suspect ext4 to be gui=
lty.
> > > > Ted, is that possible?
> > > >=20
> > > > FS is mounted as:
> > > > /dev/mapper/vg0-home on /home type ext4 (rw,noatime,nodiratime,=
barrier=3D0)
> > > >=20
> > >=20
> > > I agree it sounds like it's ext4 related, but I'm not able to
> > > reproduce it (using 2.6.30-rc8 with the patches planned for the 2=
=2E6.31
> > > merge window).  This should show the problem, you were seeing, do=
 you
> > > agree?
> >=20
> > Yeah, that should do I guess. See my other mail for a simpler, less
> > time consuming way to test. And as noted in there, it seems to happ=
en
> > only on ext3 filesystems mounted using ext4.
>=20
> > Filesystem features:      has_journal resize_inode dir_index filety=
pe
> >                           needs_recovery sparse_super large_file
>=20
> Yeah, so you haven't turned on any of the ext4 filesystem features, I
> assume because you wanted to be easily go back to ext3 if you ran int=
o
> problems?  OK, that's a good starting point.

Right.

> I'm guessing it's the presence or absence of one of the ext4-specific
> filesystem features, most probably the extents feature (which is why =
I
> had asked you to to send me your dumpe2fs -h output). =20
>=20
> So the next step is to create an ext3 filesystem with a git repositor=
y
> on it, and then to gradually turn on various ext4 specific features
> and see when the bug ends up getting replicated.  If I had to guess
> it's the lack (or absense) of the extents feature, but I'll have to
> run the test and find out for sure.

Yep, seems to be extents. Test script:

#!bin/bash

do_test ()
{
	mke2fs -j -m 1 /dev/loop0 -O $1 2>&1
	mount -t ext4 /dev/loop0 foo
	cd foo
	git init=20
	echo 123 > foo
	git add foo
	git commit -m test
	sleep 2
	sync
	git diff-index --exit-code HEAD && echo "Good: $1" >&2 ||
		echo "Bad: $1" >&2
	cd ..
	umount foo
}


for opt in extent dir_index uninit_bg extent,dir_index extent,uninit_bg=
\
	dir_index,uninit_bg extent,dir_index,uninit_bg
do
	do_test "$opt" > /dev/null
done

Results:
$ sudo bash e3t.sh=20
Good: extent
Bad: dir_index
Bad: uninit_bg
Good: extent,dir_index
Good: extent,uninit_bg
Bad: dir_index,uninit_bg
Good: extent,dir_index,uninit_bg

Bj=F6rn
