From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: A system administration use case for git
Date: Thu, 23 Apr 2009 11:55:33 +0200
Message-ID: <20090423095533.GE13989@pengutronix.de>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 11:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvgJ-0007IS-Uz
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbZDWJzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZDWJzi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:55:38 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34622 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZDWJzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:55:37 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwveZ-0008AO-Gl; Thu, 23 Apr 2009 11:55:35 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwveX-0006bj-Mn; Thu, 23 Apr 2009 11:55:33 +0200
Content-Disposition: inline
In-Reply-To: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117325>

Hello Jon,

On Wed, Apr 22, 2009 at 06:33:12PM +1000, Jon Seymour wrote:
> * calculate the git hashes of the tree (without making copies of the
> files in the tree)
You can hand-craft a tree object:

	for f in $filelist; do
		printf "100644 %s\x00" $f;

		git hash-object $f |
			perl -n -e 'chomp; for $c (split(/(.{2})/)) { printf("%c", hex($c)) =
if $c }';
	done |
		git hash-object -t tree --stdin


You get some extra points for directories that include subdirs :-)

There is a problem though, I think it has to do with the order of the
files in the tree object.  Here is a real-life example from the Linux
kernel (I choosed the usr subdirectory, because it's small and doesn't
contain subdirs):

	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ for f in .gitignore Kconfig Mak=
efile gen_init_cpio.c initramfs_data.S initramfs_data.bz2.S initramfs_d=
ata.gz.S initramfs_data.lzma.S; do printf "100644 %s\x00" $f; git hash-=
object $f | perl -n -e 'chomp; for $c (split(/(.{2})/)) { printf("%c", =
hex($c)) if $c }'; done | git hash-object -t tree --stdin
	64f2ca854bc19fd29479b198be11beba56a26b1e

	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ git rev-parse HEAD:usr
	64f2ca854bc19fd29479b198be11beba56a26b1e

There is a practical problem though:  The filelist has to be sorted in =
a
way that is not provided by ls, so:

	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ for f in $(ls -A); do printf "1=
00644 %s\x00" $f; git hash-object $f | perl -n -e 'chomp; for $c (split=
(/(.{2})/)) { printf("%c", hex($c)) if $c }'; done | git hash-object -t=
 tree -w --stdin
	a0a6efb3f1de956badc7607c7d372cc325a18846

	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ git ls-tree a0a6efb3f1de956badc=
7607c7d372cc325a18846 | wc -l
	0

doesn't work :-/

This would make a nice plumbing:

	git hash-tree $directory

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
