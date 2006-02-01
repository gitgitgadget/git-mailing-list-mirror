From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 18:04:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 03:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F47Q4-0004aQ-5K
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWBACIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWBACIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:08:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964871AbWBACIP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 21:08:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1124XDZ021176
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 18:04:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1124VYK013470;
	Tue, 31 Jan 2006 18:04:32 -0800
To: Ray Lehtiniemi <rayl@mail.com>
In-Reply-To: <20060201013901.GA16832@mail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15375>



On Tue, 31 Jan 2006, Ray Lehtiniemi wrote:
> 
> for what it's worth, it's certainly true here...  i'm using git to help
> me manage a similar project where i work.

Hmm.

We _could_ actually fairly easily add a flag to the index which means 
"don't even bother comparing - assume same", and then have specific 
operations to clear that flag.

That would allow people with slow filesystems (not just Windows: even 
under Linux, the cold-cache case is always going to be pretty slow) to 
have a _choice_: they could continue to use git it is done now (explicit 
checks), _or_ they could mark all their index caches as "implicitly 
up-to-date" and use a separate program to mark them as being potentially 
edited.

We still have one unused bit in the cache-entry "ce_flags", so we wouldn't 
even need to break any existing index files with it.

We'd just need to have two new (fast) operations:

 - mark one or more files as being "implicitly up-to-date"

   "git checkout" would do this if the proper flag was set in the 
   .git/config file.

   "git-update-index --refresh" would do this for files that weren't 
   already implicitly up-to-date _and_ the refresh actually showed it to 
   match (and the .git/config file said so).

 - mark one or more files as _not_ being implicitly up-to-date:

   people would do this by hand when editing a file (or when just deciding 
   that they want git to re-check everything again)

They're fast, because they are purely in the cache (well, git-update-index 
obviously isn't, but the new op wouldn't be any _slower_ than the old 
one).

Looks simple enough. The big thing to remember is to clear that 
"implicitly up-to-date" flag whenever we make changes (ie we'd probably 
make "add_cache_entry()" always clear it, possibly with a flag to add it 
as "pre-verified" which would set it).

Comments? Junio, what do you think?

> we're working on a vendor supplied tree which is also hacked upon
> by various VAR companies.  the tree in question has ~20,000 files
> totalling nearly 1.4 GB of source files, ms word docs, binary-only
> libraries for a wide array of processor variants, windows exe
> files, video clips, etc.  (however, the amount of actual source code
> interspersed in there is only about 6000 files totaling about 112 MB)
> 
> here's a repo sitting on the local linux filesystem with cold cache:
> 
>   reiserfs$ time git update-index --refresh
>    real    0m17.422s
>    user    0m0.025s
>    sys     0m0.320s

.. somewhat painful, but with enough memory this is hopefully a pretty 
rare case.

> and with hot cache
> 
>   reiserfs$ time git update-index --refresh
>    real    0m0.151s
>    user    0m0.020s
>    sys     0m0.067s

This is how it _should_ look.

But:

> for comparison, one of our sandboxes is sitting on an NTFS file system,
> accessed via SMB:
> 
>   smbfs$ time git update-index --refresh
>   real    11m36.502s
>   user    0m6.830s
>   sys     0m5.086s

Ouch, ouch, ouch.

Sounds like every single stat() will go out the wire. I forget what the 
Linux NFS client does, but I _think_ it has a metadata timeout that avoids 
this. But it might be as bad under NFS.

Has anybody used git over NFS? If it's this bad (or even close to), I 
guess the "mark files as up-to-date in the index" approach is a really 
good idea..

Of course, the whole point of git is that you should keep your repository 
close, but sometimes NFS - or similar - is enforced upon you by other 
issues, like the fact that the powers-that-be want anonymous workstations 
and everybody should work with a home-directory automounted over NFS..

			Linus
