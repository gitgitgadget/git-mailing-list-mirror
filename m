From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Thu, 3 Aug 2006 21:46:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 06:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8rag-0007Qf-PT
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 06:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHDErE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 00:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWHDErE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 00:47:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWHDErD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 00:47:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k744kxnW026311
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Aug 2006 21:47:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k744kwwi020476;
	Thu, 3 Aug 2006 21:46:58 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24774>



On Fri, 4 Aug 2006, Jon Smirl wrote:
>
> I am converting all of the revisions from each CVS file into git
> objects the first time the file is parsed. The plan was to run repack
> after each file is finished. That way it should be easy to figure out
> the deltas since everything will be a variation on the same file.

Sure. In that case, just list the object ID's in the exact same order you 
created them.

Basically,as you create them, just keep a list of all ID's you've created, 
and every (say) 50,000 objects, just do a

	echo all objects you've created | git-pack-objects new-pack

and then move the new pack into place, and remove all the loose objects 
(don't even bother using "git prune" - just basically do something like
"rm -rf .git/objects/??" to get rid of them).

> So what's the best way to pack these objects, append them to the
> existing pack and then clean everything up for the next file? I am
> parsing 120K CVS files containing over 1M revs.

You'll want to repack every once in a while just to not ever have _tons_ 
of those loose objects around, but if you do it every 50,000 objects, 
you'll have just twenty nice pack-files once you're done, containing all 
one million objects, and you'll never have had more than ~200 files in any 
of the loose object subdirectories.

Of course, you might want to make that "every 50,000 object" thing 
tunable, so that if you don't have a lot of memory for caching, you might 
want to do it a bit more often just to make each repack go faster and not 
have tons of IO. 

You can then do a _full_ repack to get one big object, by just listing 
every object you ever created (in creation order) to git-pack-objects, and 
then you can replace all the twenty (smaller) pack-files with the 
resulting single bigger one.

In fact, at that point you no longer even need to worry about "creation 
order", since you've basically created all the deltas in the first phase, 
and regardless of ordering, when you then repack everything at the end, it 
will re-use all earlier delta information.

		Linus
