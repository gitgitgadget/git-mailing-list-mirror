From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 19:30:59 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805291923030.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com>  <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <1212112295.3094.3.camel@obelisk.thedillows.org> <alpine.LFD.1.10.0805291905360.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Dillow <dave@thedillows.org>
X-From: git-owner@vger.kernel.org Fri May 30 04:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1uQT-0003DB-EM
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 04:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254AbYE3Cbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 22:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755139AbYE3Cbq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 22:31:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50173 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753776AbYE3Cbl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 22:31:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U2V0N2014334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 May 2008 19:31:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U2UxX0002609;
	Thu, 29 May 2008 19:30:59 -0700
In-Reply-To: <alpine.LFD.1.10.0805291905360.3141@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.398 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83266>



On Thu, 29 May 2008, Linus Torvalds wrote:
> 
> So if you have a system crash at a really bad time, you may have a git 
> repository that needs manual intervention to actually be *usable*. I hope 
> nobody ever believed anything else. That manual intervention may be things 
> like:
> ...
>  - actually throw away broken commits, and re-create them (ie basically 
>    doing a "git reset <known-good-state>" plus re-committing the working 
>    tree or perhaps re-doing a whole "git am" series or something)

The important part here is that it's only the *new* state that can be this 
kind of "broken commits". In other words, you'd never have to re-do actual 
*old* commits, just the commits you were doing as things crashed - the 
commits that you were in the middle of doing, and still have the data for.

Example from my case: I may have series of 250+ commits that I create with 
"git am" when I sync up with Andrew, and I very much want the speed of 
being able to create all that new commit data without ever even causing a 
_single_ synchronous disk write.

So if the machine were to crash in the middle of the series, I might lose 
all of that data, but I still have my mailbox, so I'd just need to reset 
to the point before I even started the "git am", and re-do the whole 
series. My actual *base* repository objects would never get corrupted.

[ And one final notice: I don't know about others, but I've actually had 
  more corruption from disks going bad etc that from system crashes per 
  se. And when *that* happens, old data is obviously as easily gone as new 
  data is. So absolutely _nothing_ replaces backups. It doesn't matter if 
  you do a "fsync()" after every single byte write - a disk crash can and 
  will corrupt things that were "stable". So even "stable storage" is 
  very much unstable in the end. ]

			Linus
