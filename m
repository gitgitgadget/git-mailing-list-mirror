From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: gc changes permissions of files
Date: Sun, 15 Jun 2008 02:27:36 -0400
Message-ID: <20080615062736.GC14357@lifeintegrity.com>
References: <20080615035917.GA13414@lifeintegrity.com> <alpine.DEB.1.00.0806150551010.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 15 08:28:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7lj8-0008Ew-My
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 08:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYFOG1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 02:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYFOG1j
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 02:27:39 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:53006 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYFOG1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 02:27:38 -0400
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id 6FF98D5C840;
	Sun, 15 Jun 2008 06:27:37 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id 9571430436E; Sun, 15 Jun 2008 02:27:36 -0400 (EDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806150551010.6439@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85066>

On 2008-06-15T06:38:21+0100, Johannes Schindelin wrote:
> On Sat, 14 Jun 2008, Allan Wind wrote:
> 
> > Is anyone looking into fixing gc so it does not change permission on 
> > files?  I would think it should consider current permissions of files 
> > before umask.
> > 
> > I believe Nigel reported this issue with:
> > http://thread.gmane.org/gmane.comp.version-control.git/79213/focus=79237
> > and still seeing issues with 1.5.5.4.
> 
> It would have been nice to briefly illustrate the problem again.

Of course.

# umask
umask 0022
# find . -ls > /tmp/before
# git gc
Counting objects: 1435, done.
Compressing objects: 100% (747/747), done.
Writing objects: 100% (1435/1435), done.
Total 1435 (delta 690), reused 1422 (delta 682)
# find . -ls > /tmp/after

On these files group write is revoked when running gc (g-w).  /tmp/before:

 16420 662752 -rw-rw----   1 root     users    677990209 Jun 15 01:49 ./objects/pack/pack-f962a3321392570
5b321ad2ba6ccb0037114f92d.pack
 16432   36 -rw-rw----   1 root     users       35504 Jun 15 01:49 ./objects/pack/pack-f962a33213925705b3
21ad2ba6ccb0037114f92d.idx
...
 18258    4 drwxrwx---   2 allan    users        4096 Jun 15 01:47 ./logs/refs/heads
 16481    8 -rw-rw----   1 root     users        6100 Jun 15 01:47 ./logs/refs/heads/master

and /tmp/after:

 16401 662752 -r--r--r--   1 root     root     677990209 Jun 15 01:59 ./objects/pack/pack-f962a3321392570
5b321ad2ba6ccb0037114f92d.pack
 16404   36 -r--r--r--   1 root     root        35504 Jun 15 01:59 ./objects/pack/pack-f962a33213925705b3
21ad2ba6ccb0037114f92d.idx
...
 16402    8 -rw-r--r--   1 root     root         6100 Jun 15 01:57 ./logs/refs/heads/master
 16403    8 -rw-r--r--   1 root     root         6100 Jun 15 01:57 ./logs/HEAD

and these on these other read permissions (o+r) is added.  /tmp/before:

 16394    4 -rw-rw----   1 root     users          54 Jun 15 01:49 ./objects/info/packs
 16481    8 -rw-rw----   1 root     users        6100 Jun 15 01:47 ./logs/refs/heads/master
 16475    8 -rw-rw----   1 root     users        6100 Jun 15 01:47 ./logs/HEAD
 16485   16 -rw-rw----   1 root     users       14773 Jun 15 01:47 ./packed-refs

and /tmp/after:

 16393    4 -rw-rw-r--   1 root     root           54 Jun 15 01:59 ./objects/info/packs
 16402    8 -rw-r--r--   1 root     root         6100 Jun 15 01:57 ./logs/refs/heads/master
 16403    8 -rw-r--r--   1 root     root         6100 Jun 15 01:57 ./logs/HEAD
 16386   16 -rw-rw-r--   1 root     root        14773 Jun 15 01:57 ./packed-refs

I seem to recall that push to the repository also introduces files without
group write permission.  Unfortunately it looks something broke when I ran
gc.  Any help in getting my repository back up would be appreciated:

allan@vent:~/var/git/www2$ git clone ssh://pawan.localnet./var/lib/git/www.git
Initialized empty Git repository in /home/allan/var/git/www2/www/.git/
fatal: git-upload-pack: cannot find object 56032c4f35fd39fe4151fca2d010d299a8901101:
fatal: The remote end hung up unexpectedly
fetch-pack from 'ssh://pawan.localnet./var/lib/git/www.git' failed.


/Allan
