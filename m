From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Tue, 27 Feb 2007 20:57:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 05:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGsT-0002Nv-SL
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXB1E5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXB1E5L
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:57:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39393 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbXB1E5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:57:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S4v8hB031700
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 20:57:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S4v76o007286;
	Tue, 27 Feb 2007 20:57:07 -0800
In-Reply-To: <200702281036.30539.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.443 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40896>



On Wed, 28 Feb 2007, Alexander Litvinov wrote:
> 
> Some times ago I descide to run fsck and found that by working repo is broken, 
> while imported repo is correct. Is there way to fix it ? 

Generally, the best way to fix things is (I've written this up at 
somewhat more length before, but I'm too lazy to find it):

 - back up all your state so that anything you do is re-doable if you 
   corrupt things more!

 - explode any corrupt pack-files

   See "man git-unpack-objects", and in particular the "-r" flag. Also, 
   please realize that it only unpacks objects that aren't already 
   available, so you need to move the pack-file away from its normal 
   location first (otherwise git-unpack-objects will find all objects 
   that are in the pack-file in the pack-file itself, and not unpack 
   anything at all)

 - replace any broken and/or missing objects

   This is the challenging part. Sometimes (hopefully often!) you can find 
   the missing objects in other copies of the repositories. At other 
   times, you may need to try to find the data some other way (for 
   example, maybe your checked-out copy contains the file content that 
   when hashed will be the missing object?).

 - make sure everything is happy with "git-fsck --full"

 - repack everything to get back to an efficient state again.

And remember: git does _not_ make backups pointless. It hopefully makes 
backups *easy* (since cloning and pulling is easy), but the basic need for 
backups does not go away!

> By the way, several times I interrupt git's commands like commit and pull 
> using Ctrl-C.

Shouldn't matter, at least as long as you are using the native git 
protocol: git will create objects fully under a temporary name, and then 
atomically rename things to their right names. 

Using rsync and/or http may not be as safe.

HOWEVER! I do not know how well Windows and/or cygwin does file renames. 
If cygwin does a rename as a copy + delete, a lot of the safety 
assumptions just fly out the window.

> I tried to unpack all objects:
>
> > git-unpack-objects -r < .git/objects/pack/pack-c4554978bbe079c9a43d6a13546a2fa314fe0884.pack; echo  $?
> Unpacking 12868 objects
>  100% (12868/12868) done

Ok, that's a good thing, but see above: I don't think anything should have 
gotten unpacked, because it found all objects already existing in the very 
pack-file you tried to unpack.

So you might well need to do

	mv .git/objects/pack/pack-c4554978bbe079c9a43d6a13546a2fa314fe0884.pack oldpack
	git-unpack-objects -r < oldpack

(or rename the .idx file instead).

Alternatively (and in many ways this migth be better when you're trying to 
recover something) just create a totally *new* git repo, by doing

	mkdir new-repo
	cd new-repo
	git init
	git unpack-objects -r < ../other-repo/.git/pack/pack-.....pack

and re-create the objects somewhere else - you can do all of this without 
at all disturbing the old repository (but you'd need to copy all the refs 
and all the loose objects by hand, of course!)

> No erorts here. But fsck find that broken blob:
> > git fsck 
> dangling blob beb992198d4d8813ea51fd1cbbf38313ef490c22
> 
> git-cat-file shows me this this is a broken object with correct sha1 sum.
> 
> As a cunclusion: my repo has broken file and I don't see there is the brakage. 
> Can I reconstruct file by sha1 sum :-) or can I do something to stop fsck 
> warn me ?

You didn't do "--full", so it's not looking inside your pack, so the fsck 
wasn't very interesting in this case.

And no, you cannot reconstruct the file by sha1 sum, although you may be 
able to reconstruct the file some *other* way (by looking at the other 
blobs and remembering what the missing case is), and then you can 
obviously use the sha1-sum to *confirm* that you reconstructed the file 
exactly as it was!

So yes, reconstruction of missing objects is possible, but no, you can't 
do it based purely based on SHA1, you need to base reconstruction on some 
other information. That's kind of what "cryptographically secure hash" 
means ;^p

			Linus
