From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 18:40:42 +0200
Message-ID: <20070716164042.GB4484@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de> <86644kaaf1.fsf@lola.quinscape.zz> <20070716123913.GJ24036@cip.informatik.uni-erlangen.de> <86myxw8pzg.fsf@lola.quinscape.zz> <20070716131537.GA26675@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATct-0000BZ-Iq
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518AbXGPQkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759965AbXGPQko
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:40:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42249 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026AbXGPQko (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 12:40:44 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 060233F42F; Mon, 16 Jul 2007 18:40:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716131537.GA26675@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52687>

Hello,


> exactly. The question is: Is it a Solaris bug or is it something that is
> supposed a user is able to do (it doesn't make sense for me)? I posted
> this problem to comp.unix.solaris and also contacted the UFS Maintainer
> of Solaris (it is not the first UFS bug I original found). If I don't
> receive feedback, I am going to open a call with Sun. Whatever is going
> on (hopefully it isn't PEBKAC - but I don't think so) and this time it
> isn't broken hardware either (like the last time I reported a serious
> git bug) because it happens on two machines.

below I quote the answer of the UFS maintainer:

Thomas,

some notes on the unlink(directory) part:

In the case of calling unlink(2) on a directory as a privilidged user, things
like ".." (and the link count in the parent) would not be cleaned up.

The man page for unlink(1M) and unlink(2) is very clear about using rmdir(1/2) to
remove a directory.  It's also very clear that this does exactly what
it's supposed to do: Remove a link to a file/directory.  Cleaning up
the ".." entry (which would clean up the link to the parent) could
be considered "extra".

First the standards issues:
    The link(BA_OS) and unlink(BA_OS) descriptions in SVID3 both specify that
    a process with appropriate privileges is allowed to operate on a directory.
    We have claimed to conform to SVID3 since Solaris 2.0 and have not announced
    that we ever plan to EOL SVID3 conformance.

    UFS does support link(2)/unlink(2) with appropriate privilidges of
    directories while ZFS does not.

    The change that would provide ``Cleaning up the ".." entry ...'' would
    violate both SVID3 and POSIX and SUS requirements.  (The unlink(path)
    system call is supposed to remove the directory entry named by path; not
    the directory entry named by path and an arbitrary number of other
    directory entries.)

Second some history:
    Back before there were mkdir() and rmdir() system calls, applications
    wanting to create a directory invoked the setuid root mkdir utility
    which performed a series of mknod() and link() operations to create the
    directory and create dot and dot-dot entries in the new directory.
    Similarly, applications wanting to remove a directory invoked the
    setuid root rmdir uility which performed a series of unlink()
    operations to destroy the directory if it was empty.

    Not quite so far back in ancient history, there is also the point
    that before symlinks were available it was common practice to make
    hard links to directories.  Privileged applications can still do this
    today (as mandated by SVID) using the link() and unlink() system calls
    and the link and unlink commands.

UFS and ZFS are actually both correct, the standards wording permits either way kind of:

<snip>
If path1 names a directory, link() shall fail unless the process has
appropriate privileges and the implementation supports using link() on directories.

The path argument shall not name a directory unless the process has
appropriate privileges and the implementation supports using unlink() on directories.
<snip end>

This seems to implicitely allow an escape route; we can declare that no process
has sufficient privileges to link(2)/unlink(2) directories or like ZFS did,
have the underlaying implementation not supporting it at all.

The proper way is for the application to use the rmdir(2) system call,
it's there since ages!

my bottom line: GIT should not call unlink on a directory.

        Thomas
