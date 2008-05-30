From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: reducing prune sync()s
Date: Fri, 30 May 2008 08:57:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <20080530152527.GF4032@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 30 17:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K270d-00061a-49
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYE3P6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYE3P6X
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:58:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752219AbYE3P6W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 11:58:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UFvMfg032730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 08:57:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UFvLtR032352;
	Fri, 30 May 2008 08:57:22 -0700
In-Reply-To: <20080530152527.GF4032@redhat.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.398 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83312>



On Fri, 30 May 2008, Frank Ch. Eigler wrote:
> 
> On Thu, May 29, 2008 at 05:27:35PM -0700, Linus Torvalds wrote:
> > [...]
> > >	  Or perhaps having the blanket sync be replaced a
> > > list of fsync()s for only the relevant git repository files?
> > [...]
> > Soemthing like this *may* work. THIS IS TOTALLY UNTESTED. And when I say 
> > "TOTALLY UNTESTED", I mean it. Zero testing. None. Nada. Zilch. Testing is 
> > for people who are actually interested in the feature (hint, hint).
> 
> The patch does add an fsync or two into the mix, a "git gc" or 
> "git repack -a" still goes through the "git-repack" shell script, which
> still did its "sync".

Yes.

But I actually think there is a simpler and more straightforward approach.

Instead of being careful when removing objects (whether old packs or loose 
objects that are made redundant by a new pack), the simpler approach is to 
just always fsync() the new pack when creating it.

I was always very careful to *not* make git depend on any serialized IO, 
but the reason for that was literally the fact that I wanted to make sure 
that I could batch up things efficiently, and do any serialization (if I 
wanted to) later. So it was literally always about the whole "apply 
several hundred patches in one go" kind of thing.

And the thing is, the repacking phase *is* the "serialize things later (if 
you want)" thing, so doing things synchronously at that point is actually 
perfectly fine.

And every single "let's remove objects" operation is literally always 
about the fact that we have a new better pack-file, making old objects 
redundant, so if we just create those new pack-files stably on disk, then 
any subsequent action pretty much by definition doesn't need any sync. 
Because we know that the only thing we can really care about *is* stable.

So this is a conceptually much more direct approach. Creating pack-files 
really is the special occasion, since it's (a) literally the event that 
causes other objects to potentially be stale (b) fairly rare and (c) not 
normally limited by disk-IO anyway (ie a "git fetch" will create a new 
pack-file, but it's normally limited by the network overhead or the cost 
of creating the pack-file, not by adding a fsync() to make sure that the 
end result is stable).

So I'll follow up with a two-patch series (the first to create pack-files 
and their indexes stably on disk, the second to just remove the now 
unnecessary 'sync()' calls). I'll give it *some* basic testing first, 
though.

		Linus
