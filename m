From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: symbolic link management in git-archive
Date: Mon, 31 Mar 2008 22:44:58 +0200
Message-ID: <47F14D4A.2020403@lsrfire.ath.cx>
References: <loom.20080327T112740-539@post.gmane.org> <7v3aqcb02s.fsf@gitster.siamese.dyndns.org> <loom.20080327T175844-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgQt1-0000VA-L2
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 22:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbYCaUpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 16:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbYCaUpD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 16:45:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:49706 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbYCaUpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 16:45:00 -0400
Received: from [10.0.1.101] (p57B7CE24.dip.t-dialin.net [87.183.206.36])
	by india601.server4you.de (Postfix) with ESMTPSA id 53E5B2F8002;
	Mon, 31 Mar 2008 22:44:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <loom.20080327T175844-199@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78603>

Sergio Callegari schrieb:
> I have a project where I need to have the same content in multiple pl=
aces,
> otherwise development tools are not happy.
> Since I do most of the development on Linux, I use symbolic links. Th=
is is very
> good, not just because I save space, but particularly because I am su=
re that the
> content cannot loose coherency (which would be very bad) at the diffe=
rent
> places.
>=20
> Every now and then, to distribute snapshots of the project, I run git=
 archive to
> make a zip file, that I give to other people.  Unfortunately, some of=
 them use
> Windows, where the symbolic links appear as one-liner text files. And=
 obviously
> they cannot compile anything and they complain.
>=20
> So I would like git archive to be able to make zip archives with the =
symbolic
> links /resolved/.

Windows 2000 and up has support for symbolic links; it's just strangely
restricted, e.g. on Windows 2000 you can only link to directories and
you have to use tools that aren't shipped with the OS to create them.
Microsoft even calls them differently; here's a good starting point for
more information: http://en.wikipedia.org/wiki/NTFS_junction_point

Arguably, your unzip program should create junction points for symlinks
in zip files.  I wouldn't be surprised if none of the existing ones
support that, though; junction points have been left undocumented for a
long time.  It's also possible that they'd understand a different zip
dialect for symlinks than the Info-Zip one produced by git-archive.

Would it be practical for you to distribute a junction point creation
tool like Mark Russinovich's Junction (except that Junction's EULA
forbids redistribution under most circumstances; see here:
http://www.microsoft.com/technet/sysinternals/FileAndDisk/Junction.mspx=
)
and a script that creates these symlinks for your audience?


It's harder for git-archive to support following symlinks than for e.g.
GNU tar.  The reason is that the former operates on git objects, not
files, directories or symlinks.  In order to follow a symlink it would
need to evaluate the symlink, follow it and then add actual files and
directories to the archive.

=46or your purposes, perhaps a slightly different implementation might =
be
sufficient: namely to follow only relative symlinks that point to
tracked objects.  That way you still get a repeatable result and (most
importantly) git-archive doesn't need to look at files and directories,
it can stay safely in git land.  Would such a way of operation be usefu=
l
to you?

Thanks,
Ren=E9
