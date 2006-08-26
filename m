From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 12:24:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608261203220.11811@g5.osdl.org>
References: <44F098C0.8000202@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 21:24:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH3lP-0005Oh-7a
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 21:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHZTYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWHZTYJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 15:24:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWHZTYG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 15:24:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7QJO2nW007367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 12:24:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7QJO12e029818;
	Sat, 26 Aug 2006 12:24:01 -0700
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44F098C0.8000202@arces.unibo.it>
X-Spam-Status: No, hits=-0.421 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26064>



On Sat, 26 Aug 2006, Sergio Callegari wrote:
>
> Might the problem have come out of a scenario like the following...
> 
> 1) I use unison to sync my documents (rather than using the git tools...
> silly me!)
> 2) I get things wrong in controlling unison (without realizing that I
> do) and the result is that I lose some blobs.
> 3) I repack an unclean tree (missing some objects)
> 
> Can this be the case?

I do think that your synchronization using unison is _somehow_ part of the 
reason why bad things happened, but I really can't see why it would cause 
problems, and perhaps more importantly, git should have noticed them 
earlier (and, in particular, failed the repack). So a git bug and/or 
misfeature is involved somehow.

One thing that may have happened is that the use of unison somehow 
corrupted an older pack (or you had a disk corruption), and that it was 
missed because the corruption was in a delta of the old pack that was 
silently re-used for the new one.

That would explain how the SHA1 of the pack-file matches - the repack 
would have re-computed the SHA1 properly, but since the source delta 
itself was corrupt, the resulting new pack is corrupt.

If you had used git itself to synchronize the two repositories, that 
corruption of one repo would have been noticed when it transfers the data 
over to the other side, which is one reason why the native git syncing 
tools are so superior to doing a filesystem-level synchronization.

With a filesystem-level sync (unison or anything else - rsync, cp -r, 
etc), a problem introduced in one repository will be copied to another one 
without any sanity checking.

(Which is not to say that the native protocol might not miss something 
too, but it should be _much_ harder to trigger: for anything but the 
initial close, the native protocol will unpack all objects and recompute 
their SHA1 hashes from first principles on the receiving side, rather than 
trust the sender implicitly, so it's fundamentally safer. But maybe we 
could be even _more_ anal somewhere).

So as a suggestion if you want to be careful:

 - only use "git fetch/pull" to synchronize two git repos, because that's 
   inherently safer than any non-native synchronization.

 - if you repack reasonably often, do "git fsck-objects" (which is very 
   cheap when there aren't a lot of unpacked objects) to verify the 
   archive before "git repack -a -d" to repack it.

 - the "fsck-objects" thing won't catch a corrupt pack (unless you ask for 
   it with "--full", which is expensive for bigger projects), but at least 
   with "git fetch/pull", such corruption should not be able to replicate 
   to another repository.

but in the meantime, when you find a place to put the corrupt pack/index 
file, please include me and Junio at a minimum into the group of people 
who you tell where to find it (and/or passwords to access it). I'll 
happily keep your data private (I've done it before for others).

		Linus
