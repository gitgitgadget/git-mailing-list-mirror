From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 11:15:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAt4I-0006jI-Po
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbXA0TS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbXA0TS0
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:18:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59808 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbXA0TSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:18:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RJF11m016961
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 11:15:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RJF0hk014672;
	Sat, 27 Jan 2007 11:15:01 -0800
In-Reply-To: <45BB9C8B.8020907@fs.ei.tum.de>
X-Spam-Status: No, hits=-0.492 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37986>



On Sat, 27 Jan 2007, Simon 'corecode' Schubert wrote:
> 
> git rev-list and git log (with or without -p) perform poorly when invoked with
> a pathspec.

Really? I would say exactly the opposite. They _smoke_ when invoked with a 
pathspec.

Show me *one* other SCM that even comes close..

And please, realize that git does arbitrary combinations of directories, 
and not just single files. AND THAT IS IMPORTANT!

Any SCM that can't do

	git log drivers/scsi/ include/scsi/

and have it be a sane log of the changes to the _union_ of those two 
directories is strictly inferior to what git can do.

Usually this is something that others CANNOT DO AT ALL.

Even your 1:18 number is a hell of a lot faster than "can't do it", which 
is what you have for everything else I can imagine.

Maybe you just do single files, but my pathspecs tend to be directories or 
multiple files more often than single ones.

How the heck did you intend to cache that?

> I agreee with those numbers.  However, on a converted KDE repo, they are
> *completely* different:
> 
> git log kdelibs/README takes 1:18.  One minute, eighteen seconds.
> git rev-list and git blame take roughly the same time.

Do you have the converted repo somewhere to be cloned for? It's going to 
be a lot more interesting for scalability testing than anything else.

It is possible, for example, that the real issue is that we shouldn't 
compress delta objects in a pack.

> That's what we were getting at.  Not the superiority of git blame (no irony)
> and thus reduced speed, but the algorithmic deficiency of any operation on a
> pathspec/object, which can be easily fixed.

The thing is, one of the reasons the git object database is small is that 
it compresses really well, and I suspect that for the KDE repo, what 
you're seeing is really a combination of:

 - the KDE people were idiots in the first place to make it into one big 
   repo

 - we've consciously made repo size be a major goal, and yes, we spend a 
   lot of CPU as a result, following delta chains etc. The zlib overhead 
   is more visible, because once you've uncompressed the delta the delta 
   itself is really quick to apply, but the whole "trees compress really 
   well" all boils down to the same thing: we create lots of small 
   objects, and we have tons of deltas, and the hierarchical nature of the 
   data structures (ie saving the trees not as one big manifest but as 
   a more complex hierarchial datastructure) is what allows us to do tons 
   of the path-based optimizations.

But they all do end up boiling down to "we use lots of CPU".

And I suspect tweaking the existing stuff is quite reasonable. But we need 
to have a public repo that people who want to tweak can play with (for 
example, the old "linux-history" archive was what made us tweak things 
like gitk, which was horribly horribly bad).

So please point to a kde conversion archive to play with (maybe you have, 
I missed it).

		Linus
