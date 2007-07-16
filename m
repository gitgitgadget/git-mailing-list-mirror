From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 15:36:02 +0200
Message-ID: <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQkZ-0002xG-Ij
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbXGPNgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbXGPNgG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:36:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60207 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932509AbXGPNgE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 09:36:04 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id D7CF93F426; Mon, 16 Jul 2007 15:36:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52676>

Hello,
might that be related to the problem:


        lstat64("profiles/icpc", 0xFFBFF350)            Err#2 ENOENT
=>       mkdir("profiles", 0777)                         = 0
        stat64(".git/objects/66/6197b02f46c92f0273f16ac77d34d76b28f4f0",
        0xFFBFF088) = 0
        open64(".git/objects/66/6197b02f46c92f0273f16ac77d34d76b28f4f0",
        O_RDONLY) = 4
        mmap64(0x00000000, 284, PROT_READ, MAP_PRIVATE, 4, 0) = 0xFF230000
        close(4)                                        = 0
        munmap(0xFF230000, 284)                         = 0
        open64("profiles/icpc", O_WRONLY|O_CREAT|O_EXCL, 0666) = 4
        open64("profiles/.gitattributes", O_RDONLY)     Err#2 ENOENT
        write(4, " #   I C P C   P r o f i".., 420)     = 420
        close(4)                                        = 0
        lstat64("profiles/sithglan", 0xFFBFF350)        Err#2 ENOENT
=>      mkdir("profiles", 0777)                         Err#17 EEXIST
=>      unlink("profiles")                              = 0
=>      mkdir("profiles", 0777)                         = 0

I think it is. Damn it. What seems to hapen here is that git does:

        - create a subdirectory
        - puts a file in
        - deletes a subdirectory (by call unlink - that would normally fail,
          but with solaris as root it does not fail)

                => here comes the dangling hard link counter

        - created the directory again
        - puts the file in

That is why I only see one file in each subdirectory (the one that got
checkedout last). So the fix for git should be straight forward. But I still
think that Solaris is obviously broken. Because if you ask me it should not be
possible to unlink a directory that has files in it?!

                Thomas
