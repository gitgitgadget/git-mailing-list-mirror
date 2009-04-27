From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Mon, 27 Apr 2009 08:15:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySbC-00010P-0A
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbZD0PRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbZD0PRp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:17:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42549 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755933AbZD0PRp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 11:17:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RFFBpe023107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 08:15:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RFFAkd011393;
	Mon, 27 Apr 2009 08:15:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117677>



On Mon, 27 Apr 2009, Johannes Schindelin wrote:
> 
> So, force the use of rename() instead of the link() && unlink()
> incantation on Windows, and for good measure, add a
> core.unreliableHardlinks option to optionally force it on other
> platforms, too.

Ok, so:

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

but I do think it could be improved. See below..

> 	Junio, do you want me to remove the config variable?

I'd keep it. But I'd suggest that the naming is odd. Why talk about 
"unreliable hardlinks", when that's just a particular symptom. Why not 
just talk about whether hardlinks should be used or not?

And to avoid double negative, make it

	[core]
		usehardlinks = true/false

and then default it to 'true' for Unix.

The thing is, maybe people would prefer to use 'rename' over the 
link/unlink games even on some unixes, and not because of 'reliability' 
issues, but because they may have some filesystems that don't do 
hardlinks, and they'd just rather speed things up by avoiding the 'link()' 
system call that will just error out.

So naming matters. Calling it 'unreliablehardlinks' in that case would be 
odd. They're not unreliable - you just don't want to try to use them.

I also do wonder if we could/should make this one of those options that 
get set automatically at 'git init' time, rather than silently hardcoded 
as a compile option. I thought hardlinks at least sometimes worked fine on 
Windows too, don't they? 

I do detest _hidden_ default values for config options, unless those 
hidden defaults are "obviously always correct" as a default. This one 
smells a bit uncertain, and as a result I think it's ok to default to not 
using hardlinks, but doing it with .gitconfig would be nicer.

Hmm?

		Linus
