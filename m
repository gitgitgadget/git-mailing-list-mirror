From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problematic git pack
Date: Thu, 31 Aug 2006 14:33:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608311416060.27779@g5.osdl.org>
References: <44F6A198.4040902@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 23:33:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIuA3-0001SV-PG
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 23:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHaVdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHaVdO
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 17:33:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932173AbWHaVdO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 17:33:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7VLX7nW003295
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 31 Aug 2006 14:33:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7VLX6oh024709;
	Thu, 31 Aug 2006 14:33:07 -0700
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44F6A198.4040902@arces.unibo.it>
X-Spam-Status: No, hits=-0.438 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26276>



On Thu, 31 Aug 2006, Sergio Callegari wrote:
>
> Junio, can you please send me privately details about [*1*] so I can retrieve
> the pack also?

He already did, search for "members.cox.net" in your email archive (it's 
Message-ID: <7v7j0qihwl.fsf@assigned-by-dhcp.cox.net> to be precise).

> I also have another question... (maybe it was answered in some previous thread
> on this list, in this case a pointer would be enough).
> Now I am going to have the fixed archive and also a new archive, which I
> restarted from the latest working copy I had of my project.
> Is there any way to automatically do real "surgery" to attach one to the other
> and get a single archive with all the history?

Yes. This is just what a "grafts" file is for.

Put the old pack/idx files into the .git/objects/packs directory, and then 
you can create "fake parenthood" information in a ".git/info/grafts" file 
by just adding text-lines of the format "<sha1> <fakeparentsha1>" (with 
each SHA being the regular 40-byte hex representation).

> Obviously, if I try to change a commit object to modify its parents, its
> signature changes, so I need to modify its childs and so on, is this correct?
> Alternatively I belive that grafts should be a way to go... I had never used
> them before, do all git tools support them? Particularly do they get pushed
> and pulled correctly?

Nope, they won't get pushed and pulled correctly, you need to put the 
grafts files in all repositories. Alternatively, you can re-create the 
whole history, I think cogito had some history re-writing tool.

> > So the _real_ difference is literally just the one byte at offset 0151000
> > (decimal 53760) which in the fixed pack is 0x96, and in the corrupt pack it
> > is 0x94. That's a single-bit difference (bit #1 has been cleared).
> 
> So, possibly, the alpha particle theory could be the plausible one in the
> end...

Yes. It's just that Junio's original theory required it to not just hit a 
memory cell, it also had to hit it at _just_ the right time in between 
being written and the SHA1 of the buffer being computed. So the original 
theory was very unlikely indeed.

My theory of the corruption just causing a re-computed SHA1 when repacking 
(and silently copying the corruption without realizing it) meant that 
there was no such small and unlikely window, but that any regular memory 
(or disk) corruption could easily have caused it at any time, and then a 
subsequent re-pack "fixed" the SHA1 to match the corruption..

> The bad thing is that I don't know which of my two machines (the laptop or the
> desktop) caused the issue!

I'd suggest running memtest86 for a few days on both (not necessarily at 
the same time - keep one working machine to do you job on ;)

> > Finally, this also points out that the corrupted packs _can_ be fixed, but I
> > think Sergio was a bit lucky (to offset all the bad luck). Sergio still had
> > access to the original file that had had its object corrupted. 
>
> Actually, this could possibly be a not so rare case... In my tree I had the
> development of some LaTeX documents and packages (code like, the really
> "precious" files) and a few binary objects (images and openoffice files
> mainly, by far less precious).

Sure. In your case you had checked in generated files too, and yes, they 
were the larger ones. That's not true in general - in many other projects, 
the _directory_ structure (ie the git "tree" objects) will be a large 
portion of the project, and probably more likely to be corrupt. Now, to 
some degree the tree objects are likely the ones easiest to "repair" 
(because you can try to look at the history and figure things out by 
hand), but at the same time, people also tend to have deeper delta-chains 
and it would just be _very_ painful.

So I do think you were somewhat lucky.

> Finally, having a command to create an object out of a single file (contrary
> of git cat-file) could help re-creating the missing objects...

Hmm. Like "git-hash-object"?

			Linus
