From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hash algorithm choice
Date: Sun, 9 Aug 2009 11:33:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908091116340.3288@localhost.localdomain>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com> <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com> <alpine.LFD.2.01.0908091038300.3288@localhost.localdomain> <7vljls986b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jerome Baum <jerome@jeromebaum.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaDD1-0004ZM-HP
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZHISdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZHISdX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:33:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57533 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374AbZHISdW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 14:33:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79IXIwk026082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Aug 2009 11:33:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79IXIZt023682;
	Sun, 9 Aug 2009 11:33:18 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljls986b.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125361>



On Sun, 9 Aug 2009, Junio C Hamano wrote:
> 
> Just in case Jerome really wants to go further, "almost no changes" and
> "minimal" refers to the fact that we have a few hard-coded hash values
> known to the code, such as the object name for an empty blob and an empty
> tree.

Once nice thing about git is also that in many ways git doesn't even 
_care_ about the actual hash algorithm, because read-only git will 
generally (always?) just use the hashes as pointers.

So you could actually create a very limited sort of git that doesn't have 
any hash algorithm at all - and it would still be able to do a lot of 
regular git operations.

Git strictly speaking needs to hash things only when

 - validating the index (ie if the index and stat data do not match). Git 
   also checks the SHA1 hash at teh end of the index file every time it 
   loads it.

 - creating new objects (ie commit)

 - git-fsck

 - probably some situation I didn't think about.

but during normal operations git doesn't strictly _need_ to hash anything.

For example, I literally just checked what happens when you break our hash 
algorithm on purpose, and while any index operation is unhappy and 
complains about index corruption:

	[torvalds@nehalem git]$ ./git diff
	error: bad index file sha1 signature
	fatal: index file corrupt

that's really largely a sanity check. You can literally do things like 
"git log -p" without ever generating a single hash at all - because all 
git will do is to look up objects based on the hashes it finds.

Now, what's nice about this is that it means that 

 (a) Hash performance only really matters for "git add" and "git fsck" 
     (well, as long as it's not _totally_ sucky. As mentioned above, we do 
     check the integrity of the index file more often, but that could be a 
     different hash than the _object_ hashes - so even if you change the 
     object hashes to be something else than SHA1, you wouldn't 
     necessarily have to change the index checksum)

 (b) You could actually afford to have git auto-detect the hashes from 
     existing objects

 (c) it's not even entirely unreasonable to mix different hashes in the 
     same repository (ie "old objects use old hash, new objects use new 
     hash".

     Aliasing (same object with different hashes) will hurt disk-space, 
     and will make some operations (like merges and 'git diff') much more 
     expensive when they hit a "hash boundary", but other than that you'd 
     never even notice.

Of course, the downside to the above is that git may not notice some kinds 
of corruption until you actually do things like "git fsck" (or native git 
transfers like "git pull", which always check the result very carefully). 

For disk corruption issues, there are things like zlib Adler checksums 
(and xdelta crc's) etc that we always check when unpacking objects, but 
the hash itself only gets recomputed for fairly special events.

			Linus
