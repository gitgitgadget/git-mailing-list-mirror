From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Mon, 27 Apr 2009 13:13:53 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904271304300.22156@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 22:24:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyXMn-0007lj-2O
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbZD0UV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757115AbZD0UV6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 16:21:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38232 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756419AbZD0UV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 16:21:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RKDsg0017979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 13:14:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RKDrU6006351;
	Mon, 27 Apr 2009 13:13:53 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117713>



On Mon, 27 Apr 2009, Junio C Hamano wrote:
> 
> The coda hack comment in move_temp_to_file() shows what we can do to
> autodetect (i.e. try cross directory hardlink)

The thing is, we cannot do it reliably across different systems.

Coda simply doesn't _support_ hardlinks across directories at all. So it 
will always return an error when you try, and you can see the error 
directly and easily.

> but I somehow thought that we changed the code enough to ensure that we 
> create the tmpfiles in the same directory as their final destination?

This was for a totally different case - a certain kind of NFS client bug 
with a certain kind of (arguably buggy, but I can understand it because 
NFS is just a bad protocol in this respect) NFS server, where you may be 
able to do cross-directory renames, but it caused problems later.

Now, the reason cross-directory name movement matters is that it makes 
many things much harder, and filesystems thus have a much harder time 
doing them well (or decide to not support them at all, as in Coda). Within 
a single directory, things are just simpler, and thus less likely to hit 
bugs.

IOW, with cross-directory link/rename, you didn't get an error, you got 
some unreliable behavior - very much like the thing we see with ufsd. But 
with those problems, we could fix it by just always making the link and 
the rename be within a single directory.

Now, it seems, even being in the same directory isn't sufficient for that 
ufsd thing (but rename works. Knock wood).

			Linus
