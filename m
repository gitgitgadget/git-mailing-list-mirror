From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 07:41:39 +0100
Organization: glandium.org
Message-ID: <20080123064139.GC16297@glandium.org>
References: <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHZIq-00072x-GG
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 07:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbYAWGk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 01:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbYAWGk5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 01:40:57 -0500
Received: from vuizook.err.no ([85.19.215.103]:42367 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYAWGk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 01:40:56 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JHZIM-00016E-1c; Wed, 23 Jan 2008 07:41:16 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JHZIp-00054D-TM; Wed, 23 Jan 2008 07:41:39 +0100
Content-Disposition: inline
In-Reply-To: <20080123013325.GB1320@mit.edu>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71513>

On Tue, Jan 22, 2008 at 08:33:25PM -0500, Theodore Tso wrote:
> On Tue, Jan 22, 2008 at 04:38:37PM -0800, Linus Torvalds wrote:
> > One thing I'd like somebody to check: what _does_ happen with OS X and NFS 
> > (OS X as a client, not server)? In particular:
> > 
> >  - Is it suddenly sane and case-sensitive?
> 
> Using a Linux server, and a OS X client, over NFS, it is in
> case-sensitive.  This is not unexpected, since you can mount UFS
> partitions on Mac OS X, or reformat HFS+ filesystems and make them be
> case-sensitive.
> 
> >  - Does the NFS client do any unicode conversion?
> 
> Nope:
> 
> # perl -CO -e 'print pack("U",0x00C4)."\n"'  | xargs touch
> # ls -l | cat -v
> total 0
> 0 -rw-r--r--   1 nobody  nobody  0 Jan 22 20:30 M-CM-^D
> 
> It's pretty clear the Unicode conversion is being done in HFS+, not in
> the VFS layer of Mac OS X.

There must be something at the VFS layer, or some other layer:
- IIRC, Joliet iso9660 volumes end up being mounted with files names in
  NFS when the real file names are NFC on the disk.
- Likewise for Samba shares.
- When I had my problems with iso9660 rockridge volumes using NFC (you
  can create that just fine with mkisofs), the volume is mounted without
  normalisation, i.e. if you get to a shell and want to access files,
  you must use NFC, but at least the Finder does transliteration at some
  stage, because going into the mount point and opening some files fail
  because it's trying to open the file with the name transliterated to
  NFD. I just hope the same doesn't happen with other filesystems.

Also, OSX using NFD widely, a file created from non Unix applications
may end up being named in NFD on any file system. File contents, too,
may end up being transliterated whenever a file is modified with non
Unix applications, introducing unwanted changes.
Typing file names in the Terminal might also make them encoded in NFD,
too.

Mike
