From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 11:56:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M28ni-00054S-LU
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762648AbZEGS62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762692AbZEGS60
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:58:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48545 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757285AbZEGS6Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 14:58:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47Iu588012893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 11:56:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47Iu5DN007337;
	Thu, 7 May 2009 11:56:05 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118505>



On Thu, 7 May 2009, Bevan Watkiss wrote:
> 
> Basically I have a copy of my tree where only git can write to it, so I know
> the files are right.  The NAS box I have the tree on is slow, so reading the
> tree adds about 10 minutes to the process when I only want to update a few
> files.

Ouch.

You could try doing

	[core]
		preloadindex = true

and see if that helps some of your loads. It does limit even the parallel 
tree stat to 20 or so, but if most of your cost is in just doing the 
lstat() over the files to see that they haven't changed, you might be 
getting a factor-of-20 speedup for at least _some_ of what you do.

If you can, it might also be interesting to see system call trace patterns 
(with times!) to see if there is something obviously horribly bad going 
on. If you're running under Linux, and don't think the data contains 
anything very private, send me the output of "strace -f -T" of the most 
problematic operations, and maybe I can see if I can come up with anything 
interesting.

I have long refused to use networked filesystems because I used to find 
them -so- painful when working with CVS, so none of my performance work 
has ever really directly concentrated on long-latency filesystems. Even 
the index preload was all done "blind" with other people reporting issues 
(and happily I could see some of the effects with local filesystems and 
multiple CPU's ;).

			Linus
	
