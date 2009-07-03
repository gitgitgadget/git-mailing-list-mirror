From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 3 Jul 2009 09:08:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907030858540.3210@localhost.localdomain>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net> <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain> <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com> <4A4DA1D6.40301@viscovery.net> <20090703085608.GA18757@dpotapov.dyndns.org>
 <4A4DCCDD.9030901@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 03 18:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMlJM-0002uq-63
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 18:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbZGCQIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbZGCQIO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 12:08:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60430 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756056AbZGCQIM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2009 12:08:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n63G8Afe019106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2009 09:08:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n63G88qQ012313;
	Fri, 3 Jul 2009 09:08:09 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A4DCCDD.9030901@viscovery.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122703>



On Fri, 3 Jul 2009, Johannes Sixt wrote:
> 
> Do we ever call fsync on a pipe? In this case, fsync should fail with
> EINVAL, but your implementation would wait until the reader has drained
> all data.

I'm pretty sure we never call fsync() on anything but a file. So I suspect 
the patch for windows is fine - it only needs to care about regular files.

That said, there's a reason we don't enable fsync by default - it's 
generally not needed. I'm not sure what the NTFS crash semantics are, but 
I _think_ NTFS does everything with a proper log, and then fsync probably 
doesn't matter on windows.

The "fsync on CIFS" was not about "windows is crap, and because it's a 
windows filesystem we need to fsync" - it was literally because there was 
a bug in the Linux CIFS implementation that meant that pending writes 
could be lost if the file was made read-only while they were still 
pending.

And on non-journaling filesystems, fsync is obviously a good idea, but 
even then the state is often recoverable even in the face of a crash. Now, 
without fsync, you might have to work at it a bit and know what to do - 
like _manually_ resetting to the previous state and re-doing the last 
corrupt commit, throwing out any corrupt objects etc.

So enabling fsync can make things _much_ easier for recovery (to the point 
of making it possible at all for somebody who doesn't know the git object 
model), but is generally not a hard requirement.

Giving windows git the capability to do it sounds like a good idea, 
though.

Keep in mind: enabling fsync _will_ make object creation slower. Most 
people probably won't care much, though. It really only matters under some 
fairly rare circumstances - I care, beause it matters for things like 
"apply 200 patches in one go as fast as you can", but for most 'normal' 
workflows you'd probably never even notice.

			Linus
