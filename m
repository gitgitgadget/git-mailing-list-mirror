From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git checkout preserve timestamp?
Date: Thu, 1 Mar 2007 14:25:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703011409220.12485@woody.linux-foundation.org>
References: <17895.18265.710811.536526@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtiS-0002m6-IK
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbXCAWZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXCAWZd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:25:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45163 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161020AbXCAWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:25:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l21MPVhB023761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Mar 2007 14:25:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l21MPUVX024464;
	Thu, 1 Mar 2007 14:25:30 -0800
In-Reply-To: <17895.18265.710811.536526@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41138>



On Thu, 1 Mar 2007, Bill Lear wrote:
>
> I often find myself in branch A, with everything checked in and
> compiled, wanting to look at something on branch B.  I hop to branch
> B, look, and come back to branch A.  Unfortunately, when I then do a
> make, files that differed between A and B will be recompiled, as well as
> any further dependencies.
> 
> I wonder if it would be possible or desirable to have a config flag
> that told git to restore the timestamps across branch checkouts in
> order to prevent this perturbation.

I think you're much better off just using multiple repositories instead, 
if this is something common.

Messing with timestamps is not going to work in general. It's just going 
to guarantee you that "make" gets confused in a really bad way, and does 
not recompile *enough* instead of recompiling *too much*.

Git does make it possible to do your "check the other branch out" thing  
very easily, in many different ways.

You could create some trivial script that does any of the following 
(ranging from the trivial to the more exotic):

 - just create a new repo:

	git clone old new
	cd new
	git checkout origin/<branch>

   and there you are. The old timestamps are fine in your old repo, and 
   you can work (and compile) in the new one, without affectign the old 
   one at all.

   Use the flags "-n -l -s" to "git clone" to basically make this 
   instantaneous. For lots of files (eg big repos like the kernel), it's 
   not going to be as fast as just switching branches, but havign a second 
   copy of the working tree can be quite powerful.

 - do the same thing with just a tar-ball instead, if you want to

	git archive --format=tar --prefix=new-tree/ <branchname> |
		(cd .. ; tar xvf -)

   which is really quite fast, if you just want a snapshot.

 - get used to "git show", and just look at individual files.

   This is actually *really* useful at times. You just do

	git show otherbranch:filename

   in one xterm window, and look at the same file in your current branch 
   in another window. In particular, this should be trivial to do with 
   scriptable editors (ie GNU emacs), where it should be possible to 
   basically have a whole "dired mode" for other branches within the 
   editor, using this. For all I know, the emacs git mode already offers 
   something like this (I'm not an emacs user)

 - and in the extreme example of that "virtual directory" thing, there was 
   at least somebody working on a git plugin for FUSE, ie you could 
   literally just have virtual directories showing *all* your branches.

and I'm sure any of the above are better alternatives than playing games 
with file timestamps.

		Linus
