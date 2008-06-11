From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 10:46:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806111037530.3101@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org>
 <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6UW3-0001zV-Cb
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYFKRwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbYFKRwr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:52:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34347 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbYFKRwq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 13:52:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BHk1Ga028977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 10:46:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BHk07t009560;
	Wed, 11 Jun 2008 10:46:00 -0700
In-Reply-To: <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.373 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84628>



On Wed, 11 Jun 2008, Linus Torvalds wrote:
> 
> Do you have people using special flags for your NFS mounts? And do you 
> know if there is some pattern to the client kernel versions when the 
> problem happens?

Oh, before I even go there - let's get the _really_ obvious case out of 
the way first.

If you are using a shared git object repository (why are you doing that, 
btw?), are people perhaps doing things like "git gc --auto" etc at the 
same time? Perhaps even unknowingly, thanks to autogc?

That's an absolute no-no. It works on a real POSIX filesystem, because 
even if you unlink a file that is in use by another process, the other 
process still has access to the data and the file won't be *really* 
removed until all users have gone away.

That's also true within a _single_ NFS client thanks to so-called 
"silly-renaming", but it is *not* true across multiple clients.

So if one client is doing some kind of gc and creates a new pack-file and 
then removes old loose objects, and another client has already looked up 
and opened that loose object (but not finished reading it), then when the 
file gets removed, you will literally lose the data on the other client 
and get a short read!

And nothing we can do can ever fix this very fundamental issue of NFS. NFS 
simply isn't an even remotely POSIX filesystem, even though it's set up to 
mostly _look_ like one when accessed from a single client.

In general, I would discourage people ever sharing object directories 
among multiple users except in a server kind of environment (eg 
kernel.org). 

			Linus
