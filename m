From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sat, 25 Apr 2009 10:56:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:00:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxmAX-000443-L1
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZDYR6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbZDYR6c
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 13:58:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55307 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753177AbZDYR6b (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 13:58:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3PHu2hb007978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Apr 2009 10:56:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3PHu1CJ015913;
	Sat, 25 Apr 2009 10:56:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.456 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117566>



On Thu, 23 Apr 2009, Johannes Schindelin wrote:
> 
> It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> has an unnerving bug: if you link() a file and unlink() it right away,
> the target of the link() will have the correct size, but consist of NULs.

So I assume that the way ufsd works is that it implements a user-level 
NTFS driver and then exposes it as a NFS mount over local networking (and
perhaps also remotely?)

> It seems as if the calls are simply not serialized correctly, as single-stepping
> through the function move_temp_to_file() works flawlessly.

So presumably there is some cached writes somewhere (a NFS client _should_ 
not cache writes past a 'close()', but maybe there is a bug there and/or 
buffering inside ufsd itself that means that the writes are still queued 
up). And when the unlink() happens, it loses the writes to the original 
file, and thus to the new one too.

If you _don't_ do this patch, does 

	[core]
		fsyncobjectfiles = true

hide the bug? 

I don't disagree with your patch (apart from the error number games), but 
I'd like to understand what's going on. I also wonder if we should make 
that fsync thign be the default.

[ That said, I think the http walker and possibly others may be using 
  'move_temp_to_file()' without going through any of the paths that know 
  about fsync, so 'fsyncobjectfiles' wouldn't fix all cases anyway. ]

Hmm. I hate how we have problems with that "link/unlink" sequence, and 
"rename()" would be much better, but I'd hate overwriting existing objects 
even _more_, and the normal POSIX rename() behavior is to overwrite any 
old object. So link/unlink is supposed to be a lot safer, but it's clearly 
problematic.

		Linus
