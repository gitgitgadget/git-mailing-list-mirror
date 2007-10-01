From: Johan Herland <johan@herland.net>
Subject: Re: git clone questions relating to cpio
Date: Mon, 01 Oct 2007 23:42:36 +0200
Message-ID: <200710012342.37352.johan@herland.net>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Reece Dunn <msclrhd@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 23:44:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcT2f-00088f-0y
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 23:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbXJAVm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 17:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbXJAVm5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 17:42:57 -0400
Received: from smtp.getmail.no ([84.208.20.33]:51833 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbXJAVm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 17:42:56 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JP90065L5NHYT00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Oct 2007 23:42:53 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JP900DXF5N2RM30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Oct 2007 23:42:38 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JP900CCR5N1GOA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Oct 2007 23:42:38 +0200 (CEST)
In-reply-to: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59635>

On Monday 01 October 2007, Reece Dunn wrote:
> Hi,
> 
> I am running a Linux From Scratch 6.2 system that does not have cpio
> installed on it. This means that I can't clone a local repository
> unless I install cpio. Is it possible to use a fallback method if cpio
> is not present, as there is no NO_CPIO option on make like there is
> for OpenSSH, cURL and expat?

Using "file://" when specifying the source repo will force git-clone to use 
the git protocol, instead of doing a copy/hardlink.

I.e. change "git clone foo bar" to "git clone file://foo bar" in order to 
prevent git-clone from calling cpio.

However, grepping for cpio in the git source tree reveals a couple of uses 
in git-merge, so you might bump into problems there...

> Also, I have an external USB hardrive that is mounted onto the virtual
> filesystem. Will clones from the USB harddrive (or a USB flash drive
> that is mounted) result in a copy being performed, not a hardlink?

Hardlinks are impossible across filesystems. If you're cloning to a 
different filesystem git will _have_ to make a full copy.

> Ideally, the hard linking for local clones should be optional.

<quote src="git-clone(1)">
--local, -l

  When the repository to clone from is on a local machine, this flag 
bypasses normal "git aware" transport mechanism and clones the repository 
by making a copy of HEAD and everything under objects and refs directories. 
The files under .git/objects/ directory are hardlinked to save space when 
possible. This is now the default when the source repository is specified 
with /path/to/repo syntax, so it essentially is a no-op option. To force 
copying instead of hardlinking (which may be desirable if you are trying to 
make a back-up of your repository), but still avoid the usual "git aware" 
transport mechanism, --no-hardlinks can be used.

--no-hardlinks

  Optimize the cloning process from a repository on a local filesystem by 
copying files under .git/objects directory.
</quote>

And as I said above, you can use "file://" to force the "git aware" 
transport mechanism, which bypasses the whole local copy/hardlink issue 
entirely.

> What if I want to move a repository because, for example, I have imported
> a CVS repository and now want to push it to a new bare repository?

Even if you were to use hardlinks, cloning a repo followed by deleting the 
original will be safe (as long as you don't supply '--shared' to 
git-clone). That's the beauty of hardlinks.

I also think it's fairly safe to just 'mv' the whole repository to its new 
location.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
