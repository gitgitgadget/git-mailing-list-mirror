From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 10:33:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
References: <1247577632053-3255106.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Breitwieser <florian.bw@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 19:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQluG-0004gw-6M
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZGNRec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbZGNRec
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:34:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45177 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718AbZGNReb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 13:34:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EHXwlo001659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Jul 2009 10:33:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EHXwOd029167;
	Tue, 14 Jul 2009 10:33:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1247577632053-3255106.post@n2.nabble.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123259>



On Tue, 14 Jul 2009, Florian Breitwieser wrote:
>
> $ git commit -m "Some message"
> error: invalid object 1086b1c606a04bcb78b92d1d411a299d20d18034
> fatal: Error building trees

Hmm. That "invalid object" error comes from 'update_one()' when it cannot 
find the object it is looking for. That, in turn, tends to be an issue of 
the index containing a SHA1 that does not exist in the database.

Do you trust your filesystem? The symptoms really sound like you did a 
"git add .." earlier, and populated the index, but now the object that got 
populated is no longer found.

What OS, what filesystem?  Oh, and what version of git?

> $ git-fsck --full
> dangling tree c2549a3cdd83098a523cb707f217f4656cde7eb5

The fsck seems to imply that things are ok. The fsck _should_ have checked 
the index too.

The 'git commit' obviously disagrees.

Two things to check:

 - do you use grafts to hide old history, rather than connect additional 
   history?

   That can be really dangerous, and will make fsck (and other tools) not 
   look at the hidden state. 

 - do you have alternates (is multiple _different_ repositories tat point 
   to each other)? That can cause problems if you then do things like git 
   prune in them. It wouldn't explain this particular case, but it's 
   something I look out for when I hear about corruption.

> $ git prune

Not a good idea. When you suspect corruption, the _last_ thing you want to 
do is prune things. Who knows what happened?

> $ git commit -m "Some message"
> Created commit e32d5dd: Some message
>  2 files changed, 167 insertions(+), 10 deletions(-)

So now the same commit worked? It _really_ sounds like your filesystem has 
a hard time finding the files it just created. Some local caching issue.

Is it a network filesystem? If so, what's the filesystem server and 
version, if you can find it out?

> $ git push
> Counting objects: 15, done.
> Compressing objects: 100% (6/6), done.
> Writing objects: 100% (8/8), 2.44 KiB, done.
> Total 8 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (8/8), done.
> fatal: unresolved deltas left after unpacking
> error: unpack failed: unpacker exited with error code
> To /mnt/extstore2/bioinformatic/git/ppi.git
>  ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to
> '/mnt/extstore2/bioinformatic/git/ppi.git'

Here the other end doesn't have some object that we expect it to have, and 
that we sent a delta to it against. Sounds like potentially the exact same 
problem (it created some new file, but then couldn't see it). Is the thign 
you are pushing to a similar machine with similar filesystems?

We've had issues with both CIFS and NFS. Using

	[core]
		fsyncobjectfiles = true

might work around some issues where the filesystem does crazy things. But 
I'd really like to hear what OS and filesystem versions you're running.

			Linus
