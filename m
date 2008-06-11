From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 08:17:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 17:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6SBF-00011Z-QJ
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 17:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbYFKPWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYFKPWr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 11:22:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53975 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753255AbYFKPWr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 11:22:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BFH5ej018945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 08:17:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BFH41o003952;
	Wed, 11 Jun 2008 08:17:04 -0700
In-Reply-To: <20080611074309.GB28629@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.374 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84618>



On Wed, 11 Jun 2008, Pierre Habouzit wrote:
> 
>   Could this be the source of a problem we often meet at work ? Let me
> try to describe it.

The fsync() *should* make no difference unless you actually crash. So my 
initial reaction is no, but non-coherent client-side write caching over 
NFS may actually make a difference.

>   We work with our git repositories (storages I should say) on NFS
> homes, with workdirs on a local directory (NFS homes are backuped daily,
> hence everything commited get backuped, and developers have shorter
> compilation times thanks to the local FS).

Ok, so your actual git object directory is on NFS?

>   Quite often, when people commit, they have corrupt repositories. The
> symptom is a `cannot read <sha1>` error message (or many at times). The
> usual way to "fix" it is to git fsck, and git reset (because after the
> fsck the index is totally screwed and all local files are marked new),
> and usually everything is fine then.

Hmm. Very interesting. That definitely sounds like a cache coherency 
issue (ie the "fsck" probably doesn't really _do_ anything, it just 
delays things and possibly causes memory pressure to throw some stuff out 
of the cache).

What clients, what server?

NFS clients (I assume v2, which is not coherent) _should_ be doing what is 
called open-close consistent, which means that while clients can cache 
data locally, they should aim to be consistent between two clients over a 
an open-close pair (ie if two clients have the same file open at the same 
time, there are no consistency guarantees, but if you close on one client 
and then open on another, the data should be consistent).

If open-close consistency doesn't work, then things like various parallel 
load distribution things (clusters with a NFS filesystem doing parallel 
makes, etc) don't tend to work all that well either (ie an object file is 
written on one client, and then used for linking on another).

And that is what git does: even without the fsync(), git will "close()" 
the file before it actually does the link + unlink to move it to the new 
position. So it all _should_ be perfectly consistent even in the absense 
of explicit syncs.

That said, if there is some problem with that whole thing, then yes, the 
fsync() may well hide it. So yes, adding the fsync() is certainly worth 
testing.

>   This is not really a hard corruption, and it's really hard to
> reproduce, I don't know why it happens, and I wonder if this patch could
> help, or if it's unrelated. I can only bring speculations as it's really
> hard to reproduce, and it quite depends on the load of the NFS server :/

Yes, that sounds very much like a cache coherency issue. The "corruption" 
goes away when the cache gets flushed and the clients see the real state 
again. But as mentioned, git should already do things in a way that this 
should all work, but hey, that's using certain assumptions that perhaps 
aren't true in your environment.

			Linus
