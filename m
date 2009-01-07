From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Tue, 6 Jan 2009 20:54:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home> <1231292360.8870.61.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 05:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKQSk-00013P-Fx
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 05:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbZAGEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 23:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757577AbZAGEyw
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 23:54:52 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41824 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757550AbZAGEyv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 23:54:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n074s8nk031410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 20:54:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n074s6Wm014046;
	Tue, 6 Jan 2009 20:54:06 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231292360.8870.61.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104755>



On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
> 
> I'll back the patch out and redeploy, it's worth mentioning that a
> coworker of mine just got the issue as well (on 1.6.1). He was able to
> `git pull` and the error went away, but I doubt that it "magically fixed
> itself"

Quite frankly, that behaviour sounds like a disk _cache_ corruption issue. 
The fact that some corruption "comes and goes" and sometimes magically 
heals itself sounds very much like some disk cache problem, and then that 
particular part of the cache gets replaced and then when re-populated it 
is magically correct.

We had that in one case with a Linux NFS client, where a rename across 
directories caused problems.

This was a networked filesystem on OS X, right? File caching is much more 
"interesting" in networked filesystems than it is in normal private 
on-disk ones.

> I've tarred one of the repositories that had it in a reproducible state
> so I can create a build and extract the tar and run against that to
> verify any patches anybody might have, but unfortunately at 7GB of
> company code and assets, I can't exactly share ;)

The thing to do is

 - untar it on some trusted machine with a local disk and a known-good 
   filesystem.

   IOW, not that networked samba share.

 - verify that it really does happen on that machine, with that untarred 
   image. Because maybe it doesn't. 

   The hope is that you caught the corruption in the cache, and it 
   actually got written out to the tar-file. But if it _is_ a disk cache 
   (well, network cache) issue, maybe the IO required to tar everything up 
   was enough to flush it, and the tar-file actually _works_ because it 
   got repopulated correctly.

   So that's why you should double-check that it really ends up being 
   corrupt after being untarred again.

 - go back and test the original git repo on the network share, preferably 
   on another client. See if the error has gone away.

 - If so, try to compare that known-corrupt filesystem with the original 
   one:  and preferably do this on another machine over the network mount. 

   See if they differ. They obviously should *not* differ, since it's an 
   tar/untar of the same files, but ...

The fact that you seem to get a _lot_ of these errors really does make it 
sound like something in your environment. It's actually really hard to get 
git to corrupt anything. Especially objects that got packed. They've been 
quiescent for a long time, they got repacked in a very simple way, they 
are totally read-only.

But it is _not_ hard to corrupt network filesystems. It's downright 
trivial with some of them, especially with some hardware (eg there's no 
end-to-end checksumming except for the _extremely_ weak 16-bit IP csum, 
and even that has been known to be disabled, or screwed up by ethernet 
cards that do IP packet offloading and thus computing the csum not on the 
data that tee user actually wrote, but the data that the card received, 
which is not necessarily at all the same thing).

And while ethernet uses a stronger CRC, that one is not end-to-end, so 
corruption on the card or in a switch in between easily defeats that too. 

Just google for something like

	"OS X" SMB "file corruption"

and you'll find quite a bit of hits. Not all that unusual.

				Linus
