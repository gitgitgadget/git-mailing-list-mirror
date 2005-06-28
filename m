From: Linus Torvalds <torvalds@osdl.org>
Subject: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 18:14:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 28 03:06:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn4Y2-0007Yq-DT
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 03:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVF1BMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 21:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVF1BMx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 21:12:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262157AbVF1BMj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 21:12:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5S1CajA032471
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 27 Jun 2005 18:12:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5S1CY1S003153
	for <git@vger.kernel.org>; Mon, 27 Jun 2005 18:12:35 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Some people may have noticed already (hopefully not the hard way) that the 
current git code doesn't support delta objects lying around in the object 
directory any more.

In other words, if you have delta objects, you need to un-deltify your 
repository _before_ you upgrade your git binaries, or they won't be able 
to read your objects any more.

The reason? The new git understands packed files natively, which ends up 
being a much bigger win in many many ways.

You should be very careful about using packed files (since they are a very 
recent addition), but what you can do to try them out is to do so in a 
separate repository.

Starting to use a packed repository is very simple indeed, and here's what 
you need to do for git, for example:

In your regular "git" directory (once you have ypdated your git to a 
recent version, in particular you need to have the "csum-file: fix missing 
buf pointer update" commit), do:

	git-rev-list --objects HEAD | git-pack-objects --window=50 --depth=50 out

which will say something like "Packing 3741 objects" and result in two new 
files a few seconds later:

	torvalds@ppc970:~/git> ls -lh out*
	-rw-r--r--  1 torvalds torvalds  89K Jun 27 17:59 out.idx
	-rw-r--r--  1 torvalds torvalds 1.3M Jun 27 17:59 out.pack

now, don't do anythign with those files, but instead go and create a 
directory somewhere else:

	cd ~
	mkdir packed-git-trial
	cd packed-git-trial
	git-init-db

you have now obviously created a totally empty repository. Now, let's 
populate that empty repository with _just_ the pack files:

	mkdir .git/objects/pack
	mv ~/git/out.* .git/objects/pack

and then, move over your tags, in particularly the HEAD pointer, with 
something like

	cat ~/git/.git/HEAD > .git/HEAD

and voila, you're done. Try "gitk", for example. Or "git log".

Now, what's even cooler is how you can just start using this packed tree: 
feel free to do a test-commit or something, and notice how git starts 
populating the empty .git/objects/xx/ subdirectories with new objects. But 
it still relies on the pack-file for the old history.

Now, there's still a misfeature there, which is that when you create a new
object, it doesn't check whether that object already exists in the
pack-file, so you'll end up with a few recent objects that you really
don't need (notably tree objects), and we'll fix that eventually. But
notice how you started with a 17MB .git/objects/ directory in your
original tree, and you now have just a 1.3MB pack-file and a 90kB index
file that replaces all that?

There are some other issues too, like the fact that "git-fsck-cache"  
doesn't know about the pack-files yet, so it will complain about missing
objects etc. Also, please note that the pack-file _only_ packs the commits
and the things reachable from them: things like tags (and your references
in your .git/refs directory) need to be copied over separately.

So this is all very rough, still, but the basics do actually seem to work
(ie anything that doesn't look directly at the object files - which is
pretty much all of it except for fsck and the direct-filesystem-access 
things like "rsync" and "git-local-pull").

Maybe you might not want to switch over yet, and as mentioned, rsync then
ends up not being a good way to sync (nor git-local-pull), but the
"git-http/ssh-pull" family should hopefully just work.

I've used a packed kernel tree too, so this has gotten _some_ testing even 
on really quite big git trees. 

			Linus
