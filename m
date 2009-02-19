From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Really slow 'git gc'
Date: Thu, 19 Feb 2009 13:25:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902191318310.21686@localhost.localdomain>
References: <alpine.LFD.2.00.0902191200010.21686@localhost.localdomain> <7vr61uku2f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 22:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGQk-0001zz-My
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZBSV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756108AbZBSV0K
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:26:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41576 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756067AbZBSV0J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 16:26:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1JLPVSf017014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Feb 2009 13:25:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1JLPU3h024010;
	Thu, 19 Feb 2009 13:25:30 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vr61uku2f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.456 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110754>



On Thu, 19 Feb 2009, Junio C Hamano wrote:
> 
> I think we can add a single bit to "struct packed_git" and in the middle
> of setup_revisions() perform the O(N**2) once, so that find_pack_entry()
> can check the bit without looping.

Yes. However, most users call find_pack_entry() with a NULL ignore_packed, 
so we'd still have to pass in that flag to say whether we should look at 
the bit or not.

However, the real issue (?) I think is that the whole "ignore_packed" 
logic is crazy. It's the wrong way around. The whole thing is broken.

Rather than marking which ones are "unpacked" and should be ignored, it 
should just look at the ones to keep. That's how the filesystem layout 
works and that's what "git repack" does anyway.

So I think we should just remove the whole "--unpacked=" thing, and 
instead replace it with a "--keep" flag - and then only finding things in 
the keep packs if we have a list of them.

That would (a) make the logic a whole lot easier to follow and (b) get rid 
of the scalability issue, since you're not really supposed to have more 
than one or two .keep files anyway (if that).

Nobody uses "--unpacked=xyzzy" by hand anyway. The only thing that 
generates those things is git-repack.sh, so this is not a compatibility 
issue, I suspect.

			Linus
