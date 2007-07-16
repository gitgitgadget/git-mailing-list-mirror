From: David Kastrup <dak@gnu.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 18:29:07 +0200
Message-ID: <86d4ys71nw.fsf@lola.quinscape.zz>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 18:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATRu-0004yh-4I
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761059AbXGPQ3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760868AbXGPQ3W
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:29:22 -0400
Received: from main.gmane.org ([80.91.229.2]:33550 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759997AbXGPQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:29:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IATRj-0002Gj-FE
	for git@vger.kernel.org; Mon, 16 Jul 2007 18:29:15 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 18:29:15 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 18:29:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:tnAQdCOmLhA82lhm2j8XL6WcCHg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52684>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello,
> might that be related to the problem:
>
>
>         lstat64("profiles/icpc", 0xFFBFF350)            Err#2 ENOENT
> =>       mkdir("profiles", 0777)                         = 0
>         stat64(".git/objects/66/6197b02f46c92f0273f16ac77d34d76b28f4f0",
>         0xFFBFF088) = 0
>         open64(".git/objects/66/6197b02f46c92f0273f16ac77d34d76b28f4f0",
>         O_RDONLY) = 4
>         mmap64(0x00000000, 284, PROT_READ, MAP_PRIVATE, 4, 0) = 0xFF230000
>         close(4)                                        = 0
>         munmap(0xFF230000, 284)                         = 0
>         open64("profiles/icpc", O_WRONLY|O_CREAT|O_EXCL, 0666) = 4
>         open64("profiles/.gitattributes", O_RDONLY)     Err#2 ENOENT
>         write(4, " #   I C P C   P r o f i".., 420)     = 420
>         close(4)                                        = 0
>         lstat64("profiles/sithglan", 0xFFBFF350)        Err#2 ENOENT
> =>      mkdir("profiles", 0777)                         Err#17 EEXIST
> =>      unlink("profiles")                              = 0
> =>      mkdir("profiles", 0777)                         = 0
>
> I think it is. Damn it. What seems to hapen here is that git does:
>
>         - create a subdirectory
>         - puts a file in
>         - deletes a subdirectory (by call unlink - that would normally fail,
>           but with solaris as root it does not fail)
>
>                 => here comes the dangling hard link counter
>
>         - created the directory again
>         - puts the file in
>
> That is why I only see one file in each subdirectory (the one that got
> checkedout last). So the fix for git should be straight forward. But I still
> think that Solaris is obviously broken. Because if you ask me it should not be
> possible to unlink a directory that has files in it?!

<URL:http://www.opengroup.org/onlinepubs/000095399/functions/unlink.html>

    The path argument shall not name a directory unless the process has
    appropriate privileges and the implementation supports using unlink()
    on directories.

So Solaris has the right to do this.

    APPLICATION USAGE

        Applications should use rmdir() to remove a directory.

    RATIONALE

        Unlinking a directory is restricted to the superuser in many
        historical implementations for reasons given in link() (see
        also rename()).


In short: git should not call remove, ever.  It may succeed, and is a
badly low-level call.  If something is known to be a directory, then
it needs to be removed using rmdir, and if it is a nondirectory, with
unlink.

Hm, browsing through Posix indicates that unlink is probably the same
as remove.  Pity.  I thought that just "remove" was the potential
evildoer.

-- 
David Kastrup
