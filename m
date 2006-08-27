From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem with pack
Date: Sun, 27 Aug 2006 11:27:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608271102450.27779@g5.osdl.org>
References: <44F1DA25.3050403@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 20:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHPLs-0003iy-Px
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 20:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWH0S1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWH0S1R
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 14:27:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932239AbWH0S1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 14:27:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7RIR5nW014847
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Aug 2006 11:27:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7RIR45L001794;
	Sun, 27 Aug 2006 11:27:05 -0700
To: Sergio Callegari <scallegari@arces.unibo.it>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <44F1DA25.3050403@arces.unibo.it>
X-Spam-Status: No, hits=-0.435 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26107>



On Sun, 27 Aug 2006, Sergio Callegari wrote:
>
> There is something that I still do not understand... (sorry if I ask stupid
> questions)...
> Since packs have an sha signature too, if there was a data corruption (disk or
> transfer), shouldn't that have been detected at the repack? I.e. doesn't
> repack -d verify the available data before cancelling anything?

The packs do have a SHA1 signature, but verifying it is too expensive for 
normal operations. It's only verified when you explicitly ask for it, ie 
by git-fsck-objects and git-verify-pack.

Now, for small projects we could easily verify the SHA1 csum when we load 
the pack, but imagine doing the same thing when the pack is half a 
gigabyte in size, and I think you see the problem.. Especially as most 
normal operations wouldn't even otherwise touch more than a small small 
fraction of the pack contents, so verifying the SHA1 would be relatively 
very expensive indeed.

Now, "git repack -a" is obviously special in that the "-a" will mean that 
we will generally touch all of the old pack _anyway_, and thus verifying 
the signature is no longer at all as unreasonable as it is under other 
circumstances. And very arguably, if you _also_ do "-d", then since that 
is a fairly dangerous operation with the potential for real data loss, you 
could well argue that we should do it.

However, since the data was _already_ corrupt in that situation, and since 
a "git-fsck-objects --full" _will_ pick up the corruption in that case 
both before and after, equally arguably it's also true that there's really 
not a huge advantage to checking it in "git repack -a -d".

In other words, in your case, the reason you ended up with the corruption 
spreading was _not_ that "git repack -a -d" might have silently not 
noticed it, but really the fact that unison meant that the corruption 
would spread from one archive to another in the first place.

NOTE! This is all assuming my theory that a packed entry was broken in the 
first place was correct. We obviously still don't _know_ what the problem 
was. So far it's just a theory.

Final note: a "git repack -a -d" normally actually _does_ do almost as 
much checking as a "git-fsck-objects". It's literally just the "copy the 
already packed object from an old pack to a new one" that it an 
optimization that short-circuits all the normal git sanity checks. All the 
other cases will effectively do a lot of integrity checking just by virtue 
of unpacking the data in the object that is packed, before re-packing it.

So it might well be the case that we should simply add an extra integrity 
check to the raw data copy in builtin-pack-objects.c: write_object().

Now, these days there is actually two cases of that: the pack-to-pack copy 
(which has existed for a long while) and the new "!legacy_loose_object()" 
case. They should perhaps both verify the integrity of what they copy.

Junio, comments?

		Linus
