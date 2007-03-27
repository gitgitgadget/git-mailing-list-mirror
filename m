From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 10:04:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWF7w-0006d1-Oc
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbXC0RGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933776AbXC0RGI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:06:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34081 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933688AbXC0RGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:06:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RH4sU2006672
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 10:04:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RH4r3W021225;
	Tue, 27 Mar 2007 10:04:53 -0700
In-Reply-To: <200703270117.59205.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43286>



On Tue, 27 Mar 2007, Josef Weidendorfer wrote:

> On Tuesday 27 March 2007, Junio C Hamano wrote:
> > Martin Waitz <tali@admingilde.org> writes:
> > 
> > > For submodules I currently use <parent>/.git/objects/module/<submodule>/
> > > to store the objects belonging to the submodule.
> > 
> > I was not following the gitlink discussion closely, but what is
> > the motivation behind this separation of the object store?
> 
> The separation issue is about scalability of submodules, and not
> directly about gitlink.

NOTE! It's fine to share the *object*store* for a supermodule setup.

The scalability concerns are not about the number of objects, but about 
the operations that work on them, and specifically *traverse* the objects.

So while it's fine to share the same GIT_OBJECT_DIR for all the 
submodules, it's *not* ok if "git clone" on a supermodule will consider 
things to be one single repository, and clone it as one huge thing, 
generating (and having to look up!) a ten-million object pack for a 
hundred smaller projects. THAT won't scale.

Basically, a "git-rev-list --objects HEAD" in the super-module should only 
list the objects in the supermodule itself, not in all the submodules. And 
that implies that cloning a supermodule is not about cloning a single big 
repository: it would be a matter of:

 - first cloning first the supermodule itself (which is often fairly 
   small: just a top-level directory, with some top-level Makefiles and a 
   number of directories that are submodules)

 - then parsing some supermodule data structure, and cloning each 
   submodule individually.

Similarly for "fetch" (and merging too, of course - it ends up having to 
merge each sub-project separately). 

Think of it this way: if you think people find it a bit annoying that you 
currently have to get all the history when you do clone (and why people 
have worked on "shallow clones" in git), imagine just *how* frustrating it 
is if you have to get all five-hundred subprojects when you only want to 
work on one small one!

Think of something like a huge *BSD "world" tree, where the supermodule 
contains *everything*. Do you really _really_ expect that every single 
developer wants to clone it all? I have no idea how much that is, but I 
can well imagine that it's several thousand subprojects, some of which are 
quite big in their own right. 

Also, imagine the server side.. Anybody who thinks that the server wants 
to (or is even *able* to) do things like a fsck on the totality, or keep 
every single object in memory, is in for a nasty surprise..

So I think that:

 - sharing object directories should not be a requirement, but it should 
   certainly be *possible*. Quite often you might want to do it, although 
   for really big superprojects it might well make sense to have 
   individual object stores too.

 - walking the *global* object list is simply not possible. You need to 
   fsck every single subtree individually, and fsck the superproject on 
   its own, *without* recursing into the subprojects. And you need to be 
   able to clone the superproject and only one or two subprojects, and 
   never see it as one "atomic" big repository.

I really think people should think about the *BSD kind of "world" setup. 
You absolutely do _not_ want supermodules to be indivisible "everything or 
nothign" kind of things. You want submodules to be very much separate 
repostories, although you *can* of course share the object store if you 
want to (the same way git can do it between any number of totally 
unrelated repositories!)

		Linus
